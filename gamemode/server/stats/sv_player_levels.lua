function AddXP(ply, amt)
	local maxXP = 250
	
	ply.hl2cPersistent.XP = ply.hl2cPersistent.XP + amt 
	
	if (ply.hl2cPersistent.XP >= maxXP) then
		maxXP = maxXP * 3.5
		ply.hl2cPersistent.Level = ply.hl2cPersistent.Level + 1
		ply.hl2cPersistent.XP = 0
		print("Max xp is now " .. maxXP)
		print(ply.hl2cPersistent.Level)
		for k, v in pairs(player.GetAll()) do
			v:ChatPrint(ply:Nick() .. " has leveled up to " .. ply.hl2cPersistent.Level)
		end
		if ply.hl2cPersistent.Level == 5 then
			ply:ChatPrint("Your help to the resistance has granted you rebellion suits!")
		end
		
		if ply.hl2cPersistent.Level == 10 then
			ply:ChatPrint("Your help to the resistance has granted you medic suits!")
		end
		
		if ply.hl2cPersistent.Level == 20 then
			ply:ChatPrint("You have submitted to the combine, they grant you a Civil Protection Suit!")
		end
		
		if ply.hl2cPersistent.Level == 35 then
			ply:ChatPrint("Your loyalty has been very appreciated by the combine, they grant you a soldier Suit!")
		end
		
		if ply.hl2cPersistent.Level == 55 then
			ply:ChatPrint("Your great loyalty has been very appreciated by the combine, they grant you an elite Suit!")
		end
	end
end

function GetLevel(ply)
	return ply.hl2cPersistent.Level
end

function SetLevel(ply, lvl)
	ply.hl2cPersistent.Level = lvl
end

net.Receive("GiveXP", function(len, ply)
	local amount = net.ReadInt(16)
	AddXP(ply, amount)
end)

net.Receive("SetLevel", function(len, ply)
	local level = net.ReadInt(16)
	SetLevel(ply, level)
end)