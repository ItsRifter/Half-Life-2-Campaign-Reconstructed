function AddXP(ply, amt)
	ply.hl2cPersistent.XP = ply.hl2cPersistent.XP + amt 
	ply:SetNWInt("XP", math.Round(ply.hl2cPersistent.XP))
	
	while tonumber(ply.hl2cPersistent.XP) >= tonumber(ply.hl2cPersistent.MaxXP) do
		math.ceil(ply.hl2cPersistent.MaxXP)
		ply.hl2cPersistent.Level = ply.hl2cPersistent.Level + 1
		ply.hl2cPersistent.XP = ply.hl2cPersistent.XP - ply.hl2cPersistent.MaxXP
		ply.hl2cPersistent.MaxXP = ply.hl2cPersistent.MaxXP + 500
		ply:SetNWInt("Level", ply.hl2cPersistent.Level)
		ply:SetNWInt("XP", math.Round(ply.hl2cPersistent.XP))
		ply:SetNWInt("maxXP", math.Round(ply.hl2cPersistent.MaxXP))
		
		net.Start("PlaySoundLevelUp")
			net.WriteInt(ply.hl2cPersistent.Level, 32)
		net.Send(ply)
	end
end
