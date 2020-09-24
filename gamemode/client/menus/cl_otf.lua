surface.CreateFont( "OTF_Title_Font", {
	font = "Arial",
	size = 62,
})

surface.CreateFont( "OTF_Font", {
	font = "Arial",
	size = 38,
})

surface.CreateFont( "OTF_Normal_Font", {
	font = "Arial",
	size = 26,
})

net.Receive("ShowOTF", function()
	local frame = vgui.Create("DFrame")
	frame:SetSize(1450, 800)
	frame:ShowCloseButton(true)
	frame:SetDraggable(false)
	frame:MakePopup()
	frame:SetTitle("")
	frame:SetBackgroundBlur(true)
	frame:Center()
	
	local otfPanel = vgui.Create("DPanel", frame)
	otfPanel:SetSize(1350, 750)
	otfPanel:SetPos(50, 35)
	otfPanel:SetBackgroundColor(Color(255, 153, 0))
	
	local otfTitle = vgui.Create("DLabel", otfPanel)
	otfTitle:SetText("ONE TRUE FREEMAN")
	otfTitle:SetFont("OTF_Title_Font")
	otfTitle:SetPos(otfPanel:GetWide() / 4 - 25, 0)
	otfTitle:SetTextColor(Color(255, 170, 40))
	otfTitle:SizeToContents()
	
	local otfText = vgui.Create("DLabel", otfPanel)
	otfText:SetText("Keep in note: Attempting this challenge will be difficult\nFollow the guidelines to ensure you complete it")
	otfText:SetFont("OTF_Font")
	otfText:SetPos(otfPanel:GetWide() / 8, 100)
	otfText:SetTextColor(Color(0, 0, 0))
	otfText:SizeToContents()
	
	local otfRules = vgui.Create("DLabel", otfPanel)
	otfRules:SetText("GUIDELINES:\nYou must only use the crowbar to kill, anything else will fail\nPet kills are allowed\nVehicle kills are allowed\nYou must finish the map otherwise you will fail\nIf survival is enabled, failing the map will fail the challenge")
	otfRules:SetFont("OTF_Normal_Font")
	otfRules:SetPos(15, 225)
	otfRules:SetTextColor(Color(0, 0, 0))
	otfRules:SizeToContents()
	
	local otfRules = vgui.Create("DLabel", otfPanel)
	otfRules:SetText("Grand Prize:\nFinish all of the Half-Life 2 series (including Episode 1 and Episode 2)\nand win a gordon freeman model along with loads of XP")
	otfRules:SetFont("OTF_Normal_Font")
	otfRules:SetPos(15, 475)
	otfRules:SetTextColor(Color(0, 0, 0))
	otfRules:SizeToContents()
	
	local prizeModel = vgui.Create("DModelPanel", otfPanel)
	prizeModel:SetSize(450, 450)
	prizeModel:SetPos(850, 325)
	prizeModel:SetModel("models/kaesar/hlalyx/gordon/gordon.mdl")
	
	local beginButton = vgui.Create("DButton", otfPanel)
	beginButton:SetSize(150, 100)
	beginButton:SetPos(600, 625)
	beginButton:SetText("Start Challenge")
	beginButton.DoClick = function()
		net.Start("BeginOTF")
		net.SendToServer()
		frame:Close()
	end
end)