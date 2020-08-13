surface.CreateFont("F4_font", {
	font = "Arial",
	size = 24,
})

surface.CreateFont("F4_Stats_font", {
	font = "Arial",
	size = 28,
})

surface.CreateFont("F4_Shop_Title_font", {
	font = "Arial",
	size = 42,
})

surface.CreateFont("F4_Shop_font", {
	font = "Arial",
	size = 32,
})

surface.CreateFont("F4_Trader_font", {
	font = "Arial",
	size = 28,
})

surface.CreateFont("F4_Trader_Exchange_font", {
	font = "Arial",
	size = 18,
})

local function DropSuit( self, panels, onDropped, Command, x, y )
	if (onDropped) then
		for k, v in pairs(panels) do
			if suitImage:GetImage() != v:GetImage() then
				suitImage:SetImage(v:GetImage())
				surface.PlaySound("npc/combine_gunship/gunship_ping_search.wav")
				
				net.Start("AddArmour")
					net.WriteString(v:GetImage())
				net.SendToServer()
			end
		end
	end
end

local function DropHelmet( self, panels, onDropped, Command, x, y )
	if (onDropped) then
		for k, v in pairs(panels) do
			if helmetImage:GetImage() != v:GetImage() then
				helmetImage:SetImage(v:GetImage())
				surface.PlaySound("npc/combine_gunship/gunship_ping_search.wav")
				
				net.Start("AddArmour")
					net.WriteString(v:GetImage())
				net.SendToServer()
			end
		end
	end
end

local function DropArm( self, panels, onDropped, Command, x, y )
	if (onDropped) then
		for k, v in pairs(panels) do
			if armImage:GetImage() != v:GetImage() then
				armImage:SetImage(v:GetImage())
				surface.PlaySound("npc/combine_gunship/gunship_ping_search.wav")
				
				net.Start("AddArmour")
					net.WriteString(v:GetImage())
				net.SendToServer()
			end
		end
	end
end

function OpenMenu(inventoryItems)
	
	local getModel = LocalPlayer():GetNWString("Model")
	
	local totalDeaths = LocalPlayer():GetNWInt("Deaths")
	local totalKills = LocalPlayer():GetNWInt("Kills")
	
	local getLevel = LocalPlayer():GetNWInt("Level")
	local getXP = LocalPlayer():GetNWInt("XP")
	local getMaxXP = LocalPlayer():GetNWInt("maxXP")
	
	local curCoins = LocalPlayer():GetNWInt("Coins")
	local curEssence = LocalPlayer():GetNWInt("Essence")
	local curCryst = LocalPlayer():GetNWInt("Cryst")
	local curTempUpg = LocalPlayer():GetNWString("TempUpg")
	
	local invItems = LocalPlayer():GetNWString("Inventory")
	
	local suitSlot = LocalPlayer():GetNWString("SuitSlot")
	local helmetSlot = LocalPlayer():GetNWString("HelmetSlot")
	local armSlot = LocalPlayer():GetNWString("ArmSlot")
	
	DEFAULT_COLOUR_HL2 = Color(243, 123, 33, 255)
	COLOUR_MODEL_PANEL = Color(100, 100, 100)
	COLOUR_BLACK_PANEL = Color(0, 0, 0)
	
	local F4_Frame = vgui.Create("DFrame")
	F4_Frame:SetSize(900, 700)
	F4_Frame:MakePopup()
	F4_Frame:Center()

	local TabSheet = vgui.Create( "DPropertySheet", F4_Frame )
	TabSheet:Dock(FILL)

	local pmPanel = vgui.Create("DPanel", F4_Frame)
	pmPanel:SetSize(350, 600)
	pmPanel:SetPos(25, 50)
	pmPanel.Paint = function( self, w, h ) 
		draw.RoundedBox( 4, 0, 0, w, h, COLOUR_MODEL_PANEL ) 
	end
	
	local currentModel = vgui.Create("DModelPanel", pmPanel)
	currentModel:SetSize(700, 600)
	currentModel:Center()
	currentModel.Think = function()
		currentModel:SetModel(getModel)
	end
	function currentModel:LayoutEntity( Entity ) return end
	
	local selectPMScrollPanel = vgui.Create("DHorizontalScroller", pmPanel)
	selectPMScrollPanel:SetSize(275, 65)
	selectPMScrollPanel:SetPos(525, 475)
	selectPMScrollPanel:SetOverlap(-4)

	local selectPMLabel = vgui.Create("DLabel", pmPanel)
	selectPMLabel:SetText("Select Model")
	selectPMLabel:SetFont("F4_font")
	selectPMLabel:SetPos(565, 450)
	selectPMLabel:SizeToContents()

	local selectModelLayout = vgui.Create("DIconLayout", selectPMPanel)
	selectModelLayout:Dock(FILL)
	selectModelLayout:SetSpaceX(5)
	selectModelLayout:SetSpaceY(5)
	selectModelLayout:SetSize(80, 60)
		
	for k, citizen in pairs(GAMEMODE.citizens) do
		local citizenModel = selectModelLayout:Add("SpawnIcon")
		citizenModel:SetModel(citizen[1])
		citizenModel.OnMousePressed = function()
			net.Start("Update_Model")
				net.WriteString(citizenModel:GetModelName())
			net.SendToServer()
			getModel = citizenModel:GetModelName()
		end
		selectPMScrollPanel:AddPanel(citizenModel)
	end
	
	if tonumber(getLevel) >= 5 then
		for k, rebel in pairs(GAMEMODE.rebels) do
			local rebelModel = selectModelLayout:Add("SpawnIcon")
			rebelModel:SetModel(rebel[1])
			rebelModel.OnMousePressed = function()
				net.Start("Update_Model")
					net.WriteString(rebelModel:GetModelName())
				net.SendToServer()
				getModel = rebelModel:GetModelName()
			end
			selectPMScrollPanel:AddPanel(rebelModel)
		end
	end
	
	if tonumber(getLevel) >= 10 then
		for k, medics in pairs(GAMEMODE.medics) do
			local medicsModel = selectModelLayout:Add("SpawnIcon")
			medicsModel:SetModel(medics[1])
			medicsModel.OnMousePressed = function()
				net.Start("Update_Model")
					net.WriteString(medicsModel:GetModelName())
				net.SendToServer()
				getModel = medicsModel:GetModelName()
			end
			selectPMScrollPanel:AddPanel(medicsModel)
		end
	end
	
	if tonumber(getLevel) >= 20 then
		for k, police in pairs(GAMEMODE.police) do
			local policeModel = selectModelLayout:Add("SpawnIcon")
			policeModel:SetModel(police[1])
			policeModel.OnMousePressed = function()
				net.Start("Update_Model")
					net.WriteString(policeModel:GetModelName())
				net.SendToServer()
				getModel = policeModel:GetModelName()
			end
			selectPMScrollPanel:AddPanel(policeModel)
		end
	end
	
	if tonumber(getLevel) >= 35 then
		for k, soldier in pairs(GAMEMODE.soldier) do
			local soldierModel = selectModelLayout:Add("SpawnIcon")
			soldierModel:SetModel(soldier[1])
			soldierModel.OnMousePressed = function()
				net.Start("Update_Model")
					net.WriteString(soldierModel:GetModelName())
				net.SendToServer()
				getModel = soldierModel:GetModelName()
			end
			selectPMScrollPanel:AddPanel(soldierModel)
		end
	end
	
	if tonumber(getLevel) >= 50 then
		for k, heavySoldier in pairs(GAMEMODE.heavySoldier) do
			local heavyModel = selectModelLayout:Add("SpawnIcon")
			heavyModel:SetModel(heavySoldier[1])
			heavyModel.OnMousePressed = function()
				net.Start("Update_Model")
					net.WriteString(heavyModel:GetModelName())
				net.SendToServer()
				getModel = heavyModel:GetModelName()
			end
			selectPMScrollPanel:AddPanel(heavyModel)
		end
	end
	
	if tonumber(getLevel) >= 65 then
		for k, eliteSoldier in pairs(GAMEMODE.eliteSoldier) do
			local eliteModel = selectModelLayout:Add("SpawnIcon")
			eliteModel:SetModel(eliteSoldier[1])
			eliteModel.OnMousePressed = function()
				net.Start("Update_Model")
					net.WriteString(eliteModel:GetModelName())
				net.SendToServer()
				getModel = eliteModel:GetModelName()
			end
			selectPMScrollPanel:AddPanel(eliteModel)
		end
	end
	
	if tonumber(getLevel) >= 80 then
		for k, capSoldier in pairs(GAMEMODE.captainSoldier) do
			local captainModel = selectModelLayout:Add("SpawnIcon")
			captainModel:SetModel(capSoldier[1])
			captainModel.OnMousePressed = function()
				net.Start("Update_Model")
					net.WriteString(captainModel:GetModelName())
				net.SendToServer()
				getModel = captainModel:GetModelName()
			end
			selectPMScrollPanel:AddPanel(captainModel)
		end
	end
	
	if tonumber(getLevel) >= 100 then
		for k, hev in pairs(GAMEMODE.hev) do
			local hevModel = selectModelLayout:Add("SpawnIcon")
			hevModel:SetModel(hev[1])
			hevModel.OnMousePressed = function()
				net.Start("Update_Model")
					net.WriteString(hevModel:GetModelName())
				net.SendToServer()
				getModel = hevModel:GetModelName()
			end
			selectPMScrollPanel:AddPanel(hevModel)
		end
	end
	
	for k, admin in pairs(GAMEMODE.admin) do
		if LocalPlayer():IsAdmin() then
			local adminModel = selectModelLayout:Add("SpawnIcon")
			adminModel:SetModel(admin[1])
			adminModel.OnMousePressed = function()
				net.Start("Update_Model")
					net.WriteString(adminModel:GetModelName())
				net.SendToServer()
				getModel = adminModel:GetModelName()
			end
			selectPMScrollPanel:AddPanel(adminModel)
		end
	end
	
	local helmetPanelReceiver = vgui.Create("DPanel", pmPanel)
	helmetPanelReceiver:SetPos(250, 50)
	helmetPanelReceiver:SetSize(75, 75)
	helmetPanelReceiver:SetToolTip("Armour for your head")
	helmetPanelReceiver:Receiver("Helmet", DropHelmet)
	
	helmetImage = vgui.Create("DImage", helmetPanelReceiver)
	helmetImage:SetSize(75, 75)
	
	if helmetSlot != "" then
		helmetImage:SetImage(helmetSlot)
		
		local itemButton = helmetPanelReceiver:Add("DButton")
		itemButton:SetPos(0, 60)
		itemButton:SetSize(25, 25)
		itemButton:SetText("Sell")
		itemButton:SizeToContents()
		
		function itemButton:DoClick()
			net.Start("SellItemSlot")
				net.WriteString(helmetImage:GetImage())
			net.SendToServer()
			helmetImage:SetImage("hlmv/gray")
			itemButton:Remove()
		end
	else
		helmetImage:SetImage("hlmv/gray")
	end
	
	local suitPanelReceiver = vgui.Create("DPanel", pmPanel)
	suitPanelReceiver:SetPos(25, 175)
	suitPanelReceiver:SetSize(75, 75)
	suitPanelReceiver:SetToolTip("Armour for your body")
	suitPanelReceiver:Receiver("Suit", DropSuit)
	
	suitImage = vgui.Create("DImage", suitPanelReceiver)
	suitImage:SetSize(75, 75)
	
	if suitSlot != "" then
		suitImage:SetImage(suitSlot)
		local itemButton = suitPanelReceiver:Add("DButton")
		itemButton:SetPos(0, 60)
		itemButton:SetSize(25, 25)
		itemButton:SetText("Sell")
		itemButton:SizeToContents()
		
		function itemButton:DoClick()
			net.Start("SellItemSlot")
				net.WriteString(suitImage:GetImage())
			net.SendToServer()
			suitImage:SetImage("hlmv/gray")
			itemButton:Remove()
		end
	else
		suitImage:SetImage("hlmv/gray")
	end
	
	local armPanelReceiver = vgui.Create("DPanel", pmPanel)
	armPanelReceiver:SetPos(300, 250)
	armPanelReceiver:SetSize(75, 75)
	armPanelReceiver:SetToolTip("Armour for your arms")
	armPanelReceiver:Receiver("Arm", DropArm)
	
	armImage = vgui.Create("DImage", armPanelReceiver)
	armImage:SetSize(75, 75)
	
	if armSlot != "" then
		armImage:SetImage(armSlot)
		
		local itemButton = armPanelReceiver:Add("DButton")
		itemButton:SetPos(0, 60)
		itemButton:SetSize(25, 25)
		itemButton:SetText("Sell")
		itemButton:SizeToContents()
		
		function itemButton:DoClick()
			net.Start("SellItemSlot")
				net.WriteString(armImage:GetImage())
			net.SendToServer()
			armImage:SetImage("hlmv/gray")
			itemButton:Remove()
		end
	else
		armImage:SetImage("hlmv/gray")
	end
	
	--vgui/hud/icon_locked
	--vgui/cursors/no
	--vgui/hud/icon_check
	
	local inventoryLayout = vgui.Create("DIconLayout", pmPanel)
	inventoryLayout:SetPos(400, 100)
	inventoryLayout:SetSize(400, 150)
	inventoryLayout:Receiver("Inventory", DoDrop)
	inventoryLayout:SetSpaceX(5)
	inventoryLayout:SetSpaceY(5)

	--Splits the item string into separate strings
	local splitItems = inventoryItems
	
	--Gets max inventory space
	local maxSpace = tonumber(LocalPlayer():GetNWInt("MaxInvSpace"))
	
	for i = 1, maxSpace do
		
		local item = inventoryLayout:Add("DPanel")
		item:SetSize(75, 75)
		
		local itemImg = vgui.Create("DImage")
		itemImg:SetSize(75, 75)
		
		if splitItems[i] == "Health_Module_MK1" then
			itemImg:SetImage("hl2cr/armour_parts/health")
			itemImg:Droppable("Arm")
			
		elseif splitItems[i] == "Health_Module_MK2" then
			itemImg:SetImage("hl2cr/armour_parts/healthmk2")
			itemImg:Droppable("Arm")
			
		elseif splitItems[i] == "Suit_Battery_Pack" then
			itemImg:SetImage("hl2cr/armour_parts/battery")
			itemImg:Droppable("Arm")
			
		elseif splitItems[i] == "Mark_VII_Helmet" then
			itemImg:SetImage("hl2cr/armour_parts/helmet")
			itemImg:Droppable("Helmet")
		
		elseif splitItems[i] == "Mark_VII_Suit" then
			itemImg:SetImage("hl2cr/armour_parts/suit")
			itemImg:Droppable("Suit")
		else
			itemImg:SetImage("hlmv/gray")
		end
		
		item:Add(itemImg)
		
		if splitItems[i] then
			local itemButton = itemImg:Add("DButton")
			itemButton:SetPos(0, 60)
			itemButton:SetSize(25, 25)
			itemButton:SetText("Sell")
			itemButton:SizeToContents()
			
			function itemButton:DoClick()
				net.Start("SellItem")
					net.WriteString(itemImg:GetImage())
				net.SendToServer()
				itemImg:SetImage("hlmv/gray")
				itemButton:Remove()
			end
		end
	end
	TabSheet:AddSheet("Suit", pmPanel, nil)	
		
	local shopPanel = vgui.Create("DPanel", F4_Frame)
	shopPanel.Paint = function( self, w, h ) 
		draw.RoundedBox( 4, 0, 0, w, h, COLOUR_MODEL_PANEL ) 
	end 
	
	local shopTitleLabel = vgui.Create("DLabel", shopPanel)
	shopTitleLabel:SetText("CrowMart Shop")
	shopTitleLabel:SetFont("F4_Shop_Title_font")
	shopTitleLabel:SizeToContents()
	shopTitleLabel:SetPos(300, 25)
	
	local curCoinsLabel = vgui.Create("DLabel", shopPanel)
	curCoinsLabel:SetText("Coins: " .. curCoins)
	curCoinsLabel:SetFont("F4_Shop_font")
	curCoinsLabel:SetPos(365, 75)
	curCoinsLabel:SizeToContents()
	
	local curEssenceLabel = vgui.Create("DLabel", shopPanel)
	curEssenceLabel:SetText("Vorti-Essence: " .. curEssence)
	curEssenceLabel:SetFont("F4_Shop_font")
	curEssenceLabel:SetPos(370, 115)
	curEssenceLabel:SizeToContents()
	
	shopPanel.Think = function()
		curCoinsLabel:SetText("Coins: " .. curCoins)
		curCoinsLabel:SetFont("F4_Shop_font")
		curCoinsLabel:SizeToContents()
		
		curEssenceLabel:SetText("Essence: " .. curEssence)
		curEssenceLabel:SetFont("F4_Shop_font")
		curEssenceLabel:SizeToContents()
	end
	
	local shopArmourLabel = vgui.Create("DLabel", shopPanel)
	shopArmourLabel:SetText("Armour")
	shopArmourLabel:SetFont("F4_Shop_font")
	shopArmourLabel:SizeToContents()
	shopArmourLabel:SetPos(135, 125)
	
	local armourScroll = vgui.Create("DScrollPanel", shopPanel)
	armourScroll:SetPos(50, 175)
	armourScroll:SetSize(275, 150)
	
	local armourLayout = vgui.Create("DIconLayout", armourScroll)
	armourLayout:Dock(FILL)
	armourLayout:SetSpaceX(5)
	armourLayout:SetSpaceY(5)
	
	for i, armour in pairs(GAMEMODE.ArmourItem) do
		local armourItem = armourLayout:Add("DPanel")
		armourItem:SetSize(80, 80)
		
		local armourIcon = armourItem:Add("DImage")
		armourIcon:SetSize(80, 80)
		armourIcon:SetImage(GAMEMODE.ArmourItem[i].Icon)
					
		local armourButton = armourItem:Add("DButton")
		armourButton:SetSize(80, 80)
		armourButton:SetToolTip(GAMEMODE.ArmourItem[i].Name .. "\n" .. GAMEMODE.ArmourItem[i].Desc)
		armourButton:SetText("λ" .. GAMEMODE.ArmourItem[i].Cost)
		armourButton:SetColor(Color(255, 225, 165))
		armourButton:SetDrawBackground(false)
		armourButton.DoClick = function()
			if curCoins < GAMEMODE.ArmourItem[i].Cost then
				surface.PlaySound("buttons/button10.wav")
				LocalPlayer():ChatPrint("Insufficient Coins")
			elseif LocalPlayer():GetNWInt("InvSpace") >= LocalPlayer():GetNWInt("MaxInvSpace") then
				surface.PlaySound("buttons/button10.wav")
				LocalPlayer():ChatPrint("Your inventory is full!")
			else
				net.Start("Purchase")
					net.WriteString(GAMEMODE.ArmourItem[i].Name)
				net.SendToServer()
				curCoins = curCoins - GAMEMODE.ArmourItem[i].Cost
				surface.PlaySound("buttons/button9.wav")
			end
		end
	
		local shopTempUpgLabel = vgui.Create("DLabel", shopPanel)
		shopTempUpgLabel:SetText("Temporary Upgrades")
		shopTempUpgLabel:SetFont("F4_Shop_font")
		shopTempUpgLabel:SizeToContents()
		shopTempUpgLabel:SetPos(75, 350)
		
		local tempUpgScroll = vgui.Create("DScrollPanel", shopPanel)
		tempUpgScroll:SetPos(50, 450)
		tempUpgScroll:SetSize(275, 150)
		
		local tempUpgLayout = vgui.Create("DIconLayout", tempUpgScroll)
		tempUpgLayout:Dock(FILL)
		tempUpgLayout:SetSpaceX(5)
		tempUpgLayout:SetSpaceY(5)
		
		for i, tempUpg in pairs(GAMEMODE.TempUpgItem) do
			if not string.find(curTempUpg, GAMEMODE.TempUpgItem[i].Name) then
				local tempUpgItem = tempUpgLayout:Add("DPanel")
				tempUpgItem:SetSize(80, 80)
			
				local tempUpgIcon = tempUpgItem:Add("DImage")
				tempUpgIcon:SetSize(80, 80)
				tempUpgIcon:SetImage(GAMEMODE.TempUpgItem[i].Icon)
							
				local tempUpgButton = tempUpgItem:Add("DButton")
				tempUpgButton:SetSize(80, 80)
				tempUpgButton:SetToolTip(GAMEMODE.TempUpgItem[i].Name .. "\n" .. GAMEMODE.TempUpgItem[i].Desc)
				tempUpgButton:SetText("Essence: " .. GAMEMODE.TempUpgItem[i].EssenceCost)
				tempUpgButton:SetColor(Color(255, 225, 165))
				tempUpgButton:SetDrawBackground(false)
				tempUpgButton.DoClick = function()
					if curEssence < GAMEMODE.TempUpgItem[i].EssenceCost then
						surface.PlaySound("buttons/button10.wav")
						LocalPlayer():ChatPrint("Insufficient Essence")
					else
						net.Start("Upgrade")
							net.WriteString(GAMEMODE.TempUpgItem[i].Name)
						net.SendToServer()
						curEssence = curEssence - GAMEMODE.TempUpgItem[i].EssenceCost
						surface.PlaySound("buttons/button9.wav")
						tempUpgItem:Remove()
					end
				end
			end
		end
		
		local shopPetLabel = vgui.Create("DLabel", shopPanel)
		if getLevel < 10 then
			shopPetLabel:SetText("Locked until lvl 10")
		else
			shopPetLabel:SetText("Pet Items")
		end
		shopPetLabel:SetFont("F4_Shop_font")
		shopPetLabel:SizeToContents()
		shopPetLabel:SetPos(625, 125)
		
		local petScroll = vgui.Create("DScrollPanel", shopPanel)
		petScroll:SetPos(580, 175)
		petScroll:SetSize(275, 150)
		
		local petList = vgui.Create("DIconLayout", petScroll)
		petList:Dock(FILL)
		petList:SetSpaceX(5)
		petList:SetSpaceY(5)
		
		--[[
		for k, pet in pairs(GAMEMODE.PetItem) do
			local petItem = petList:Add("DPanel")
			petItem:SetSize(80, 80)
			
			local weaponIcon = petItem:Add("DImage")
			weaponIcon:SetSize(80, 80)
			weaponIcon:SetImage(GAMEMODE.PetItem[k].Icon)
			
			local weaponButton = petItem:Add("DButton")
			weaponButton:SetSize(80, 80)
			weaponButton:SetToolTip(GAMEMODE.PetItem[k].Name)
			weaponButton:SetText("λ" .. GAMEMODE.PetItem[k].Cost)
			weaponButton:SetColor(Color(255, 225, 165))
			weaponButton:SetDrawBackground(false)

			weaponButton.DoClick = function()
				if curCoins < GAMEMODE.PetItem[i].Cost then
					surface.PlaySound("buttons/button10.wav")
					LocalPlayer():ChatPrint("Insufficient Coins")
				elseif LocalPlayer():GetNWInt("InvSpace") >= LocalPlayer():GetNWInt("MaxInvSpace") then
					surface.PlaySound("buttons/button10.wav")
					LocalPlayer():ChatPrint("Your inventory is full!")
				else
					net.Start("Purchase")
						net.WriteString(GAMEMODE.PetItem[i].Name)
					net.SendToServer()
					curCoins = curCoins - GAMEMODE.PetItem[i].Cost
					surface.PlaySound("buttons/button9.wav")
				end
			end
		end--]]
	end
	
	TabSheet:AddSheet("Shop", shopPanel, nil)
	
	local statsPanel = vgui.Create("DPanel", F4_Frame)
	statsPanel.Paint = function( self, w, h ) 
		draw.RoundedBox( 4, 0, 0, w, h, COLOUR_MODEL_PANEL ) 
	end 
	
	local XPModel = vgui.Create("DModelPanel", statsPanel)
	XPModel:SetSize(550, 450)
	XPModel:SetPos(350, 75)
	XPModel:SetModel(getModel)
	function XPModel:LayoutEntity( Entity ) return end
	
	local XPLabel = vgui.Create("DLabel", statsPanel)
	XPLabel:SetText("XP: " .. getXP .. " / " .. getMaxXP)
	XPLabel:SetSize(185, 25)
	XPLabel:SetPos(25, 35)
	XPLabel:SetFont("F4_Stats_font")
	XPLabel:SizeToContents()
	
	local LevelLabel = vgui.Create("DLabel", statsPanel)
	LevelLabel:SetText("Level: " .. getLevel)
	LevelLabel:SetSize(185, 25)
	LevelLabel:SetPos(25, 75)
	LevelLabel:SetFont("F4_Stats_font")
	LevelLabel:SizeToContents()
	
	local KillLabel = vgui.Create("DLabel", statsPanel)
	KillLabel:SetText("Total Deaths: " .. totalDeaths)
	KillLabel:SetSize(185, 25)
	KillLabel:SetPos(25, 115)
	KillLabel:SetFont("F4_Stats_font")
	KillLabel:SizeToContents()
	
	local DeathLabel = vgui.Create("DLabel", statsPanel)
	DeathLabel:SetText("Total Kills: " .. totalKills)
	DeathLabel:SetSize(185, 25)
	DeathLabel:SetPos(25, 155)
	DeathLabel:SetFont("F4_Stats_font")
	DeathLabel:SizeToContents()
	
	local CoinLabel = vgui.Create("DLabel", statsPanel)
	CoinLabel:SetText("Coins: " .. curCoins)
	CoinLabel:SetSize(185, 25)
	CoinLabel:SetPos(25, 195)
	CoinLabel:SetFont("F4_Stats_font")
	CoinLabel:SizeToContents()
	
	local EssenceLabel = vgui.Create("DLabel", statsPanel)
	EssenceLabel:SetText("Vorti-Essence: " .. curEssence)
	EssenceLabel:SetSize(185, 25)
	EssenceLabel:SetPos(25, 235)
	EssenceLabel:SetFont("F4_Stats_font")
	EssenceLabel:SizeToContents()
	
	local CrystLabel = vgui.Create("DLabel", statsPanel)
	CrystLabel:SetText("Crystal Anomalies: " .. curCryst)
	CrystLabel:SetSize(185, 25)
	CrystLabel:SetPos(25, 275)
	CrystLabel:SetFont("F4_Stats_font")
	CrystLabel:SizeToContents()
	
	TabSheet:AddSheet("Stats", statsPanel, nil)

	local traderPanel = vgui.Create("DPanel", F4_Frame)
	traderPanel.Paint = function( self, w, h ) 
		draw.RoundedBox( 4, 0, 0, w, h, COLOUR_BLACK_PANEL ) 
	end
	
	local vortiModel = vgui.Create("DModelPanel", traderPanel)
	vortiModel:SetSize(700, 600)
	vortiModel:SetPos(425, 50)
	vortiModel:SetModel("models/vortigaunt.mdl")
	function vortiModel:LayoutEntity( Entity ) return end

	local welcomeLabel = vgui.Create("DLabel", traderPanel)
	welcomeLabel:SetText("Welcome Human,\nDo you wish to exchange some coins?")
	welcomeLabel:SetPos(25, 25)
	welcomeLabel:SetFont("F4_Trader_font")
	welcomeLabel:SizeToContents()

	local welcomeLabel2 = vgui.Create("DLabel", traderPanel)
	welcomeLabel2:SetText("Every essence is worth 500 Lambda Coins")
	welcomeLabel2:SetPos(25, 125)
	welcomeLabel2:SetFont("F4_Trader_font")
	welcomeLabel2:SizeToContents()

	local exchangeLabel = vgui.Create("DLabel", traderPanel)
	exchangeLabel:SetText("Essence")
	exchangeLabel:SetPos(115, 195)
	exchangeLabel:SetFont("F4_Trader_font")
	exchangeLabel:SizeToContents()
	
	local exchangeLabel2 = vgui.Create("DLabel", traderPanel)
	exchangeLabel2:SetText("Lambda")
	exchangeLabel2:SetPos(265, 195)
	exchangeLabel2:SetFont("F4_Trader_font")
	exchangeLabel2:SizeToContents()

	local exchangerEssence = vgui.Create("DNumberWang", traderPanel)
	exchangerEssence:SetSize(75, 25)
	exchangerEssence:SetPos(125, 225)
	exchangerEssence:SetMin(1)
	exchangerEssence:SetValue(1)
	
	local exchangerCoinLabel = vgui.Create("DLabel", traderPanel)
	exchangerCoinLabel:SetText("λ" .. exchangerEssence:GetValue() * 500)
	exchangerCoinLabel:SetPos(285, 225)
	exchangerCoinLabel:SetFont("F4_Trader_Exchange_font")
	exchangerCoinLabel:SizeToContents()
	
	exchangerCoinLabel.Think = function()
		exchangerCoinLabel:SetText("λ" .. exchangerEssence:GetValue() * 500)
		exchangerCoinLabel:SizeToContents()
	end
	
	local exchangeButton = vgui.Create("DButton", traderPanel)
	exchangeButton:SetPos(175, 275)
	exchangeButton:SetSize(150, 50)
	exchangeButton:SetText("Make Exchange")
	exchangeButton:SetFont("F4_Trader_Exchange_font")
	exchangeButton.DoClick = function()
		if curCoins < exchangerEssence:GetValue() * 500 then
			LocalPlayer():ChatPrint("You don't have enough coins")
			surface.PlaySound("buttons/button10.wav")
		else
			net.Start("Exchange")
				net.WriteInt(exchangerEssence:GetValue(), 32)
			net.SendToServer()
			surface.PlaySound("buttons/button9.wav")
		end
	end
	
	TabSheet:AddSheet("Trader", traderPanel, nil)

end

net.Receive("Open_F4_Menu", function(len, ply)
	local invItems = net.ReadTable()
	OpenMenu(invItems)
end)