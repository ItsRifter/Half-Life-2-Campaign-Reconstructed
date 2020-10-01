local strengthIcon = "vgui/achievements/hl2_get_crowbar.png"
local strengthDesc = "Strength\nIncrease Strength by "

local enduranceIcon = "vgui/achievements/hl2_beat_cemetery.png"
local enduranceDesc = "Endurance:\nIncrease Max HP by "

local recoveryIcon = "vgui/achievements/hlx_kill_elitesoldier_withhisenergyball.png"
local recoveryDesc = "Recovery:\nIncrease recovery by "

local geneticIcon = "vgui/achievements/hl2_beat_game.png"
local geneticDesc = "Genetic Mutation:\nAllow your pet to become something stronger"

function showFastZombieTree(curSkill, skillPoints)
	petEvolPanel.Paint = function(self, w, h)
		draw.RoundedBox( 4, 0, 0, w, h, COLOUR_PET_EVOL_PANEL)
		
		if curSkill < 1 then
			surface.SetDrawColor(255, 0, 0)
			surface.DrawLine(50, 175, 150, 175)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(50, 175, 150, 175)
		end
		
		if curSkill < 2 then
			surface.SetDrawColor(255, 0, 0)
			surface.DrawLine(150, 175, 250, 175)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(150, 175, 250, 175)
		end
		
		if curSkill < 3 then
			surface.SetDrawColor(255, 0, 0)
			surface.DrawLine(250, 175, 350, 175)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(250, 175, 350, 175)
		end
		
		if curSkill < 4 then
			surface.SetDrawColor(255, 0, 0)
			surface.DrawLine(375, 175, 275, 275)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(375, 175, 275, 275)
		end
		
		if curSkill < 5 then
			surface.SetDrawColor(255, 0, 0)
			surface.DrawLine(275, 275, 175, 375)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(275, 275, 175, 375)
		end
		
		if curSkill < 6 then
			surface.SetDrawColor(255, 0, 0)
			surface.DrawLine(175, 375, 75, 475)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(175, 375, 75, 475)
		end
		
		if curSkill < 7 then
			surface.SetDrawColor(255, 0, 0)
			surface.DrawLine(50, 475, 150, 475)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(50, 475, 150, 475)
		end
		
		if curSkill < 8 then
			surface.SetDrawColor(255, 0, 0)
			surface.DrawLine(150, 475, 250, 475)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(150, 475, 250, 475)
		end
		
		if curSkill < 9 then
			surface.SetDrawColor(255, 0, 0)
			surface.DrawLine(250, 475, 350, 475)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(250, 475, 350, 475)
		end
		
		if curSkill < 10 then
			surface.SetDrawColor(255, 0, 0)
			surface.DrawLine(350, 475, 250, 575)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(350, 475, 250, 575)
		end
	end
	
	local fastZombTree1 = vgui.Create("DImageButton", petEvolPanel)
	fastZombTree1:SetImage(strengthIcon)
	fastZombTree1:SetPos(50, 150)
	fastZombTree1:SetSize(50, 50)
	fastZombTree1:SetToolTip(strengthDesc .. "2")
	fastZombTree1.DoClick = function()
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
			fastZombTree2:SetImage(recoveryIcon)
			fastZombTree2:SetToolTip(recoveryDesc .. "10")
		end
	end
	
	fastZombTree2 = vgui.Create("DImageButton", petEvolPanel)
	fastZombTree2:SetPos(150, 150)
	fastZombTree2:SetSize(50, 50)
	if curSkill < 1 then
		fastZombTree2:SetImage("vgui/hud/icon_locked")
		fastZombTree2:SetToolTip("'UNKNOWN GENE'")
	else
		fastZombTree2:SetImage(recoveryIcon)
		fastZombTree2:SetToolTip(recoveryDesc .. "10")
	end
	fastZombTree2.DoClick = function()
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
			fastZombTree3:SetImage(enduranceIcon)
			fastZombTree3:SetToolTip(enduranceDesc .. "15")
		end
	end
	
	fastZombTree3 = vgui.Create("DImageButton", petEvolPanel)
	fastZombTree3:SetPos(250, 150)
	fastZombTree3:SetSize(50, 50)
	if curSkill < 2 then
		fastZombTree3:SetImage("vgui/hud/icon_locked")
		fastZombTree3:SetToolTip("'UNKNOWN GENE'")
	else
		fastZombTree3:SetImage(enduranceIcon)
		fastZombTree3:SetToolTip(enduranceDesc .. "15")
	end
	fastZombTree3.DoClick = function()
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
			fastZombTree4:SetImage(enduranceIcon)
			fastZombTree4:SetToolTip(enduranceDesc .. "25")
		end
	end
	
	fastZombTree4 = vgui.Create("DImageButton", petEvolPanel)
	fastZombTree4:SetPos(350, 150)
	fastZombTree4:SetSize(50, 50)
	if curSkill < 3 then
		fastZombTree4:SetImage("vgui/hud/icon_locked")
		fastZombTree4:SetToolTip("'UNKNOWN GENE'")
	else
		fastZombTree4:SetImage(enduranceIcon)
		fastZombTree4:SetToolTip(enduranceDesc .. "25")
	end
	fastZombTree4.DoClick = function()
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
			fastZombTree5:SetImage(strengthIcon)
			fastZombTree5:SetToolTip(strengthDesc .. "2")
		end
	end
	
	fastZombTree5 = vgui.Create("DImageButton", petEvolPanel)
	fastZombTree5:SetPos(250, 250)
	fastZombTree5:SetSize(50, 50)
	if curSkill < 4 then
		fastZombTree5:SetImage("vgui/hud/icon_locked")
		fastZombTree5:SetToolTip("'UNKNOWN GENE'")
	else
		fastZombTree5:SetImage(strengthIcon)
		fastZombTree5:SetToolTip(strengthDesc .. "2")
	end
	fastZombTree5.DoClick = function()
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
			fastZombTree6:SetImage(strengthIcon)
			fastZombTree6:SetToolTip(strengthDesc .. "3")
		end
	end
	
	fastZombTree6 = vgui.Create("DImageButton", petEvolPanel)
	fastZombTree6:SetPos(150, 350)
	fastZombTree6:SetSize(50, 50)
	if curSkill < 5 then
		fastZombTree6:SetImage("vgui/hud/icon_locked")
		fastZombTree6:SetToolTip("'UNKNOWN GENE'")
	else
		fastZombTree6:SetImage(strengthIcon)
		fastZombTree6:SetToolTip(strengthDesc .. "3")
	end
	fastZombTree6.DoClick = function()
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
			fastZombTree7:SetImage(recoveryIcon)
			fastZombTree7:SetToolTip(recoveryDesc .. "15")
		end
	end

	fastZombTree7 = vgui.Create("DImageButton", petEvolPanel)
	fastZombTree7:SetPos(50, 450)
	fastZombTree7:SetSize(50, 50)
	if curSkill < 6 then
		fastZombTree7:SetImage("vgui/hud/icon_locked")
		fastZombTree7:SetToolTip("'UNKNOWN GENE'")
	else
		fastZombTree7:SetImage(recoveryIcon)
		fastZombTree7:SetToolTip(recoveryDesc .. "15")
	end
	fastZombTree7.DoClick = function()
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
			fastZombTree8:SetImage(enduranceIcon)
			fastZombTree8:SetToolTip(enduranceDesc .. "25")
		end
	end
	
	fastZombTree8 = vgui.Create("DImageButton", petEvolPanel)
	fastZombTree8:SetPos(150, 450)
	fastZombTree8:SetSize(50, 50)
	if curSkill < 7 then
		fastZombTree8:SetImage("vgui/hud/icon_locked")
		fastZombTree8:SetToolTip("'UNKNOWN GENE'")
	else
		fastZombTree8:SetImage(enduranceIcon)
		fastZombTree8:SetToolTip(enduranceDesc .. "25")
	end
	fastZombTree8.DoClick = function()
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
			fastZombTree9:SetImage(enduranceIcon)
			fastZombTree9:SetToolTip(enduranceDesc .. "25")
		end
	end
	
	fastZombTree9 = vgui.Create("DImageButton", petEvolPanel)
	fastZombTree9:SetPos(250, 450)
	fastZombTree9:SetSize(50, 50)
	if curSkill < 8 then
		fastZombTree9:SetImage("vgui/hud/icon_locked")
		fastZombTree9:SetToolTip("'UNKNOWN GENE'")
	else
		fastZombTree9:SetImage(enduranceIcon)
		fastZombTree9:SetToolTip(enduranceDesc .. "25")
	end
	fastZombTree9.DoClick = function()
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
			fastZombTree10:SetImage(enduranceIcon)
			fastZombTree10:SetToolTip(enduranceDesc .. "25")
		end
	end
	
	fastZombTree10 = vgui.Create("DImageButton", petEvolPanel)
	fastZombTree10:SetPos(350, 450)
	fastZombTree10:SetSize(50, 50)
	if curSkill < 9 then
		fastZombTree10:SetImage("vgui/hud/icon_locked")
		fastZombTree10:SetToolTip("'UNKNOWN GENE'")
	else
		fastZombTree10:SetImage(enduranceIcon)
		fastZombTree10:SetToolTip(enduranceDesc .. "25")
	end
	fastZombTree10.DoClick = function()
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
			fastZombTree11:SetImage(geneticIcon)
			fastZombTree11:SetToolTip(geneticDesc)
		end
	end
	
	fastZombTree11 = vgui.Create("DImageButton", petEvolPanel)
	fastZombTree11:SetPos(200, 550)
	fastZombTree11:SetSize(50, 50)
	if curSkill < 10 then
		fastZombTree11:SetImage("vgui/hud/icon_locked")
		fastZombTree11:SetToolTip("'UNKNOWN GENE'")
	else
		fastZombTree11:SetImage(geneticIcon)
		fastZombTree11:SetToolTip(geneticDesc)
	end
	fastZombTree11.DoClick = function()
		if curSkill < 10 then
			LocalPlayer():ChatPrint("You need to unlock the previous skills")
			surface.PlaySound("buttons/button8.wav")
		elseif skillPoints <= 0 then
			LocalPlayer():ChatPrint("You don't have enough pet skill points")
			surface.PlaySound("buttons/button8.wav")
		elseif curSkill >= 11 then
			LocalPlayer():ChatPrint("You already unlocked this!")
			surface.PlaySound("buttons/button8.wav")
		else
			skillPoints = skillPoints - 1
			net.Start("Achievement")
				net.WriteString("Fast_Climber")
				net.WriteString("Misc_Ach_List")
				net.WriteInt(5000, 32)
			net.SendToServer()
			
			curSkill = 11
			net.Start("UpdateSkills")
			net.SendToServer()
			surface.PlaySound("beams/beamstart5.wav")
		end
	end
end