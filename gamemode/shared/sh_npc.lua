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
	"npc_vortigaunt",
}

function GM:EntityTakeDamage(ent, dmgInfo)
	local attacker = dmgInfo:GetAttacker()
	local dmg = dmgInfo:GetDamage()
	
	if table.HasValue(INVUL_NPCS, ent:GetClass()) or (attacker:IsPlayer() and table.HasValue(FRIENDLY_NPCS, ent:GetClass())) then
		dmgInfo:SetDamage(0)
		return
	end
end

function GM:ScaleNPCDamage(npc, hitGroup, dmgInfo)
	
	local inflictor = dmgInfo:GetDamageType()
	local attacker = dmgInfo:GetAttacker()
 	
	if table.HasValue(INVUL_NPCS, npc:GetClass()) and attacker:IsPlayer() or table.HasValue(FRIENDLY_NPCS, npc:GetClass()) then
		dmgInfo:SetDamage(0)
	return
	end
	
	if hitGroup == HITGROUP_HEAD then
		hitGroupScale = 2
	else
		hitGroupScale = 1
	end
	
	dmgInfo:ScaleDamage(hitGroupScale / GetConVar("hl2c_difficulty"):GetInt())
end