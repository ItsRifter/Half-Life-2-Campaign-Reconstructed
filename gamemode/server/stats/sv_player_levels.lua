function AddXP(ply, amt)
	
	ply.hl2cPersistent.XP = ply.hl2cPersistent.XP + amt 

	if (ply.hl2cPersistent.XP >= tonumber(ply.hl2cPersistent.MaxXP)) then
		ply.hl2cPersistent.MaxXP = (ply.hl2cPersistent.MaxXP / 1.5) * ply.hl2cPersistent.Level
		math.ceil(ply.hl2cPersistent.MaxXP)
		ply.hl2cPersistent.Level = ply.hl2cPersistent.Level + 1
		ply.hl2cPersistent.XP = 0
		ply:SetNWInt("Level", ply.hl2cPersistent.Level)
		print(ply.hl2cPersistent.Level)
		net.Start("PlaySoundLevelUp")
		net.Send(ply)
		for k, v in pairs(player.GetAll()) do
			v:ChatPrint(ply:Nick() .. " has leveled up to " .. ply.hl2cPersistent.Level)
		end
		if ply.hl2cPersistent.Level == 5 then
			ply:ChatPrint("Your help to the resistance has granted you rebellion suits!")
		elseif ply.hl2cPersistent.Level == 15 then
			ply:ChatPrint("Your help to the resistance has granted you medic suits!")
		elseif ply.hl2cPersistent.Level == 25 then
			ply:ChatPrint("You have submitted to the combine, they grant you a Civil Protection Suit!")
		elseif ply.hl2cPersistent.Level == 40 then
			ply:ChatPrint("Your loyalty has been very appreciated by the combine, they grant you a soldier Suit!")
		elseif ply.hl2cPersistent.Level == 60 then
			ply:ChatPrint("Your great loyalty has been very appreciated by the combine, they grant you an elite Suit!")
		elseif ply.hl2cPersistent.Level == 100 then
			ply:ChatPrint("You resign and flee from the combine, upon doing so you have discovered an old HEV suit")
		end
	end
end

function GetLevel(ply)
	return ply.hl2cPersistent.Level
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