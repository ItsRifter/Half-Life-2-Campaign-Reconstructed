function AddXP(ply, amt)
	ply.hl2cPersistent.XP = ply.hl2cPersistent.XP + amt 
	ply:SetNWInt("XP", math.Round(ply.hl2cPersistent.XP))
	
	while tonumber(ply.hl2cPersistent.XP) >= tonumber(ply.hl2cPersistent.MaxXP) do
		math.ceil(ply.hl2cPersistent.MaxXP)
		ply.hl2cPersistent.Level = ply.hl2cPersistent.Level + 1
		ply.hl2cPersistent.XP = ply.hl2cPersistent.XP - ply.hl2cPersistent.MaxXP
		ply.hl2cPersistent.MaxXP = ply.hl2cPersistent.MaxXP + 250
		ply:SetNWInt("Level", ply.hl2cPersistent.Level)
		ply:SetNWInt("XP", math.Round(ply.hl2cPersistent.XP))
		ply:SetNWInt("maxXP", math.Round(ply.hl2cPersistent.MaxXP))
		net.Start("PlaySoundLevelUp")
			net.WriteInt(ply.hl2cPersistent.Level, 32)
		net.Send(ply)

		if tonumber(ply.hl2cPersistent.Level) >= tonumber(ply.hl2cPersistent.Milestone) then
			ply.hl2cPersistent.Milestone = ply.hl2cPersistent.Milestone + 5
		end
		
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

net.Receive("GiveXP", function(len, ply)
	local amount = net.ReadInt(16)
	AddXP(ply, amount)
end)

net.Receive("SetLevel", function(len, ply)
	local level = net.ReadInt(16)
	ply.hl2cPersistent.Level = level
	ply.hl2cPersistent.XP = 0
	ply:SetNWInt("Level", ply.hl2cPersistent.Level)
end)

net.Receive("SetMaxXP", function(len, ply)
	local maxXP = net.ReadInt(16)
	ply.hl2cPersistent.MaxXP = maxXP
	ply:SetNWInt("maxXP", math.Round(ply.hl2cPersistent.MaxXP))
end)