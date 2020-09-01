AddCSLuaFile()

net.Receive("Purchase", function(len, ply)
	local itemName = net.ReadString()
	
	if itemName == "Health_Module_MK1" then
		SubCoins(ply, 1000)
	elseif itemName == "Health_Module_MK2" then
		SubCoins(ply, 1500)
	elseif itemName == "Suit_Battery_Pack" then
		SubCoins(ply, 1500)
	elseif itemName == "Pair_Gloves" then
		SubCoins(ply, 3500)
	elseif itemName == "Mark_VII_Suit" then
		SubCoins(ply, 25000)
	elseif itemName == "Mark_VII_Helmet" then
		SubCoins(ply, 17500)
	end
	
	ply.hl2cPersistent.InvSpace = ply.hl2cPersistent.InvSpace + 1
	ply:SetNWInt("InvSpace", ply.hl2cPersistent.InvSpace)
	
	table.insert(ply.hl2cPersistent.Inventory, itemName)
	
	ply:SetNWString("Inventory", table.concat(ply.hl2cPersistent.Inventory, itemName))
end)

net.Receive("Exchange", function(len, ply)
	local exchangeAmt = net.ReadInt(32)
	
	if exchangeAmt <= 0 then
		ply:ChatPrint("Nice try human")
		return
	end
	
	ply.hl2cPersistent.Coins = ply.hl2cPersistent.Coins -(exchangeAmt * 500)
	ply.hl2cPersistent.Essence = ply.hl2cPersistent.Essence + exchangeAmt
	
	ply:SetNWInt("Coins", math.Round(ply.hl2cPersistent.Coins))
	ply:SetNWInt("Essence", math.Round(ply.hl2cPersistent.Essence))
	
end)

net.Receive("Upgrade", function(len, ply)
	local UpgName = net.ReadString()
	
	if UpgName == "Self Healing" then
		SubEssen(ply, 10)
	elseif UpgName == "Health Boost" then
		SubEssen(ply, 5)
		ply:SetHealth(ply:Health() + 5)
	end
	
	ply.hl2cPersistent.TempUpg = ply.hl2cPersistent.TempUpg .. UpgName .. " "
	ply:SetNWString("TempUpg", ply.hl2cPersistent.TempUpg .. UpgName .. " ")

end)


local minRewards = 1
local maxRewards = 2
local neverDiedBonus = false
function giveRewards(ply)
	if not ply.hasDiedOnce then
		neverDiedBonus = true
	else
		neverDiedBonus = false
	end
	
	for i = minRewards, maxRewards do
		randCoins = math.random(1, 25)
		ply.hl2cPersistent.Coins = ply.hl2cPersistent.Coins + randCoins
		
		randXP = math.random(1, 50)
		ply.hl2cPersistent.XP = ply.hl2cPersistent.XP + randXP
	end
	
	net.Start("ShowEndStats")
		net.WriteInt(randCoins, 32)
		net.WriteInt(randXP, 32)
		net.WriteBool(neverDiedBonus)
		net.WriteBool(ply.crowbarOnly)
		net.WriteInt(GetConVar("hl2cr_difficulty"):GetInt(), 8)
	net.Send(ply)
end

if CLIENT then
	surface.CreateFont("End_Stats_font", {
		font = "Arial",
		size = 28,
	})
	surface.CreateFont("Rewards_Font", {
		font = "Arial",
		bold = true,
		size = 22,
	})
end

net.Receive("AddArmour", function(len, ply)
	local slotToFill = net.ReadString()
	
	--If the player has an item in the 'ARM' slot, put the item back into their inventory
	if ply:GetNWString("ArmSlot") == "hl2cr/armour_parts/health" and slotToFill == ply:GetNWString("ArmSlot") then
		table.insert(ply.hl2cPersistent.Inventory, "Health_Module_MK1")
	elseif ply:GetNWString("ArmSlot") == "hl2cr/armour_parts/healthmk2" and slotToFill == ply:GetNWString("ArmSlot") then
		table.insert(ply.hl2cPersistent.Inventory, "Health_Module_MK2")
	elseif ply:GetNWString("ArmSlot") == "hl2cr/armour_parts/battery" and slotToFill == ply:GetNWString("ArmSlot") then
		table.insert(ply.hl2cPersistent.Inventory, "Suit_Battery_Pack")
	elseif ply:GetNWString("ArmSlot") == "hl2cr/armour_parts/gloves" and slotToFill == ply:GetNWString("ArmSlot") then
		table.insert(ply.hl2cPersistent.Inventory, "Pair_Gloves")
	end
	
	--If the player has an item in the 'HEAD' slot, put the item back into their inventory
	if ply:GetNWString("HelmetSlot") == "hl2cr/armour_parts/helmet" and slotToFill == ply:GetNWString("HelmetSlot") then
		table.insert(ply.hl2cPersistent.Inventory, "Mark_VII_Helmet")
	end
	
	--If the player has an item in the 'SUIT' slot, put the item back into their inventory
	if ply:GetNWString("SuitSlot") == "hl2cr/armour_parts/suit" and slotToFill == ply:GetNWString("SuitSlot") then
		table.insert(ply.hl2cPersistent.Inventory, "Mark_VII_Suit")
	end
	
	--Suit
	if slotToFill == "hl2cr/armour_parts/suit" then
		
		table.RemoveByValue(ply.hl2cPersistent.Inventory, "Mark_VII_Suit")
		
		ply.hl2cPersistent.Suit = slotToFill
		ply:SetNWString("SuitSlot", slotToFill)
	
		ply.hl2cPersistent.Armour = ply.hl2cPersistent.Armour + 15
	
	--Helmet
	elseif slotToFill == "hl2cr/armour_parts/helmet" then
		
		table.RemoveByValue(ply.hl2cPersistent.Inventory, "Mark_VII_Helmet")
		
		ply.hl2cPersistent.Helmet = slotToFill
		ply:SetNWString("HelmetSlot", slotToFill)
		
		ply.hl2cPersistent.Armour = ply.hl2cPersistent.Armour + 8
		
	--Arm
	elseif slotToFill == "hl2cr/armour_parts/health" then
		
		table.RemoveByValue(ply.hl2cPersistent.Inventory, "Health_Module_MK1")
		
		ply.hl2cPersistent.Arm = slotToFill
		ply:SetNWString("ArmSlot", slotToFill)
		
		AddStats("health", 10, ply)
		
	elseif slotToFill == "hl2cr/armour_parts/healthmk2" then
	
		table.RemoveByValue(ply.hl2cPersistent.Inventory, "Health_Module_MK2")
		
		ply.hl2cPersistent.Arm = slotToFill
		ply:SetNWString("ArmSlot", slotToFill)
		
		AddStats("health", 15, ply)
	elseif slotToFill == "hl2cr/armour_parts/battery" then
		
		table.RemoveByValue(ply.hl2cPersistent.Inventory, "Suit_Battery_Pack")
		
		ply.hl2cPersistent.Arm = slotToFill
		ply:SetNWString("ArmSlot", slotToFill)
	elseif slotToFill == "hl2cr/armour_parts/gloves" then
		
		table.RemoveByValue(ply.hl2cPersistent.Inventory, "Pair_Gloves")
		
		ply.hl2cPersistent.Arm = slotToFill
		ply:SetNWString("ArmSlot", slotToFill)
		
		ply.hl2cPersistent.Armour = ply.hl2cPersistent.Armour + 1
	end
	
	ply.hl2cPersistent.InvSpace = ply.hl2cPersistent.InvSpace - 1
	ply:SetNWInt("InvSpace", ply.hl2cPersistent.InvSpace)
	ply:SetNWInt("Armour", ply.hl2cPersistent.Armour)
	
end)

net.Receive("SellItem", function(len, ply)
	local readItem = net.ReadString()
	
	if readItem == "hl2cr/armour_parts/health" and table.HasValue(ply.hl2cPersistent.Inventory, "Health_Module_MK1") then
		ply.hl2cPersistent.Coins = ply.hl2cPersistent.Coins + 250
	
		table.RemoveByValue(ply.hl2cPersistent.Inventory, "Health_Module_MK1")
		
		ply.hl2cPersistent.InvSpace = ply.hl2cPersistent.InvSpace - 1
		ply:SetNWInt("InvSpace", ply.hl2cPersistent.InvSpace)
		
	elseif readItem == "hl2cr/armour_parts/healthmk2" and table.HasValue(ply.hl2cPersistent.Inventory, "Health_Module_MK2") then
		ply.hl2cPersistent.Coins = ply.hl2cPersistent.Coins + 500
	
		table.RemoveByValue(ply.hl2cPersistent.Inventory, "Health_Module_MK2")
		
		ply.hl2cPersistent.InvSpace = ply.hl2cPersistent.InvSpace - 1
		ply:SetNWInt("InvSpace", ply.hl2cPersistent.InvSpace)
	
	elseif readItem == "hl2cr/armour_parts/battery" and table.HasValue(ply.hl2cPersistent.Inventory, "Suit_Battery_Pack") then
		ply.hl2cPersistent.Coins = ply.hl2cPersistent.Coins + 500
	
		table.RemoveByValue(ply.hl2cPersistent.Inventory, "Suit_Battery_Pack")
		
		ply.hl2cPersistent.InvSpace = ply.hl2cPersistent.InvSpace - 1
		ply:SetNWInt("InvSpace", ply.hl2cPersistent.InvSpace)
		
	elseif readItem == "hl2cr/armour_parts/gloves" and table.HasValue(ply.hl2cPersistent.Inventory, "Pair_Gloves") then
		ply.hl2cPersistent.Coins = ply.hl2cPersistent.Coins + 1166
	
		table.RemoveByValue(ply.hl2cPersistent.Inventory, "Pair_Gloves")
		
		ply.hl2cPersistent.InvSpace = ply.hl2cPersistent.InvSpace - 1
		ply:SetNWInt("InvSpace", ply.hl2cPersistent.InvSpace)
		
	elseif readItem == "hl2cr/armour_parts/helmet" and table.HasValue(ply.hl2cPersistent.Inventory, "Mark_VII_Helmet") then
		ply.hl2cPersistent.Coins = ply.hl2cPersistent.Coins + 500
	
		table.RemoveByValue(ply.hl2cPersistent.Inventory, "Mark_VII_Helmet")
		
		ply.hl2cPersistent.InvSpace = ply.hl2cPersistent.InvSpace - 1
		ply:SetNWInt("InvSpace", ply.hl2cPersistent.InvSpace)
		
	elseif readItem == "hl2cr/armour_parts/suit" and table.HasValue(ply.hl2cPersistent.Inventory, "Mark_VII_Suit") then
		ply.hl2cPersistent.Coins = ply.hl2cPersistent.Coins + 8333
	
		table.RemoveByValue(ply.hl2cPersistent.Inventory, "Mark_VII_Suit")
		
		ply.hl2cPersistent.InvSpace = ply.hl2cPersistent.InvSpace - 1
		ply:SetNWInt("InvSpace", ply.hl2cPersistent.InvSpace)
		
	end
	
	ply:SetNWInt("Coins", math.Round(ply.hl2cPersistent.Coins), 0)
	
end)

net.Receive("SellItemSlot", function(len, ply)

	local readItem = net.ReadString()

	--Items in the arm slot
	if readItem == "hl2cr/armour_parts/health" then
		ply.hl2cPersistent.Coins = ply.hl2cPersistent.Coins + 250
		
		ply.hl2cPersistent.Arm = ""
		ply:SetNWString("ArmSlot", ply.hl2cPersistent.Arm)
		
	elseif readItem == "hl2cr/armour_parts/healthmk2" then
		ply.hl2cPersistent.Coins = ply.hl2cPersistent.Coins + 500
		
		ply.hl2cPersistent.Arm = ""
		ply:SetNWString("ArmSlot", ply.hl2cPersistent.Arm)
	elseif readItem == "hl2cr/armour_parts/healthmk2" then
		ply.hl2cPersistent.Coins = ply.hl2cPersistent.Coins + 500
		
		ply.hl2cPersistent.Arm = ""
		ply:SetNWString("ArmSlot", ply.hl2cPersistent.Arm)
	elseif readItem == "hl2cr/armour_parts/gloves" then
		ply.hl2cPersistent.Coins = ply.hl2cPersistent.Coins + 1166
		
		ply.hl2cPersistent.Arm = ""
		ply:SetNWString("ArmSlot", ply.hl2cPersistent.Arm)
		ply.hl2cPersistent.Armour = ply.hl2cPersistent.Armour - 1
	end
	
	--Items in the head slot
	if readItem == "hl2cr/armour_parts/helmet" then
		ply.hl2cPersistent.Coins = ply.hl2cPersistent.Coins + 5833
		
		ply.hl2cPersistent.Helmet = ""
		ply:SetNWString("HelmetSlot", ply.hl2cPersistent.Helmet)
		ply.hl2cPersistent.Armour = ply.hl2cPersistent.Armour - 1
	end
	--Items in the suit slot
	if readItem == "hl2cr/armour_parts/suit" then
		ply.hl2cPersistent.Coins = ply.hl2cPersistent.Coins + 8333
		
		ply.hl2cPersistent.Suit = ""
		ply:SetNWString("SuitSlot", ply.hl2cPersistent.Suit)
	
		ply.hl2cPersistent.Armour = ply.hl2cPersistent.Armour - 2
	end
	
	ply:SetNWInt("Armour", ply.hl2cPersistent.Armour)
	ply:SetNWInt("Coins", math.Round(ply.hl2cPersistent.Coins), 0)
end)

function AddStats(statToAdd, amt, ply)
	ply:SetMaxHealth(100)
	
	if statToAdd == "health" then
		ply:SetMaxHealth(ply:GetMaxHealth() + amt)
		
		if ply:Health() > ply:GetMaxHealth() then
			ply:SetHealth(ply:GetMaxHealth())
		end
	end
end

net.Receive("ShowEndStats", function()
	
	local coins = net.ReadInt(32)
	local xp = net.ReadInt(32)
	local boolDeaths = net.ReadBool()
	local boolCrowbar = net.ReadBool()
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

	local xpReward = itemsLayout:Add("SpawnIcon")
	xpReward:SetImage("hl2cr/misc/xp")
	xpReward:SetToolTip(xp .. " XP") 
	
	local coinReward = itemsLayout:Add("SpawnIcon")
	coinReward:SetImage("hl2cr/misc/coins")
	coinReward:SetToolTip("λ" .. coins) 

	itemsText = vgui.Create("DLabel", itemsPanel)
	itemsText:SetText("Crates")
	itemsText:SetFont("End_Stats_font")
	itemsText:SetPos(125, 350)
	itemsText:SetColor(Color(0, 0, 0))
	itemsText:SizeToContents()
	
	local endTextPanel = vgui.Create("DPanel", endFrame)
	endTextPanel:SetSize(400, 475)
	endTextPanel:SetBackgroundColor(Color(255, 255, 255))
	endTextPanel:SetPos(400, 100)
	
	local rewardsLabel = vgui.Create("DLabel", endTextPanel)
	rewardsLabel:SetText("Rewards")
	rewardsLabel:SetPos(150, 20)
	rewardsLabel:SetColor(Color(0, 0, 0))
	rewardsLabel:SetFont("End_Stats_font")
	rewardsLabel:SizeToContents()
	
	if boolDeaths then
		local rewardsTextNoDeaths = vgui.Create("DLabel", endTextPanel)
		rewardsTextNoDeaths:SetText("NO DEATHS: " .. 50 * diffBoost .. "XP, λ" .. 25 * diffBoost) 
		rewardsTextNoDeaths:SetFont("Rewards_Font")
		rewardsTextNoDeaths:SizeToContents()	
		rewardsTextNoDeaths:SetColor(Color(0, 0, 0))
		rewardsTextNoDeaths:SetPos(100, 65)
	end
	if boolCrowbar then
		local rewardsTextNoDeaths = vgui.Create("DLabel", endTextPanel)
		rewardsTextNoDeaths:SetText("CROWBAR ONLY: " .. 75 * diffBoost .. "XP, λ" .. 45 * diffBoost) 
		rewardsTextNoDeaths:SetFont("Rewards_Font")
		rewardsTextNoDeaths:SizeToContents()	
		rewardsTextNoDeaths:SetColor(Color(0, 0, 0))
		rewardsTextNoDeaths:SetPos(100, 95)
	end
	
end)