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

function OpenMenu()
	
	local getModel = LocalPlayer():GetNWString("Model")
	local totalDeaths = LocalPlayer():GetNWInt("Deaths")
	local totalKills = LocalPlayer():GetNWInt("Kills")
	local getLevel = LocalPlayer():GetNWInt("Level")
	local getXP = LocalPlayer():GetNWInt("XP")
	local getMaxXP = LocalPlayer():GetNWInt("maxXP")
	local curCoins = LocalPlayer():GetNWInt("Coins")
	DEFAULT_COLOUR_HL2 = Color(243, 123, 33, 255)
	COLOUR_MODEL_PANEL = Color(100, 100, 100)
	XP_COLOUR_BAR_EMPTY = Color(0, 0, 0)
	
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

	local selectPMScrollPanel = vgui.Create("DScrollPanel", pmPanel)
	selectPMScrollPanel:Dock(FILL)

	local selectPMLabel = vgui.Create("DLabel", selectPMScrollPanel)
	selectPMLabel:SetText("Select Model")
	selectPMLabel:SetFont("F4_font")
	selectPMLabel:SetPos(565, 450)
	selectPMLabel:SizeToContents()

	local selectPMPanel = vgui.Create("DPanel", selectPMScrollPanel)
	selectPMPanel:SetPos(525, 475)
	selectPMPanel:SetSize(275, 900)

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
		end
	end
	
	local invName = string.Split(LocalPlayer():GetNWString("Inventory"), " ")
	local invSpace = tonumber(LocalPlayer():GetNWInt("InvSpace"))
	
	local inventoryPanel = vgui.Create("DIconLayout", pmPanel)
	inventoryPanel:SetPos(450, 100)
	inventoryPanel:SetSize(400, 150)
	inventoryPanel:Receiver("Inventory", DoDrop)
	inventoryPanel:SetSpaceX(5)
	inventoryPanel:SetSpaceY(5)
	
	for i = 1, invSpace do
		local ItemName = invName[i]
		
		local item = inventoryPanel:Add("DImage")
		item:SetImage("hlmv/gray")
		item:SetSize(75, 75)
		local itemDesc = item:Add("DLabel")
		
		if ItemName then
			itemDesc:SetText(ItemName)
			itemDesc:SizeToContents()
		else
			itemDesc:SetText("")
		end
	end
	
	local helmetPanelReceiver = vgui.Create("DPanel", pmPanel)
	helmetPanelReceiver:SetPos(250, 50)
	helmetPanelReceiver:SetSize(75, 75)
	helmetPanelReceiver:SetToolTip("Helmets for your head")
	helmetPanelReceiver:Receiver("Helmet", DoDrop)
	
	local helmetImage = vgui.Create("DImage", helmetPanelReceiver)
	helmetImage:SetSize(75, 75)
	helmetImage:SetImage("hlmv/gray")
	--vgui/hud/icon_locked
	--vgui/cursors/no
	--vgui/hud/icon_check
	
	TabSheet:AddSheet("Suit", pmPanel, nil)
	
	local function DoDrop(self, panels, IsDropped, Command, x, y )
		if IsDropped then
			
		end
	end
	
		
	local shopPanel = vgui.Create("DPanel", F4_Frame)
	shopPanel.Paint = function( self, w, h ) 
		draw.RoundedBox( 4, 0, 0, w, h, COLOUR_MODEL_PANEL ) 
	end 
	
	if game.GetMap() == "d1_trainstation_01" or game.GetMap() == "d1_trainstation_02" or game.GetMap() == "d1_trainstation_03" or game.GetMap() == "d1_trainstation_04" or game.GetMap() == "d1_trainstation_05" then
	
	local shopUnavailableLabel = vgui.Create("DLabel", shopPanel)
	shopUnavailableLabel:SetFont("F4_Shop_Title_font")
	shopUnavailableLabel:SetText("The shop is unavailable on this map")
	shopUnavailableLabel:SizeToContents()
	shopUnavailableLabel:SetPos(150, 250)
	
		TabSheet:AddSheet("Shop", shopPanel, nil)
	else
	
	
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
		
		shopPanel.Think = function()
			curCoinsLabel:SetText("Coins: " .. curCoins)
			curCoinsLabel:SetFont("F4_Shop_font")
			curCoinsLabel:SizeToContents()
		end
		
		local shopArmourLabel = vgui.Create("DLabel", shopPanel)
		shopArmourLabel:SetText("Armour/Materials")
		shopArmourLabel:SetFont("F4_Shop_font")
		shopArmourLabel:SizeToContents()
		shopArmourLabel:SetPos(65, 125)
		
		
		
		local armourScroll = vgui.Create("DScrollPanel", shopPanel)
		armourScroll:SetPos(50, 175)
		armourScroll:SetSize(250, 150)
		
		local armourLayout = vgui.Create("DIconLayout", armourScroll)
		armourLayout:Dock(FILL)
		armourLayout:SetSpaceX(5)
		armourLayout:SetSpaceY(5)
		
		for i, armour in pairs(armourItem or {}) do
			local armourItem = armourLayout:Add("DPanel")
			armourItem:SetSize(75, 75)
			
			local armourIcon = armourItem:Add("DImage")
			armourIcon:SetSize(75, 75)
			armourIcon:SetImage(armourItem[i].mat)
			
			local armourLabel = armourItem:Add("DLabel")
			armourLabel:SetText(armourItem[i].name)
			armourLabel:SetPos(0, 0)
			armourLabel:SizeToContents()
			
			local armourButton = armourItem:Add("DButton")
			armourButton:SetSize(125, 125)
			armourButton:SetText(armour[i].cost)
			armourButton:SetColor(Color(255, 255, 255))
			armourButton:SetDrawBackground(false)
			armourButton.DoClick = function()
			if curCoins >= armourCost[i] then
					surface.PlaySound("ambient/levels/labs/coinslot1.wav")
					curCoins = curCoins - armourCost[i]
					net.Start("Purchase")
						net.WriteInt(armourCost[i], 32)
						net.WriteString(armourName[i])
					net.SendToServer()
				elseif curCoins < armourCost[i] then
					surface.PlaySound("buttons/button10.wav")				
				end
			end
		end
	
		local shopWeaponsLabel = vgui.Create("DLabel", shopPanel)
		shopWeaponsLabel:SetText("Weapon Parts")
		shopWeaponsLabel:SetFont("F4_Shop_font")
		shopWeaponsLabel:SizeToContents()
		shopWeaponsLabel:SetPos(625, 125)
		
		local weaponScroll = vgui.Create("DScrollPanel", shopPanel)
		weaponScroll:SetPos(580, 175)
		weaponScroll:SetSize(250, 150)
		
		local weaponList = vgui.Create("DIconLayout", weaponScroll)
		weaponList:Dock(FILL)
		weaponList:SetSpaceX(5)
		weaponList:SetSpaceY(5)
		
		for k, weapon in pairs(weaponItem or {}) do
			local weaponItem = weaponList:Add("DPanel")
			weaponItem:SetSize(75, 75)
			
			local weaponIcon = weaponItem:Add("DImage")
			weaponIcon:SetSize(75, 75)
			weaponIcon:SetImage(weaponItem[i])
			
			local weaponLabel = weaponItem:Add("DLabel")
			weaponLabel:SetText(weaponItem[i])
			weaponLabel:SizeToContents()
			
			local weaponButton = weaponItem:Add("DButton")
			weaponButton:SetSize(125, 125)
			weaponButton:SetText(weaponCost[i])
			weaponButton:SetColor(Color(255, 255, 255))
			weaponButton:SetDrawBackground(false)
			weaponButton.DoClick = function()
			if curCoins >= weaponCost[i] then
				surface.PlaySound("ambient/levels/labs/coinslot1.wav")
				curCoins = curCoins - weaponCost[i]
				net.Start("Purchase")
					net.WriteInt(weaponCost[i], 32)
					net.WriteString(weaponItem[i])
				net.SendToServer()
			elseif curCoins < weaponCost[i] then
				surface.PlaySound("buttons/button10.wav")				
			end
		end
	end
	
	TabSheet:AddSheet("Shop", shopPanel, nil)
	
	end
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
	
	TabSheet:AddSheet("Stats", statsPanel, nil)
end
	
net.Receive("Open_F4_Menu", function(len, ply)
	OpenMenu()
end)