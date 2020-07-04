Lobby_Ach_List = {
	[1] = {name = "First Time", desc = "Play the gamemode for the first time", mat = "vgui/achievements/hl2_beat_cemetery.png", isRare = false, clientTriggerable = true},
	[2] = {name = "Worthless Secret", desc = "You get this one, but with no XP!", mat = "entities/npc_kleiner.png", isRare = true},
	[3] = {name = "Lost Cause", desc = "Find what remains of Leiftiger's HL2C server", mat = "vgui/achievements/hl2_beat_cemetery.png", isRare = false, clientTriggerable = true}
}

HL2_Ach_List = {
	[1] = {name = "A Red Letter Baby", desc = "Bring the baby doll to Dr.Kleiner", mat = "vgui/achievements/hl2_beat_game.png", isRare = false},
	[2] = {name = "Trusty Hardware", desc = "Acquire the crowbar", mat = "vgui/achievements/hl2_get_crowbar.png", isRare = false},
	[3] = {name = "ZeroPoint Energy", desc = "Acquire the Gravity gun in Black Mesa East", mat = "vgui/achievements/hl2_get_gravitygun.png", isRare = false},
	[4] = {name = "Rave Ball", desc = "Carry dog's ball through Ravenholm\ninto the mines", mat = "vgui/achievements/hl2_get_gravitygun.png", isRare = false},
	[5] = {name = "Keep off the sand", desc = "Cross the antlion beach in d2_coast_11 without touching the sand", mat = "vgui/achievements/hl2_beat_donttouchsand.png", isRare = false},
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
	[6] = {name = "d1_town_02", desc = "Find the vortex by grenade\njumping OR climbing to the chimney", mat = "vgui/achievements/hlx_find_onegman.png"},
}

function AchievementMenu(achievement, vortexes)

	local achFrame = vgui.Create("DFrame")
	achFrame:SetSize(950, 600)
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
	
	local fixString = string.Replace(table.ToString(achievement), "_", " ")
	local fixVortex = table.ToString(vortexes)
	
	for i = 1, #Lobby_Ach_List do
		
		local xPos = 280 * i
		local yPos = 45
		
		local achLobbyName = ScrollLobbyAch:Add("DLabel")
		achLobbyName:SetPos(xPos - 165, yPos)
		--Find if the player has this achievement, if so show it with name, desc and icon
		if string.find(fixString, Lobby_Ach_List[i].name, 1, true) then
			achLobbyName:SetText(Lobby_Ach_List[i].name)
		else
			achLobbyName:SetText("LOCKED")
		end
		achLobbyName:SizeToContents()
		achLobbyName:SetColor(Color(0, 0, 0))
		
		local achLobbyDesc = ScrollLobbyAch:Add("DLabel")
		achLobbyDesc:SetPos(xPos - 165, yPos + 30)
		if string.find(fixString, Lobby_Ach_List[i].name, 1) then
			achLobbyDesc:SetText(Lobby_Ach_List[i].desc)
		else
			achLobbyDesc:SetText("???")
		end
		achLobbyDesc:SizeToContents()
		achLobbyDesc:SetColor(Color(0, 0, 0))
		
		local achLobbyIcon = ScrollLobbyAch:Add("DImage")
		achLobbyIcon:SetPos(xPos - 235, yPos)
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
	
	for i = 1, #HL2_Ach_List do
	
		local xPos = 280
		local yPos = 45
	
		if i <= 3 then
			xPos = xPos * i
		end
		
		if i >= 4 and i <= 7 then
			xPos = xPos * i - 840
			yPos = 135
		end
		
		local achHL2Name = ScrollHL2Ach:Add("DLabel")
		achHL2Name:SetPos(xPos - 165, yPos)
		if string.find(fixString, HL2_Ach_List[i].name, 1, true) then
			achHL2Name:SetText(HL2_Ach_List[i].name)
		else
			achHL2Name:SetText("LOCKED")
		end
		achHL2Name:SizeToContents()
		achHL2Name:SetColor(Color(0, 0, 0))
		
		local achHL2Desc = ScrollHL2Ach:Add("DLabel")
		achHL2Desc:SetPos(xPos - 165, yPos + 30)
		if string.find(fixString, HL2_Ach_List[i].name, 1) then
			achHL2Desc:SetText(HL2_Ach_List[i].desc)
		else
			achHL2Desc:SetText("???")
		end
		achHL2Desc:SizeToContents()
		achHL2Desc:SetColor(Color(0, 0, 0))
		
		local achHL2Icon = ScrollHL2Ach:Add("DImage")
		achHL2Icon:SetPos(xPos - 235, yPos)
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
	
	for i = 1, #Misc_Ach_List do
	
		local xPos = 280 * i
		local yPos = 45
		if xPos >= 960 then
			xPos = xPos / i 
			yPos = 135
		end
		
		local achMiscName = ScrollMiscAch:Add("DLabel")
		achMiscName:SetPos(xPos - 165, yPos)
		if string.find(fixString, Misc_Ach_List[i].name, 1, true) then
			achMiscName:SetText(Misc_Ach_List[i].name)
		else
			achMiscName:SetText("LOCKED")
		end
		achMiscName:SizeToContents()
		achMiscName:SetColor(Color(0, 0, 0))
		
		local achMiscDesc = ScrollMiscAch:Add("DLabel")
		achMiscDesc:SetPos(xPos - 165, yPos + 30)
		if string.find(fixString, Misc_Ach_List[i].name, 1, true) then
			achMiscDesc:SetText(Misc_Ach_List[i].desc)
		else
			achMiscDesc:SetText("???")
		end
		achMiscDesc:SizeToContents()
		achMiscDesc:SetColor(Color(0, 0, 0))
		
		local achMiscIcon = ScrollMiscAch:Add("DImage")
		achMiscIcon:SetPos(xPos - 235, yPos)
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
	
	for i = 1, #HL2_Vortex_List do
	
		--Not the best code but it works
		local xPos = 280 * i
		local yPos = 45
		if i == 4 then
			xPos = 280
			yPos = 135
		elseif i == 5 then
			xPos = 280 * 2
			yPos = 135
		elseif i == 6 then
			xPos = 280 * 3
			yPos = 135
		elseif i == 7 then
			xPos = 280
			yPos = 225
		end
		
		local vortHL2Name = ScrollHL2Vort:Add("DLabel")
		vortHL2Name:SetPos(xPos - 165, yPos)
		vortHL2Name:SetText(HL2_Vortex_List[i].name)
		
		vortHL2Name:SizeToContents()
		vortHL2Name:SetColor(Color(0, 0, 0))
		
		local vortHL2Desc = ScrollHL2Vort:Add("DLabel")
		vortHL2Desc:SetPos(xPos - 165, yPos + 30)
		if string.find(fixVortex, HL2_Vortex_List[i].name, 1, true) then
			vortHL2Desc:SetText(HL2_Vortex_List[i].desc)
		else
			vortHL2Desc:SetText("???")
		end
		vortHL2Desc:SizeToContents()
		vortHL2Desc:SetColor(Color(0, 0, 0))
		
		local vortHL2Icon = ScrollHL2Vort:Add("DImage")
		vortHL2Icon:SetPos(xPos - 235, yPos)
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
