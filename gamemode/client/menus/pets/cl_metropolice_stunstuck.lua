local strengthIcon = "vgui/achievements/hl2_get_crowbar.png"
local strengthDesc = "Strength\nIncrease Strength by "

local enduranceIcon = "vgui/achievements/hl2_beat_cemetery.png"
local enduranceDesc = "Endurance:\nIncrease Max HP by "

local recoveryIcon = "vgui/achievements/hlx_kill_elitesoldier_withhisenergyball.png"
local recoveryDesc = "Recovery:\nIncrease recovery by "

local geneticIcon = "vgui/achievements/hl2_beat_game.png"
local geneticDesc = "Genetic Mutation:\nAllow your pet to become something stronger"

function showMetroStunTree(curSkill, skillPoints)
	petEvolPanel.Paint = function(self, w, h)
		draw.RoundedBox( 4, 0, 0, w, h, COLOUR_PET_EVOL_PANEL)
		if curSkill < 1 then
			surface.SetDrawColor(255, 0, 0)
			surface.DrawLine(275, 500, 275, 450)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(275, 500, 275, 450)
		end
		
		if curSkill < 2 then
			surface.SetDrawColor(255, 0, 0)
			surface.DrawLine(250, 425, 150, 425)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(250, 425, 150, 425)
		end
		
		if curSkill < 3 then
			surface.SetDrawColor(255, 0, 0)
			surface.DrawLine(175, 450, 175, 550)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(175, 450, 175, 550)
		end
	end
	
	local metroStunTree1 = vgui.Create("DImageButton", petEvolPanel)
	metroStunTree1:SetImage(strengthIcon)
	metroStunTree1:SetPos(250, 500)
	metroStunTree1:SetSize(50, 50)
	metroStunTree1:SetToolTip(strengthDesc .. "1")
	metroStunTree1.DoClick = function()
		if skillPoints <= 0 then
			LocalPlayer():ChatPrint("You don't have enough pet skill points")
			surface.PlaySound("buttons/button8.wav")
		elseif curSkill >= 1 then
			LocalPlayer():ChatPrint("You already unlocked this!")
			surface.PlaySound("buttons/button8.wav")
		else
			skillPoints = skillPoints - 1
			curSkill = 1
			net.Start("UpdateSkills")
			net.SendToServer()
			surface.PlaySound("beams/beamstart5.wav")
			metroStunTree2:SetImage(strengthIcon)
			metroStunTree2:SetToolTip(strengthDesc .. "2")
		end
	end
		
	metroStunTree2 = vgui.Create("DImageButton", petEvolPanel)
	metroStunTree2:SetPos(250, 400)
	metroStunTree2:SetSize(50, 50)
	if curSkill < 1 then
		metroStunTree2:SetImage("vgui/hud/icon_locked")
		metroStunTree2:SetToolTip("'UNKNOWN GENE'")
	else
		metroStunTree2:SetImage(strengthIcon)
		metroStunTree2:SetToolTip(strengthDesc .. "2")
	end
	
	metroStunTree2.DoClick = function()
		if curSkill < 1 then
			LocalPlayer():ChatPrint("You need to unlock the previous skill")
			surface.PlaySound("buttons/button8.wav")
		elseif skillPoints <= 0 then
			LocalPlayer():ChatPrint("You don't have enough pet skill points")
			surface.PlaySound("buttons/button8.wav")
		elseif curSkill >= 2 then
			LocalPlayer():ChatPrint("You already unlocked this!")
			surface.PlaySound("buttons/button8.wav")
		else
			skillPoints = skillPoints - 1
			curSkill = 2
			net.Start("UpdateSkills")
			net.SendToServer()
			surface.PlaySound("beams/beamstart5.wav")
			metroStunTree3:SetImage(strengthIcon)
			metroStunTree3:SetToolTip(strengthDesc .. "3")
		end
	end
	
	metroStunTree3 = vgui.Create("DImageButton", petEvolPanel)
	metroStunTree3:SetPos(150, 400)
	metroStunTree3:SetSize(50, 50)
	if curSkill < 1 then
		metroStunTree3:SetImage("vgui/hud/icon_locked")
		metroStunTree3:SetToolTip("'UNKNOWN GENE'")
	else
		metroStunTree3:SetImage(strengthIcon)
		metroStunTree3:SetToolTip(strengthDesc .. "3")
	end
	
	metroStunTree3.DoClick = function()
		if curSkill < 1 then
			LocalPlayer():ChatPrint("You need to unlock the previous skill")
			surface.PlaySound("buttons/button8.wav")
		elseif skillPoints <= 0 then
			LocalPlayer():ChatPrint("You don't have enough pet skill points")
			surface.PlaySound("buttons/button8.wav")
		elseif curSkill >= 3 then
			LocalPlayer():ChatPrint("You already unlocked this!")
			surface.PlaySound("buttons/button8.wav")
		else
			skillPoints = skillPoints - 1
			curSkill = 3
			net.Start("UpdateSkills")
			net.SendToServer()
			surface.PlaySound("beams/beamstart5.wav")
			metroStunTree4:SetImage(geneticIcon)
			metroStunTree4:SetToolTip(geneticDesc)
		end
	end
	
	metroStunTree4 = vgui.Create("DImageButton", petEvolPanel)
	metroStunTree4:SetPos(150, 500)
	metroStunTree4:SetSize(50, 50)
	if curSkill < 4 then
		metroStunTree4:SetImage("vgui/hud/icon_locked")
		metroStunTree4:SetToolTip("'UNKNOWN GENE'")
	else
		metroStunTree4:SetImage(geneticIcon)
		metroStunTree4:SetToolTip(geneticDesc)
	end
	
	metroStunTree4.DoClick = function()
		if curSkill < 3 then
			LocalPlayer():ChatPrint("You need to unlock the previous skill")
			surface.PlaySound("buttons/button8.wav")
		elseif skillPoints <= 0 then
			LocalPlayer():ChatPrint("You don't have enough pet skill points")
			surface.PlaySound("buttons/button8.wav")
		elseif curSkill >= 4 then
			LocalPlayer():ChatPrint("You already unlocked this!")
			surface.PlaySound("buttons/button8.wav")
		else
			skillPoints = skillPoints - 1
			curSkill = 4
			net.Start("UpdateSkills")
			net.SendToServer()
			surface.PlaySound("beams/beamstart5.wav")
		end
	end
end