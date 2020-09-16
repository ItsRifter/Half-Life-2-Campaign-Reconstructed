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

surface.CreateFont("F4_Shop_Cost", {
	font = "Arial",
	size = 16,
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
				surface.PlaySound("hl1/fvox/bell.wav")
				
				for i, armour in pairs(GAMEMODE.ArmourItem) do
					if v:GetImage() == GAMEMODE.ArmourItem[i].Icon then
						net.Start("AddArmour")
							net.WriteString(GAMEMODE.ArmourItem[i].Name)
							net.WriteString(GAMEMODE.ArmourItem[i].Icon)
							net.WriteString("Suit")
							net.WriteInt(GAMEMODE.ArmourItem[i].ArmourPoints, 16)
						net.SendToServer()
					end
				end
			end
		end
	end
end

local function DropHelmet( self, panels, onDropped, Command, x, y )
	if (onDropped) then
		for k, v in pairs(panels) do
			if helmetImage:GetImage() != v:GetImage() then
				helmetImage:SetImage(v:GetImage())
				surface.PlaySound("hl1/fvox/bell.wav")
				
				for i, armour in pairs(GAMEMODE.ArmourItem) do
					if v:GetImage() == GAMEMODE.ArmourItem[i].Icon then
						net.Start("AddArmour")
							net.WriteString(GAMEMODE.ArmourItem[i].Name)
							net.WriteString(GAMEMODE.ArmourItem[i].Icon)
							net.WriteString("Helmet")
							net.WriteInt(GAMEMODE.ArmourItem[i].ArmourPoints, 16)
						net.SendToServer()
					end
				end
			end
		end
	end
end

local function DropArm( self, panels, onDropped, Command, x, y )
	if (onDropped) then
		for k, v in pairs(panels) do
			if armImage:GetImage() != v:GetImage() then
				armImage:SetImage(v:GetImage())
				surface.PlaySound("hl1/fvox/bell.wav")
				
				for i, armour in pairs(GAMEMODE.ArmourItem) do
					if v:GetImage() == GAMEMODE.ArmourItem[i].Icon then
						net.Start("AddArmour")
							net.WriteString(GAMEMODE.ArmourItem[i].Name)
							net.WriteString(GAMEMODE.ArmourItem[i].Icon)
							net.WriteString("Arm")
							net.WriteInt(GAMEMODE.ArmourItem[i].ArmourPoints, 16)
						net.SendToServer()
					end
				end
			end
		end
	end
end

local function DropHands( self, panels, onDropped, Command, x, y )
	if (onDropped) then
		for k, v in pairs(panels) do
			if handImage:GetImage() != v:GetImage() then
				handImage:SetImage(v:GetImage())
				surface.PlaySound("hl1/fvox/bell.wav")
				
				for i, armour in pairs(GAMEMODE.ArmourItem) do
					if v:GetImage() == GAMEMODE.ArmourItem[i].Icon then
						net.Start("AddArmour")
							net.WriteString(GAMEMODE.ArmourItem[i].Name)
							net.WriteString(GAMEMODE.ArmourItem[i].Icon)
							net.WriteString("Hands")
							net.WriteInt(GAMEMODE.ArmourItem[i].ArmourPoints, 16)
						net.SendToServer()
					end
				end
			end
		end
	end
end

local function DropBoot( self, panels, onDropped, Command, x, y )
	if (onDropped) then
		for k, v in pairs(panels) do
			if bootImage:GetImage() != v:GetImage() then
				bootImage:SetImage(v:GetImage())
				surface.PlaySound("hl1/fvox/bell.wav")
				
				for i, armour in pairs(GAMEMODE.ArmourItem) do
					if v:GetImage() == GAMEMODE.ArmourItem[i].Icon then
						net.Start("AddArmour")
							net.WriteString(GAMEMODE.ArmourItem[i].Name)
							net.WriteString(GAMEMODE.ArmourItem[i].Icon)
							net.WriteString("Boots")
							net.WriteInt(GAMEMODE.ArmourItem[i].ArmourPoints, 16)
						net.SendToServer()
					end
				end
			end
		end
	end
end

function OpenMenu(inventoryItems, randomExchange)
	
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
	local curArmour = LocalPlayer():GetNWInt("Armour")
	
	local invItems = LocalPlayer():GetNWString("Inventory")
	
	local helmetSlot = LocalPlayer():GetNWString("HelmetSlot")
	local suitSlot = LocalPlayer():GetNWString("SuitSlot")
	local armSlot = LocalPlayer():GetNWString("ArmSlot")
	local handSlot = LocalPlayer():GetNWString("HandSlot")
	local bootSlot = LocalPlayer():GetNWString("BootSlot")
	
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
	selectPMScrollPanel:SetSize(325, 65)
	selectPMScrollPanel:SetPos(475, 475)

	local selectPMLabel = vgui.Create("DLabel", pmPanel)
	selectPMLabel:SetText("Select Model")
	selectPMLabel:SetFont("F4_font")
	selectPMLabel:SetPos(565, 450)
	selectPMLabel:SizeToContents()

	local selectModelLayout = vgui.Create("DIconLayout", selectPMScrollPanel)
	selectModelLayout:Dock(FILL)
	selectModelLayout:SetSpaceX(5)
	selectModelLayout:SetSpaceY(5)
	selectModelLayout:SetSize(125, 250)
	
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
	
	--Donators
	for k, tier1 in pairs(GAMEMODE.donateCitizen) do
		if LocalPlayer():GetUserGroup() == "donator_citizen" or LocalPlayer():IsAdmin() then
			local tier1Model = selectModelLayout:Add("SpawnIcon")
			tier1Model:SetModel(tier1[1])
			tier1Model.OnMousePressed = function()
				net.Start("Update_Model")
					net.WriteString(tier1Model:GetModelName())
				net.SendToServer()
				getModel = tier1Model:GetModelName()
			end
			selectPMScrollPanel:AddPanel(tier1Model)
		end
	end
	
	local helmetPanelReceiver = vgui.Create("DPanel", pmPanel)
	helmetPanelReceiver:SetPos(225, 25)
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
			for i, armour in pairs(GAMEMODE.ArmourItem) do
				if helmetImage:GetImage() == GAMEMODE.ArmourItem[i].Icon then
					net.Start("SellItemSlot")
						net.WriteString(GAMEMODE.ArmourItem[i].Name)
						net.WriteInt(GAMEMODE.ArmourItem[i].Cost, 32)
						net.WriteInt(GAMEMODE.ArmourItem[i].ArmourPoints, 16)
					net.SendToServer()
				end
			end
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
			for i, armour in pairs(GAMEMODE.ArmourItem) do
				if suitImage:GetImage() == GAMEMODE.ArmourItem[i].Icon then
					net.Start("SellItemSlot")
						net.WriteString(GAMEMODE.ArmourItem[i].Name)
						net.WriteInt(GAMEMODE.ArmourItem[i].Cost, 32)
						net.WriteInt(GAMEMODE.ArmourItem[i].ArmourPoints, 16)
					net.SendToServer()
					suitImage:SetImage("hlmv/gray")
					itemButton:Remove()
				end
			end
		end
	else
		suitImage:SetImage("hlmv/gray")
	end
	
	local armPanelReceiver = vgui.Create("DPanel", pmPanel)
	armPanelReceiver:SetPos(300, 175)
	armPanelReceiver:SetSize(75, 75)
	armPanelReceiver:SetToolTip("Armour for your arms")
	armPanelReceiver:Receiver("Arm", DropArm)
	
	armImage = vgui.Create("DImage", armPanelReceiver)
	armImage:SetSize(75, 75)
	
	if armSlot != "" then
		for i, a in pairs(GAMEMODE.ArmourItem) do
			if armSlot == GAMEMODE.ArmourItem[i].Icon then
				armImage:SetImage(GAMEMODE.ArmourItem[i].Icon)
			end
		end
		local itemButton = armPanelReceiver:Add("DButton")
		itemButton:SetPos(0, 60)
		itemButton:SetSize(25, 25)
		itemButton:SetText("Sell")
		itemButton:SizeToContents()
		
		function itemButton:DoClick()
			for i, armour in pairs(GAMEMODE.ArmourItem) do
				if armImage:GetImage() == GAMEMODE.ArmourItem[i].Icon then
					net.Start("SellItemSlot")
						net.WriteString(GAMEMODE.ArmourItem[i].Name)
						net.WriteInt(GAMEMODE.ArmourItem[i].Cost, 32)
						net.WriteInt(GAMEMODE.ArmourItem[i].ArmourPoints, 16)
					net.SendToServer()
				end
			end
			armImage:SetImage("hlmv/gray")
			itemButton:Remove()
		end
	else
		armImage:SetImage("hlmv/gray")
	end
	
	local handPanelReceiver = vgui.Create("DPanel", pmPanel)
	handPanelReceiver:SetPos(275, 350)
	handPanelReceiver:SetSize(75, 75)
	handPanelReceiver:SetToolTip("Armour for your hands")
	handPanelReceiver:Receiver("Hand", DropHands)
	
	handImage = vgui.Create("DImage", handPanelReceiver)
	handImage:SetSize(75, 75)
	
	if handSlot != "" then
		handImage:SetImage(handSlot)
		
		local itemButton = handPanelReceiver:Add("DButton")
		itemButton:SetPos(0, 60)
		itemButton:SetSize(25, 25)
		itemButton:SetText("Sell")
		itemButton:SizeToContents()
		
		function itemButton:DoClick()
			for i, armour in pairs(GAMEMODE.ArmourItem) do
				if handImage:GetImage() == GAMEMODE.ArmourItem[i].Icon then
					net.Start("SellItemSlot")
						net.WriteString(GAMEMODE.ArmourItem[i].Name)
						net.WriteInt(GAMEMODE.ArmourItem[i].Cost, 32)
						net.WriteInt(GAMEMODE.ArmourItem[i].ArmourPoints, 16)
					net.SendToServer()
				end
			end
			handImage:SetImage("hlmv/gray")
			itemButton:Remove()
		end
	else
		handImage:SetImage("hlmv/gray")
	end
	
	local bootPanelReceiver = vgui.Create("DPanel", pmPanel)
	bootPanelReceiver:SetPos(25, 450)
	bootPanelReceiver:SetSize(75, 75)
	bootPanelReceiver:SetToolTip("Armour for your feet")
	bootPanelReceiver:Receiver("Boot", DropBoot)
	
	bootImage = vgui.Create("DImage", bootPanelReceiver)
	bootImage:SetSize(75, 75)
	
	if bootSlot != "" then
		bootImage:SetImage(bootSlot)
		
		local itemButton = bootPanelReceiver:Add("DButton")
		itemButton:SetPos(0, 60)
		itemButton:SetSize(25, 25)
		itemButton:SetText("Sell")
		itemButton:SizeToContents()
		
		function itemButton:DoClick()
			for i, armour in pairs(GAMEMODE.ArmourItem) do
				if bootImage:GetImage() == GAMEMODE.ArmourItem[i].Icon then
					net.Start("SellItemSlot")
						net.WriteString(GAMEMODE.ArmourItem[i].Name)
						net.WriteInt(GAMEMODE.ArmourItem[i].Cost, 32)
						net.WriteInt(GAMEMODE.ArmourItem[i].ArmourPoints, 16)
					net.SendToServer()
				end
			end
			bootImage:SetImage("hlmv/gray")
			itemButton:Remove()
		end
	else
		bootImage:SetImage("hlmv/gray")
	end
	
	--vgui/hud/icon_locked
	--vgui/cursors/no
	--vgui/hud/icon_check
	
	local armourLabel = vgui.Create("DLabel", pmPanel)
	armourLabel:SetPos(400, 50)
	armourLabel:SetFont("F4_Stats_font")
	armourLabel:SetText("Armour: " .. curArmour)
	armourLabel:SizeToContents()
	
	
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
		
		--Upg Items
		if splitItems[i] == "Health_Module_MK1" then
			itemImg:SetImage("hl2cr/armour_parts/health")
			itemImg:Droppable("Arm")
			
		elseif splitItems[i] == "Health_Module_MK2" then
			itemImg:SetImage("hl2cr/armour_parts/healthmk2")
			itemImg:Droppable("Arm")	
			
		elseif splitItems[i] == "Health_Module_MK3" then
			itemImg:SetImage("hl2cr/armour_parts/healthmk3")
			itemImg:Droppable("Arm")
			
		elseif splitItems[i] == "Suit_Battery_Pack_MK1" then
			itemImg:SetImage("hl2cr/armour_parts/battery")
			itemImg:Droppable("Arm")
			
		elseif splitItems[i] == "Suit_Battery_Pack_MK2" then
			itemImg:SetImage("hl2cr/armour_parts/batterymk2")
			itemImg:Droppable("Arm")
			
		elseif splitItems[i] == "Suit_Battery_Pack_MK3" then
			itemImg:SetImage("hl2cr/armour_parts/batterymk3")
			itemImg:Droppable("Arm")

		--Arm Items, is also shoulder
		elseif splitItems[i] == "Spiked_Padding" then
			itemImg:SetImage("hl2cr/armour_parts/spikedpadding")
			itemImg:Droppable("Arm")
		
		elseif splitItems[i] == "Steel_Padding" then
			itemImg:SetImage("hl2cr/armour_parts/steelpadding")
			itemImg:Droppable("Arm")
			
		elseif splitItems[i] == "Shoulder_Plate" then
			itemImg:SetImage("hl2cr/armour_parts/shoulderplate")
			itemImg:Droppable("Arm")
		
		--Hand Items
		elseif splitItems[i] == "Pair_Gloves" then
			itemImg:SetImage("hl2cr/armour_parts/gloves")
			itemImg:Droppable("Hand")
			
		elseif splitItems[i] == "Steel_Gloves" then
			itemImg:SetImage("hl2cr/armour_parts/steelglove")
			itemImg:Droppable("Hand")
			
		elseif splitItems[i] == "Leather_Gloves" then
			itemImg:SetImage("hl2cr/armour_parts/leathergloves")
			itemImg:Droppable("Hand")
		
		--Helmet Items
		elseif splitItems[i] == "Steel_Helmet" then
			itemImg:SetImage("hl2cr/armour_parts/helmet")
			itemImg:Droppable("Helmet")
			
		elseif splitItems[i] == "Soldier_Helmet" then
			itemImg:SetImage("hl2cr/armour_parts/soldierhelm")
			itemImg:Droppable("Helmet")
		
		--Suit Items
		elseif splitItems[i] == "Mark_VII_Suit" then
			itemImg:SetImage("hl2cr/armour_parts/suit")
			itemImg:Droppable("Suit")
			
		elseif splitItems[i] == "Metal_Chestplate" then
			itemImg:SetImage("hl2cr/armour_parts/metalchest")
			itemImg:Droppable("Suit")

		elseif splitItems[i] == "Leather_Chestplate" then
			itemImg:SetImage("hl2cr/armour_parts/leather")
			itemImg:Droppable("Suit")
			
		--Helmet Items
		elseif splitItems[i] == "HECU_Gasmask" then
			itemImg:SetImage("hl2cr/armour_parts/hecu")
			itemImg:Droppable("Helmet")
			
		--Boot Items
		elseif splitItems[i] == "Steel_Boots" then
			itemImg:SetImage("hl2cr/armour_parts/steelboot")
			itemImg:Droppable("Boot")
			
		elseif splitItems[i] == "Metal_Boots" then
			itemImg:SetImage("hl2cr/armour_parts/metalboot")
			itemImg:Droppable("Boot")
			
		--Special Items
		elseif splitItems[i] == "Witch_Hat" then
			itemImg:SetImage("hl2cr/armour_parts/witchhat")
			itemImg:Droppable("Helmet")
		--If nothing, display a grey blank image
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
				for i, armour in pairs(GAMEMODE.ArmourItem) do
					if itemImg:GetImage() == GAMEMODE.ArmourItem[i].Icon then
						net.Start("SellItem")
							net.WriteString(GAMEMODE.ArmourItem[i].Name)
							net.WriteInt(GAMEMODE.ArmourItem[i].Cost, 32)
						net.SendToServer()
					end
				end
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
	shopArmourLabel:SetText("Armour List")
	shopArmourLabel:SetFont("F4_Shop_font")
	shopArmourLabel:SizeToContents()
	shopArmourLabel:SetPos(150, 200)
	
	local armourScroll = vgui.Create("DScrollPanel", shopPanel)
	armourScroll:SetPos(50, 250)
	armourScroll:SetSize(350, 225)
	
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
		
		local lambdaText = armourItem:Add("DLabel")
		lambdaText:SetText("λ" .. GAMEMODE.ArmourItem[i].Cost)
		lambdaText:SetFont("F4_Shop_Cost")
		lambdaText:SetPos(0, 0)
		lambdaText:SetColor(Color(255, 225, 165))
		local display = nil
		if GAMEMODE.ArmourItem[i].ArmourPoints then
			display = GAMEMODE.ArmourItem[i].ArmourPoints 
		elseif GAMEMODE.ArmourItem[i].BatteryBoost then
			display = GAMEMODE.ArmourItem[i].BatteryBoost
		elseif GAMEMODE.ArmourItem[i].HPBoost then
			display = GAMEMODE.ArmourItem[i].HPBoost
		end
		
		local armourButton = armourItem:Add("DButton")
		armourButton:SetSize(80, 80)
		armourButton:SetToolTip(GAMEMODE.ArmourItem[i].Name .. "\n" .. GAMEMODE.ArmourItem[i].Desc .. "\n" .. display)
		armourButton:SetText("")
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
					net.WriteInt(GAMEMODE.ArmourItem[i].Cost, 32)
				net.SendToServer()
				curCoins = curCoins - GAMEMODE.ArmourItem[i].Cost
				surface.PlaySound("buttons/button9.wav")
			end
		end
	
		local shopTempUpgLabel = vgui.Create("DLabel", shopPanel)
		shopTempUpgLabel:SetText("Temporary Upgrades")
		shopTempUpgLabel:SetFont("F4_Shop_font")
		shopTempUpgLabel:SizeToContents()
		shopTempUpgLabel:SetPos(525, 200)
		
		local tempUpgScroll = vgui.Create("DScrollPanel", shopPanel)
		tempUpgScroll:SetPos(475, 250)
		tempUpgScroll:SetSize(350, 150)
		
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
						tempUpgItem:Remove()
						net.Start("Upgrade")
							net.WriteString(GAMEMODE.TempUpgItem[i].Name)
							net.WriteInt(GAMEMODE.TempUpgItem[i].EssenceCost, 16)
						net.SendToServer()
						curEssence = curEssence - GAMEMODE.TempUpgItem[i].EssenceCost
						surface.PlaySound("buttons/button9.wav")
					end
				end
			end
		end
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
	welcomeLabel2:SetText("I'll sell essence for λ" .. randomExchange .. " each")
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
	exchangerCoinLabel:SetText("λ" .. exchangerEssence:GetValue() * randomExchange)
	exchangerCoinLabel:SetPos(285, 225)
	exchangerCoinLabel:SetFont("F4_Trader_Exchange_font")
	exchangerCoinLabel:SizeToContents()
	
	exchangerCoinLabel.Think = function()
		exchangerCoinLabel:SetText("λ" .. exchangerEssence:GetValue() * randomExchange)
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
		elseif exchangerEssence:GetValue() < 1 then
			LocalPlayer():ChatPrint("Questionable... but I won't do that")
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
	local randomExchange = net.ReadInt(32)
	OpenMenu(invItems, randomExchange)
end)