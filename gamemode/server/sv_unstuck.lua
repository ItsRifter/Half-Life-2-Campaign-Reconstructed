function IsStuck(ply)
	
	if not IsValid(ply) then return end
	
	local pos = ply:GetPos()
	ply:SetPos(Vector(pos.x, pos.y, pos.z + 75))
end
