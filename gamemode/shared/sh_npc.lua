AddCSLuaFile() -- Add itself to files to be sent to the clients, as this file is shared

FRIENDLY_NPCS = {
	"npc_citizen"
}
INVUL_NPCS = {
	"npc_alyx",
	"npc_barney",
	"npc_breen",
	"npc_dog",
	"npc_eli",
	"npc_fisherman",
	"npc_gman",
	"npc_kleiner",
	"npc_magnusson",
	"npc_monk",
	"npc_mossman",
}	

VORTI_FRIENDLY = {
	"npc_vortigaunt",
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
	}
	
	local attacker = dmgInfo:GetAttacker()
	local dmg = dmgInfo:GetDamage()
	
	if attacker:IsPet() then
		ent:AddEntityRelationship(attacker, D_HT, 15)
		local totalDMG = dmg + attacker:GetNWInt("PetStr")
		dmgInfo:SetDamage(totalDMG)
	end
	
	if ent:IsPet() and (attacker:IsNPC() and table.HasValue(INVUL_NPCS, attacker:GetClass())) then
		attacker:AddEntityRelationship(ent, D_LI, 99)
		dmgInfo:SetDamage(0)
	end
	
	if table.HasValue(INVUL_NPCS, ent:GetClass()) or (attacker:IsPlayer() and attacker:Team() == TEAM_ALIVE and table.HasValue(FRIENDLY_NPCS, ent:GetClass())) then
		dmgInfo:SetDamage(0)
		return
	end
	if table.HasValue(VORTI_FRIENDLY, ent:GetClass()) then
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
end)

hook.Add("Think", "NPCThinkRelation", function()
	for k, v in pairs(player.GetAll()) do
		if v:Team() == TEAM_LOYAL then
			for i, cits in pairs(ents.FindByClass("npc_citizen")) do
				cits:AddEntityRelationship(v, D_HT, 99)
			end
			for i, combine in pairs(ents.FindByClass("npc_combine_s")) do
				combine:AddEntityRelationship(v, D_LI, 99)
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
end)

hook.Add("ScaleNPCDamage", "DiffScalingNPC", function(ent, hitGroup, dmgInfo)
	
	local inflictor = dmgInfo:GetDamageType()
	local attacker = dmgInfo:GetAttacker()
	local dmg = dmgInfo:GetDamage()
 	
	if table.HasValue(INVUL_NPCS, ent:GetClass()) or attacker:IsPlayer() and table.HasValue(FRIENDLY_NPCS, ent:GetClass()) and ent:IsPet() then
		dmgInfo:SetDamage(0)
		return
	elseif attacker:IsPlayer() and attacker:GetActiveWeapon():GetClass() == "weapon_crowbar" then
		dmgInfo:ScaleDamage(1.75 / GetConVar("hl2cr_difficulty"):GetInt())
	else
		dmgInfo:ScaleDamage(1.55 / GetConVar("hl2cr_difficulty"):GetInt())
	end
	
	--if ent:GetClass() == "npc_combinegunship" then
	--	attacker.sharedXP = attacker.sharedXP + dmg * GetConVar("hl2cr_difficulty"):GetInt()
	--end
end)