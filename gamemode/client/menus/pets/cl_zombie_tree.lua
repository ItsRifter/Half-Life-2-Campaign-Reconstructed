local strengthIcon = "vgui/achievements/hl2_get_crowbar.png"
local strengthDesc = "Strength\nIncrease Strength by "

local enduranceIcon = "vgui/achievements/hl2_beat_cemetery.png"
local enduranceDesc = "Endurance:\nIncrease Max HP by "

local recoveryIcon = "vgui/achievements/hlx_kill_elitesoldier_withhisenergyball.png"
local recoveryDesc = "Recovery:\nIncrease recovery by "

local geneticIcon = "vgui/achievements/hl2_beat_game.png"
local geneticDesc = "Genetic Mutation:\nAllow your pet to become something stronger"

function showZombieTree(curSkill, skillPoints)
	petEvolPanel.Paint = function(self, w, h)
		draw.RoundedBox( 4, 0, 0, w, h, COLOUR_PET_EVOL_PANEL)
		if curSkill < 1 then
			surface.SetDrawColor(255, 0, 0)
			surface.DrawLine(275, 525, 375, 425)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(275, 525, 375, 425)
		end

		if curSkill < 2 then
			surface.SetDrawColor(255, 0, 0)
			surface.DrawLine(375, 450, 175, 325)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(375, 450, 175, 325)
		end

		if curSkill < 3 then
			surface.SetDrawColor(255, 0, 0)
			surface.DrawLine(175, 350, 375, 225)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(175, 350, 375, 225)
		end

		if curSkill < 4 then
			surface.SetDrawColor(255, 0, 0)
			surface.DrawLine(375, 250, 175, 125)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(375, 250, 175, 125)
		end

		if curSkill < 5 then
			surface.SetDrawColor(255, 0, 0)
			surface.DrawLine(175, 150, 275, 75)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(175, 150, 275, 75)
		end
	end
	
	local zombTree1 = vgui.Create("DImageButton", petEvolPanel)
	zombTree1:SetImage(enduranceIcon)
	zombTree1:SetPos(250, 500)
	zombTree1:SetSize(50, 50)
	zombTree1:SetToolTip(enduranceDesc .. "5")
	zombTree1.DoClick = function()
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
			zombTree2:SetImage(recoveryIcon)
			zombTree2:SetToolTip(recoveryDesc .. "5")
		end
	end

	zombTree2 = vgui.Create("DImageButton", petEvolPanel)
	zombTree2:SetPos(350, 415)
	zombTree2:SetSize(50, 50)
	if curSkill < 1 then
		zombTree2:SetImage("vgui/hud/icon_locked")
		zombTree2:SetToolTip("'UNKNOWN GENE'")
	else
		zombTree2:SetImage(recoveryIcon)
		zombTree2:SetToolTip(recoveryDesc .. "5")
	end
	zombTree2.DoClick = function()
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
			zombTree3:SetImage(enduranceIcon)
			zombTree3:SetToolTip(enduranceDesc .. "5")
		end
	end

	zombTree3 = vgui.Create("DImageButton", petEvolPanel)
	zombTree3:SetPos(150, 315)
	zombTree3:SetSize(50, 50)
	if curSkill < 2 then
		zombTree3:SetImage("vgui/hud/icon_locked")
		zombTree3:SetToolTip("'UNKNOWN GENE'")
	else
		zombTree3:SetImage(enduranceIcon)
		zombTree3:SetToolTip(enduranceDesc .. "5")
	end
	zombTree3.DoClick = function()
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
			net.Start("UpdateSkills")
			net.SendToServer()
			surface.PlaySound("beams/beamstart5.wav")
			zombTree4:SetImage(strengthIcon)
			zombTree4:SetToolTip(strengthDesc .. "1")
		end
	end

	zombTree4 = vgui.Create("DImageButton", petEvolPanel)
	zombTree4:SetPos(350, 215)
	zombTree4:SetSize(50, 50)
	if curSkill < 3 then
		zombTree4:SetImage("vgui/hud/icon_locked")
		zombTree4:SetToolTip("'UNKNOWN GENE'")
	else
		zombTree4:SetImage(strengthIcon)
		zombTree4:SetToolTip(strengthDesc .. "1")
	end
	zombTree4.DoClick = function()
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
				net.WriteInt(4, 16)
			net.SendToServer()
			surface.PlaySound("beams/beamstart5.wav")
			zombTree5:SetImage(enduranceIcon)
			zombTree5:SetToolTip(enduranceDesc .. "10")
		end
	end

	zombTree5 = vgui.Create("DImageButton", petEvolPanel)
	zombTree5:SetPos(150, 115)
	zombTree5:SetSize(50, 50)
	if curSkill < 4 then
		zombTree5:SetImage("vgui/hud/icon_locked")
		zombTree5:SetToolTip("'UNKNOWN GENE'")
	else
		zombTree5:SetImage(enduranceIcon)
		zombTree5:SetToolTip(enduranceDesc .. "10")
	end
	zombTree5.DoClick = function()
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
			zombTree6:SetImage(strengthIcon)
			zombTree6:SetToolTip(strengthDesc .. "2")
		end
	end

	zombTree6 = vgui.Create("DImageButton", petEvolPanel)
	zombTree6:SetPos(250, 65)
	zombTree6:SetSize(50, 50)
	if curSkill < 5 then
		zombTree6:SetImage("vgui/hud/icon_locked")
		zombTree6:SetToolTip("'UNKNOWN GENE'")
	else
		zombTree6:SetImage(strengthIcon)
		zombTree6:SetToolTip(strengthDesc .. "2")
	end
	zombTree6.DoClick = function()
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
			
			net.Start("Achievement")
				net.WriteString("Blast_that_little")
				net.WriteString("Misc_Ach_List")
				net.WriteInt(2500, 32)
			net.SendToServer()
			
			LocalPlayer():ChatPrint("It seems like your pet is tired of fighting, time for a new pet")
			
			surface.PlaySound("beams/beamstart5.wav")
		end
	end
end