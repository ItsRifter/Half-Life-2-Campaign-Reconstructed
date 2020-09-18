AddCSLuaFile() -- Add itself to files to be sent to the clients, as this file is shared

hook.Add("OnNPCKilled", "NPCDeathIndicator", function(npc, attacker, inflictor)
	local giveXP = 0
	local giveCoins = 0
	local bonusXP = 0
	local bonusCoins = 0
	local givePetXP = 0
	local totalXPSquad = 0
	
	if npc:IsNPC() and attacker:IsPlayer() and inflictor:GetModel() == "models/props_wasteland/prison_toilet01.mdl" and game.GetMap() == "d2_prison_02" then
		Achievement(attacker, "Flushed", "HL2_Ach_List")
	end
	
	if npc:IsPet() and attacker:IsPet() then
		local npcOwner = npc.owner
		local attackerOwner = attacker.owner
		if npcOwner:IsValid() and attackerOwner:IsValid() then
			local duel = GetDuelAccepted(npcOwner)
			if duel then
				AddCoins(attackerOwner, duel.bet * 2)
				for k, v in pairs(player.GetAll()) do
					v:ChatPrint(string.format("%s won the pet battle against %s", attackerOwner:Nick(), npcOwner:Nick()))
				end
				RemoveDuel(duel.challenger, duel.challengee)
			end
		end
	end
	
	if npc:GetClass() == "npc_antlionguard" then
		bonusXP = 100
		bonusCoins = 75
	end
	
	--Stop players from getting easy XP/Coins from birds
	
	local RESTRICTED_NPCS = {
		["npc_crow"] = true,
		["npc_pigeon"] = true,
		["npc_seagull"] = true
	}

	if not RESTRICTED_NPCS[npc:GetClass()] then
		giveXP = math.random(1 + bonusXP, (25 + bonusXP) * GetConVar("hl2cr_difficulty"):GetInt())
		giveCoins = math.random(1 + bonusCoins, (15 + bonusCoins) * GetConVar("hl2cr_difficulty"):GetInt())
	else
		giveXP = 0
		giveCoins = 0
	end
	
	local RESTRICTED_MAPS = {
		["d2_coast_01"] = true,
		["d2_coast_03"] = true,
		["d2_coast_04"] = true,
		["d2_coast_11"] = true,
		["d2_coast_12"] = true,
		["d2_prison_01"] = true,
		["d2_prison_02"] = true,
		["d2_prison_03"] = true,
		["ep1_c17_00"] = true,
		["ep1_c17_00a"] = true,
		["ep1_c17_01"] = true,
		["ep1_c17_01a"] = true,
		["ep1_c17_02"] = true
	}
	
	--Prevent antlion farming
	if npc:GetClass() == "npc_antlion" and RESTRICTED_MAPS[game.GetMap()] and (attacker:IsPlayer() or attacker:IsPet()) then
		giveXP = 0
		giveCoins = 0
		givePetXP = 0
	elseif attacker:IsPet() and attacker.owner then
		givePetXP = math.random(1, 15 * GetConVar("hl2cr_difficulty"):GetInt())
		addPetXP(attacker.owner, givePetXP)
		Spawn(givePetXP, 0, npc:GetPos(), npc, attacker.owner)
	end
	
	if attacker:IsPlayer() and not npc.owner then
		attacker.hl2cPersistent.KillCount = attacker.hl2cPersistent.KillCount + 1
		AddXP(attacker, giveXP)
		AddCoins(attacker, giveCoins)
		Spawn(giveXP, giveCoins, npc:GetPos(), npc, attacker)
	end
	
	--Crowbar bonus if the player beats the map using only the crowbar
	if attacker:IsPlayer() and attacker:GetActiveWeapon():GetClass() != "weapon_crowbar" and attacker.crowbarOnly then
		attacker.crowbarOnly = false
	end
	
	if attacker:IsPlayer() and inflictor:GetClass() == "prop_combine_ball" and string.match(game.GetMap(), "ep1_") then
		Achievement(attacker, "Think_Fast", "EP1_Ach_List")
	end
	
	if game.GetMap() == "ep1_citadel_03" and attacker:IsPlayer() and npc:GetClass() == "npc_stalker" then
		if pacifistAchEarnable and not surpassPacifist then 
			for k, v in pairs(player.GetAll()) do
				v:ChatPrint("Pacifist Failed Caused by: " .. attacker:Nick())
			end
		end
		pacifistAchEarnable = false
	end
	
	if attacker:IsPlayer() and (attacker.squads.leader == attacker:Nick() or string.find(table.ToString(attacker.squads.membername), attacker:Nick())) then
		totalXPSquad = totalXPSquad + giveXP
		net.Start("Squad_XPUpdate")
			net.WriteInt(totalXPSquad, 32)
			net.WriteString(attacker:Nick())
		net.Broadcast()
	end
end)

function Spawn(xpAmt, coinAmt, pos, target, reciever)
	
	net.Start("IndicSpawn")
	
	net.WriteInt(xpAmt, 16)
	
	net.WriteInt(coinAmt, 16)
	
	net.WriteVector(pos)
	net.Send(reciever)

end