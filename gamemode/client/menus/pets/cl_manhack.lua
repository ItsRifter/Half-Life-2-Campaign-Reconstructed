local strengthIcon = "vgui/achievements/hl2_get_crowbar.png"
local strengthDesc = "Strength\nIncrease Strength by "

local enduranceIcon = "vgui/achievements/hl2_beat_cemetery.png"
local enduranceDesc = "Endurance:\nIncrease Max HP by "

local recoveryIcon = "vgui/achievements/hlx_kill_elitesoldier_withhisenergyball.png"
local recoveryDesc = "Recovery:\nIncrease recovery by "

local geneticIcon = "vgui/achievements/hl2_beat_game.png"
local geneticDesc = "Genetic Mutation:\nAllow your pet to become something stronger"

function showManhackTree(curSkill, skillPoints)
	petEvolPanel.Paint = function(self, w, h)
		draw.RoundedBox( 4, 0, 0, w, h, COLOUR_PET_EVOL_PANEL)
		if curSkill < 1 then
			surface.SetDrawColor(255, 0, 0)
			surface.DrawLine(75, 350, 125, 250)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(75, 350, 125, 250)
		end
		
		if curSkill < 2 then
			surface.SetDrawColor(255, 0, 0)
			surface.DrawLine(125, 250, 175, 450)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(125, 250, 175, 450)
		end
		
		if curSkill < 3 then
			surface.SetDrawColor(255, 0, 0)
			surface.DrawLine(175, 450, 225, 250)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(175, 450, 225, 250)
		end
		
		if curSkill < 4 then
			surface.SetDrawColor(255, 0, 0)
			surface.DrawLine(225, 250, 275, 450)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(225, 250, 275, 450)
		end
		
		if curSkill < 5 then
			surface.SetDrawColor(255, 0, 0)
			surface.DrawLine(275, 450, 325, 250)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(275, 450, 325, 250)
		end
		
		if curSkill < 6 then
			surface.SetDrawColor(255, 0, 0)
			surface.DrawLine(325, 250, 375, 350)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(325, 250, 375, 350)
		end
	end
	
	local manhackTree1 = vgui.Create("DImageButton", petEvolPanel)
	manhackTree1:SetImage(recoveryIcon)
	manhackTree1:SetPos(50, 350)
	manhackTree1:SetSize(50, 50)
	manhackTree1:SetToolTip(recoveryDesc .. "10")
	manhackTree1.DoClick = function()
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
			manhackTree2:SetImage(enduranceIcon)
			manhackTree2:SetToolTip(enduranceDesc .. "15")
		end
	end
		
	manhackTree2 = vgui.Create("DImageButton", petEvolPanel)
	manhackTree2:SetPos(100, 250)
	manhackTree2:SetSize(50, 50)
	if curSkill < 1 then
		manhackTree2:SetImage("vgui/hud/icon_locked")
		manhackTree2:SetToolTip("'UNKNOWN GENE'")
	else
		manhackTree2:SetImage(enduranceIcon)
		manhackTree2:SetToolTip(enduranceDesc .. "15")
	end
	
	manhackTree2.DoClick = function()
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
			manhackTree3:SetImage(enduranceIcon)
			manhackTree3:SetToolTip(enduranceDesc .. "20")
		end
	end
	manhackTree3 = vgui.Create("DImageButton", petEvolPanel)
	manhackTree3:SetPos(150, 450)
	manhackTree3:SetSize(50, 50)
	if curSkill < 1 then
		manhackTree3:SetImage("vgui/hud/icon_locked")
		manhackTree3:SetToolTip("'UNKNOWN GENE'")
	else
		manhackTree3:SetImage(enduranceIcon)
		manhackTree3:SetToolTip(enduranceDesc .. "20")
	end
	
	manhackTree3.DoClick = function()
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
			manhackTree4:SetImage(recoveryIcon)
			manhackTree4:SetToolTip(recoveryDesc .. "10")
		end
	end
	
	manhackTree4 = vgui.Create("DImageButton", petEvolPanel)
	manhackTree4:SetPos(200, 250)
	manhackTree4:SetSize(50, 50)
	if curSkill < 4 then
		manhackTree4:SetImage("vgui/hud/icon_locked")
		manhackTree4:SetToolTip("'UNKNOWN GENE'")
	else
		manhackTree4:SetImage(recoveryIcon)
		manhackTree4:SetToolTip(recoveryDesc .. "10")
	end
	
	manhackTree4.DoClick = function()
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
			manhackTree5:SetImage(recoveryIcon)
			manhackTree5:SetToolTip(recoveryDesc .. "15")
		end
	end
	
	manhackTree5 = vgui.Create("DImageButton", petEvolPanel)
	manhackTree5:SetPos(250, 450)
	manhackTree5:SetSize(50, 50)
	if curSkill < 5 then
		manhackTree5:SetImage("vgui/hud/icon_locked")
		manhackTree5:SetToolTip("'UNKNOWN GENE'")
	else
		manhackTree5:SetImage(recoveryIcon)
		manhackTree5:SetToolTip(recoveryDesc .. "15")
	end
	
	manhackTree5.DoClick = function()
		if curSkill < 4 then
			LocalPlayer():ChatPrint("You need to unlock the previous skill")
			surface.PlaySound("buttons/button8.wav")
		elseif skillPoints <= 0 then
			LocalPlayer():ChatPrint("You don't have enough pet skill points")
			surface.PlaySound("buttons/button8.wav")
		elseif curSkill >= 5 then
			LocalPlayer():ChatPrint("You already unlocked this!")
			surface.PlaySound("buttons/button8.wav")
		else
			skillPoints = skillPoints - 1
			curSkill = 5
			net.Start("UpdateSkills")
			net.SendToServer()
			surface.PlaySound("beams/beamstart5.wav")
			manhackTree6:SetImage(strengthIcon)
			manhackTree6:SetToolTip(strengthDesc .. "3")
		end
	end
	
	manhackTree6 = vgui.Create("DImageButton", petEvolPanel)
	manhackTree6:SetPos(300, 250)
	manhackTree6:SetSize(50, 50)
	if curSkill < 5 then
		manhackTree6:SetImage("vgui/hud/icon_locked")
		manhackTree6:SetToolTip("'UNKNOWN GENE'")
	else
		manhackTree6:SetImage(strengthIcon)
		manhackTree6:SetToolTip(strengthDesc .. "3")
	end
	
	manhackTree6.DoClick = function()
		if curSkill < 5 then
			LocalPlayer():ChatPrint("You need to unlock the previous skill")
			surface.PlaySound("buttons/button8.wav")
		elseif skillPoints <= 0 then
			LocalPlayer():ChatPrint("You don't have enough pet skill points")
			surface.PlaySound("buttons/button8.wav")
		elseif curSkill >= 6 then
			LocalPlayer():ChatPrint("You already unlocked this!")
			surface.PlaySound("buttons/button8.wav")
		else
			skillPoints = skillPoints - 1
			curSkill = 6
			net.Start("UpdateSkills")
			net.SendToServer()
			surface.PlaySound("beams/beamstart5.wav")
			manhackTree7:SetImage(geneticIcon)
			manhackTree7:SetToolTip(geneticDesc)
		end
	end
	
	manhackTree7 = vgui.Create("DImageButton", petEvolPanel)
	manhackTree7:SetPos(350, 350)
	manhackTree7:SetSize(50, 50)
	if curSkill < 6 then
		manhackTree7:SetImage("vgui/hud/icon_locked")
		manhackTree7:SetToolTip("'UNKNOWN GENE'")
	else
		manhackTree7:SetImage(geneticIcon)
		manhackTree7:SetToolTip(geneticDesc)
	end
	
	manhackTree7.DoClick = function()
		if curSkill < 6 then
			LocalPlayer():ChatPrint("You need to unlock the previous skill")
			surface.PlaySound("buttons/button8.wav")
		elseif skillPoints <= 0 then
			LocalPlayer():ChatPrint("You don't have enough pet skill points")
			surface.PlaySound("buttons/button8.wav")
		elseif curSkill >= 7 then
			LocalPlayer():ChatPrint("You already unlocked this!")
			surface.PlaySound("buttons/button8.wav")
		else
			skillPoints = skillPoints - 1
			curSkill = 7
			net.Start("UpdateSkills")
			net.SendToServer()
			surface.PlaySound("beams/beamstart5.wav")
		end
	end
end