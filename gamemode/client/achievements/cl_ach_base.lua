Lobby_Ach_List_Name = {
	[1] = "Rise and Shine",
	[2] = "Shitter",
}

Lobby_Ach_List_Desc = {
	[1] = "Play the gamemode for the first time",
	[2] = "How did you find this?",
}

Lobby_Ach_List_Icon = {
	[1] = "vgui/achievements/hl2_beat_cemetery.png",
	[2] = "vgui/achievements/hl2_kill_enemy_withtoilet.png",
}
function AchievementMenu()

	local achFrame = vgui.Create("DFrame")
	achFrame:SetSize(800, 600)
	achFrame:Center()
	achFrame:SetDraggable(false)
	achFrame:ShowCloseButton(true)
	achFrame:SetTitle("Achievements Menu")
	achFrame:MakePopup()
	
	local TabAchSheet = vgui.Create( "DPropertySheet", achFrame )
	TabAchSheet:Dock( FILL )
	
	local PanelLobbyAch = vgui.Create( "DPanel", achFrame )
	PanelLobbyAch:SetSize(800, 850)
	PanelLobbyAch:SetPos(0, 400)
	PanelLobbyAch.Paint = function(s, w, h)
		draw.RoundedBox(0,0,0, w, h, Color(170, 170, 170, 255))
	end
		
	local yPosition = PanelLobbyAch:GetWide() * .02
	
	for i = 1, 2 do
		local achName = vgui.Create("DLabel", PanelLobbyAch)
		achName:SetPos(85, yPosition)
		achName:SetText(Lobby_Ach_List_Name[i])
		achName:SizeToContents()
		
		local achDesc = vgui.Create("DLabel", PanelLobbyAch)
		achDesc:SetPos(85, yPosition + 35)
		achDesc:SetText(Lobby_Ach_List_Desc[i])
		achDesc:SizeToContents()
		
		local achIcon = vgui.Create("DImage", PanelLobbyAch)
		achIcon:SetPos(15, yPosition)
		achIcon:SetSize(64, 64)
		achIcon:SetImage(Lobby_Ach_List_Icon[i])
		
		
		yPosition = yPosition + 75 * i
	end
	
	TabAchSheet:AddSheet("Lobby", PanelLobbyAch, nil)
	
	local PanelHL2Ach = vgui.Create( "DPanel", achFrame )
	PanelHL2Ach:SetSize(800, 850)
	PanelHL2Ach:SetPos(0, 400)
	PanelHL2Ach.Paint = function(s, w, h)
		draw.RoundedBox(0,0,0, w, h, Color(170, 170, 170, 255))
	end
	
	TabAchSheet:AddSheet("Half-Life 2", PanelHL2Ach, nil)
	
end

surface.CreateFont( "DermaDefault_18px", {
	font = "DermaDefault",
	extended = false,
	size = 17,
	weight = 300,
	blursize = 0,
	scanlines = 0,
	antialias = false,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false
} )

function PopUp(ply, idTitle, idMsg, idImg)
	
	local achTitle = net.ReadString()
	local achMessage = idMsg
	local unlocked = "Achievement Unlocked!"
	local achImage = net.ReadString()
	
	if not achTitle then achTitle = "Bug" end
	if not achImage then achImage = "entities/npc_kleiner.png" end
	if not achMessage then achMessage = "'bugged'" end
	
		local popUpNotify = vgui.Create("DNotify")
		popUpNotify:SetSize(320, 80)
		popUpNotify:SetPos(ScrW() - 280, ScrH())
		popUpNotify:SetLife(7)
		
		local popUpBG = vgui.Create("DPanel", popUpNotify)
		popUpBG:Dock(FILL)
		popUpBG:SetBackgroundColor(Color(200, 115, 0))
		
		local popUpImg = vgui.Create("DImage", popUpBG)
		popUpImg:SetPos(10, 10)
		popUpImg:SetSize(55, 55)
		popUpImg:SetImage(achImage)
		
		local popUplbl = vgui.Create("DLabel", popUpBG)
		popUplbl:SetPos(75, 5)
		popUplbl:SetSize(128, 72)
		popUplbl:SetText(unlocked .. "\n" .. achTitle)
		popUplbl:SetTextColor(Color(230, 230, 230))
		popUplbl:SetFont("DermaDefault_18px")
		popUplbl:SetWrap(true)
		
		popUpNotify:AddItem(popUpBG)
		
		popUpNotify:MoveTo(ScrW() - 280, ScrH() - 80, 2, 0, -1, function()
			timer.Simple(6, function()
				popUpNotify:MoveTo( ScrW(), - 280, ScrH(), 2, 0, -1, function() end)
			end)
		end)
		surface.PlaySound("hl2_campaign/ach_unlock.wav")
end

net.Receive("Open_Ach_Menu", AchievementMenu)
net.Receive("Achievement_Earned", PopUp)
