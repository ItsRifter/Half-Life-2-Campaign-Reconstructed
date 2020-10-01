local strengthIcon = "vgui/achievements/hl2_get_crowbar.png"
local strengthDesc = "Strength\nIncrease Strength by "

local enduranceIcon = "vgui/achievements/hl2_beat_cemetery.png"
local enduranceDesc = "Endurance:\nIncrease Max HP by "

local recoveryIcon = "vgui/achievements/hlx_kill_elitesoldier_withhisenergyball.png"
local recoveryDesc = "Recovery:\nIncrease recovery by "

local geneticIcon = "vgui/achievements/hl2_beat_game.png"
local geneticDesc = "Genetic Mutation:\nAllow your pet to become something stronger"

function showHeadcrabTree(curSkill, skillPoints)
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
			surface.DrawLine(275, 225, 275, 100)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(275, 225, 275, 100)
		end
	end
	
	local headcrabTree1 = vgui.Create("DImageButton", petEvolPanel)
	headcrabTree1:SetImage(enduranceIcon)
	headcrabTree1:SetPos(250, 500)
	headcrabTree1:SetSize(50, 50)
	headcrabTree1:SetToolTip(enduranceDesc .. "5")
	headcrabTree1.DoClick = function()
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
			headcrabTree2:SetImage(enduranceIcon)
			headcrabTree2:SetToolTip(enduranceDesc .. "5")
		end
	end
		
	headcrabTree2 = vgui.Create("DImageButton", petEvolPanel)
	headcrabTree2:SetPos(250, 400)
	headcrabTree2:SetSize(50, 50)
	if curSkill < 1 then
		headcrabTree2:SetImage("vgui/hud/icon_locked")
		headcrabTree2:SetToolTip("'UNKNOWN GENE'")
	else
		headcrabTree2:SetImage(enduranceIcon)
		headcrabTree2:SetToolTip(enduranceDesc .. "5")
	end
	
	headcrabTree2.DoClick = function()
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
			headcrabTree3:SetImage(strengthIcon)
			headcrabTree3:SetToolTip(strengthDesc .. "1")
		end
	end
	
	headcrabTree3 = vgui.Create("DImageButton", petEvolPanel)
	headcrabTree3:SetPos(250, 300)
	headcrabTree3:SetSize(50, 50)
	if curSkill < 2 then
		headcrabTree3:SetImage("vgui/hud/icon_locked")
		headcrabTree3:SetToolTip("'UNKNOWN GENE'")
	else
		headcrabTree3:SetImage(strengthIcon)
		headcrabTree3:SetToolTip(strengthDesc .. "1")
	end
	headcrabTree3.DoClick = function()
		if skillPoints <= 0 then
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
			headcrabTree4:SetImage(strengthIcon)
			headcrabTree4:SetToolTip(strengthDesc .. "1")
		end
	end
	
	headcrabTree4 = vgui.Create("DImageButton", petEvolPanel)
	headcrabTree4:SetPos(250, 200)
	headcrabTree4:SetSize(50, 50)
	if curSkill < 3 then
		headcrabTree4:SetImage("vgui/hud/icon_locked")
		headcrabTree4:SetToolTip("'UNKNOWN GENE'")
	else
		headcrabTree4:SetImage(strengthIcon)
		headcrabTree4:SetToolTip(strengthDesc .. "1")
	end
	
	headcrabTree4.DoClick = function()
		if skillPoints <= 0 then
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
			headcrabTree5:SetImage(geneticIcon)
			headcrabTree5:SetToolTip(geneticDesc)
		end
	end

	headcrabTree5 = vgui.Create("DImageButton", petEvolPanel)
	headcrabTree5:SetPos(250, 100)
	headcrabTree5:SetSize(50, 50)
	if curSkill < 4 then
		headcrabTree5:SetImage("vgui/hud/icon_locked")
		headcrabTree5:SetToolTip("'UNKNOWN GENE'")
	else
		headcrabTree5:SetImage(geneticIcon)
		headcrabTree5:SetToolTip(geneticDesc)
	end
	
	headcrabTree5.DoClick = function()
		if skillPoints <= 0 then
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
		end
	end
end