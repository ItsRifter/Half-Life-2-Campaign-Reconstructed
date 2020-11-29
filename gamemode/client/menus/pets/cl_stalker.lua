local strengthIcon = "vgui/achievements/hl2_get_crowbar.png"
local strengthDesc = "Strength\nIncrease Strength by "

local enduranceIcon = "vgui/achievements/hl2_beat_cemetery.png"
local enduranceDesc = "Endurance:\nIncrease Max HP by "

local recoveryIcon = "vgui/achievements/hlx_kill_elitesoldier_withhisenergyball.png"
local recoveryDesc = "Recovery:\nIncrease recovery by "

local geneticIcon = "vgui/achievements/hl2_beat_game.png"
local geneticDesc = "Genetic Mutation:\nAllow your pet to become something stronger"

function showStalkerTree(curSkill, skillPoints)
	petEvolPanel.Paint = function(self, w, h)
		draw.RoundedBox( 4, 0, 0, w, h, COLOUR_PET_EVOL_PANEL)
		
		if curSkill < 1 then
			surface.SetDrawColor(255, 0, 0)
			surface.DrawLine(275, 500, 275, 425)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(275, 500, 275, 425)
		end
		
		if curSkill < 2 then
			surface.SetDrawColor(255, 0, 0)
			surface.DrawLine(275, 450, 275, 325)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(275, 450, 275, 325)
		end

		if curSkill < 3 then
			surface.SetDrawColor(255, 0, 0)
			surface.DrawLine(275, 350, 275, 225)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(275, 350, 275, 225)
		end
		
		if curSkill < 4 then
			surface.SetDrawColor(255, 0, 0)
			surface.DrawLine(275, 225, 375, 225)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(275, 225, 375, 225)
		end
		
		if curSkill < 5 then
			surface.SetDrawColor(255, 0, 0)
			surface.DrawLine(375, 225, 475, 225)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(375, 225, 475, 225)
		end
		
	end
	
	local stalkerTree1 = vgui.Create("DImageButton", petEvolPanel)
	stalkerTree1:SetImage(strengthIcon)
	stalkerTree1:SetPos(250, 500)
	stalkerTree1:SetSize(50, 50)
	stalkerTree1:SetToolTip(strengthDesc .. "1")
	stalkerTree1.DoClick = function()
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
			stalkerTree2:SetImage(strengthIcon)
			stalkerTree2:SetToolTip(strengthDesc .. "2")
		end
	end
		
	stalkerTree2 = vgui.Create("DImageButton", petEvolPanel)
	stalkerTree2:SetPos(250, 400)
	stalkerTree2:SetSize(50, 50)
	if curSkill < 1 then
		stalkerTree2:SetImage("vgui/hud/icon_locked")
		stalkerTree2:SetToolTip("'UNKNOWN GENE'")
	else
		stalkerTree2:SetImage(strengthIcon)
		stalkerTree2:SetToolTip(strengthDesc .. "2")
	end
	
	stalkerTree2.DoClick = function()
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
			stalkerTree3:SetImage(strengthIcon)
			stalkerTree3:SetToolTip(strengthDesc .. "3")
		end
	end
	
	stalkerTree3 = vgui.Create("DImageButton", petEvolPanel)
	stalkerTree3:SetPos(250, 300)
	stalkerTree3:SetSize(50, 50)
	if curSkill < 1 then
		stalkerTree3:SetImage("vgui/hud/icon_locked")
		stalkerTree3:SetToolTip("'UNKNOWN GENE'")
	else
		stalkerTree3:SetImage(strengthIcon)
		stalkerTree3:SetToolTip(strengthDesc .. "3")
	end
	
	stalkerTree3.DoClick = function()
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
			stalkerTree4:SetImage(enduranceIcon)
			stalkerTree4:SetToolTip(enduranceDesc .. "5")
		end
	end
	
	stalkerTree4 = vgui.Create("DImageButton", petEvolPanel)
	stalkerTree4:SetPos(250, 200)
	stalkerTree4:SetSize(50, 50)
	if curSkill < 4 then
		stalkerTree4:SetImage("vgui/hud/icon_locked")
		stalkerTree4:SetToolTip("'UNKNOWN GENE'")
	else
		stalkerTree4:SetImage(enduranceIcon)
		stalkerTree4:SetToolTip(enduranceDesc .. "5")
	end
	
	stalkerTree4.DoClick = function()
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
			stalkerTree5:SetImage(enduranceIcon)
			stalkerTree5:SetToolTip(enduranceDesc .. "10")
		end
	end
	
	stalkerTree5 = vgui.Create("DImageButton", petEvolPanel)
	stalkerTree5:SetPos(350, 200)
	stalkerTree5:SetSize(50, 50)
	if curSkill < 4 then
		stalkerTree5:SetImage("vgui/hud/icon_locked")
		stalkerTree5:SetToolTip("'UNKNOWN GENE'")
	else
		stalkerTree5:SetImage(enduranceIcon)
		stalkerTree5:SetToolTip(enduranceDesc .. "10")
	end
	
	stalkerTree5.DoClick = function()
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
			stalkerTree6:SetImage(geneticIcon)
			stalkerTree6:SetToolTip(geneticDesc)
		end
	end
	
	stalkerTree6 = vgui.Create("DImageButton", petEvolPanel)
	stalkerTree6:SetPos(450, 200)
	stalkerTree6:SetSize(50, 50)
	if curSkill < 4 then
		stalkerTree6:SetImage("vgui/hud/icon_locked")
		stalkerTree6:SetToolTip("'UNKNOWN GENE'")
	else
		stalkerTree6:SetImage(geneticIcon)
		stalkerTree6:SetToolTip(geneticDesc)
	end
	
	stalkerTree6.DoClick = function()
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
		end
	end
end