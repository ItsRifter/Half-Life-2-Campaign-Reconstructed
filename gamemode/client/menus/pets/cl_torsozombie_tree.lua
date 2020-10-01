local strengthIcon = "vgui/achievements/hl2_get_crowbar.png"
local strengthDesc = "Strength\nIncrease Strength by "

local enduranceIcon = "vgui/achievements/hl2_beat_cemetery.png"
local enduranceDesc = "Endurance:\nIncrease Max HP by "

local recoveryIcon = "vgui/achievements/hlx_kill_elitesoldier_withhisenergyball.png"
local recoveryDesc = "Recovery:\nIncrease recovery by "

local geneticIcon = "vgui/achievements/hl2_beat_game.png"
local geneticDesc = "Genetic Mutation:\nAllow your pet to become something stronger"

function showZombTorsoTree(curSkill, skillPoints)
	petEvolPanel.Paint = function(self, w, h)
		draw.RoundedBox( 4, 0, 0, w, h, COLOUR_PET_EVOL_PANEL)
		
		if curSkill < 1 then
			surface.SetDrawColor(255, 0, 0)
			surface.DrawLine(275, 425, 275, 500)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(275, 425, 275, 500)
		end

		if curSkill < 2 then
			surface.SetDrawColor(255, 0, 0)
			surface.DrawLine(275, 425, 375, 425)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(275, 425, 375, 425)
		end

		if curSkill < 3 then
			surface.SetDrawColor(255, 0, 0)
			surface.DrawLine(375, 425, 375, 325)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(375, 425, 375, 325)
		end

		if curSkill < 4 then
			surface.SetDrawColor(255, 0, 0)
			surface.DrawLine(375, 325, 375, 225)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(375, 325, 375, 225)
		end

		if curSkill < 5 then
			surface.SetDrawColor(255, 0, 0)
			surface.DrawLine(375, 225, 275, 225)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(375, 225, 275, 225)
		end
		
		if curSkill < 6 then
			surface.SetDrawColor(255, 0, 0)
			surface.DrawLine(275, 225, 275, 125)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(275, 225, 275, 125)
		end
	end
	
	local torsozombTree1 = vgui.Create("DImageButton", petEvolPanel)
	torsozombTree1:SetImage(enduranceIcon)
	torsozombTree1:SetPos(250, 500)
	torsozombTree1:SetSize(50, 50)
	torsozombTree1:SetToolTip(enduranceDesc .. "10")
	torsozombTree1.DoClick = function()
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
			torsozombTree2:SetImage(recoveryIcon)
			torsozombTree2:SetToolTip(recoveryDesc .. "5")
		end
	end
	
	torsozombTree2 = vgui.Create("DImageButton", petEvolPanel)
	torsozombTree2:SetPos(250, 400)
	torsozombTree2:SetSize(50, 50)	
	if curSkill < 2 then
		torsozombTree2:SetImage("vgui/hud/icon_locked")
		torsozombTree2:SetToolTip("'UNKNOWN GENE'")
	else
		torsozombTree2:SetImage(recoveryIcon)
		torsozombTree2:SetToolTip(recoveryDesc .. "5")
	end
	torsozombTree2.DoClick = function()
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
			torsozombTree3:SetImage(strengthIcon)
			torsozombTree3:SetToolTip(strengthDesc .. "1")
		end
	end
	
	torsozombTree3 = vgui.Create("DImageButton", petEvolPanel)
	torsozombTree3:SetImage(strengthIcon)
	torsozombTree3:SetPos(350, 400)
	torsozombTree3:SetSize(50, 50)
	if curSkill < 3 then
		torsozombTree3:SetImage("vgui/hud/icon_locked")
		torsozombTree3:SetToolTip("'UNKNOWN GENE'")
	else
		torsozombTree3:SetImage(strengthIcon)
		torsozombTree3:SetToolTip(strengthDesc .. "1")
	end
	torsozombTree3.DoClick = function()
		if curSkill < 2 then
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
			surface.PlaySound("beams/beamstart5.wav")
			net.Start("UpdateSkills")
			net.SendToServer()
			torsozombTree4:SetImage(enduranceIcon)
			torsozombTree4:SetToolTip(enduranceDesc .. "10")
		end
	end
	torsozombTree4 = vgui.Create("DImageButton", petEvolPanel)
	torsozombTree4:SetPos(350, 300)
	torsozombTree4:SetSize(50, 50)
	if curSkill < 3 then
		torsozombTree4:SetImage("vgui/hud/icon_locked")
		torsozombTree4:SetToolTip("'UNKNOWN GENE'")
	else
		torsozombTree4:SetImage(enduranceIcon)
		torsozombTree4:SetToolTip(enduranceDesc .. "10")
	end
	torsozombTree4.DoClick = function()
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
			surface.PlaySound("beams/beamstart5.wav")
			net.Start("UpdateSkills")
				net.WriteInt(4, 16)
			net.SendToServer()
			torsozombTree5:SetImage(recoveryIcon)
			torsozombTree5:SetToolTip(recoveryDesc .. "5")
		end
	end

	torsozombTree5 = vgui.Create("DImageButton", petEvolPanel)
	torsozombTree5:SetPos(350, 200)
	torsozombTree5:SetSize(50, 50)
	if curSkill < 4 then
		torsozombTree5:SetImage("vgui/hud/icon_locked")
		torsozombTree5:SetToolTip("'UNKNOWN GENE'")
	else
		torsozombTree5:SetImage(recoveryIcon)
		torsozombTree5:SetToolTip(recoveryDesc .. "5")
	end
	torsozombTree5.DoClick = function()
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
			surface.PlaySound("beams/beamstart5.wav")
			net.Start("UpdateSkills")
			net.SendToServer()
			torsozombTree6:SetImage(enduranceIcon)
			torsozombTree6:SetToolTip(enduranceDesc .. "15")
		end
	end
	
	torsozombTree6 = vgui.Create("DImageButton", petEvolPanel)
	torsozombTree6:SetPos(250, 200)
	torsozombTree6:SetSize(50, 50)
	if curSkill < 5 then
		torsozombTree6:SetImage("vgui/hud/icon_locked")
		torsozombTree6:SetToolTip("'UNKNOWN GENE'")
	else
		torsozombTree6:SetImage(enduranceIcon)
		torsozombTree6:SetToolTip(enduranceDesc .. "15")
	end
	torsozombTree6.DoClick = function()
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
			surface.PlaySound("beams/beamstart5.wav")
			net.Start("UpdateSkills")
			net.SendToServer()
			torsozombTree7:SetImage(geneticIcon)
			torsozombTree7:SetToolTip(geneticDesc)
		end
	end
	
	torsozombTree7 = vgui.Create("DImageButton", petEvolPanel)
	torsozombTree7:SetPos(250, 100)
	torsozombTree7:SetSize(50, 50)
	if curSkill < 6 then
		torsozombTree7:SetImage("vgui/hud/icon_locked")
		torsozombTree7:SetToolTip("'UNKNOWN GENE'")
	else
		torsozombTree7:SetImage(geneticIcon)
		torsozombTree7:SetToolTip(geneticDesc)
	end
	torsozombTree7.DoClick = function()
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