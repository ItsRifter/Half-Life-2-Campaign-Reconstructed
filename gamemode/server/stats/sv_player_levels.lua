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
		
		if ply.hl2cPersistent.Level == 5 then
			net.Start("NewSuit")
				net.WriteInt(ply.hl2cPersistent.Level, 16)
			net.Send(ply)
		elseif ply.hl2cPersistent.Level == 15 then
			net.Start("NewSuit")
				net.WriteInt(ply.hl2cPersistent.Level, 16)
			net.Send(ply)
		elseif ply.hl2cPersistent.Level == 25 then
			net.Start("NewSuit")
				net.WriteInt(ply.hl2cPersistent.Level, 16)
			net.Send(ply)
		elseif ply.hl2cPersistent.Level == 40 then
			net.Start("NewSuit")
				net.WriteInt(ply.hl2cPersistent.Level, 16)
			net.Send(ply)
		elseif ply.hl2cPersistent.Level == 60 then
			net.Start("NewSuit")
				net.WriteInt(ply.hl2cPersistent.Level, 16)
			net.Send(ply)
		elseif ply.hl2cPersistent.Level == 90 then
			net.Start("NewSuit")
				net.WriteInt(ply.hl2cPersistent.Level, 16)
			net.Send(ply)
		end
	end
end
