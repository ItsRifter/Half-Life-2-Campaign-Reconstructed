surface.CreateFont("F4_font", {
	font = "Arial",
	size = 24,
})

surface.CreateFont("F4_Stats_font", {
	font = "Arial",
	size = 28,
})

surface.CreateFont("F4_Customizer_font", {
	font = "Arial",
	bold = true,
	size = 38,
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

surface.CreateFont("Default", {
	font = "Arial",
	size = 48,
})

surface.CreateFont("Spooky", {
	font = "Coraline's Cat",
	size = 48,
})

surface.CreateFont("Robotic", {
	font = "Robotica",
	size = 48,
})

--Inventory Drag n drop triggers
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
					itemButton:Remove()
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
					itemButton:Remove()
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
					itemButton:Remove()
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
					itemButton:Remove()
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
					itemButton:Remove()
				end
			end
		end
	end
end

local function DropWeapon( self, panels, onDropped, Command, x, y )
	if (onDropped) then
		for k, v in pairs(panels) do
			if wepImage:GetImage() != v:GetImage() then
				wepImage:SetImage(v:GetImage())
				surface.PlaySound("hl1/fvox/bell.wav")
				
				for i, armour in pairs(GAMEMODE.WeaponItem) do
					if v:GetImage() == GAMEMODE.WeaponItem[i].Icon then
						net.Start("AddWeapon")
							net.WriteString(GAMEMODE.WeaponItem[i].Name)
							net.WriteString(GAMEMODE.WeaponItem[i].Icon)
						net.SendToServer()
					end
					itemButton:Remove()
				end
			end
		end
	end
end

--Crafting Drag n Drop slots
local function DropSlot( self, panels, onDropped, Command, x, y )
	if (onDropped) then
		for k, v in pairs(panels) do
			if ciyImageOne:GetImage() != v:GetImage() then
				ciyImageOne:SetImage(v:GetImage())
				surface.PlaySound("hl1/fvox/bell.wav")
			end
		end
	end
end


function OpenMenu(inventoryItems, randomExchange, HasOTF, colours, enabled, font, curEventItems, curEvent, curHats, curTempUpg)
	
	local getModel = LocalPlayer():GetNWString("Model")
	
	local totalDeaths = LocalPlayer():GetNWInt("Deaths")
	local totalKills = LocalPlayer():GetNWInt("Kills")
	
	local getLevel = LocalPlayer():GetNWInt("Level")
	local getXP = LocalPlayer():GetNWInt("XP")
	local getMaxXP = LocalPlayer():GetNWInt("maxXP")
	
	local curCoins = LocalPlayer():GetNWInt("Coins")
	local curEssence = LocalPlayer():GetNWInt("Essence")
	local curCryst = LocalPlayer():GetNWInt("Cryst")
	local curScrap = LocalPlayer():GetNWInt("Scrap")
	local curArmour = LocalPlayer():GetNWInt("Armour")
	
	local helmetSlot = LocalPlayer():GetNWString("HelmetSlot")
	local suitSlot = LocalPlayer():GetNWString("SuitSlot")
	local armSlot = LocalPlayer():GetNWString("ArmSlot")
	local handSlot = LocalPlayer():GetNWString("HandSlot")
	local bootSlot = LocalPlayer():GetNWString("BootSlot")
	local wepSlot = LocalPlayer():GetNWString("WepSlot")
	
	DEFAULT_COLOUR_HL2 = Color(243, 123, 33, 255)
	COLOUR_MODEL_PANEL = Color(100, 100, 100)
	INVENTORY_MENU = Color(50, 50, 50)
	CRAFTING_PANEL = Color(255, 200, 0)
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
	
	for k, tier2 in pairs(GAMEMODE.donateFighter) do
		if LocalPlayer():GetUserGroup() == "donator_resistance" or LocalPlayer():IsAdmin() then
			local tier2Model = selectModelLayout:Add("SpawnIcon")
			tier2Model:SetModel(tier2[1])
			tier2Model.OnMousePressed = function()
				net.Start("Update_Model")
					net.WriteString(tier2Model:GetModelName())
				net.SendToServer()
				getModel = tier2Model:GetModelName()
			end
			selectPMScrollPanel:AddPanel(tier2Model)
		end
	end
	
	--OTF Prized Model
	for k, rare in pairs(GAMEMODE.rareHev) do
		if HasOTF or LocalPlayer():IsAdmin() then
			local rareModel = selectModelLayout:Add("SpawnIcon")
			rareModel:SetModel(rare[1])
			rareModel.OnMousePressed = function()
				net.Start("Update_Model")
					net.WriteString(rareModel:GetModelName())
				net.SendToServer()
				getModel = rareModel:GetModelName()
			end
			selectPMScrollPanel:AddPanel(rareModel)
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
	
	local weaponPanelReceiver = vgui.Create("DPanel", pmPanel)
	weaponPanelReceiver:SetPos(275, 450)
	weaponPanelReceiver:SetSize(75, 75)
	weaponPanelReceiver:SetToolTip("Starting Weapons")
	weaponPanelReceiver:Receiver("Wep", DropWeapon)
	
	wepImage = vgui.Create("DImage", weaponPanelReceiver)
	wepImage:SetSize(75, 75)
	
	if wepSlot != "" then
		wepImage:SetImage(wepSlot)
		
		local itemButton = weaponPanelReceiver:Add("DButton")
		itemButton:SetPos(0, 60)
		itemButton:SetSize(25, 25)
		itemButton:SetText("Sell")
		itemButton:SizeToContents()
		
		function itemButton:DoClick()
			for i, weapon in pairs(GAMEMODE.WeaponItem) do
				if wepImage:GetImage() == GAMEMODE.WeaponItem[i].Icon then
					net.Start("SellItemSlot")
						net.WriteString(GAMEMODE.WeaponItem[i].Name)
						net.WriteInt(GAMEMODE.WeaponItem[i].Cost, 32)
					net.SendToServer()
				end
			end
			wepImage:SetImage("hlmv/gray")
			itemButton:Remove()
		end
	else
		wepImage:SetImage("hlmv/gray")
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
	
	local inventoryPanel = vgui.Create("DPanel", pmPanel)
	inventoryPanel:SetSize(400, 350)
	inventoryPanel:SetPos(400, 95)
	inventoryPanel.Paint = function( self, w, h ) 
		draw.RoundedBox( 4, 0, 0, w, h, INVENTORY_MENU ) 
	end 
	
	local inventoryLayout = vgui.Create("DIconLayout", pmPanel)
	inventoryLayout:SetPos(400, 100)
	inventoryLayout:SetSize(400, 150)
	inventoryLayout:Receiver("Inventory", DoDrop)
	inventoryLayout:SetSpaceX(5)
	inventoryLayout:SetSpaceY(5)	
	
	--Gets max inventory space
	local maxSpace = tonumber(LocalPlayer():GetNWInt("MaxInvSpace"))
	
	for k, itemName in pairs(inventoryItems) do
		
		local itemImg = vgui.Create("DImage")
		itemImg:SetSize(75, 75)
		
		--Weapons
		if itemName == "Medkit" then
			itemImg:SetImage("hl2cr/armour_parts/health")
			itemImg:Droppable("Wep")
		
		--Upg Items
		elseif itemName == "Health_Module_MK1" then
			itemImg:SetImage("hl2cr/armour_parts/health")
			itemImg:Droppable("Arm")
			
		elseif itemName == "Health_Module_MK2" then
			itemImg:SetImage("hl2cr/armour_parts/healthmk2")
			itemImg:Droppable("Arm")	
			
		elseif itemName == "Health_Module_MK3" then
			itemImg:SetImage("hl2cr/armour_parts/healthmk3")
			itemImg:Droppable("Arm")
			
		elseif itemName == "Suit_Battery_Pack_MK1" then
			itemImg:SetImage("hl2cr/armour_parts/battery")
			itemImg:Droppable("Arm")
			
		elseif itemName == "Suit_Battery_Pack_MK2" then
			itemImg:SetImage("hl2cr/armour_parts/batterymk2")
			itemImg:Droppable("Arm")
			
		elseif itemName == "Suit_Battery_Pack_MK3" then
			itemImg:SetImage("hl2cr/armour_parts/batterymk3")
			itemImg:Droppable("Arm")

		--Arm Items, is also shoulder
		elseif itemName == "Spiked_Padding" then
			itemImg:SetImage("hl2cr/armour_parts/spikedpadding")
			itemImg:Droppable("Arm")
		
		elseif itemName == "Steel_Padding" then
			itemImg:SetImage("hl2cr/armour_parts/steelpadding")
			itemImg:Droppable("Arm")
			
		elseif itemName == "Shoulder_Plate" then
			itemImg:SetImage("hl2cr/armour_parts/shoulderplate")
			itemImg:Droppable("Arm")
		
		--Hand Items
		elseif itemName == "Pair_Gloves" then
			itemImg:SetImage("hl2cr/armour_parts/gloves")
			itemImg:Droppable("Hand")
			
		elseif itemName == "Steel_Gloves" then
			itemImg:SetImage("hl2cr/armour_parts/steelglove")
			itemImg:Droppable("Hand")
			
		elseif itemName == "Leather_Gloves" then
			itemImg:SetImage("hl2cr/armour_parts/leathergloves")
			itemImg:Droppable("Hand")
		
		--Helmet Items
		elseif itemName == "HECU_Gasmask" then
			itemImg:SetImage("hl2cr/armour_parts/hecu")
			itemImg:Droppable("Helmet")

		elseif itemName == "Steel_Helmet" then
			itemImg:SetImage("hl2cr/armour_parts/helmet")
			itemImg:Droppable("Helmet")
			
		elseif itemName == "Soldier_Helmet" then
			itemImg:SetImage("hl2cr/armour_parts/soldierhelm")
			itemImg:Droppable("Helmet")
		
		--Suit Items
		elseif itemName == "Mark_VII_Suit" then
			itemImg:SetImage("hl2cr/armour_parts/suit")
			itemImg:Droppable("Suit")
			
		elseif itemName == "Metal_Chestplate" then
			itemImg:SetImage("hl2cr/armour_parts/metalchest")
			itemImg:Droppable("Suit")

		elseif itemName == "Leather_Chestplate" then
			itemImg:SetImage("hl2cr/armour_parts/leather")
			itemImg:Droppable("Suit")
			
		--Boot Items
		elseif itemName == "Steel_Boots" then
			itemImg:SetImage("hl2cr/armour_parts/steelboot")
			itemImg:Droppable("Boot")
			
		elseif itemName == "Metal_Boots" then
			itemImg:SetImage("hl2cr/armour_parts/metalboot")
			itemImg:Droppable("Boot")
			
		--Special Items
		elseif itemName == "Witch_Hat" then
			itemImg:SetImage("hl2cr/armour_parts/witchhat")
			itemImg:Droppable("Helmet")
		--If nothing, display a grey blank image
		else
			itemImg:SetImage("hlmv/gray")
		end
		
		inventoryLayout:Add(itemImg)
		
		if itemName then
			itemButton = itemImg:Add("DButton")
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
	
	local shopScroll = vgui.Create("DScrollPanel", shopPanel)
	shopScroll:Dock(FILL)
	
	local shopTitleLabel = vgui.Create("DLabel", shopScroll)
	shopTitleLabel:SetText("CrowMart Shop")
	shopTitleLabel:SetFont("F4_Shop_Title_font")
	shopTitleLabel:SizeToContents()
	shopTitleLabel:SetPos(300, 25)
	
	local curCoinsLabel = vgui.Create("DLabel", shopScroll)
	curCoinsLabel:SetText("Coins: " .. curCoins)
	curCoinsLabel:SetFont("F4_Shop_font")
	curCoinsLabel:SetPos(365, 75)
	curCoinsLabel:SizeToContents()
	
	local curEssenceLabel = vgui.Create("DLabel", shopScroll)
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
	
	local shopArmourLabel = vgui.Create("DLabel", shopScroll)
	shopArmourLabel:SetText("Armour List")
	shopArmourLabel:SetFont("F4_Shop_font")
	shopArmourLabel:SizeToContents()
	shopArmourLabel:SetPos(150, 200)
	
	local armourScroll = vgui.Create("DScrollPanel", shopScroll)
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
		
	local shopWeaponsLabel = vgui.Create("DLabel", shopScroll)
	shopWeaponsLabel:SetText("Weapons")
	shopWeaponsLabel:SetFont("F4_Shop_font")
	shopWeaponsLabel:SizeToContents()
	shopWeaponsLabel:SetPos(150, 500)
	
	local weaponScroll = vgui.Create("DScrollPanel", shopScroll)
	weaponScroll:SetPos(50, 550)
	weaponScroll:SetSize(350, 225)
	
	local weaponLayout = vgui.Create("DIconLayout", weaponScroll)
	weaponLayout:Dock(FILL)
	weaponLayout:SetSpaceX(5)
	weaponLayout:SetSpaceY(5)
	
	for i, weapon in pairs(GAMEMODE.WeaponItem) do
		local weaponItem = weaponLayout:Add("DPanel")
		weaponItem:SetSize(80, 80)
		
		local weaponIcon = weaponItem:Add("DImage")
		weaponIcon:SetSize(80, 80)
		weaponIcon:SetImage(GAMEMODE.WeaponItem[i].Icon)
		
		local lambdaText = weaponItem:Add("DLabel")
		lambdaText:SetText("λ" .. GAMEMODE.WeaponItem[i].Cost)
		lambdaText:SetFont("F4_Shop_Cost")
		lambdaText:SetPos(0, 0)
		lambdaText:SetColor(Color(255, 225, 165))
		
		local weaponButton = weaponItem:Add("DButton")
		weaponButton:SetSize(80, 80)
		weaponButton:SetToolTip(GAMEMODE.WeaponItem[i].Name .. "\n" .. GAMEMODE.WeaponItem[i].Desc .. "\n" .. display)
		weaponButton:SetText("")
		weaponButton:SetDrawBackground(false)
		weaponButton.DoClick = function()
			if curCoins < GAMEMODE.WeaponItem[i].Cost then
				surface.PlaySound("buttons/button10.wav")
				LocalPlayer():ChatPrint("Insufficient Coins")
			elseif LocalPlayer():GetNWInt("InvSpace") >= LocalPlayer():GetNWInt("MaxInvSpace") then
				surface.PlaySound("buttons/button10.wav")
				LocalPlayer():ChatPrint("Your inventory is full!")
			else
				net.Start("Purchase")
					net.WriteString(GAMEMODE.WeaponItem[i].Name)
					net.WriteInt(GAMEMODE.WeaponItem[i].Cost, 32)
				net.SendToServer()
				curCoins = curCoins - GAMEMODE.WeaponItem[i].Cost
				surface.PlaySound("buttons/button9.wav")
			end
		end
	end
	
		local shopTempUpgLabel = vgui.Create("DLabel", shopScroll)
		shopTempUpgLabel:SetText("Temporary Upgrades")
		shopTempUpgLabel:SetFont("F4_Shop_font")
		shopTempUpgLabel:SizeToContents()
		shopTempUpgLabel:SetPos(525, 200)
		
		local tempUpgScroll = vgui.Create("DScrollPanel", shopScroll)
		tempUpgScroll:SetPos(475, 250)
		tempUpgScroll:SetSize(350, 150)
		
		local tempUpgLayout = vgui.Create("DIconLayout", tempUpgScroll)
		tempUpgLayout:Dock(FILL)
		tempUpgLayout:SetSpaceX(5)
		tempUpgLayout:SetSpaceY(5)
		
		for i, tempUpg in pairs(GAMEMODE.TempUpgItem) do
			if not table.HasValue(curTempUpg, GAMEMODE.TempUpgItem[i].Name) then
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
		if curCoins < exchangerEssence:GetValue() * randomExchange then
			LocalPlayer():ChatPrint("You don't have enough coins")
			surface.PlaySound("buttons/button10.wav")
		elseif exchangerEssence:GetValue() < 0 then
			LocalPlayer():ChatPrint("Questionable... but I won't do that")
			surface.PlaySound("buttons/button10.wav")
		elseif curCoins > exchangerEssence:GetValue() * randomExchange then
			net.Start("Exchange")
				net.WriteInt(exchangerEssence:GetValue(), 32)
			net.SendToServer()
			curCoins = curCoins - (exchangerEssence:GetValue() * randomExchange)
			surface.PlaySound("buttons/button9.wav")
		end
	end
	
	TabSheet:AddSheet("Trader", traderPanel, nil)
	
	--[[
	local metalInput = CreateSound(LocalPlayer(), "physics/metal/metal_barrel_impact_hard1.wav")
	
	local ciySlot1 = ""
	local ciySlot2 = ""
	local ciySlot3 = ""
	
	local ciyPanel = vgui.Create("DPanel", F4_Frame)
	ciyPanel.Paint = function( self, w, h ) 
		draw.RoundedBox( 4, 0, 0, w, h, COLOUR_MODEL_PANEL ) 
	end

	local ciyPanelSlotOne = vgui.Create("DPanel", ciyPanel)
	ciyPanelSlotOne:SetSize(120, 120)
	ciyPanelSlotOne:SetPos(50, 50)
	ciyPanelSlotOne.Paint = function( self, w, h ) 
		draw.RoundedBox( 4, 0, 0, w, h, CRAFTING_PANEL ) 
	end
	ciyPanelSlotOne:Receiver("CraftSlot1", DropSlot)
	
	ciyImageOne = vgui.Create("DImage", ciyPanelSlotOne)
	ciyImageOne:SetSize(120, 120)
	if ciySlot1 != "" then
		ciyImageOne:SetImage(ciySlot1)
	end
	
	local ciyPanelSlotTwo = vgui.Create("DPanel", ciyPanel)
	ciyPanelSlotTwo:SetSize(120, 120)
	ciyPanelSlotTwo:SetPos(250, 50)
	ciyPanelSlotTwo.Paint = function( self, w, h ) 
		draw.RoundedBox( 4, 0, 0, w, h, CRAFTING_PANEL ) 
	end
	ciyPanelSlotTwo:Receiver("CraftSlot2", DropSlot)
	
	
	ciyImageTwo = vgui.Create("DImage", ciyPanelSlotTwo)
	ciyImageTwo:SetSize(120, 120)
	if ciySlot2 != "" then
		ciyImageTwo:SetImage(ciySlot2)
	end
	
	local ciyPanelSlotThree = vgui.Create("DPanel", ciyPanel)
	ciyPanelSlotThree:SetSize(120, 120)
	ciyPanelSlotThree:SetPos(450, 50)
	ciyPanelSlotThree.Paint = function( self, w, h ) 
		draw.RoundedBox( 4, 0, 0, w, h, CRAFTING_PANEL ) 
	end
	ciyPanelSlotThree:Receiver("CraftSlot3", DropSlot)

	ciyImageThree = vgui.Create("DImage", ciyPanelSlotTwo)
	ciyImageTwo:SetSize(120, 120)
	if ciySlot3 != "" then
		ciyImageThree:SetImage(ciySlot3)
	end

	local craftingPanel = vgui.Create("DPanel", ciyPanel)
	craftingPanel:SetSize(700, 175)
	craftingPanel:SetPos(25, 450)
	craftingPanel.Paint = function( self, w, h ) 
		draw.RoundedBox( 4, 0, 0, w, h, CRAFTING_PANEL ) 
	end 
	
	local craftingLayout = vgui.Create("DIconLayout", ciyPanel)
	craftingLayout:SetPos(25, 450)
	craftingLayout:SetSize(700, 175)
	craftingLayout:SetSpaceX(5)
	craftingLayout:SetSpaceY(5)

	for k, itemName in pairs(inventoryItems) do
		
		local itemImg = vgui.Create("DImage")
		itemImg:SetSize(75, 75)
		
		--Upg Items
		if itemName == "Health_Module_MK1" then
			itemImg:SetImage("hl2cr/armour_parts/health")
			itemImg:Droppable("CraftSlot1")
			
		elseif itemName == "Health_Module_MK2" then
			itemImg:SetImage("hl2cr/armour_parts/healthmk2")
			itemImg:Droppable("CraftSlot1")			
			
		elseif itemName == "Health_Module_MK3" then
			itemImg:SetImage("hl2cr/armour_parts/healthmk3")
			itemImg:Droppable("CraftSlot1")
			
		elseif itemName == "Suit_Battery_Pack_MK1" then
			itemImg:SetImage("hl2cr/armour_parts/battery")
			itemImg:Droppable("CraftSlot1")
			
		elseif itemName == "Suit_Battery_Pack_MK2" then
			itemImg:SetImage("hl2cr/armour_parts/batterymk2")
			itemImg:Droppable("CraftSlot1")
			
		elseif itemName == "Suit_Battery_Pack_MK3" then
			itemImg:SetImage("hl2cr/armour_parts/batterymk3")
			itemImg:Droppable("CraftSlot1")

		else
			itemImg:Remove()
		end
		itemImg:Droppable("CraftSlot2")
		itemImg:Droppable("CraftSlot3")
		craftingLayout:Add(itemImg)
	end

	TabSheet:AddSheet("C.I.Y", ciyPanel, nil)
	--]]
	
	local customPanel = vgui.Create("DPanel", F4_Frame)
	customPanel.Paint = function( self, w, h ) 
		draw.RoundedBox( 4, 0, 0, w, h, COLOUR_MODEL_PANEL ) 
	end
	
	local customHatLabel = vgui.Create("DLabel", customPanel)
	customHatLabel:SetPos(625, 100)
	customHatLabel:SetText("Select Hat")
	customHatLabel:SetFont("Default")
	customHatLabel:SizeToContents()
	
	local customHatCombo = vgui.Create("DComboBox", customPanel)
	customHatCombo:SetPos(650, 150)
	customHatCombo:SetSize(100, 50)
	customHatCombo:AddChoice("no_hat")
	for i, k in pairs(curHats) do
		customHatCombo:AddChoice(k)
	end
	
	customHatCombo.OnSelect = function(index, value, data)
		net.Start("EquipHat")
			net.WriteString(customHatCombo:GetSelected())
		net.SendToServer()
	end
	local customTextExample = vgui.Create("DLabel", customPanel)
	customTextExample:SetPos(650, 325)
	customTextExample:SetText("npc_text")
	customTextExample:SetFont(font)
	customTextExample:SizeToContents()
	customTextExample:SetColor(Color(colours.r, colours.b, colours.g, colours.a))
	
	local customColourMixer = vgui.Create("DColorMixer", customPanel)
	customColourMixer:SetPos(600, 395)
		
	local enableColoursLabel = vgui.Create("DLabel", customPanel)
	enableColoursLabel:SetText("Enable/Disable Colours")
	enableColoursLabel:SetPos(375, 500)
	enableColoursLabel:SetFont("F4_font")
	enableColoursLabel:SizeToContents()
	
	local enableColoursCheckbox = vgui.Create("DCheckBox", customPanel)
	enableColoursCheckbox:SetSize(25, 25)
	enableColoursCheckbox:SetPos(475, 525)
	enableColoursCheckbox.OnChange = function()
		net.Start("UpdateNPCColour")
			net.WriteBool(enableColoursCheckbox:GetChecked())
		net.SendToServer()
	end
	
	if enabled then
		enableColoursCheckbox:SetChecked(true)
	else
		enableColoursCheckbox:SetChecked(false)
	end
	
	local customFontLabel = vgui.Create("DLabel", customPanel)
	customFontLabel:SetPos(375, 425)
	customFontLabel:SetText("Set Font")
	customFontLabel:SetFont("F4_Customizer_font")
	customFontLabel:SizeToContents()

	local fontComboBox = vgui.Create("DComboBox", customPanel)
	fontComboBox:SetPos(375, 475)
	fontComboBox:SetValue(font)
	fontComboBox:AddChoice("Default")
	fontComboBox:AddChoice("Spooky")
	fontComboBox:AddChoice("Robotic")
	
	local applyColourButton = vgui.Create("DButton", customPanel)
	applyColourButton:SetText("Apply Colours")
	applyColourButton:SetFont("F4_Customizer_font")
	applyColourButton:SetPos(375, 575)
	applyColourButton:SizeToContents()
	applyColourButton.DoClick = function()
		customTextExample:SetColor(customColourMixer:GetColor())
		if fontComboBox:GetSelected() then
			customTextExample:SetFont(fontComboBox:GetSelected())
		else
			customTextExample:SetFont(font)
		end
		
		local red = customColourMixer:GetColor().r
		local green = customColourMixer:GetColor().g
		local blue = customColourMixer:GetColor().b
		local alpha = customColourMixer:GetColor().a
		
		local colours = Color(red, green, blue, alpha)
		net.Start("UpdateNPCColour")
			net.WriteColor(colours)
			net.WriteBool(enableColoursCheckbox:GetChecked())
			if fontComboBox:GetSelected() then
				net.WriteString(fontComboBox:GetSelected())
			else
				net.WriteString(font)
			end
		net.SendToServer()
	end
	
	TabSheet:AddSheet("Customizer", customPanel, nil)
	
	local eventPanel = vgui.Create("DPanel", F4_Frame)
	eventPanel.Paint = function( self, w, h ) 
		draw.RoundedBox( 4, 0, 0, w, h, COLOUR_BLACK_PANEL ) 
	end
	
	if curEvent == 1 then
	
		local eventWelcome = vgui.Create("DLabel", eventPanel)
		eventWelcome:SetFont("Spooky")
		eventWelcome:SetText("Welcome mortal,\n\nto my shop of\ntricks and treats")
		eventWelcome:SetPos(250, 50)
		eventWelcome:SizeToContents()
		
		local eventDealer = vgui.Create("DModelPanel", eventPanel)
		eventDealer:SetModel("models/zerochain/props_pumpkinnight/zpn_shopnpc.mdl")
		eventDealer:SetPos(-100, -50)
		eventDealer:SetSize(550, 750)
		function eventDealer:LayoutEntity(Entity) return end
		
		local eyepos = eventDealer.Entity:GetBonePosition(eventDealer.Entity:LookupBone("ValveBiped.Bip01_Head1"))
		eyepos:Add(Vector(45, 0, -15))
		eventDealer:SetLookAt(eyepos)
		eventDealer:SetCamPos(eyepos-Vector(-12, 0, 0))
		
		local eventScroll = vgui.Create("DScrollPanel", eventPanel)
		eventScroll:Dock(FILL)
		
		local eventItems = vgui.Create("DImage", eventScroll)
		eventItems:SetSize(125, 125)
		eventItems:SetPos(600, 0)
		eventItems:SetImage("materials/zerochain/zpn/ui/zpn_candy_large.png")
		
		local eventItemsCount = vgui.Create("DLabel", eventScroll)
		eventItemsCount:SetPos(725, 50)
		eventItemsCount:SetFont("Spooky")
		eventItemsCount:SetText("= " .. tostring(curEventItems))
		eventItemsCount:SizeToContents()
	else
		local noEvent = vgui.Create("DLabel", eventPanel)
		noEvent:SetFont("Default")
		noEvent:SetText("There are currently no events on...")
		noEvent:SetPos(150, 100)
		noEvent:SizeToContents()
	end
	
	TabSheet:AddSheet("Event", eventPanel, nil)
	
end

net.Receive("Open_F4_Menu", function(len, ply)
	local invItems = net.ReadTable()
	local randomExchange = net.ReadInt(32)
	local hasOTF = net.ReadBool()
	local colours = net.ReadColor()
	local enabled = net.ReadBool()
	local font = net.ReadString()
	local eventItemsCount = net.ReadInt(32)
	local curEvent = net.ReadInt(8)
	local hats = net.ReadTable()
	local curTempUpg = net.ReadTable()
	OpenMenu(invItems, randomExchange, hasOTF, colours, enabled, font, eventItemsCount, curEvent, hats, curTempUpg)
end)