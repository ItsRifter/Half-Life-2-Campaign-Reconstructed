Lobby_Ach_List = {
	[1] = {name = "First Time", desc = "Play the gamemode\nfor the first time", mat = "vgui/achievements/hl2_beat_cemetery.png", isRare = false, clientTriggerable = true},
	[2] = {name = "Worthless Secret", desc = "You get this one\nbut with no XP!", mat = "entities/npc_kleiner.png", isRare = true},
	[3] = {name = "Lost Cause", desc = "Find what remains of\nLeiftiger's HL2C server", mat = "vgui/achievements/hl2_beat_cemetery.png", isRare = false, clientTriggerable = true}
}

HL2_Ach_List = {
	[1] = {name = "A Red Letter Baby", desc = "Bring the baby\ndoll to Dr.Kleiner", mat = "vgui/achievements/hl2_beat_game.png", isRare = false},
	[2] = {name = "What cat", desc = "Break the mini-teleporter\nin Kleiner's lab", mat = "vgui/achievements/hl2_break_miniteleporter.png", isRare = false},
	[3] = {name = "Trusty Hardware", desc = "Acquire the crowbar", mat = "vgui/achievements/hl2_get_crowbar.png", isRare = false},
	[4] = {name = "ZeroPoint Energy", desc = "Acquire the Gravity gun in Black Mesa East", mat = "vgui/achievements/hl2_get_gravitygun.png", isRare = false},
	[5] = {name = "Rave Ball", desc = "Carry dog's ball through Ravenholm\ninto the mines", mat = "vgui/achievements/hl2_get_gravitygun.png", isRare = false},
	[6] = {name = "Keep off the sand", desc = "Cross the antlion beach in d2_coast_11 without touching the sand", mat = "vgui/achievements/hl2_beat_donttouchsand.png", isRare = false},
}

Misc_Ach_List = {
	[1] = {name = "A Predictable Failure", desc = "Fail a map on survival with 4 or more players", mat = "vgui/achievements/hl2_find_allgmen.png", isRare = false},
	[2] = {name = "Blast that little", desc = "Complete the Zombie evolution tree", mat = "vgui/achievements/hl2_beat_toxictunnel.png", isRare = false},
	[3] = {name = "Born Survivor", desc = "Finish five maps without dying", mat = "vgui/achievements/hl2_followfreeman", isRare = false},
}

HL2_Vortex_List = {
	[1] = {name = "d1_trainstation_05", desc = "Find the vortex after the\nteleportation disaster", mat = "vgui/achievements/hlx_find_onegman.png"},
	[2] = {name = "d1_trainstation_06", desc = "Find the vortex near the\ncombine forcefield", mat = "vgui/achievements/hlx_find_onegman.png"},
	[3] = {name = "d1_canals_01", desc = "Find the vortex underwater", mat = "vgui/achievements/hlx_find_onegman.png"},
	[4] = {name = "d1_canals_02", desc = "Find the vortex in the tunnel", mat = "vgui/achievements/hlx_find_onegman.png"},
	[5] = {name = "d1_eli_01", desc = "Find the vortex inside\nBlack Mesa East", mat = "vgui/achievements/hlx_find_onegman.png"},
	[6] = {name = "d1_eli_02", desc = "Find the vortex ontop of a silo in the scrapyard", mat = "vgui/achievements/hlx_find_onegman.png"},
	[7] = {name = "d1_town_02", desc = "Find the vortex by grenade\njumping OR climbing to the chimney", mat = "vgui/achievements/hlx_find_onegman.png"},
	[8] = {name = "d1_town_03", desc = "Find the vortex by prop\nclimbing to the roof", mat = "vgui/achievements/hlx_find_onegman.png"},
	[9] = {name = "d1_town_02a", desc = "Find the vortex by using\nsawblades to climb upto the roof", mat = "vgui/achievements/hlx_find_onegman.png"},
	[10] = {name = "d1_town_04", desc = "Find the vortex by prop\nclimbing to the big tank", mat = "vgui/achievements/hlx_find_onegman.png"},
	[11] = {name = "d1_town_05", desc = "Find the vortex by prop\nclimbing onto metal support", mat = "vgui/achievements/hlx_find_onegman.png"},
	[12] = {name = "d2_coast_01", desc = "Find the vortex by prop\nclimbing onto the hut", mat = "vgui/achievements/hlx_find_onegman.png"},
}

function AchievementMenu(achievement, vortexes)

	local achFrame = vgui.Create("DFrame")
	achFrame:SetSize(820, 600)
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
	
	local fixString = string.Replace(table.ToString(achievement), "_", " ")
	local fixVortex = table.ToString(vortexes)
	
	local ScrollLobbyAch = vgui.Create("DScrollPanel", PanelLobbyAch)
	ScrollLobbyAch:Dock(FILL)
	
	local iconListLobby = vgui.Create("DIconLayout", ScrollLobbyAch)
	iconListLobby:Dock(FILL)
	iconListLobby:SetSpaceY(5)
	iconListLobby:SetSpaceX(5)
	
	for i = 1, #Lobby_Ach_List do
		
		local lobbyPanel = iconListLobby:Add("DPanel")
		lobbyPanel:SetPaintBackground(false)
		lobbyPanel:SetSize(128, 128)
		
		local achLobbyName = lobbyPanel:Add("DLabel")
		achLobbyName:SetPos(0, 65)
		--Find if the player has this achievement, if so show it with name, desc and icon
		if string.find(fixString, Lobby_Ach_List[i].name, 1, true) then
			achLobbyName:SetText(Lobby_Ach_List[i].name)
		else
			achLobbyName:SetText("LOCKED")
		end
		achLobbyName:SizeToContents()
		achLobbyName:SetColor(Color(0, 0, 0))
		
		local achLobbyDesc = lobbyPanel:Add("DLabel")
		achLobbyDesc:SetPos(0, 90)
		if string.find(fixString, Lobby_Ach_List[i].name, 1) then
			achLobbyDesc:SetText(Lobby_Ach_List[i].desc)
		else
			achLobbyDesc:SetText("???")
		end
		achLobbyDesc:SizeToContents()
		achLobbyDesc:SetColor(Color(0, 0, 0))
		
		local achLobbyIcon = lobbyPanel:Add("DImage")
		achLobbyIcon:SetPos(0, 0)
		achLobbyIcon:SetSize(64, 64)
		
		if string.find(fixString, Lobby_Ach_List[i].name, 1) then
			achLobbyIcon:SetImage(Lobby_Ach_List[i].mat)
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
	
	local iconListHL2 = vgui.Create("DIconLayout", ScrollHL2Ach)
	iconListHL2:Dock(FILL)
	iconListHL2:SetSpaceY(5)
	iconListHL2:SetSpaceX(5)
	
	for i = 1, #HL2_Ach_List do
		
		local hl2Panel = iconListHL2:Add("DPanel")
		hl2Panel:SetPaintBackground(false)
		hl2Panel:SetSize(128, 128)
		
		local achHL2Name = hl2Panel:Add("DLabel")
		achHL2Name:SetPos(0, 65)
		if string.find(fixString, HL2_Ach_List[i].name, 1, true) then
			achHL2Name:SetText(HL2_Ach_List[i].name)
		else
			achHL2Name:SetText("LOCKED")
		end
		achHL2Name:SizeToContents()
		achHL2Name:SetColor(Color(0, 0, 0))
		
		local achHL2Desc = hl2Panel:Add("DLabel")
		achHL2Desc:SetPos(0, 90)
		if string.find(fixString, HL2_Ach_List[i].name, 1) then
			achHL2Desc:SetText(HL2_Ach_List[i].desc)
		else
			achHL2Desc:SetText("???")
		end
		achHL2Desc:SizeToContents()
		achHL2Desc:SetColor(Color(0, 0, 0))
		
		local achHL2Icon = hl2Panel:Add("DImage")
		achHL2Icon:SetPos(0, 0)
		achHL2Icon:SetSize(64, 64)
		if string.find(fixString, HL2_Ach_List[i].name, 1, true) then
			achHL2Icon:SetImage(HL2_Ach_List[i].mat)
		else
			achHL2Icon:SetImage("vgui/hud/icon_locked")
		end
	end
	
	TabAchSheet:AddSheet("Half-Life 2", PanelHL2Ach, nil)
	
	local PanelMiscAch = vgui.Create( "DPanel", achFrame )
	PanelMiscAch:SetSize(800, 850)
	PanelMiscAch:SetPos(0, 400)
	PanelMiscAch.Paint = function(s, w, h)
		draw.RoundedBox(0,0,0, w, h, Color(170, 170, 170, 255))
	end
		
	
	local ScrollMiscAch = vgui.Create("DScrollPanel", PanelMiscAch)
	ScrollMiscAch:Dock(FILL)
	
	local iconListMisc = vgui.Create("DIconLayout", ScrollMiscAch)
	iconListMisc:Dock(FILL)
	iconListMisc:SetSpaceY(5)
	iconListMisc:SetSpaceX(5)
	
	for i = 1, #Misc_Ach_List do
		
		local miscPanel = iconListMisc:Add("DPanel")
		miscPanel:SetPaintBackground(false)
		miscPanel:SetSize(128, 128)
		
		local achMiscName = miscPanel:Add("DLabel")
		achMiscName:SetPos(0, 65)
		if string.find(fixString, Misc_Ach_List[i].name, 1, true) then
			achMiscName:SetText(Misc_Ach_List[i].name)
		else
			achMiscName:SetText("LOCKED")
		end
		
		achMiscName:SizeToContents()
		achMiscName:SetColor(Color(0, 0, 0))
		
		local achMiscDesc = miscPanel:Add("DLabel")
		achMiscDesc:SetPos(0, 90)
		if string.find(fixString, Misc_Ach_List[i].name, 1, true) then
			achMiscDesc:SetText(Misc_Ach_List[i].desc)
		else
			achMiscDesc:SetText("???")
		end
		achMiscDesc:SizeToContents()
		achMiscDesc:SetColor(Color(0, 0, 0))
		
		local achMiscIcon = miscPanel:Add("DImage")
		achMiscIcon:SetPos(0, 0)
		achMiscIcon:SetSize(64, 64)
		if string.find(fixString, Misc_Ach_List[i].name, 1, true) then
			achMiscIcon:SetImage(Misc_Ach_List[i].mat)
		else
			achMiscIcon:SetImage("vgui/hud/icon_locked")
		end
	end
		
	TabAchSheet:AddSheet("Miscellaneous", PanelMiscAch, nil)
	
	local PanelHL2Vort = vgui.Create( "DPanel", achFrame )
	PanelHL2Vort:SetSize(800, 850)
	PanelHL2Vort:SetPos(0, 400)
	PanelHL2Vort.Paint = function(s, w, h)
		draw.RoundedBox(0,0,0, w, h, Color(170, 170, 170, 255))
	end
		
	local ScrollHL2Vort = vgui.Create("DScrollPanel", PanelHL2Vort)
	ScrollHL2Vort:Dock(FILL)
	
	local iconListHL2Vort = vgui.Create("DIconLayout", ScrollHL2Vort)
	iconListHL2Vort:Dock(FILL)
	iconListHL2Vort:SetSpaceY(5)
	iconListHL2Vort:SetSpaceX(5)
	
	for i = 1, #HL2_Vortex_List do
		
		local vortHL2Panel = iconListHL2Vort:Add("DPanel")
		vortHL2Panel:SetPaintBackground(false)
		vortHL2Panel:SetSize(128, 128)
		
		local vortHL2Name = vortHL2Panel:Add("DLabel")
		vortHL2Name:SetPos(0, 65)
		vortHL2Name:SetText(HL2_Vortex_List[i].name)
		
		vortHL2Name:SizeToContents()
		vortHL2Name:SetColor(Color(0, 0, 0))
		
		local vortHL2Desc = vortHL2Panel:Add("DLabel")
		vortHL2Desc:SetPos(0, 90)
		if string.find(fixVortex, HL2_Vortex_List[i].name, 1, true) then
			vortHL2Desc:SetText(HL2_Vortex_List[i].desc)
		else
			vortHL2Desc:SetText("???")
		end
		vortHL2Desc:SizeToContents()
		vortHL2Desc:SetColor(Color(0, 0, 0))
		
		local vortHL2Icon = vortHL2Panel:Add("DImage")
		vortHL2Icon:SetPos(0, 0)
		vortHL2Icon:SetSize(64, 64)
		if string.find(fixVortex, HL2_Vortex_List[i].name, 1, true) then
			vortHL2Icon:SetImage(HL2_Vortex_List[i].mat)
		else
			vortHL2Icon:SetImage("vgui/hud/icon_locked")
		end
	end
	
	
	TabAchSheet:AddSheet("HL2 Vortexes", PanelHL2Vort, nil)
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
	local unlocked = "Achievement Unlocked!"
	local achImage = net.ReadString()
	local isRare = net.ReadBool()
	if not achTitle then achTitle = "Bug" end
	if not achImage then achImage = "entities/npc_kleiner.png" end
	
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
		if not isRare then
			surface.PlaySound("hl2cr/ach_unlock.wav")
		else
			surface.PlaySound("hl2cr/rare_ach_unlock.wav")
		end
end

net.Receive("Open_Ach_Menu", function()
	local ach = net.ReadTable()
	local vort = net.ReadTable()
	AchievementMenu(ach, vort)
end)
net.Receive("Achievement_Earned", PopUp)
