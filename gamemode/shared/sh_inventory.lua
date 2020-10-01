AddCSLuaFile()

net.Receive("Purchase", function(len, ply)
	local itemName = net.ReadString()
	local itemCost = net.ReadInt(32)

	if not ply then return end
	SubCoins(ply, itemCost)
	
	ply.hl2cPersistent.InvSpace = ply.hl2cPersistent.InvSpace + 1
	ply:SetNWInt("InvSpace", ply.hl2cPersistent.InvSpace)
	
	table.insert(ply.hl2cPersistent.Inventory, itemName)
	
	ply:SetNWString("Inventory", table.concat(ply.hl2cPersistent.Inventory, itemName))
end)

net.Receive("Exchange", function(len, ply)
	local exchangeAmt = net.ReadInt(32)
	local total = 0
	if exchangeAmt <= 0 then
		ply:ChatPrint("Nice try human")
		return
	end
	
	total = randomExchange * exchangeAmt

	ply.hl2cPersistent.Coins = ply.hl2cPersistent.Coins - total
	ply.hl2cPersistent.Essence = ply.hl2cPersistent.Essence + exchangeAmt
	
	ply:SetNWInt("Coins", math.Round(ply.hl2cPersistent.Coins))
	ply:SetNWInt("Essence", math.Round(ply.hl2cPersistent.Essence))
	
end)

net.Receive("Upgrade", function(len, ply)
	local UpgName = net.ReadString()
	local UpgCost = net.ReadInt(16)
	
	if not ply then return end
	
	SubEssen(ply, UpgCost)
	
	table.insert(ply.hl2cPersistent.TempUpg, UpgName)

end)

local chance = 0

local NO_REWARDS = {
	["d1_trainstation_01"] = true,
	["d1_trainstation_02"] = true,
	["d1_trainstation_03"] = true,
	["d1_trainstation_04"] = true,
	["d1_trainstation_05"] = true
}

function giveRewards(ply)
	if ply.hasDiedOnce then
		ply.tableRewards["HasDied"] = true
	end
	
	if ply.tableRewards["Kills"] >= 5 and ply.tableRewards["Kills"] < 10 then
		chance = 5
	elseif ply.tableRewards["Kills"] >= 10 and ply.tableRewards["Kills"] < 15 then
		chance = 10
	elseif ply.tableRewards["Kills"] >= 15 and ply.tableRewards["Kills"] < 20 then
		chance = 15
	elseif ply.tableRewards["Kills"] >= 20 then
		chance = 20
	end
	
	local metalChance = math.random(1, 75)
	
	if chance >= metalChance then
		local metalEarned = math.random(1, 10)
		ply.tableRewards["Metal"] = metalEarned
		ply.hl2cPersistent.ScrapMetal = ply.hl2cPersistent.ScrapMetal + metalEarned
		ply:SetNWInt("Scrap", ply.hl2cPersistent.ScrapMetal)
	end
	
	if ply.tableRewards["Kills"] != 0 then
		randCoins = math.random(1, 10 * ply.tableRewards["Kills"])
		ply.hl2cPersistent.Coins = ply.hl2cPersistent.Coins + randCoins
		ply:SetNWInt("Coins", ply.hl2cPersistent.Coins)
		
		randXP = math.random(1, 10 * ply.tableRewards["Kills"])
		ply.hl2cPersistent.XP = ply.hl2cPersistent.XP + randXP
		ply:SetNWInt("XP", ply.hl2cPersistent.XP)
	else
		randCoins = 0
		randXP = 0
	end

	if not NO_REWARDS[game.GetMap()] then
		net.Start("ShowEndStats")
			net.WriteInt(randCoins, 32)
			net.WriteInt(randXP, 32)
			net.WriteTable(ply.tableRewards)
			net.WriteInt(GetConVar("hl2cr_difficulty"):GetInt(), 8)
		net.Send(ply)
	end
end

net.Receive("AddWeapon", function(len, ply)
	local slotToFill = net.ReadString()
	local slotImage = net.ReadString()
	
	if not ply then return end
	
	ply.hl2cPersistent.InvWeapon = slotToFill
	ply.hl2cPersistent.InvWeaponImage = slotImage
	ply:SetNWString("WepSlot", ply.hl2cPersistent.InvWeaponImage)
	
	table.RemoveByValue(ply.hl2cPersistent.Inventory, slotToFill)
	
	ply.hl2cPersistent.InvSpace = ply.hl2cPersistent.InvSpace - 1 
	
end)

net.Receive("AddArmour", function(len, ply)
	local slotToFill = net.ReadString()
	local slotImage = net.ReadString()
	local slot = net.ReadString()
	local shieldPoints = net.ReadInt(16)
	
	if not ply then return end

	ply.hl2cPersistent.Armour = ply.hl2cPersistent.Armour + shieldPoints

	
	if ply.hl2cPersistent.Helmet != "" and slot == "Helmet" then
		table.insert(ply.hl2cPersistent.Inventory, ply.hl2cPersistent.Helmet)
		ply.hl2cPersistent.Armour = ply.hl2cPersistent.Armour - ply:GetNWInt("OldArmourHelmet")
	end
	
	if ply.hl2cPersistent.Suit != "" and slot == "Suit" then
		table.insert(ply.hl2cPersistent.Inventory, ply.hl2cPersistent.Suit)
		ply.hl2cPersistent.Armour = ply.hl2cPersistent.Armour - ply:GetNWInt("OldArmourSuit")
	end
	
	if ply.hl2cPersistent.Arm != "" and slot == "Arm" then
		table.insert(ply.hl2cPersistent.Inventory, ply.hl2cPersistent.Arm)
		ply.hl2cPersistent.Armour = ply.hl2cPersistent.Armour - ply:GetNWInt("OldArmourArm")
	end
	
	if ply.hl2cPersistent.Hands != "" and slot == "Hands" then
		table.insert(ply.hl2cPersistent.Inventory, ply.hl2cPersistent.Hands)
		ply.hl2cPersistent.Armour = ply.hl2cPersistent.Armour - ply:GetNWInt("OldArmourHand")
	end
	
	if ply.hl2cPersistent.Boot != "" and slot == "Boots" then
		table.insert(ply.hl2cPersistent.Inventory, ply.hl2cPersistent.Boot)
		ply.hl2cPersistent.Armour = ply.hl2cPersistent.Armour - ply:GetNWInt("OldArmourBoot")
	end
	
	table.RemoveByValue(ply.hl2cPersistent.Inventory, slotToFill)
	
	if slot == "Helmet" then
		ply.hl2cPersistent.Helmet = slotToFill
		ply.hl2cPersistent.HelmetImage = slotImage
		ply:SetNWString("HelmetSlot", ply.hl2cPersistent.HelmetImage)
		ply:SetNWInt("OldArmourHelmet", shieldPoints)
		
	elseif slot == "Suit" then
		ply.hl2cPersistent.Suit = slotToFill
		ply.hl2cPersistent.SuitImage = slotImage
		ply:SetNWString("SuitSlot", ply.hl2cPersistent.SuitImage)
		ply:SetNWInt("OldArmourSuit", shieldPoints)
		
	elseif slot == "Arm" then
		ply.hl2cPersistent.Arm = slotToFill
		ply.hl2cPersistent.ArmImage = slotImage
		ply:SetNWString("ArmSlot", ply.hl2cPersistent.ArmImage)
		ply:SetNWInt("OldArmourArm", shieldPoints)
		
	elseif slot == "Hands" then
		ply.hl2cPersistent.Hands = slotToFill
		ply.hl2cPersistent.HandsImage = slotImage
		ply:SetNWString("HandSlot", ply.hl2cPersistent.HandsImage)
		ply:SetNWInt("OldArmourHand", shieldPoints)
		
	elseif slot == "Boots" then
		ply.hl2cPersistent.Boot = slotToFill
		ply.hl2cPersistent.BootImage = slotImage
		ply:SetNWString("BootSlot", ply.hl2cPersistent.BootImage)
		ply:SetNWInt("OldArmourBoot", shieldPoints)
	end
	
	ply.hl2cPersistent.InvSpace = ply.hl2cPersistent.InvSpace - 1 
	ply:SetNWInt("InvSpace", ply.hl2cPersistent.InvSpace)
	ply:SetNWInt("Armour", ply.hl2cPersistent.Armour)
	
	
end)

net.Receive("SellItem", function(len, ply)
	local readItem = net.ReadString()
	local sellReturn = net.ReadInt(32)
	
	if not ply then return end
	
	sellReturn = math.Round(sellReturn / 3, 0)
	
	if table.HasValue(ply.hl2cPersistent.Inventory, readItem) then
	
		table.RemoveByValue(ply.hl2cPersistent.Inventory, readItem)
		
		ply.hl2cPersistent.InvSpace = ply.hl2cPersistent.InvSpace - 1
		ply:SetNWInt("InvSpace", ply.hl2cPersistent.InvSpace)
		
	end
	
	ply.hl2cPersistent.Coins = ply.hl2cPersistent.Coins + sellReturn
	ply:SetNWInt("Coins", ply.hl2cPersistent.Coins)
	
end)

net.Receive("SellItemSlot", function(len, ply)
	local readItem = net.ReadString()
	local sellReturn = net.ReadInt(32)
	local removePoints = net.ReadInt(16)
	
	if not ply then return end
	
	sellReturn = math.Round(sellReturn / 3)
	
	--Items in the head slot
	if string.find(ply.hl2cPersistent.Helmet, readItem) then
		ply.hl2cPersistent.Helmet = ""
		ply.hl2cPersistent.HelmetImage = ""
		ply:SetNWString("HelmetSlot", "")
	end
	
	--Items in the suit slot
	if string.find(ply.hl2cPersistent.Suit, readItem) then
		ply.hl2cPersistent.Suit = ""
		ply.hl2cPersistent.SuitImage = ""
		ply:SetNWString("SuitSlot", "")
	end
	
	--Items in the arm slot
	if string.find(ply.hl2cPersistent.Arm, readItem) then
		ply.hl2cPersistent.Arm = ""
		ply.hl2cPersistent.ArmImage = ""
		ply:SetNWString("ArmSlot", "")
	end
	
	if string.find(ply.hl2cPersistent.Boot, readItem) then
		ply.hl2cPersistent.Boot = ""
		ply.hl2cPersistent.BootImage = ""
		ply:SetNWString("BootSlot", "")
	end
	
	--Items in the head slot
	if string.find(ply.hl2cPersistent.Hands, readItem) then
		ply.hl2cPersistent.Hands = ""
		ply:SetNWString("HandSlot", "")
	end
	
	--Items in the weapon slot
	if string.find(ply.hl2cPersistent.InvWeapon, readItem) then
		ply.hl2cPersistent.InvWeapon = ""
		ply:SetNWString("WepSlot", "")
	end

	if removePoints then
		ply.hl2cPersistent.Armour = ply.hl2cPersistent.Armour - removePoints
	end
	ply.hl2cPersistent.Coins = ply.hl2cPersistent.Coins + sellReturn
	ply:SetNWInt("Armour", ply.hl2cPersistent.Armour)
	ply:SetNWInt("Coins", ply.hl2cPersistent.Coins)
end)
if CLIENT then
	
	surface.CreateFont("End_Stats_font", {
		font = "Arial",
		size = 28,
	})
	
	surface.CreateFont("Bonus_Items_Font", {
		font = "Arial",
		bold = true,
		size = 24,
	})
	
	surface.CreateFont("Rewards_Font", {
		font = "Arial",
		bold = true,
		size = 22,
	})
	
	net.Receive("ShowEndStats", function()
		
		local coins = net.ReadInt(32)
		local xp = net.ReadInt(32)
		local Rewards = net.ReadTable()
		
		local diffBoost = net.ReadInt(8)
		
		local endFrame = vgui.Create("DFrame")
		endFrame:SetSize(800, 600)
		endFrame:MakePopup()
		endFrame:SetTitle("End Map Rewards")
		endFrame:Center()
		endFrame:SetBackgroundBlur(true)
		
		local itemsPanel = vgui.Create("DPanel", endFrame)
		itemsPanel:SetSize(325, 400)
		itemsPanel:SetPos(25, 150)	
		
		local itemsLayout = vgui.Create("DIconLayout", itemsPanel)
		itemsLayout:Dock(FILL)
		itemsLayout:SetSpaceY(5)
		itemsLayout:SetSpaceX(10)
 		
		local coinReward = itemsLayout:Add("DImage")
		coinReward:SetSize(64, 64)
		coinReward:SetImage("hl2cr/misc/coins")
	
		local coinLabel = coinReward:Add("DLabel")
		coinLabel:SetFont("Bonus_Items_Font")
		coinLabel:SetText(coins) 
	
		local xpReward = itemsLayout:Add("DImage")
		xpReward:SetImage("hl2cr/misc/xp")
		xpReward:SetSize(64, 64)
		
		local xpLabel = xpReward:Add("DLabel")
		xpLabel:SetFont("Bonus_Items_Font")
		xpLabel:SetText(xp) 

		if Rewards["Metal"] != 0 then
			local scrapReward = itemsLayout:Add("DImage")
			scrapReward:SetImage("hl2cr/mats/scrap")
			scrapReward:SetSize(64, 64)
			
			local scrapLabel = scrapReward:Add("DLabel")
			scrapLabel:SetFont("Bonus_Items_Font")
			scrapLabel:SetText(Rewards["Metal"]) 
		end

		local itemsText = vgui.Create("DLabel", itemsPanel)
		itemsText:SetText("Bonus Items")
		itemsText:SetFont("End_Stats_font")
		itemsText:SetPos(itemsPanel:GetWide() / 3.5, 350)
		itemsText:SetColor(Color(0, 0, 0))
		itemsText:SizeToContents()
		
		local endTextPanel = vgui.Create("DPanel", endFrame)
		endTextPanel:SetSize(400, 475)
		endTextPanel:SetBackgroundColor(Color(255, 255, 255))
		endTextPanel:SetPos(400, 100)
		
		local rewardsLabel = vgui.Create("DLabel", endTextPanel)
		rewardsLabel:SetText("Rewards")
		rewardsLabel:SetPos(endTextPanel:GetWide() / 2.5, 20)
		rewardsLabel:SetColor(Color(0, 0, 0))
		rewardsLabel:SetFont("End_Stats_font")
		rewardsLabel:SizeToContents()

		local diffBoostText = vgui.Create("DLabel", endTextPanel)
		diffBoostText:SetText("Difficulty Multiplier: x" .. diffBoost) 
		diffBoostText:SetFont("Rewards_Font")
		diffBoostText:SizeToContents()	
		diffBoostText:SetColor(Color(0, 0, 0))
		diffBoostText:SetPos(0, 65)
		
		if not Rewards["HasDied"] then
			local rewardsTextNoDeaths = vgui.Create("DLabel", endTextPanel)
			rewardsTextNoDeaths:SetText("NO DEATHS: " .. 50 * diffBoost .. "XP, λ" .. 25 * diffBoost) 
			rewardsTextNoDeaths:SetFont("Rewards_Font")
			rewardsTextNoDeaths:SizeToContents()	
			rewardsTextNoDeaths:SetColor(Color(0, 0, 0))
			rewardsTextNoDeaths:SetPos(0, 95)
		end
		if Rewards["CrowbarOnly"] then
			local rewardsTextNoDeaths = vgui.Create("DLabel", endTextPanel)
			rewardsTextNoDeaths:SetText("CROWBAR ONLY: " .. 75 * diffBoost .. "XP, λ" .. 45 * diffBoost) 
			rewardsTextNoDeaths:SetFont("Rewards_Font")
			rewardsTextNoDeaths:SizeToContents()	
			rewardsTextNoDeaths:SetColor(Color(0, 0, 0))
			rewardsTextNoDeaths:SetPos(0, 125)
		end
		
		if Rewards["Kills"] then
			local rewardsTextKills = vgui.Create("DLabel", endTextPanel)
			rewardsTextKills:SetText("KILLS: " .. Rewards["Kills"])
			rewardsTextKills:SetFont("Rewards_Font")
			rewardsTextKills:SizeToContents()	
			rewardsTextKills:SetColor(Color(0, 0, 0))
			rewardsTextKills:SetPos(0, 155)
		end
	end)
end