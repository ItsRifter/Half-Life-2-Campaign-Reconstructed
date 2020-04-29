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
	["models/player/combine_soldier.mdl"] = {},
}

local eliteModels = {
	["models/player/combine_super_soldier.mdl"] = {},
}

local hevModels = {
	["models/player/SGG/hev_helmet.mdl"] = {},
}

local adminModels = {
	["models/lazlo/gordon_freeman.mdl"] = {},
}

surface.CreateFont("F4_font", {
	font = "Arial",
	size = 24,
})

invSpace = {

	[1] = "vgui/achievements/hl2_beat_c1713striderstandoff",
	[2] = "vgui/achievements/hlx_kill_enemy_withhoppermine",
	[3] = "vgui/achievements/hl2_get_crowbar",
	[4] = "matsys_regressiontest/background.png",
}

function OpenMenu(ply)
	
	local getModel = net.ReadString()
	local totalDeaths = net.ReadString()
	local totalKills = net.ReadString()
	local getLevel = net.ReadInt(16)
	local getXP = net.ReadInt(16)
	local getMaxXP = net.ReadInt(16)
	
	DEFAULT_COLOR_HL2 = Color(243, 123, 33, 255)
	COLOR_MODEL_PANEL = Color(102, 102, 102)
	XP_COLOR_BAR_EMPTY = Color(0, 0, 0)
	
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
		draw.RoundedBox( 4, 0, 0, w, h, COLOR_MODEL_PANEL ) 
	end 
	
	local currentModel = vgui.Create("DModelPanel", pmPanel)
	currentModel:SetSize(700, 600)
	currentModel:Center()
	currentModel:SetModel(getModel)
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
	
	if getLevel >= 5 then
		selectModel:SetModelList(rebelModels, "", false, true)
	end
	
	if getLevel >= 15 then
		selectModel:SetModelList(medicModels, "", false, true)
	end
	
	if getLevel >= 25 then
		selectModel:SetModelList(cpModels, "", true, true)
	end
	
	if getLevel >= 40 then
		selectModel:SetModelList(soldierModels, "", true, true)
	end
	
	if getLevel >= 60 then
		selectModel:SetModelList(eliteModels, "", true, true)
	end
	
	if getLevel >= 100 then
		selectModel:SetModelList(hevModels, "", true, true)
	end
	
	if LocalPlayer():IsAdmin() then
		selectModel:SetModelList(adminModels, "", true, true)
	end
	
	selectModel:SetSize(275, 150)
	selectModel.OnActivePanelChanged = function(ply, oldIcon, newIcon)
		net.Start("Update_Model")
			net.WriteString(newIcon:GetModelName())
		net.SendToServer()
	end
	
	local helmetReceiver = vgui.Create("DImage", pmPanel)
	helmetReceiver:SetSize(75, 75)
	helmetReceiver:SetPos(250, 50)
	helmetReceiver:SetImage("vgui/achievements/hl2_find_alllambdas.png")
	helmetReceiver:Receiver("Helmet", function(helmetReceiver, panels, isDropped, menuIndex, mouseX, mouseY) 
		if isDropped then
			for k, v in pairs(panels) do
				helmetReceiver:SetImage(v)
			end
		end
	end)
	
	local inventory = vgui.Create("DPanel", pmPanel)
	inventory:SetPos(450, 100)
	inventory:SetSize(400, 150)
	
	for i, k in pairs(invSpace) do
		local invItem = vgui.Create("DImage")
		invItem:SetImage(invSpace[i])
		if i == 1 then
			invItem:SetPos(0, 0)
		else
			invItem:SetPos((75 * i) - 75, 0)
		end
		invItem:SetSize(75, 75)
		invItem:Droppable("Helmet")
		inventory:Add(invItem)
	end
	
	
	TabSheet:AddSheet("Suit", pmPanel, nil)
	
	local shopPanel = vgui.Create("DPanel", frame)
	shopPanel.Paint = function( self, w, h ) 
		draw.RoundedBox( 4, 0, 0, w, h, COLOR_MODEL_PANEL ) 
	end 
	
	
	TabSheet:AddSheet("Shop", shopPanel, nil)
	
	local statsPanel = vgui.Create("DPanel", frame)
	statsPanel.Paint = function( self, w, h ) 
		draw.RoundedBox( 4, 0, 0, w, h, COLOR_MODEL_PANEL ) 
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
	XPLabel:SetFont("F4_font")
	XPLabel:SizeToContents()
	
	local LevelLabel = vgui.Create("DLabel", statsPanel)
	LevelLabel:SetText("Level: " .. getLevel)
	LevelLabel:SetSize(185, 25)
	LevelLabel:SetPos(25, 75)
	LevelLabel:SetFont("F4_font")
	LevelLabel:SizeToContents()
	
	local KillLabel = vgui.Create("DLabel", statsPanel)
	KillLabel:SetText("Total Deaths: " .. totalDeaths)
	KillLabel:SetSize(185, 25)
	KillLabel:SetPos(25, 115)
	KillLabel:SetFont("F4_font")
	KillLabel:SizeToContents()
	
	local DeathLabel = vgui.Create("DLabel", statsPanel)
	DeathLabel:SetText("Total Kills: " .. totalKills)
	DeathLabel:SetSize(185, 25)
	DeathLabel:SetPos(25, 155)
	DeathLabel:SetFont("F4_font")
	DeathLabel:SizeToContents()
	
	TabSheet:AddSheet("Stats", statsPanel, nil)
end
	
net.Receive("Open_F4_Menu", OpenMenu)