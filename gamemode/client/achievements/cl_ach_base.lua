Lobby_Ach_List_Name = {
	[1] = "Rise and Shine",
	[2] = "Shitter",
}

Lobby_Ach_List_Desc = {
	[1] = "Play the gamemode \nfor the first time",
	[2] = "How did you find this?",
}

Lobby_Ach_List_Icon = {
	[1] = "vgui/achievements/hl2_beat_cemetery.png",
	[2] = "entities/npc_kleiner.png",
}

HL2_Ach_List_Name = {
	[1] = "A Red Letter Baby",
	[2] = "Trusty Hardware",
	[3] = "Zero-Point Energy",
	[4] = "RaveBall",
	[5] = "Keep off the Sand",
}

HL2_Ach_List_Desc = {
	[1] = "Bring the doll from \nthe playground to Dr.Kleiner",
	[2] = "Acquire the crowbar",
	[3] = "Acquire the gravity gun",
	[4] = "Carry dog's ball through Ravenholm \n(Don't worry about water)",
	[5] = "Cross the antlion beach in d2_coast_11 without touching the sand",
}

HL2_Ach_List_Mat = {
	[1] = "vgui/achievements/hl2_beat_game.png",
	[2] = "vgui/achievements/hl2_get_crowbar.png",
	[3] = "vgui/achievements/hl2_get_gravitygun.png",
	[4] = "vgui/achievements/hl2_get_gravitygun.png",
	[5] = "vgui/achievements/hl2_beat_donttouchsand.png",
}

Misc_Ach_List_Name = {
	[1] = "A Predictable Failure",
}

Misc_Ach_List_Desc = {
	[1] = "Fail a map on survival with 4 or more players",
}

Misc_Ach_List_Mat = {
	[1] = "vgui/achievements/hl2_find_allgmen.png",
}

function AchievementMenu(ply)

	local name = LocalPlayer():GetNWString("Ach")

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
	
	local ScrollLobbyAch = vgui.Create("DScrollPanel", PanelLobbyAch)
	ScrollLobbyAch:Dock(FILL)
	
	for i = 1, 2 do
	
		local xPos = 240 * i
		local yPos = 45
		
		local achLobbyName = ScrollLobbyAch:Add("DLabel")
		achLobbyName:SetPos(xPos - 165, yPos)
		if string.find(name, Lobby_Ach_List_Name[i], 1, true) then
			achLobbyName:SetText(Lobby_Ach_List_Name[i])
		else
			achLobbyName:SetText("LOCKED")
		end
		achLobbyName:SizeToContents()
		achLobbyName:SetDark(1)
		local achLobbyDesc = ScrollLobbyAch:Add("DLabel")
		achLobbyDesc:SetPos(xPos - 165, yPos + 30)
		if  string.find(name, Lobby_Ach_List_Name[i], 1, true) then
			achLobbyDesc:SetText(Lobby_Ach_List_Desc[i])
		else
			achLobbyDesc:SetText("???")
		end
		achLobbyDesc:SizeToContents()
		achLobbyDesc:SetDark(1)
		
		local achLobbyIcon = ScrollLobbyAch:Add("DImage")
		achLobbyIcon:SetPos(xPos - 235, yPos)
		achLobbyIcon:SetSize(64, 64)
		if string.find(name, Lobby_Ach_List_Name[i], 1, true) then
			achLobbyIcon:SetImage(Lobby_Ach_List_Icon[i])
		else
			achLobbyIcon:SetImage("vgui/hud/icon_locked")
		end
	end
	
	TabAchSheet:AddSheet("Lobby", PanelLobbyAch, nil)
	
	
	local PanelHL2Ach = vgui.Create( "DPanel", achFrame )
	PanelHL2Ach:SetSize(800, 850)
	PanelHL2Ach:SetPos(0, 400)
	PanelHL2Ach.Paint = function(s, w, h)
		draw.RoundedBox(0,0,0, w, h, Color(170, 170, 170, 255))
	end
	
	local ScrollHL2Ach = vgui.Create("DScrollPanel", PanelHL2Ach)
	ScrollHL2Ach:Dock(FILL)
	
	for i = 1, 5 do
	
		local xPos = 240 * i
		local yPos = 45
		if xPos >= 960 then
			xPos = xPos - 720 
			yPos = 135
		end
		
		local achHL2Name = ScrollHL2Ach:Add("DLabel")
		achHL2Name:SetPos(xPos - 165, yPos)
		if string.find(name, HL2_Ach_List_Name[i], 1, true) then
			achHL2Name:SetText(HL2_Ach_List_Name[i])
		else
			achHL2Name:SetText("LOCKED")
		end
		achHL2Name:SizeToContents()
		achHL2Name:SetDark(1)
		
		local achHL2Desc = ScrollHL2Ach:Add("DLabel")
		achHL2Desc:SetPos(xPos - 165, yPos + 30)
		if string.find(name, HL2_Ach_List_Name[i], 1, true) then
			achHL2Desc:SetText(HL2_Ach_List_Desc[i])
		else
			achHL2Desc:SetText("???")
		end
		achHL2Desc:SizeToContents()
		achHL2Desc:SetDark(1)
		
		local achHL2Icon = ScrollHL2Ach:Add("DImage")
		achHL2Icon:SetPos(xPos - 235, yPos)
		achHL2Icon:SetSize(64, 64)
		if string.find(name, HL2_Ach_List_Name[i], 1, true) then
			achHL2Icon:SetImage(HL2_Ach_List_Mat[i])
		else
			achHL2Icon:SetImage("vgui/hud/icon_locked")
		end
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

net.Receive("Open_Ach_Menu", function(ply)
	AchievementMenu(ply)
end)
net.Receive("Achievement_Earned", PopUp)
