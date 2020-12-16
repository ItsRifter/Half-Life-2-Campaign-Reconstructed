AddCSLuaFile() -- Add itself to files to be sent to the clients, as this file is shared

--[[FRIENDLY_NPCS = {
	"npc_citizen"
}--]]
INVUL_NPCS = {
	["npc_alyx"] = true,
	["npc_barney"] = true,
	["npc_breen"] = true,
	["npc_dog"] = true,
	["npc_eli"] = true,
	["npc_fisherman"] = true,
	["npc_gman"] = true,
	["npc_kleiner"] = true,
	["npc_magnusson"] = true,
	["npc_monk"] = true,
	["npc_mossman"] = true
}

--[[VORTI_FRIENDLY = {
	"npc_vortigaunt",
}--]]

local RESTRICTED_NPCS = {
	["npc_antlion"] = true,
	["zpn_pumpkin_boss"] = true
}

hook.Add("EntityTakeDamage", "FriendOrFoe", function(ent, dmgInfo)
	friendlyMaps = {
		"d1_trainstation_01",
		"d1_trainstation_02",
		"d1_trainstation_03",
		"d1_trainstation_04",
		"d1_trainstation_05",
		"d1_trainstation_06",
		"d1_canals_01",
		"d1_canals_01a",
		"d1_canals_02",
		"d1_canals_03",
		"d1_canals_05",
		"d1_canals_06",
		"d1_canals_07",
		"d1_canals_08",
		"d1_canals_09",
		"d1_canals_10",
		"d1_canals_11",
		"d1_canals_12",
		"d1_canals_13",
		"d1_eli_01",
		"d1_eli_02",
		"d1_town_01",
		"d1_town_01a",
		"d1_town_02",
		"d1_town_03",
		"d1_town_02",
		"d1_town_02a",
		"d1_town_04",
		"d1_town_05",
		"d2_coast_01",
		"d2_coast_03",
		"d2_coast_04",
		"d2_coast_05",
		"d2_coast_07",
		"d2_coast_08",
		"d2_coast_09",
		"d2_coast_10",
		"d2_coast_11",
		"d2_coast_12",
		"d2_prison_01",
		"d2_prison_02",
		"d2_prison_03",
		"d2_prison_04",
		"d2_prison_05",
		"d2_prison_06",
		"d2_prison_07",
		"d2_prison_08",
		"d3_c17_01",
		"d3_c17_02",
		"d3_c17_03",
		"d3_c17_04",
		"d3_c17_05",
		"d3_c17_06a",
		"d3_c17_06b",
		"d3_c17_07",
		"d3_c17_08",
		"d3_c17_09",
		"d3_c17_10a",
		"d3_c17_10b",
		"d3_c17_11",
		"d3_c17_12",
		"d3_c17_12b",
		"d3_c17_13",
		"d3_citadel_01",
		"d3_citadel_03",
		"d3_citadel_04",
		"d3_citadel_05",
		"d3_breen_01",
		"ep2_outland_01",
		"ep2_outland_02",
		"ep2_outland_03",
		"ep2_outland_04",
		"ep2_outland_05",
		"ep2_outland_06",
		"ep2_outland_11",
		"ep2_outland_11b",
	}

	local attacker = dmgInfo:GetAttacker()
	local dmg = dmgInfo:GetDamage()
	local inflictor = dmgInfo:GetInflictor()
	if attacker:IsPet() and ent:IsNPC() then
		ent:AddEntityRelationship(attacker, D_HT, 15)
		local totalDMG = dmg + attacker:GetNWInt("PetStr")
		dmgInfo:SetDamage(totalDMG)
	end

	if ent:IsPet() and (attacker:IsNPC() and INVUL_NPCS[attacker:GetClass()]) then
		attacker:AddEntityRelationship(ent, D_LI, 99)
		dmgInfo:SetDamage(0)
	end

	if INVUL_NPCS[ent:GetClass()] or (attacker:IsPlayer() and attacker:Team() == TEAM_ALIVE and ent:GetClass() == "npc_citizen") then
		dmgInfo:SetDamage(0)
		return
	end
	if ent:GetClass() == "npc_vortigaunt" then
		for k, m in pairs(friendlyMaps) do
			if game.GetMap() == m then
				dmgInfo:SetDamage(0)
				return
			end
		end
	end

	if ent:IsPet() and ent.owner:IsValid() and attacker:IsNPC() then
		ent:SetHealth(ent:Health() - dmg)
	end

	if attacker:IsPet() and attacker.owner and attacker:GetClass() != "npc_headcrab" then
		local totalPetDMG = math.Round((attacker.owner.hl2cPersistent.PetStr * dmg) / GetConVar("hl2cr_difficulty"):GetInt())
		dmgInfo:SetDamage(totalPetDMG)
	end
end)
if SERVER then

	hook.Add("Think", "NPCThinkRelation", function()
		--Loyal Players relation with combine npc
		for k, v in pairs(player.GetAll()) do
			if v:Team() == TEAM_LOYAL then
				for i, cits in pairs(ents.FindByClass("npc_citizen")) do
					cits:AddEntityRelationship(v, D_HT, 99)
				end
				for i, combine in pairs(ents.FindByClass("npc_combine_s")) do
					combine:AddEntityRelationship(v, D_LI, 99)
				end
			else
				for i, cits in pairs(ents.FindByClass("npc_citizen")) do
					cits:AddEntityRelationship(v, D_LI, 99)
				end
				for i, combine in pairs(ents.FindByClass("npc_combine_s")) do
					combine:AddEntityRelationship(v, D_HT, 99)
				end
			end
		end

		local NEUTRAL_MAPS = {
			["d1_trainstation_01"] = true,
			["d1_trainstation_02"] = true,
			["d1_trainstation_03"] = true
		}
		--If server is on first three maps, make everyone neutral until hostility is activated
		if NEUTRAL_MAPS[game.GetMap()] and not activateHostility then
			for k, pl in pairs(player.GetAll()) do
				for i, cits in pairs(ents.FindByClass("npc_citizen")) do
					cits:AddEntityRelationship(pl, D_NU, 99)
					for m, combine in pairs(ents.FindByClass("npc_metropolice")) do
						combine:AddEntityRelationship(pl, D_NU, 99)
						combine:AddEntityRelationship(cits, D_NU, 99)
						cits:AddEntityRelationship(combine, D_NU, 99)
					end
				end
			end
		else
			for k, pl in pairs(player.GetAll()) do
				for i, cits in pairs(ents.FindByClass("npc_citizen")) do
					cits:AddEntityRelationship(pl, D_LI, 99)
					for m, combine in pairs(ents.FindByClass("npc_metropolice")) do
						combine:AddEntityRelationship(pl, D_HT, 99)
						combine:AddEntityRelationship(cits, D_HT, 99)
						cits:AddEntityRelationship(combine, D_HT, 99)
					end
				end
			end
		end

		if game.GetMap() == "d2_coast_10" then
			for k, gunship in pairs(ents.FindByClass("npc_combinegunship")) do
				if gunship:IsValid() and gunship:Health() <= 0 then
					endLoyal()
				end
			end
		end
			
		if game.GetMap() == "ep1_c17_02a" then
			for k, gunship in pairs(ents.FindByClass("npc_combinegunship")) do
				if gunship:IsValid() and gunship:Health() <= 0 then
					for k, v in pairs(player.GetAll()) do
						Achievement(v, "Attica", "EP1_Ach_List")
					end
				end
			end
		end

		for k, npc in pairs(ents.FindByClass("npc_*")) do
			for n, pet in pairs(ents.FindByClass("npc_*")) do
				if pet:IsPet() and not npc:IsPet() then
					if npc:IsFriendly() then
						npc:AddEntityRelationship(pet, D_LI, 99)
						pet:AddEntityRelationship(npc, D_LI, 99)
					elseif game.GetGlobalState("antlion_allied") == 1 and npc:GetClass() == "npc_antlion" then
						npc:AddEntityRelationship(pet, D_LI, 99)
						pet:AddEntityRelationship(npc, D_LI, 99)
					elseif npc:IsPet() then
						pet:AddEntityRelationship(npc, D_LI, 99)
						npc:AddEntityRelationship(pet, D_LI, 99)
					elseif not npc:IsFriendly() then
						pet:AddEntityRelationship(npc, D_HT, 99)
					end
				end
			end
		end
	end)
	hook.Add("Think", "UpdateNPC", function()
		if GetConVar("hl2cr_doublehp"):GetInt() == 1 then
			for k, dbNPC in pairs(ents.FindByClass("npc_*")) do
				if not dbNPC.doubled and not dbNPC:IsPet() then
					dbNPC:SetHealth(dbNPC:Health() * 2)
					dbNPC.doubled = true
				end
			end
		end
	end)
	
	hook.Add("OnEntityCreated", "SpecialChanger", function(ent)
		if GetConVar("hl2cr_specials"):GetInt() == 1 then
			if ent:IsNPC() then
				if ent:GetName() != "" or ent.Changed == true then return end
				if ent:GetClass() == "npc_combine_s" or ent:GetClass() == "npc_metropolice" then
					local specialChance = math.random(1, 100)
					if specialChance <= (12 * GetConVar("hl2cr_difficulty"):GetInt()) then
						local newNPC = nil
						local NPCKind = math.random(1, 5)
							
						if NPCKind == 1 then
							newNPC = ents.Create("npc_combine_assassin")
						elseif NPCKind == 2 then
							newNPC = ents.Create("npc_combine_support")
						elseif NPCKind == 3 then
							newNPC = ents.Create("npc_combine_medic")
						elseif NPCKind == 4 then
							newNPC = ents.Create("npc_combine_veteran")
						elseif NPCKind == 5 then
							newNPC = ents.Create("npc_combine_grenadier")
						end
						
						
						timer.Simple(1, function()
							if ent:IsValid() then
								ent:Remove()
								newNPC:SetPos(ent:GetPos() + Vector(0, 0, 30))
								newNPC:Spawn()
								ent.Changed = true
							end
						end)
						
			
					elseif specialChance > (12 * GetConVar("hl2cr_difficulty"):GetInt()) then 
						ent.Changed = true
					end
				end
			end
		end
	end)
	

	hook.Add("ScaleNPCDamage", "DiffScalingNPC", function(ent, hitGroup, dmgInfo)

		--local inflictor = dmgInfo:GetDamageType() --Unused variable: inflictor
		local attacker = dmgInfo:GetAttacker()
		local dmg = dmgInfo:GetDamage()
		--local dmg = dmgInfo:GetDamage()--Unused variable: dmg
		local upgDmg = 0
		if attacker:IsPlayer() and table.HasValue(attacker.hl2cPersistent.TempUpg, "Shotgun_Blaster") then
			upgDmg = 0.35
		end

		if attacker:IsPlayer() and (INVUL_NPCS[ent:GetClass()] or ent:GetClass() == "npc_citizen" or ent:IsPet()) then
			dmgInfo:SetDamage(0)
			return
		elseif attacker:IsPlayer() and attacker:GetActiveWeapon():GetClass() == "weapon_crowbar" then
			dmgInfo:ScaleDamage(1.75 / GetConVar("hl2cr_difficulty"):GetInt())
		elseif attacker:IsPlayer() and attacker:GetActiveWeapon():GetClass() == "weapon_shotgun" then
			dmgInfo:ScaleDamage(upgDmg + 1.55 / GetConVar("hl2cr_difficulty"):GetInt())
		else
			dmgInfo:ScaleDamage(1.55 / GetConVar("hl2cr_difficulty"):GetInt())
		end

		--if ent:GetClass() == "npc_combinegunship" then
		--	attacker.sharedXP = attacker.sharedXP + dmg * GetConVar("hl2cr_difficulty"):GetInt()
		--end
	end)
end

hook.Add("OnNPCKilled", "HalloweenEventNPC", function(npc, attacker, inflictor)
	if GetConVar("hl2cr_halloween"):GetInt() == 0 then return end
	if RESTRICTED_NPCS[npc:GetClass()] then return end
	
	local randCandyChance = math.random(1, 25)
	local randCandy = math.random(1, 3)
	
	if attacker:IsPlayer() then
		if randCandyChance > 15 then
			for i = 0, randCandy do
				local randPosX = math.random(1, 90)
				local randPosY = math.random(1, 90)
				local candy = ents.Create("zpn_candy")
				candy:SetCandy(1)
				candy:SetPos(Vector(npc:GetPos().x + randPosX, npc:GetPos().y + randPosY, npc:GetPos().z + 25))
				candy:Spawn()
			end
		end
	end
end)