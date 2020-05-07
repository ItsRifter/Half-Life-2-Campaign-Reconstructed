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
hook.Add("EntityTakeDamage", "DisableExplosiveDMG", function(ent, dmgInfo)
	local attacker = dmgInfo:GetAttacker()
	local dmg = dmgInfo:GetDamage()
	
	if ent:IsPet() and ent:IsValid() and ent.owner then
		net.Start("UpdatePetsHealthDMG")
			net.WriteInt(-dmg, 32)
		net.Send(ent.owner)
	end

	
	if attacker:IsPet() then
		ent:AddEntityRelationship(attacker, D_HT, 15)
		local totalDMG = dmg + attacker:GetNWInt("PetStr")
		dmgInfo:SetDamage(totalDMG)
	end
	
	if table.HasValue(INVUL_NPCS, ent:GetClass()) or (attacker:IsPlayer() and table.HasValue(FRIENDLY_NPCS, ent:GetClass())) then
		dmgInfo:SetDamage(0)
		return
	end
end)


hook.Add("ScaleNPCDamage", "DiffScaling", function(npc, hitGroup, dmgInfo)
	
	local inflictor = dmgInfo:GetDamageType()
	local attacker = dmgInfo:GetAttacker()
	local dmg = dmgInfo:GetDamage()
 	
	if table.HasValue(INVUL_NPCS, npc:GetClass()) or attacker:IsPlayer() and table.HasValue(FRIENDLY_NPCS, npc:GetClass()) and npc:IsPet() then
		dmgInfo:SetDamage(0)
		return
	else
		dmgInfo:SetDamage(dmg)
	end
	
	if hitGroup == HITGROUP_HEAD then
		hitGroupScale = 2
	else
		hitGroupScale = 1
	end
	
	--if npc:GetClass() == "npc_combinegunship" then
	--	attacker.sharedXP = attacker.sharedXP + dmg * GetConVar("hl2c_difficulty"):GetInt()
	--end
	
	dmgInfo:ScaleDamage(hitGroupScale / GetConVar("hl2c_difficulty"):GetInt())
end)