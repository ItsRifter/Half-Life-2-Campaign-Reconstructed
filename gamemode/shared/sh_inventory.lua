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

	SubCoins(ply, total)
	SubEssen(ply, exchangeAmt)
	
end)

net.Receive("Upgrade", function(len, ply)
	local UpgName = net.ReadString()
	local UpgCostCoins = net.ReadInt(16)
	local UpgCostEss = net.ReadInt(16)
	local UpgCostCryst = net.ReadInt(16)
	local UpgType = net.ReadString()
	if not ply then return end
	
	if UpgType == "hl2cr_tempupg" then
		SubCoins(ply, UpgCostCoins)
		SubEssen(ply, UpgCostEss)
		table.insert(ply.hl2cPersistent.TempUpg, UpgName)
	elseif UpgType == "hl2cr_permupg" then
		SubCoins(ply, UpgCostCoins)
		SubEssen(ply, UpgCostEss)
		SubCryst(ply, UpgCostCryst)
		table.insert(ply.hl2cPersistent.PermUpg, UpgName)
	end

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
	
	local metalChance = math.random(1, 65)
	local essenceChance = math.random(1, 45)
	local crystalChance = math.random(1, 105)
	
	if chance >= metalChance then
		local metalEarned = math.random(1, 10)
		ply.tableRewards["Metal"] = metalEarned
		ply.hl2cPersistent.ScrapMetal = ply.hl2cPersistent.ScrapMetal + metalEarned
		ply:SetNWInt("Scrap", ply.hl2cPersistent.ScrapMetal)
	end
	
	if chance >= essenceChance then
		local essenceEarned = math.random(1, 5)
		ply.tableRewards["Essence"] = essenceEarned
		AddEssen(ply, essenceEarned)
	end
	
	if chance >= crystalChance then
		local crystalEarned = math.random(1, 3)
		ply.tableRewards["Crystals"] = crystalEarned
		AddCryst(ply, crystalEarned)
	end
	
	if ply.tableRewards["Kills"] != 0 then
		randCoins = math.random(1, 10 * ply.tableRewards["Kills"])
		AddCoins(ply, randCoins)
		
		randXP = math.random(1, 10 * ply.tableRewards["Kills"])
		AddXP(ply, randXP)
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
	
	if ply.hl2cPersistent.InvWeapon != "" then
		table.insert(ply.hl2cPersistent.Inventory, ply.hl2cPersistent.InvWeapon)
	end
	
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
		ply.hl2cPersistent.Armour = ply.hl2cPersistent.Armour - ply.hl2cPersistent.OldHelmet
	end
	
	if ply.hl2cPersistent.Suit != "" and slot == "Suit" then
		table.insert(ply.hl2cPersistent.Inventory, ply.hl2cPersistent.Suit)
		ply.hl2cPersistent.Armour = ply.hl2cPersistent.Armour - ply.hl2cPersistent.OldSuit
	end
	
	if ply.hl2cPersistent.Arm != "" and slot == "Arm" then
		table.insert(ply.hl2cPersistent.Inventory, ply.hl2cPersistent.Arm)
		ply.hl2cPersistent.Armour = ply.hl2cPersistent.Armour - ply.hl2cPersistent.OldArm
	end
	
	if ply.hl2cPersistent.Hands != "" and slot == "Hands" then
		table.insert(ply.hl2cPersistent.Inventory, ply.hl2cPersistent.Hands)
		ply.hl2cPersistent.Armour = ply.hl2cPersistent.Armour - ply.hl2cPersistent.OldHands
	end
	
	if ply.hl2cPersistent.Boot != "" and slot == "Boots" then
		table.insert(ply.hl2cPersistent.Inventory, ply.hl2cPersistent.Boot)
		ply.hl2cPersistent.Armour = ply.hl2cPersistent.Armour - ply.hl2cPersistent.OldBoot
	end
	
	table.RemoveByValue(ply.hl2cPersistent.Inventory, slotToFill)
	
	if slot == "Helmet" then
		ply.hl2cPersistent.Helmet = slotToFill
		ply.hl2cPersistent.HelmetImage = slotImage
		ply:SetNWString("HelmetSlot", ply.hl2cPersistent.HelmetImage)
		ply.hl2cPersistent.OldHelmet = shieldPoints
		
	elseif slot == "Suit" then
		ply.hl2cPersistent.Suit = slotToFill
		ply.hl2cPersistent.SuitImage = slotImage
		ply:SetNWString("SuitSlot", ply.hl2cPersistent.SuitImage)
		ply.hl2cPersistent.OldSuit = shieldPoints
		
	elseif slot == "Arm" then
		ply.hl2cPersistent.Arm = slotToFill
		ply.hl2cPersistent.ArmImage = slotImage
		ply:SetNWString("ArmSlot", ply.hl2cPersistent.ArmImage)
		ply.hl2cPersistent.OldArm = shieldPoints
		
	elseif slot == "Hands" then
		ply.hl2cPersistent.Hands = slotToFill
		ply.hl2cPersistent.HandsImage = slotImage
		ply:SetNWString("HandSlot", ply.hl2cPersistent.HandsImage)
		ply.hl2cPersistent.OldHands = shieldPoints
		
	elseif slot == "Boots" then
		ply.hl2cPersistent.Boot = slotToFill
		ply.hl2cPersistent.BootImage = slotImage
		ply:SetNWString("BootSlot", ply.hl2cPersistent.BootImage)
		ply.hl2cPersistent.OldBoot = shieldPoints
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
	
	if removePoints != 0 then
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
		
		if Rewards["Essence"] != 0 then
			local essenReward = itemsLayout:Add("DImage")
			essenReward:SetImage("hl2cr/mats/essence")
			essenReward:SetSize(64, 64)
			
			local essenLabel = essenReward:Add("DLabel")
			essenLabel:SetFont("Bonus_Items_Font")
			essenLabel:SetText(Rewards["Essence"]) 
		end
		
		if Rewards["Crystals"] != 0 then
			local crystReward = itemsLayout:Add("DImage")
			crystReward:SetImage("hl2cr/mats/crystal")
			crystReward:SetSize(64, 64)
			
			local crystLabel = crystReward:Add("DLabel")
			crystLabel:SetFont("Bonus_Items_Font")
			crystLabel:SetText(Rewards["Crystals"]) 
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