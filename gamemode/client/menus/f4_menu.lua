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

function OpenMenu(ply)
	
	local getModel = net.ReadString()
	local totalDeaths = net.ReadString()
	local totalKills = net.ReadString()
	local getLevel = net.ReadInt(32)
	
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

	local selectPMPanel = vgui.Create("DPanel", selectPMScrollPanel)
	selectPMPanel:SetPos(400, 75)
	selectPMPanel:SetSize(275, 150)

	local selectModel = vgui.Create("DModelSelect", selectPMPanel)
	selectModel:SetModelList(defaultModels, "", false, true)
	
	if getLevel >= 5 then
		selectModel:SetModelList(rebelModels, "", false, true)
	end
	
	if getLevel >= 10 then
		selectModel:SetModelList(medicModels, "", false, true)
	end
	
	if getLevel >= 20 then
		selectModel:SetModelList(cpModels, "", false, true)
	end
	
	if getLevel >= 35 then
		selectModel:SetModelList(soldierModels, "", false, true)
	end
	
	if getLevel >= 55 then
		selectModel:SetModelList(eliteModels, "", false, true)
	end
	
	selectModel:SetSize(275, 150)
	selectModel.OnActivePanelChanged = function(ply, oldIcon, newIcon)
		net.Start("Update_Model")
			net.WriteString(newIcon:GetModelName())
		net.SendToServer()
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
	XPLabel:SetText("XP")
	XPLabel:SetSize(185, 25)
	XPLabel:SetPos(25, 25)
	
	local Progress = 0.0
	
	local XPProg = vgui.Create("DProgress", statsPanel)
	XPProg:SetSize(185, 25)
	XPProg:SetPos(25, 50)
	XPProg:SetFraction(Progress)
	XPProg.Paint = function( self, w, h ) 
		draw.RoundedBox( 2, 0, 0, w, h, DEFAULT_COLOR_HL2 ) 
		draw.RoundedBox( 2, Progress * 100, 0, w, h, XP_COLOR_BAR_EMPTY ) 
	end
	
	local LevelLabel = vgui.Create("DLabel", statsPanel)
	LevelLabel:SetText("Level: " .. getLevel)
	LevelLabel:SetSize(185, 25)
	LevelLabel:SetPos(25, 75)
	
	local KillLabel = vgui.Create("DLabel", statsPanel)
	KillLabel:SetText("Total Deaths: " .. totalDeaths)
	KillLabel:SetSize(185, 25)
	KillLabel:SetPos(25, 115)
	
	local DeathLabel = vgui.Create("DLabel", statsPanel)
	DeathLabel:SetText("Total Kills: " .. totalKills)
	DeathLabel:SetSize(185, 25)
	DeathLabel:SetPos(25, 155)
	
	TabSheet:AddSheet("Stats", statsPanel, nil)
end
	
net.Receive("Open_F4_Menu", OpenMenu)