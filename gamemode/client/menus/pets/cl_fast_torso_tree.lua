local strengthIcon = "vgui/achievements/hl2_get_crowbar.png"
local strengthDesc = "Strength\nIncrease Strength by "

local enduranceIcon = "vgui/achievements/hl2_beat_cemetery.png"
local enduranceDesc = "Endurance:\nIncrease Max HP by "

local recoveryIcon = "vgui/achievements/hlx_kill_elitesoldier_withhisenergyball.png"
local recoveryDesc = "Recovery:\nIncrease recovery by "

local geneticIcon = "vgui/achievements/hl2_beat_game.png"
local geneticDesc = "Genetic Mutation:\nAllow your pet to become something stronger"

function showFastTorsoTree(curSkill, skillPoints)
	petEvolPanel.Paint = function(self, w, h)
		draw.RoundedBox( 4, 0, 0, w, h, COLOUR_PET_EVOL_PANEL)
		
		if curSkill < 1 then
			surface.SetDrawColor(255, 0, 0)
			surface.DrawLine(50, 275, 150, 275)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(50, 275, 150, 275)
		end
		
		if curSkill < 2 then
			surface.SetDrawColor(255, 0, 0)
			surface.DrawLine(150, 275, 250, 275)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(150, 275, 250, 275)
		end
		
		if curSkill < 3 then
			surface.SetDrawColor(255, 0, 0)
			surface.DrawLine(250, 275, 350, 275)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(250, 275, 350, 275)
		end
		
		if curSkill < 4 then
			surface.SetDrawColor(255, 0, 0)
			surface.DrawLine(375, 250, 375, 350)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(375, 250, 375, 350)
		end
		
		if curSkill < 5 then
			surface.SetDrawColor(255, 0, 0)
			surface.DrawLine(375, 350, 375, 450)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(375, 350, 375, 450)
		end
		
		if curSkill < 6 then
			surface.SetDrawColor(255, 0, 0)
			surface.DrawLine(350, 475, 250, 475)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(350, 475, 250, 475)
		end
		
		if curSkill < 7 then
			surface.SetDrawColor(255, 0, 0)
			surface.DrawLine(250, 475, 150, 475)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(250, 475, 150, 475)
		end
		
		if curSkill < 8 then
			surface.SetDrawColor(255, 0, 0)
			surface.DrawLine(150, 475, 50, 475)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(150, 475, 50, 475)
		end
		
		if curSkill < 9 then
			surface.SetDrawColor(255, 0, 0)
			surface.DrawLine(75, 450, 75, 550)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(75, 450, 75, 550)
		end
	end
	
	local fastTorsoTree1 = vgui.Create("DImageButton", petEvolPanel)
	fastTorsoTree1:SetImage(enduranceIcon)
	fastTorsoTree1:SetPos(50, 250)
	fastTorsoTree1:SetSize(50, 50)
	fastTorsoTree1:SetToolTip(enduranceDesc .. "10")
	fastTorsoTree1.DoClick = function()
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
			fastTorsoTree2:SetImage(enduranceIcon)
			fastTorsoTree2:SetToolTip(enduranceDesc .. "15")
		end
	end

	fastTorsoTree2 = vgui.Create("DImageButton", petEvolPanel)
	fastTorsoTree2:SetPos(150, 250)
	fastTorsoTree2:SetSize(50, 50)
	if curSkill < 1 then
		fastTorsoTree2:SetImage("vgui/hud/icon_locked")
		fastTorsoTree2:SetToolTip("'UNKNOWN GENE'")
	else
		fastTorsoTree2:SetImage(enduranceIcon)
		fastTorsoTree2:SetToolTip(enduranceDesc .. "15")
	end
	fastTorsoTree2.DoClick = function()
		if curSkill < 1 then
			LocalPlayer():ChatPrint("You need to unlock the previous skills")
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
			fastTorsoTree3:SetImage(enduranceIcon)
			fastTorsoTree3:SetToolTip(enduranceDesc .. "20")
		end
	end

	fastTorsoTree3 = vgui.Create("DImageButton", petEvolPanel)
	fastTorsoTree3:SetPos(250, 250)
	fastTorsoTree3:SetSize(50, 50)
	if curSkill < 2 then
		fastTorsoTree3:SetImage("vgui/hud/icon_locked")
		fastTorsoTree3:SetToolTip("'UNKNOWN GENE'")
	else
		fastTorsoTree3:SetImage(enduranceIcon)
		fastTorsoTree3:SetToolTip(enduranceDesc .. "20")
	end
	fastTorsoTree3.DoClick = function()
		if curSkill < 2 then
			LocalPlayer():ChatPrint("You need to unlock the previous skills")
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
			fastTorsoTree4:SetImage(strengthIcon)
			fastTorsoTree4:SetToolTip(strengthDesc .. "1")
		end
	end

	fastTorsoTree4 = vgui.Create("DImageButton", petEvolPanel)
	fastTorsoTree4:SetPos(350, 250)
	fastTorsoTree4:SetSize(50, 50)
	if curSkill < 3 then
		fastTorsoTree4:SetImage("vgui/hud/icon_locked")
		fastTorsoTree4:SetToolTip("'UNKNOWN GENE'")
	else
		fastTorsoTree4:SetImage(strengthIcon)
		fastTorsoTree4:SetToolTip(strengthDesc .. "1")
	end
	fastTorsoTree4.DoClick = function()
		if curSkill < 3 then
			LocalPlayer():ChatPrint("You need to unlock the previous skills")
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
			fastTorsoTree5:SetImage(strengthIcon)
			fastTorsoTree5:SetToolTip(strengthDesc .. "2")
		end
	end

	fastTorsoTree5 = vgui.Create("DImageButton", petEvolPanel)
	fastTorsoTree5:SetPos(350, 350)
	fastTorsoTree5:SetSize(50, 50)
	if curSkill < 4 then
		fastTorsoTree5:SetImage("vgui/hud/icon_locked")
		fastTorsoTree5:SetToolTip("'UNKNOWN GENE'")
	else
		fastTorsoTree5:SetImage(strengthIcon)
		fastTorsoTree5:SetToolTip(strengthDesc .. "2")
	end
	fastTorsoTree5.DoClick = function()
		if curSkill < 4 then
			LocalPlayer():ChatPrint("You need to unlock the previous skills")
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
			fastTorsoTree6:SetImage(recoveryIcon)
			fastTorsoTree6:SetToolTip(recoveryDesc .. "5")
		end
	end

	fastTorsoTree6 = vgui.Create("DImageButton", petEvolPanel)
	fastTorsoTree6:SetPos(350, 450)
	fastTorsoTree6:SetSize(50, 50)
	if curSkill < 5 then
		fastTorsoTree6:SetImage("vgui/hud/icon_locked")
		fastTorsoTree6:SetToolTip("'UNKNOWN GENE'")
	else
		fastTorsoTree6:SetImage(recoveryIcon)
		fastTorsoTree6:SetToolTip(recoveryDesc .. "5")
	end
	fastTorsoTree6.DoClick = function()
		if curSkill < 5 then
			LocalPlayer():ChatPrint("You need to unlock the previous skills")
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
			fastTorsoTree7:SetImage(recoveryIcon)
			fastTorsoTree7:SetToolTip(recoveryDesc .. "10")
		end
	end

	fastTorsoTree7 = vgui.Create("DImageButton", petEvolPanel)
	fastTorsoTree7:SetPos(250, 450)
	fastTorsoTree7:SetSize(50, 50)
	if curSkill < 6 then
		fastTorsoTree7:SetImage("vgui/hud/icon_locked")
		fastTorsoTree7:SetToolTip("'UNKNOWN GENE'")
	else
		fastTorsoTree7:SetImage(recoveryIcon)
		fastTorsoTree7:SetToolTip(recoveryDesc .. "10")
	end
	fastTorsoTree7.DoClick = function()
		if curSkill < 6 then
			LocalPlayer():ChatPrint("You need to unlock the previous skills")
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
			fastTorsoTree8:SetImage(strengthIcon)
			fastTorsoTree8:SetToolTip(strengthDesc .. "2")
		end
	end

	fastTorsoTree8 = vgui.Create("DImageButton", petEvolPanel)
	fastTorsoTree8:SetPos(150, 450)
	fastTorsoTree8:SetSize(50, 50)
	if curSkill < 7 then
		fastTorsoTree8:SetImage("vgui/hud/icon_locked")
		fastTorsoTree8:SetToolTip("'UNKNOWN GENE'")
	else
		fastTorsoTree8:SetImage(strengthIcon)
		fastTorsoTree8:SetToolTip(strengthDesc .. "2")
	end
	fastTorsoTree8.DoClick = function()
		if curSkill < 7 then
			LocalPlayer():ChatPrint("You need to unlock the previous skills")
			surface.PlaySound("buttons/button8.wav")
		elseif skillPoints <= 0 then
			LocalPlayer():ChatPrint("You don't have enough pet skill points")
			surface.PlaySound("buttons/button8.wav")
		elseif curSkill >= 8 then
			LocalPlayer():ChatPrint("You already unlocked this!")
			surface.PlaySound("buttons/button8.wav")
		else
			skillPoints = skillPoints - 1
			curSkill = 8
			net.Start("UpdateSkills")
			net.SendToServer()
			surface.PlaySound("beams/beamstart5.wav")
			fastTorsoTree9:SetImage(recoveryIcon)
			fastTorsoTree9:SetToolTip(recoveryDesc .. "10")
		end
	end

	fastTorsoTree9 = vgui.Create("DImageButton", petEvolPanel)
	fastTorsoTree9:SetPos(50, 450)
	fastTorsoTree9:SetSize(50, 50)
	if curSkill < 8 then
		fastTorsoTree9:SetImage("vgui/hud/icon_locked")
		fastTorsoTree9:SetToolTip("'UNKNOWN GENE'")
	else
		fastTorsoTree9:SetImage(recoveryIcon)
		fastTorsoTree9:SetToolTip(recoveryDesc .. "10")
	end
	fastTorsoTree9.DoClick = function()
		if curSkill < 8 then
			LocalPlayer():ChatPrint("You need to unlock the previous skills")
			surface.PlaySound("buttons/button8.wav")
		elseif skillPoints <= 0 then
			LocalPlayer():ChatPrint("You don't have enough pet skill points")
			surface.PlaySound("buttons/button8.wav")
		elseif curSkill >= 9 then
			LocalPlayer():ChatPrint("You already unlocked this!")
			surface.PlaySound("buttons/button8.wav")
		else
			skillPoints = skillPoints - 1
			curSkill = 9
			net.Start("UpdateSkills")
			net.SendToServer()
			surface.PlaySound("beams/beamstart5.wav")
			fastTorsoTree10:SetImage(geneticIcon)
			fastTorsoTree10:SetToolTip(geneticDesc)
		end
	end
	
	fastTorsoTree10 = vgui.Create("DImageButton", petEvolPanel)
	fastTorsoTree10:SetPos(50, 550)
	fastTorsoTree10:SetSize(50, 50)
	if curSkill < 9 then
		fastTorsoTree10:SetImage("vgui/hud/icon_locked")
		fastTorsoTree10:SetToolTip("'UNKNOWN GENE'")
	else
		fastTorsoTree10:SetImage(geneticIcon)
		fastTorsoTree10:SetToolTip(geneticDesc)
	end
	fastTorsoTree10.DoClick = function()
		if curSkill < 9 then
			LocalPlayer():ChatPrint("You need to unlock the previous skills")
			surface.PlaySound("buttons/button8.wav")
		elseif skillPoints <= 0 then
			LocalPlayer():ChatPrint("You don't have enough pet skill points")
			surface.PlaySound("buttons/button8.wav")
		elseif curSkill >= 10 then
			LocalPlayer():ChatPrint("You already unlocked this!")
			surface.PlaySound("buttons/button8.wav")
		else
			skillPoints = skillPoints - 1
			curSkill = 10
			net.Start("UpdateSkills")
			net.SendToServer()
			surface.PlaySound("beams/beamstart5.wav")
		end
	end
end