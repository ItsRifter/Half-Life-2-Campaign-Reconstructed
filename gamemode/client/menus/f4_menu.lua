local defaultModels = {
	["models/player/Group01/female_01.mdl"] = {},
	["models/player/Group01/female_02.mdl"] = {},
	["models/player/Group01/female_03.mdl"] = {},
	["models/player/Group01/male_01.mdl"] = {},
	["models/player/Group01/male_02.mdl"] = {},
	["models/player/Group01/male_03.mdl"] = {},
}

local rebelModels = {
	["models/player/Group03/female_01.mdl"] = {},
	["models/player/Group03/female_02.mdl"] = {},
	["models/player/Group03/female_03.mdl"] = {},
	["models/player/Group03/male_01.mdl"] = {},
	["models/player/Group03/male_02.mdl"] = {},
	["models/player/Group03/male_03.mdl"] = {},
}

function OpenMenu(ply)
	
	local getModel = net.ReadString()
	
	DEFAULT_COLOR_HL2 = Color(243, 123, 33, 255)
	COLOR_MODEL_PANEL = Color(102, 102, 102)
	
	local pmFrame = vgui.Create("DFrame")
	pmFrame:SetSize(900, 700)
	pmFrame:MakePopup()
	pmFrame:Center()

	local pmPanel = vgui.Create("DPanel", pmFrame)
	pmPanel:SetSize(350, 600)
	pmPanel:SetBackgroundColor(COLOR_MODEL_PANEL)
	pmPanel:SetPos(25, 50)
	
	local currentModel = vgui.Create("DModelPanel", pmPanel)
	currentModel:SetSize(700, 600)
	currentModel:Center()
	currentModel:SetModel(getModel)
	function currentModel:LayoutEntity( Entity ) return end

	local selectScrollPanel = vgui.Create("DScrollPanel", pmFrame)
	selectScrollPanel:Dock(FILL)

	local selectPanel = vgui.Create("DPanel", selectScrollPanel)
	selectPanel:SetPos(400, 75)
	selectPanel:SetSize(225, 150)
	selectPanel:SetBackgroundColor(COLOR_MODEL_PANEL)

	local selectModel = vgui.Create("DModelSelect", selectPanel)
	selectModel:SetModelList(defaultModels, "", false, true)
	selectModel:SetModelList(rebelModels, "", false, true)
	selectModel:SetSize(225, 150)
	selectModel.OnActivePanelChanged = function(ply, oldIcon, newIcon)
		net.Start("Update_Model")
			net.WriteString(newIcon:GetModelName())
		net.SendToServer()
	end
	
end

net.Receive("Open_F4_Menu", OpenMenu)