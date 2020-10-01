local strengthIcon = "vgui/achievements/hl2_get_crowbar.png"
local strengthDesc = "Strength\nIncrease Strength by "

local enduranceIcon = "vgui/achievements/hl2_beat_cemetery.png"
local enduranceDesc = "Endurance:\nIncrease Max HP by "

local recoveryIcon = "vgui/achievements/hlx_kill_elitesoldier_withhisenergyball.png"
local recoveryDesc = "Recovery:\nIncrease recovery by "

local geneticIcon = "vgui/achievements/hl2_beat_game.png"
local geneticDesc = "Genetic Mutation:\nAllow your pet to become something stronger"

function showFastHeadcrabTree(curSkill, skillPoints)
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
			surface.DrawLine(275, 400, 275, 300)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(275, 400, 275, 300)
		end
		
		if curSkill < 3 then
			surface.SetDrawColor(255, 0, 0)
			surface.DrawLine(275, 300, 275, 200)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(275, 300, 275, 200)
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
		
		if curSkill < 6 then
			surface.SetDrawColor(255, 0, 0)
			surface.DrawLine(475, 200, 475, 300)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(475, 200, 475, 300)
		end
		
		if curSkill < 7 then
			surface.SetDrawColor(255, 0, 0)
			surface.DrawLine(475, 300, 475, 400)
		else
			surface.SetDrawColor(0, 255, 0)
			surface.DrawLine(475, 300, 475, 400)
		end
	end
	
	local fastHeadcrabTree1 = vgui.Create("DImageButton", petEvolPanel)
	fastHeadcrabTree1:SetImage(strengthIcon)
	fastHeadcrabTree1:SetPos(250, 500)
	fastHeadcrabTree1:SetSize(50, 50)
	fastHeadcrabTree1:SetToolTip(strengthDesc .. "1")
	fastHeadcrabTree1.DoClick = function()
		if skillPoints <= 0 then
			LocalPlayer():ChatPrint("You don't have enough pet skill points")
			surface.PlaySound("buttons/button8.wav")
		elseif curSkill >= 1 then
			LocalPlayer():ChatPrint("You already unlocked this!")
			surface.PlaySound("buttons/button8.wav")
		else
			curSkill = 1
			skillPoints = skillPoints - 1
			net.Start("UpdateSkills")
			net.SendToServer()
			surface.PlaySound("beams/beamstart5.wav")
			fastHeadcrabTree2:SetImage(recoveryIcon)
			fastHeadcrabTree2:SetToolTip(recoveryDesc .. "5")
		end
	end
	
	fastHeadcrabTree2 = vgui.Create("DImageButton", petEvolPanel)
	fastHeadcrabTree2:SetPos(250, 400)
	fastHeadcrabTree2:SetSize(50, 50)
	if curSkill < 1 then
		fastHeadcrabTree2:SetImage("vgui/hud/icon_locked")
		fastHeadcrabTree2:SetToolTip("'UNKNOWN GENE'")
	else
		fastHeadcrabTree2:SetImage(recoveryIcon)
		fastHeadcrabTree2:SetToolTip(recoveryDesc .. "5")
	end
	fastHeadcrabTree2.DoClick = function()
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
			fastHeadcrabTree3:SetImage(recoveryIcon)
			fastHeadcrabTree3:SetToolTip(recoveryDesc .. "5")
		end
	end
	
	fastHeadcrabTree3 = vgui.Create("DImageButton", petEvolPanel)
	fastHeadcrabTree3:SetPos(250, 300)
	fastHeadcrabTree3:SetSize(50, 50)
	if curSkill < 2 then
		fastHeadcrabTree3:SetImage("vgui/hud/icon_locked")
		fastHeadcrabTree3:SetToolTip("'UNKNOWN GENE'")
	else
		fastHeadcrabTree3:SetImage(recoveryIcon)
		fastHeadcrabTree3:SetToolTip(recoveryDesc .. "5")
	end
	fastHeadcrabTree3.DoClick = function()
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
			fastHeadcrabTree4:SetImage(enduranceIcon)
			fastHeadcrabTree4:SetToolTip(enduranceDesc .. "5")
		end
	end
	
	fastHeadcrabTree4 = vgui.Create("DImageButton", petEvolPanel)
	fastHeadcrabTree4:SetPos(250, 200)
	fastHeadcrabTree4:SetSize(50, 50)
	if curSkill < 3 then
		fastHeadcrabTree4:SetImage("vgui/hud/icon_locked")
		fastHeadcrabTree4:SetToolTip("'UNKNOWN GENE'")
	else
		fastHeadcrabTree4:SetImage(enduranceIcon)
		fastHeadcrabTree4:SetToolTip(enduranceDesc .. "5")
	end
	fastHeadcrabTree4.DoClick = function()
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
				net.WriteInt(4, 16)
			net.SendToServer()
			surface.PlaySound("beams/beamstart5.wav")
			fastHeadcrabTree5:SetImage(strengthIcon)
			fastHeadcrabTree5:SetToolTip(strengthDesc .. "1")
		end
	end
	
	fastHeadcrabTree5 = vgui.Create("DImageButton", petEvolPanel)
	fastHeadcrabTree5:SetPos(350, 200)
	fastHeadcrabTree5:SetSize(50, 50)
	if curSkill < 4 then
		fastHeadcrabTree5:SetImage("vgui/hud/icon_locked")
		fastHeadcrabTree5:SetToolTip("'UNKNOWN GENE'")
	else
		fastHeadcrabTree5:SetImage(strengthIcon)
		fastHeadcrabTree5:SetToolTip(strengthDesc .. "1")
	end
	fastHeadcrabTree5.DoClick = function()
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
			fastHeadcrabTree6:SetImage(strengthIcon)
			fastHeadcrabTree6:SetToolTip(strengthDesc .. "1")
		end
	end
	
	fastHeadcrabTree6 = vgui.Create("DImageButton", petEvolPanel)
	fastHeadcrabTree6:SetPos(450, 200)
	fastHeadcrabTree6:SetSize(50, 50)
	if curSkill < 5 then
		fastHeadcrabTree6:SetImage("vgui/hud/icon_locked")
		fastHeadcrabTree6:SetToolTip("'UNKNOWN GENE'")
	else
		fastHeadcrabTree6:SetImage(strengthIcon)
		fastHeadcrabTree6:SetToolTip(strengthDesc .. "1")
	end
	fastHeadcrabTree6.DoClick = function()
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
			fastHeadcrabTree7:SetImage(strengthIcon)
			fastHeadcrabTree7:SetToolTip(strengthDesc .. "2")
		end
	end
	
	fastHeadcrabTree7 = vgui.Create("DImageButton", petEvolPanel)
	fastHeadcrabTree7:SetPos(450, 300)
	fastHeadcrabTree7:SetSize(50, 50)
	if curSkill < 6 then
		fastHeadcrabTree7:SetImage("vgui/hud/icon_locked")
		fastHeadcrabTree7:SetToolTip("'UNKNOWN GENE'")
	else
		fastHeadcrabTree7:SetImage(strengthIcon)
		fastHeadcrabTree7:SetToolTip(strengthDesc .. "2")
	end
	fastHeadcrabTree7.DoClick = function()
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
			fastHeadcrabTree8:SetImage(geneticIcon)
			fastHeadcrabTree8:SetToolTip(geneticDesc)
		end
	end
	
	fastHeadcrabTree8 = vgui.Create("DImageButton", petEvolPanel)
	fastHeadcrabTree8:SetPos(450, 400)
	fastHeadcrabTree8:SetSize(50, 50)
	if curSkill < 7 then
		fastHeadcrabTree8:SetImage("vgui/hud/icon_locked")
		fastHeadcrabTree8:SetToolTip("'UNKNOWN GENE'")
	else
		fastHeadcrabTree8:SetImage(geneticIcon)
		fastHeadcrabTree8:SetToolTip(geneticDesc)
	end
	fastHeadcrabTree8.DoClick = function()
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
		end
	end
end