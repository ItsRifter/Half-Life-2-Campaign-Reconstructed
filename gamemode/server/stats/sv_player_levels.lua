function AddXP(ply, amt)
	
	if ply.hl2cPersistent.Level < ply.hl2cPersistent.LevelCap then
		ply.hl2cPersistent.XP = ply.hl2cPersistent.XP + amt 
		ply:SetNWInt("XP", math.Round(ply.hl2cPersistent.XP))
	elseif ply.hl2cPersistent.Level >= ply.hl2cPersistent.LevelCap then
		ply.hl2cPersistent.XP = 0
		ply:SetNWInt("XP", math.Round(ply.hl2cPersistent.XP))
	end
	
	local levelChanged = false
	-- ply.hl2cPersistent.MaxXP needs to be larger than 0, or this will loop infinitely
	while ply.hl2cPersistent.XP >= ply.hl2cPersistent.MaxXP and ply.hl2cPersistent.MaxXP > 0 do
			-- Additional stop condition: Level cap
		if ply.hl2cPersistent.Level >= ply.hl2cPersistent.LevelCap then
			ply.hl2cPersistent.XP = math.min(ply.hl2cPersistent.XP, ply.hl2cPersistent.MaxXP)
			break
		end
		
		ply.hl2cPersistent.XP = ply.hl2cPersistent.XP - ply.hl2cPersistent.MaxXP
		ply.hl2cPersistent.MaxXP = ply.hl2cPersistent.MaxXP + 350
		ply.hl2cPersistent.Level = ply.hl2cPersistent.Level + 1
		
		levelChanged = true
	end
  
  -- Only send the level up notification once
	if levelChanged then
		ply:SetNWInt("Level", ply.hl2cPersistent.Level)
			ply:SetNWInt("XP", math.Round(ply.hl2cPersistent.XP))
			ply:SetNWInt("maxXP", math.Round(ply.hl2cPersistent.MaxXP))
		
		net.Start("PlaySoundLevelUp")
			net.WriteInt(ply.hl2cPersistent.Level, 32)
		net.Send(ply)
	end
end

function AddBonusXP(ply, bonusAmt)
	
	if ply.hl2cPersistent.Level < ply.hl2cPersistent.LevelCap then
		ply.hl2cPersistent.XP = ply.hl2cPersistent.XP + bonusAmt 
		ply:SetNWInt("XP", math.Round(ply.hl2cPersistent.XP))
	elseif ply.hl2cPersistent.Level >= ply.hl2cPersistent.LevelCap then
		ply.hl2cPersistent.XP = 0
		ply:SetNWInt("XP", math.Round(ply.hl2cPersistent.XP))
	end
	
	ply:ChatPrint("BONUS XP: " .. bonusAmt)
	
	local levelChanged = false
	-- ply.hl2cPersistent.MaxXP needs to be larger than 0, or this will loop infinitely
	while ply.hl2cPersistent.XP >= ply.hl2cPersistent.MaxXP and ply.hl2cPersistent.MaxXP > 0 do
			-- Additional stop condition: Level cap
		if ply.hl2cPersistent.Level >= ply.hl2cPersistent.LevelCap then
			ply.hl2cPersistent.XP = math.min(ply.hl2cPersistent.XP, ply.hl2cPersistent.MaxXP)
			break
		end
		
		ply.hl2cPersistent.XP = ply.hl2cPersistent.XP - ply.hl2cPersistent.MaxXP
		ply.hl2cPersistent.MaxXP = ply.hl2cPersistent.MaxXP + 350
		ply.hl2cPersistent.Level = ply.hl2cPersistent.Level + 1
		
		levelChanged = true
	end
end

function prestige(ply)
	ply.hl2cPersistent.Prestige = ply.hl2cPersistent.Prestige + 1
	ply.hl2cPersistent.LevelCap = ply.hl2cPersistent.LevelCap + 10
	
	ply.hl2cPersistent.Level = 1
	ply.hl2cPersistent.XP = 0
	ply.hl2cPersistent.MaxXP = 500
	
	table.Empty(ply.hl2cPersistent.Inventory)
	table.Empty(ply.hl2cPersistent.PermUpg)
	ply.hl2cPersistent.InvSpace = 0
	ply.hl2cPersistent.Armour = 0
	ply.hl2cPersistent.Helmet = ""
	ply.hl2cPersistent.Suit = ""
	ply.hl2cPersistent.Arm = ""
	ply.hl2cPersistent.Hands = ""
	ply.hl2cPersistent.Boot = ""
	ply.hl2cPersistent.InvWeapon = ""
	
	ply.hl2cPersistent.HelmetImage = ""
	ply.hl2cPersistent.SuitImage = ""
	ply.hl2cPersistent.ArmImage = ""
	ply.hl2cPersistent.HandsImage = ""
	ply.hl2cPersistent.BootImage = ""
	ply.hl2cPersistent.InvWeaponImage = ""

	
	ply:SetNWInt("Level", ply.hl2cPersistent.Level)
	ply:SetNWInt("XP", ply.hl2cPersistent.XP)
	ply:SetNWInt("maxXP", ply.hl2cPersistent.MaxXP)
	ply:SetNWInt("Prestige", ply.hl2cPersistent.Prestige)
	ply:SetNWInt("Armour", ply.hl2cPersistent.Armour)
	ply:SetNWString("WepSlot", ply.hl2cPersistent.InvWeaponImage)
	ply:ChatPrint("You have prestiged, Congratulations!")
	
	if ply.hl2cPersistent.Prestige == 1 then
		ply:ChatPrint("NEW ITEMS IN SHOP")
	elseif ply.hl2cPersistent.Prestige == 2 then
		ply:ChatPrint("NEW UPGRADES AND ITEMS IN SHOP")
	end
end

net.Receive("BeginPrestige", function(len, ply)
	if not ply then return end
	
	prestige(ply)
end)