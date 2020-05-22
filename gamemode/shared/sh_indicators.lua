AddCSLuaFile() -- Add itself to files to be sent to the clients, as this file is shared

hook.Add("OnNPCKilled", "NPCDeathIndicator", function(npc, attacker, inflictor)
	local giveXP = 0
	local giveCoins = 0
	local bonusXP = 0
	local bonusCoins = 0
	local givePetXP = 0

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
	if npc:GetClass() ~= "npc_crow" and npc:GetClass() ~= "npc_pigeon" and npc:GetClass() ~= "npc_seagull" then
		giveXP = math.Rand(1 + bonusXP, (25 + bonusXP) * GetConVar("hl2c_difficulty"):GetInt())
		giveCoins = math.Rand(1 + bonusCoins, (15 + bonusCoins) * GetConVar("hl2c_difficulty"):GetInt())
	else
		giveXP = 0
		giveCoins = 0
	end
	
	--Prevent antlion farming
	if npc:GetClass() == "npc_antlion" and (game.GetMap() == "d2_coast_01" or game.GetMap() == "d2_coast_03" or game.GetMap() == "d2_coast_04" or game.GetMap() == "d2_coast_11" or game.GetMap() == "d2_coast_12" or game.GetMap() == "d2_prison_01" or game.GetMap() == "d2_prison_02" or game.GetMap() == "d2_prison_03" or game.GetMap() == "d2_prison_04" or game.GetMap() == "d2_prison_05") then
		giveXP = 0
		giveCoins = 0
		givePetXP = 0
	end
	
	
	local npcPos = npc:GetPos()
	
	
	if attacker:IsNPC() and attacker.owner and attacker:GetClass() == "npc_headcrab" then
		if npc:GetClass() == "npc_zombie" then
			givePetXP = math.random(10, 30)
		elseif npc:GetClass() == "npc_fastzombie" then
			givePetXP = math.random(15, 40)
		elseif npc:GetClass() == "npc_poisonzombie" then
			givePetXP = math.random(20, 50)
		else
			givePetXP = math.random(15, 40)
		end
		addPetXP(attacker.owner, givePetXP)
		net.Start("UpdatePetsXP")
			net.WriteInt(givePetXP, 32)
		net.Send(attacker.owner)
	end
	
	if attacker:IsPlayer() and not npc.owner then
		attacker.hl2cPersistent.KillCount = attacker.hl2cPersistent.KillCount + 1
		AddXP(attacker, giveXP)
		AddCoins(attacker, giveCoins)
		Spawn(giveXP, giveCoins, npc:GetPos(), npc, attacker)
	elseif npc.owner ~= attacker and attacker:IsPlayer() then
		npc.owner.petAlive = false
		net.Start("WarningPetKill")
			net.WriteInt(1, 8)
		net.Send(attacker)
	end
end)

function Spawn(xpAmt, coinAmt, pos, target, reciever)
	
	net.Start("IndicSpawn")
	
	net.WriteInt(xpAmt, 16)
	
	net.WriteInt(coinAmt, 16)
	
	net.WriteVector(pos)
	net.Send(reciever)

end