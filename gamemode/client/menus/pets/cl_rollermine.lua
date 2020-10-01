local strengthIcon = "vgui/achievements/hl2_get_crowbar.png"
local strengthDesc = "Strength\nIncrease Strength by "

local enduranceIcon = "vgui/achievements/hl2_beat_cemetery.png"
local enduranceDesc = "Endurance:\nIncrease Max HP by "

local recoveryIcon = "vgui/achievements/hlx_kill_elitesoldier_withhisenergyball.png"
local recoveryDesc = "Recovery:\nIncrease recovery by "

local geneticIcon = "vgui/achievements/hl2_beat_game.png"
local geneticDesc = "Genetic Mutation:\nAllow your pet to become something stronger"

function showRollermineTree(curSkill, skillPoints)
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
	
	local rollermineTree1 = vgui.Create("DImageButton", petEvolPanel)
	rollermineTree1:SetImage(strengthIcon)
	rollermineTree1:SetPos(250, 500)
	rollermineTree1:SetSize(50, 50)
	rollermineTree1:SetToolTip(strengthDesc .. "1")
	rollermineTree1.DoClick = function()
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
			rollermineTree2:SetImage(strengthIcon)
			rollermineTree2:SetToolTip(strengthDesc .. "2")
		end
	end
		
	rollermineTree2 = vgui.Create("DImageButton", petEvolPanel)
	rollermineTree2:SetPos(250, 400)
	rollermineTree2:SetSize(50, 50)
	if curSkill < 1 then
		rollermineTree2:SetImage("vgui/hud/icon_locked")
		rollermineTree2:SetToolTip("'UNKNOWN GENE'")
	else
		rollermineTree2:SetImage(strengthIcon)
		rollermineTree2:SetToolTip(strengthDesc .. "2")
	end
	
	rollermineTree2.DoClick = function()
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
			rollermineTree3:SetImage(strengthIcon)
			rollermineTree3:SetToolTip(strengthDesc .. "3")
		end
	end
	
	rollermineTree3 = vgui.Create("DImageButton", petEvolPanel)
	rollermineTree3:SetPos(150, 400)
	rollermineTree3:SetSize(50, 50)
	if curSkill < 1 then
		rollermineTree3:SetImage("vgui/hud/icon_locked")
		rollermineTree3:SetToolTip("'UNKNOWN GENE'")
	else
		rollermineTree3:SetImage(strengthIcon)
		rollermineTree3:SetToolTip(strengthDesc .. "3")
	end
	
	rollermineTree3.DoClick = function()
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
			rollermineTree4:SetImage(geneticIcon)
			rollermineTree4:SetToolTip(geneticDesc)
		end
	end
	
	rollermineTree4 = vgui.Create("DImageButton", petEvolPanel)
	rollermineTree4:SetPos(150, 500)
	rollermineTree4:SetSize(50, 50)
	if curSkill < 4 then
		rollermineTree4:SetImage("vgui/hud/icon_locked")
		rollermineTree4:SetToolTip("'UNKNOWN GENE'")
	else
		rollermineTree4:SetImage(geneticIcon)
		rollermineTree4:SetToolTip(geneticDesc)
	end
	
	rollermineTree4.DoClick = function()
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