local defaultModels = {
	["models/player/Group01/female_01.mdl"] = {},
	["models/player/Group01/female_02.mdl"] = {},
	["models/player/Group01/female_03.mdl"] = {},
	["models/player/Group01/female_04.mdl"] = {},
	["models/player/Group01/female_05.mdl"] = {},
	["models/player/Group01/female_06.mdl"] = {},
	["models/player/Group01/male_01.mdl"] = {},
	["models/player/Group01/male_02.mdl"] = {},
	["models/player/Group01/male_03.mdl"] = {},
	["models/player/Group01/male_04.mdl"] = {},
	["models/player/Group01/male_05.mdl"] = {},
	["models/player/Group01/male_06.mdl"] = {},
	["models/player/Group01/male_07.mdl"] = {},
	["models/player/Group01/male_08.mdl"] = {},
	["models/player/Group01/male_09.mdl"] = {},
}

local rebelModels = {
	["models/player/Group03/female_01.mdl"] = {},
	["models/player/Group03/female_02.mdl"] = {},
	["models/player/Group03/female_03.mdl"] = {},
	["models/player/Group03/female_04.mdl"] = {},
	["models/player/Group03/female_05.mdl"] = {},
	["models/player/Group03/female_06.mdl"] = {},
	["models/player/Group03/male_01.mdl"] = {},
	["models/player/Group03/male_02.mdl"] = {},
	["models/player/Group03/male_03.mdl"] = {},
	["models/player/Group03/male_04.mdl"] = {},
	["models/player/Group03/male_05.mdl"] = {},
	["models/player/Group03/male_06.mdl"] = {},
	["models/player/Group03/male_07.mdl"] = {},
	["models/player/Group03/male_08.mdl"] = {},
	["models/player/Group03/male_09.mdl"] = {},

}

local medicModels = {
	["models/player/Group03m/female_01.mdl"] = {},
	["models/player/Group03m/female_02.mdl"] = {},
	["models/player/Group03m/female_03.mdl"] = {},
	["models/player/Group03m/female_04.mdl"] = {},
	["models/player/Group03m/female_05.mdl"] = {},
	["models/player/Group03m/female_06.mdl"] = {},
	["models/player/Group03m/male_01.mdl"] = {},
	["models/player/Group03m/male_02.mdl"] = {},
	["models/player/Group03m/male_03.mdl"] = {},
	["models/player/Group03m/male_04.mdl"] = {},
	["models/player/Group03m/male_05.mdl"] = {},
	["models/player/Group03m/male_06.mdl"] = {},
}

local cpModels = {
	["models/player/police.mdl"] = {},
	["models/player/police_fem.mdl"] = {},
}

local soldierModels = {
	["models/hlvr/characters/combine/grunt/combine_grunt_hlvr_player.mdl"] = {},
}

local heavSoldierModels = {
	["models/hlvr/characters/combine/heavy/combine_heavy_hlvr_player.mdl"] = {},
}

local eliteModels = {
	["models/hlvr/characters/combine/suppressor/combine_suppressor_hlvr_player.mdl"] = {},
}

local capModels = {
	["models/hlvr/characters/combine_captain/combine_captain_hlvr_player.mdl"] = {},
}

local hevModels = {
	["models/player/SGG/hev_helmet.mdl"] = {},
}

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
	
	local frame = vgui.Create("DFrame")
	frame:SetSize(900, 700)
	frame:MakePopup()
	frame:Center()

	local TabSheet = vgui.Create( "DPropertySheet", frame )
	TabSheet:Dock( FILL )

	local pmPanel = vgui.Create("DPanel", frame)
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
	selectPMLabel:SetPos(600, 450)
	selectPMLabel:SizeToContents()

	local selectPMPanel = vgui.Create("DPanel", selectPMScrollPanel)
	selectPMPanel:SetPos(595, 475)
	selectPMPanel:SetSize(275, 150)

	local selectModel = vgui.Create("DModelSelect", selectPMPanel)
	selectModel:SetModelList(defaultModels, "", false, true)
	
	if tonumber(getLevel) >= 5 then
		selectModel:SetModelList(rebelModels, "", false, true)
	end
	
	if tonumber(getLevel) >= 10 then
		selectModel:SetModelList(medicModels, "", false, true)
	end
	
	if tonumber(getLevel) >= 20 then
		selectModel:SetModelList(cpModels, "", true, true)
	end
	
	if tonumber(getLevel) >= 35 then
		selectModel:SetModelList(soldierModels, "", true, true)
	end
	
	if tonumber(getLevel) >= 50 then
		selectModel:SetModelList(heavSoldierModels, "", true, true)
	end
	
	if tonumber(getLevel) >= 65 then
		selectModel:SetModelList(eliteModels, "", true, true)
	end
	
	if tonumber(getLevel) >= 80 then
		selectModel:SetModelList(capModels, "", true, true)
	end
	
	if tonumber(getLevel) >= 100 then
		selectModel:SetModelList(hevModels, "", true, true)
	end

	selectModel:SetSize(275, 150)
	selectModel.OnActivePanelChanged = function(ply, oldIcon, newIcon)
		net.Start("Update_Model")
			net.WriteString(newIcon:GetModelName())
		net.SendToServer()
		getModel = newIcon:GetModelName()
	end
	
	local invItemsName = LocalPlayer():GetNWString("Inventory")
	local invSpace = tonumber(LocalPlayer():GetNWInt("InvSpace"))
	
	local inventoryPanel = vgui.Create("DIconLayout", pmPanel)
	inventoryPanel:SetPos(450, 100)
	inventoryPanel:SetSize(400, 150)
	inventoryPanel:Receiver("Inventory", DoDrop)
	inventoryPanel:SetSpaceX(5)
	inventoryPanel:SetSpaceY(5)
	
	for i = 1, invSpace do
		local item = inventoryPanel:Add("DImage")
		item:SetImage("hlmv/gray")
		item:SetSize(75, 75)
		local itemDesc = item:Add("DLabel")
		itemDesc:SetText("")
		itemDesc:SizeToContents()
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
	
	local armourName = {
		[1] = "Health\nEnhancer",
		[2] = "Suit\nBattery\nPack",
		[3] = "Mark\nVII\nSuit",
	}
	
	local armourCost = {
		[1] = 1000,
		[2] = 2500,
		[3] = 25000,
	}
	
	local armourMats = {
		[1] = "hlmv/gray",
		[2] = "hl2cr/armour_parts/battery",
		[3] = "hl2cr/armour_parts/suit",
	}
	
	local weaponName = {
		[1] = "Shotgun\nBarrel",
		[2] = "SMG\nMuzzle",
		[3] = "Crossbow\nScope",
		[4] = "High\nExplosive\nRocket",
	}
	
	local weaponCost = {
		[1] = 500,
		[2] = 250,
		[3] = 750,
		[4] = 5000,
	}
	
	local weaponMats = {
		[1] = "hl2cr/weapon_parts/barrel",
		[2] = "hl2cr/weapon_parts/muzzle",
		[3] = "hl2cr/weapon_parts/scope",
		[4] = "hl2cr/weapon_parts/rocket",
	}
		
	local shopPanel = vgui.Create("DPanel", frame)
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
		
		local armourList = vgui.Create("DIconLayout", armourScroll)
		armourList:Dock(FILL)
		armourList:SetSpaceX(5)
		armourList:SetSpaceY(5)
		
		for i = 1, 3 do
			local armourItem = armourList:Add("DPanel")
			armourItem:SetSize(75, 75)
			
			local armourIcon = armourItem:Add("DImage")
			armourIcon:SetSize(75, 75)
			armourIcon:SetImage(armourMats[i])
			
			local armourLabel = armourItem:Add("DLabel")
			armourLabel:SetText(armourName[i])
			armourLabel:SetPos(0, 0)
			armourLabel:SizeToContents()
			
			local armourButton = armourItem:Add("DButton")
			armourButton:SetSize(125, 125)
			armourButton:SetText(armourCost[i])
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
		
		for i = 1, 4 do
			local weaponItem = weaponList:Add("DPanel")
			weaponItem:SetSize(75, 75)
			
			local weaponIcon = weaponItem:Add("DImage")
			weaponIcon:SetSize(75, 75)
			weaponIcon:SetImage(weaponMats[i])
			
			local weaponLabel = weaponItem:Add("DLabel")
			weaponLabel:SetText(weaponName[i])
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
					net.WriteString(weaponName[i])
				net.SendToServer()
			elseif curCoins < weaponCost[i] then
				surface.PlaySound("buttons/button10.wav")				
			end
		end
	end
	
	TabSheet:AddSheet("Shop", shopPanel, nil)
	
	end
	local statsPanel = vgui.Create("DPanel", frame)
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