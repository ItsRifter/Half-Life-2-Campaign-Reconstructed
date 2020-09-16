surface.CreateFont("Pet_Congrat_Title_Font", {
	font = "Arial",
	size = 48,
})

surface.CreateFont("Pet_Congrat_Desc_Font", {
	font = "Arial",
	size = 32,
})

surface.CreateFont("Pet_Desc_Font", {
	font = "Arial",
	size = 38,
})

surface.CreateFont("Pet_Evol_Font", {
	font = "Arial",
	size = 32,
})

function petDuelMenu()
	
	local target = ""
	local currentCoins = tonumber(LocalPlayer():GetNWInt("Coins"))
	
	petDuelFrame = vgui.Create("DFrame")
	petDuelFrame:SetSize(750, 550)
	petDuelFrame:Center()
	petDuelFrame:MakePopup()
	
	local petPlayerListBox = vgui.Create("DComboBox", petDuelFrame)
	petPlayerListBox:SetPos(75, 75)
	petPlayerListBox:SetSize(100, 20)
	petPlayerListBox:SetValue("Select Target")
	
	petPlayerListBox.OnSelect = function(_, _, value)
		target = value
	end
	
	for k,v in pairs(player.GetAll()) do
		if v ~= LocalPlayer() then
			petPlayerListBox:AddChoice(v:Name())
		end
	end
	
	playerCoinAmountSlider = vgui.Create("DNumSlider", petDuelFrame)
	playerCoinAmountSlider:SetPos(100, 100)
	playerCoinAmountSlider:SetSize(300, 50)
	playerCoinAmountSlider:SetText("Set Bet")
	playerCoinAmountSlider:SizeToContents()
	playerCoinAmountSlider:SetMin(0)
	playerCoinAmountSlider:SetMax(currentCoins)
	playerCoinAmountSlider:SetDecimals(0)
	
	sendBattleButton = vgui.Create("DButton", petDuelFrame)
	sendBattleButton:SetText("Send Battle")
	sendBattleButton:SetSize(150, 75)
	sendBattleButton:SetPos(300, 400)
	sendBattleButton.DoClick = function()
		if not timer.Exists("CooldownDuel") then
			timer.Create("CooldownDuel", 10, 1, function()
				timer.Remove("CooldownDuel")
			end)
			
			local betAmt = playerCoinAmountSlider:GetValue()
			
			if target == "" then
				LocalPlayer():ChatPrint("You need to select a target to challenge!")
			end
			
			net.Start("PetChallenge")
				net.WriteString(target)
				net.WriteInt(betAmt, 32)
			net.SendToServer()
			
		else
			LocalPlayer():ChatPrint("Please wait " .. math.Round(timer.TimeLeft("CooldownDuel")) .. " seconds before challenging another opponent")
		end
	end
end

net.Receive("PetDuel", function()
	petDuelMenu()
end)

--Not really used, just reminders for what is what
PET_NORMAL_ZOMBIE_EVOL_ICON = {
	[0] = "entities/npc_headcrab.png",
	[1] = "entities/npc_zombie_torso.png",
	[2] = "entities/npc_zombie.png",
}
PET_FAST_ZOMBIE_EVOL_ICON = {
	[3] = "entities/npc_headcrab_fast.png",
	[4] = "entities/npc_fastzombie_torso.png",
	[5] = "entities/npc_fastzombie.png",
}
PET_NORMAL_ZOMBIE_EVOL_MODEL = {
	[0] = "models/headcrabclassic.mdl",
	[1] = "models/zombie/Classic_torso.mdl",
	[2] = "models/zombie/Classic.mdl",
	[3] = "models/headcrab.mdl",
	[4] = "models/gibs/fast_zombie_torso.mdl",
	[5] = "models/zombie/fast.mdl",
}

function PetMenu(curSkill, skillPoints, petStage)

	local strengthIcon = "vgui/achievements/hl2_get_crowbar.png"
	local strengthDesc = "Strength\nIncrease Strength by "
	
	local enduranceIcon = "vgui/achievements/hl2_beat_cemetery.png"
	local enduranceDesc = "Endurance:\nIncrease Max HP by "
	
	local recoveryIcon = "vgui/achievements/hlx_kill_elitesoldier_withhisenergyball.png"
	local recoveryDesc = "Recovery:\nIncrease recovery by "
	
	local geneticIcon = "vgui/achievements/hl2_beat_game.png"
	local geneticDesc = "Genetic Mutation:\nAllow your pet to become something stronger"
	
	COLOUR_PET_MODEL_PANEL = Color(100, 100, 100)
	COLOUR_PET_MAIN_PANEL = Color(100, 100, 100)
	COLOUR_PET_EVOL_PANEL = Color(0, 0, 0)
	local music = CreateSound(LocalPlayer(), "HL1/ambience/alien_powernode.wav")
	music:Play()
	local petFrame = vgui.Create("DFrame")
	petFrame:SetSize(900, 700)
	petFrame:Center()
	petFrame:MakePopup()
	petFrame.OnClose = function()
		music:Stop()
	end

	local petSheet = vgui.Create( "DPropertySheet", petFrame )
	petSheet:Dock(FILL)
	
	local defaultColour = Color(255, 255, 255)
	
	local petEvolPanel = vgui.Create("DPanel", petFrame)
	
	local petSkillPointsLabel = vgui.Create("DLabel", petEvolPanel) 
	petSkillPointsLabel:SetPos(25, 50)
	petSkillPointsLabel:SetFont("Pet_Evol_Font")
	petSkillPointsLabel:SetText("Skill Points: " .. skillPoints)
	petSkillPointsLabel:SizeToContents()
	
	petEvolPanel.Paint = function( self, w, h ) 
		draw.RoundedBox( 4, 0, 0, w, h, COLOUR_PET_EVOL_PANEL)
	end
	local petEvolModel = vgui.Create("DModelPanel", petEvolPanel)
	petEvolModel:SetModel(PET_NORMAL_ZOMBIE_EVOL_MODEL[petStage])
	
	petEvolModel:SetPos(450, 25)
	petEvolModel:SetSize(550, 550)
	petEvolModel:SetColor(defaultColour)
	
	if petStage == 0 then
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
				curSkill = 1
				net.Start("UpdateSkills")
				net.SendToServer()
				surface.PlaySound("beams/beamstart5.wav")
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
				curSkill = 2
				net.Start("UpdateSkills")
				net.SendToServer()
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local headcrabTree3 = vgui.Create("DImageButton", petEvolPanel)
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
				curSkill = 3
				net.Start("UpdateSkills")
				net.SendToServer()
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local headcrabTree4 = vgui.Create("DImageButton", petEvolPanel)
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
				curSkill = 4
				net.Start("UpdateSkills")
				net.SendToServer()
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
	
		local headcrabTree5 = vgui.Create("DImageButton", petEvolPanel)
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
				curSkill = 5
				net.Start("UpdateSkills")
				net.SendToServer()
				surface.PlaySound("beams/beamstart5.wav")
			end
		end

	elseif petStage == 1 then
	
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
				curSkill = 1
				net.Start("UpdateSkills")
				net.SendToServer()
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local torsozombTree2 = vgui.Create("DImageButton", petEvolPanel)
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
				curSkill = 2
				net.Start("UpdateSkills")
				net.SendToServer()
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		local torsozombTree3 = vgui.Create("DImageButton", petEvolPanel)
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
				curSkill = 3
				surface.PlaySound("beams/beamstart5.wav")
				net.Start("UpdateSkills")
				net.SendToServer()
			end
		end
		local torsozombTree4 = vgui.Create("DImageButton", petEvolPanel)
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
				curSkill = 4
				surface.PlaySound("beams/beamstart5.wav")
				net.Start("UpdateSkills")
					net.WriteInt(4, 16)
				net.SendToServer()
			end
		end
		local torsozombTree5 = vgui.Create("DImageButton", petEvolPanel)
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
				curSkill = 5
				surface.PlaySound("beams/beamstart5.wav")
				net.Start("UpdateSkills")
				net.SendToServer()
			end
		end
		
		local torsozombTree6 = vgui.Create("DImageButton", petEvolPanel)
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
				curSkill = 6
				surface.PlaySound("beams/beamstart5.wav")
				net.Start("UpdateSkills")
				net.SendToServer()
			end
		end
		
		local torsozombTree7 = vgui.Create("DImageButton", petEvolPanel)
		torsozombTree7:SetPos(250, 100)
		torsozombTree7:SetSize(50, 50)
		if curSkill < 6 then
			torsozombTree7:SetImage("vgui/hud/icon_locked")
			torsozombTree7:SetToolTip("'UNKNOWN GENE'")
		else
			torsozombTree7:SetImage(geneticIcon)
			torsozombTree7:SetToolTip("Genetic Mutation:\nAllow your pet to become something stronger")
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
				curSkill = 7
				net.Start("UpdateSkills")
				net.SendToServer()
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
	elseif petStage == 2 then
	
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
				curSkill = 1
				net.Start("UpdateSkills")
				net.SendToServer()
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local zombTree2 = vgui.Create("DImageButton", petEvolPanel)
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
				curSkill = 2
				net.Start("UpdateSkills")
				net.SendToServer()
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local zombTree3 = vgui.Create("DImageButton", petEvolPanel)
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
				curSkill = 3
				net.Start("UpdateSkills")
				net.SendToServer()
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local zombTree4 = vgui.Create("DImageButton", petEvolPanel)
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
				curSkill = 4
				net.Start("UpdateSkills")
					net.WriteInt(4, 16)
				net.SendToServer()
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local zombTree5 = vgui.Create("DImageButton", petEvolPanel)
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
				curSkill = 5
				net.Start("UpdateSkills")
				net.SendToServer()
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local zombTree6 = vgui.Create("DImageButton", petEvolPanel)
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
	elseif petStage == 3 then
	
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
				net.Start("UpdateSkills")
				net.SendToServer()
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local fastHeadcrabTree2 = vgui.Create("DImageButton", petEvolPanel)
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
				curSkill = 2
				net.Start("UpdateSkills")
				net.SendToServer()
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local fastHeadcrabTree3 = vgui.Create("DImageButton", petEvolPanel)
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
				curSkill = 3
				net.Start("UpdateSkills")
				net.SendToServer()
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local fastHeadcrabTree4 = vgui.Create("DImageButton", petEvolPanel)
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
				curSkill = 4
				net.Start("UpdateSkills")
					net.WriteInt(4, 16)
				net.SendToServer()
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local fastHeadcrabTree5 = vgui.Create("DImageButton", petEvolPanel)
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
				curSkill = 5
				net.Start("UpdateSkills")
				net.SendToServer()
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local fastHeadcrabTree6 = vgui.Create("DImageButton", petEvolPanel)
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
				curSkill = 6
				net.Start("UpdateSkills")
				net.SendToServer()
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local fastHeadcrabTree7 = vgui.Create("DImageButton", petEvolPanel)
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
				curSkill = 7
				net.Start("UpdateSkills")
				net.SendToServer()
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local fastHeadcrabTree8 = vgui.Create("DImageButton", petEvolPanel)
		fastHeadcrabTree8:SetPos(450, 400)
		fastHeadcrabTree8:SetSize(50, 50)
		if curSkill < 7 then
			fastHeadcrabTree8:SetImage("vgui/hud/icon_locked")
			fastHeadcrabTree8:SetToolTip("'UNKNOWN GENE'")
		else
			fastHeadcrabTree8:SetImage(geneticIcon)
			fastHeadcrabTree8:SetToolTip("Genetic Mutation:\nAllow your pet to become something stronger")
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
				curSkill = 8
				net.Start("UpdateSkills")
				net.SendToServer()
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
	elseif petStage == 4 then
	
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
				curSkill = 1
				net.Start("UpdateSkills")
				net.SendToServer()
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local fastTorsoTree2 = vgui.Create("DImageButton", petEvolPanel)
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
				curSkill = 2
				net.Start("UpdateSkills")
				net.SendToServer()
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local fastTorsoTree3 = vgui.Create("DImageButton", petEvolPanel)
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
				curSkill = 3
				net.Start("UpdateSkills")
				net.SendToServer()
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local fastTorsoTree4 = vgui.Create("DImageButton", petEvolPanel)
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
				curSkill = 4
				net.Start("UpdateSkills")
				net.SendToServer()
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local fastTorsoTree5 = vgui.Create("DImageButton", petEvolPanel)
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
				curSkill = 5
				net.Start("UpdateSkills")
				net.SendToServer()
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local fastTorsoTree6 = vgui.Create("DImageButton", petEvolPanel)
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
				curSkill = 6
				net.Start("UpdateSkills")
				net.SendToServer()
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local fastTorsoTree7 = vgui.Create("DImageButton", petEvolPanel)
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
				curSkill = 7
				net.Start("UpdateSkills")
				net.SendToServer()
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local fastTorsoTree8 = vgui.Create("DImageButton", petEvolPanel)
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
				curSkill = 8
				net.Start("UpdateSkills")
				net.SendToServer()
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local fastTorsoTree9 = vgui.Create("DImageButton", petEvolPanel)
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
				curSkill = 9
				net.Start("UpdateSkills")
				net.SendToServer()
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		local fastTorsoTree10 = vgui.Create("DImageButton", petEvolPanel)
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
				curSkill = 10
				net.Start("UpdateSkills")
				net.SendToServer()
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
	elseif petStage == 5 then
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
				curSkill = 1
				net.Start("UpdateSkills")
				net.SendToServer()
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local fastZombTree2 = vgui.Create("DImageButton", petEvolPanel)
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
				curSkill = 2
				net.Start("UpdateSkills")
				net.SendToServer()
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local fastZombTree3 = vgui.Create("DImageButton", petEvolPanel)
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
				curSkill = 3
				net.Start("UpdateSkills")
				net.SendToServer()
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local fastZombTree4 = vgui.Create("DImageButton", petEvolPanel)
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
				curSkill = 4
				net.Start("UpdateSkills")
				net.SendToServer()
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local fastZombTree5 = vgui.Create("DImageButton", petEvolPanel)
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
				curSkill = 5
				net.Start("UpdateSkills")
				net.SendToServer()
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local fastZombTree6 = vgui.Create("DImageButton", petEvolPanel)
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
				curSkill = 6
				net.Start("UpdateSkills")
				net.SendToServer()
				surface.PlaySound("beams/beamstart5.wav")
			end
		end

		local fastZombTree7 = vgui.Create("DImageButton", petEvolPanel)
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
				curSkill = 7
				net.Start("UpdateSkills")
				net.SendToServer()
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local fastZombTree8 = vgui.Create("DImageButton", petEvolPanel)
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
				curSkill = 8
				net.Start("UpdateSkills")
				net.SendToServer()
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local fastZombTree9 = vgui.Create("DImageButton", petEvolPanel)
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
				curSkill = 9
				net.Start("UpdateSkills")
				net.SendToServer()
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local fastZombTree10 = vgui.Create("DImageButton", petEvolPanel)
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
				curSkill = 10
				net.Start("UpdateSkills")
				net.SendToServer()
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local fastZombTree11 = vgui.Create("DImageButton", petEvolPanel)
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
		local petEvolButton = vgui.Create("DButton", petEvolPanel)
		petEvolButton:SetPos(650, 75)
		petEvolButton:SetText("GENETIC MUTATE")
		petEvolButton:SetSize(100, 50)
		petEvolButton.DoClick = function()
		if petStage == 0 then
			if curSkill >= 5 then
				clientClosePets()
				net.Start("Evolving")
				net.SendToServer()
				timer.Simple(5, function()
					LocalPlayer():ChatPrint("Your pet has evolved, Congratulations!")
				end)
			else
				LocalPlayer():ChatPrint("Your pet isn't ready to evolve")
			end
		elseif petStage == 1 then
			if curSkill >= 7 then
				petStatFrame:Close()
				net.Start("Evolving")
				net.SendToServer()
				timer.Simple(5, function()
					LocalPlayer():ChatPrint("Your pet has evolved, Congratulations!")
				end)
			else
				LocalPlayer():ChatPrint("Your pet isn't ready to evolve")
			end
		elseif petStage == 2 then
			if curSkill >= 6 then
				LocalPlayer():ChatPrint("Your pet cannot evolve any further")
			end
		elseif petStage == 3 then
			if curSkill >= 8 then
				petStatFrame:Close()
				net.Start("Evolving")
				net.SendToServer()
				timer.Simple(5, function()
					LocalPlayer():ChatPrint("Your pet has evolved, Congratulations!")
				end)
			else
				LocalPlayer():ChatPrint("Your pet isn't ready to evolve")
			end
		elseif petStage == 4 then
			if curSkill >= 10 then
				petStatFrame:Close()
				net.Start("Evolving")
				net.SendToServer()
				timer.Simple(5, function()
					LocalPlayer():ChatPrint("Your pet has evolved, Congratulations!")
				end)
			else
				LocalPlayer():ChatPrint("Your pet isn't ready to evolve")
			end
		elseif petStage == 5 then
			if curSkill >= 11 then
				LocalPlayer():ChatPrint("Your pet cannot evolve any further")
			end
		end
	end
	petSheet:AddSheet("Evolution Tree", petEvolPanel, nil)
	
	local petSwitchPanel = vgui.Create("DPanel", petFrame)
	
	petSwitchPanel.Paint = function( self, w, h ) 
		draw.RoundedBox( 4, 0, 0, w, h, COLOUR_PET_MAIN_PANEL)
	end
	
	local selectPetLabel = vgui.Create("DLabel", petSwitchPanel)
	selectPetLabel:SetPos(250, 75)
	selectPetLabel:SetFont("Pets_Stats")
	
	local selectImage = vgui.Create("DImage", petSwitchPanel)
	selectImage:SetSize(250, 250)
	selectImage:SetPos(300, 175)
	if curSkill == 6 and petStage == 2 then
		selectImage:SetImage(PET_FAST_ZOMBIE_EVOL_ICON[3])
		selectPetLabel:SetText("Fast Pet")
		selectPetLabel:SetPos(375, 75)
	else
		selectImage:SetImage("vgui/hud/icon_locked")
		selectPetLabel:SetText("There is currently no pet for adoption")
	end
	
	selectPetLabel:SizeToContents()
	
	local selectPetButton = vgui.Create("DButton", petSwitchPanel)
	selectPetButton:SetPos(petFrame:GetWide() / 2.5, 500)
	selectPetButton:SetSize(135, 75)
	selectPetButton:SetText("Adopt New Pet")
	
	selectPetButton.DoClick = function()
		if curSkill == 6 and petStage == 2 then
			net.Start("NewPet")
				net.WriteString("hl2cr_fastzombie_pet")
			net.SendToServer()
			if petStatFrame:IsValid() then
				petStatFrame:MoveTo(-400, ScrH() / 2 - 200, 1, 0, -1, function()
					petStatFrame:Close()
				end)
			end
		else
			LocalPlayer():ChatPrint("There isn't a pet to adopt")
			surface.PlaySound("buttons/button8.wav")
		end
	end
	
	petSheet:AddSheet("Pet Adoption Centre", petSwitchPanel, nil)
	
	
end
net.Receive("Open_Pet_Menu", function(len, ply)
	local skills = net.ReadInt(16)
	local points = net.ReadInt(16)
	local stage = net.ReadInt(16)
	PetMenu(skills, points, stage)
end)

function petStats(entPet)
	local hp = entPet:Health()
	--local maxHp = pet:GetMaxHealth()
	
	petStatFrame = vgui.Create("DFrame")
	if ScrW() == 3840 and ScrH() == 2160 then
		petStatFrame:SetSize(400, 250)
	else
		petStatFrame:SetSize(400, 225)
	end
	
	petStatFrame:SetPos(-400, ScrH() / 2 - 200)
	petStatFrame:SetDraggable(false)
	petStatFrame:ShowCloseButton(false)
	petStatFrame:SetTitle("")
	petStatFrame.Paint = function()
		draw.RoundedBox( 8, 0, 0, 0, 0, Color( 0, 0, 0, 150 ) )
	end
		
	petStatPanel = vgui.Create("DPanel", petStatFrame)
	petStatPanel:SetSize(400, 250)
	petStatPanel:SetBackgroundColor(Color(0, 0, 0, 175))
	
	
	petStatLevelLabel = vgui.Create("DLabel", petStatPanel)
	petStatLevelLabel:SetPos(150, 25)
	petStatLevelLabel:SetFont("Pets_Stats")
	petStatLevelLabel:SetText("Level " .. LocalPlayer():GetNWInt("PetLevel"))
	petStatLevelLabel:SizeToContents()
			
	petStatHPLabel = vgui.Create("DLabel", petStatPanel)
	petStatHPLabel:SetPos(25, 75)
	petStatHPLabel:SetFont("Pets_Stats")
	petStatHPLabel:SetText("HP")

	petStatHealthBar = vgui.Create("DPanel", petStatPanel)
	petStatHealthBar:SetPos( 25, 100 )
	petStatHealthBar:SetSize( 350, 25 )
	petStatHealthBar.Paint = function(self, w, h)
		if hp >= 75 then
			surface.SetDrawColor(0, 255, 0, 255)
			surface.DrawRect(0, 0, hp, h)
		elseif hp <= 75 and hp >= 25 then
			surface.SetDrawColor(255, 255, 0, 255)
			surface.DrawRect(0, 0, hp, h)
		elseif hp <= 25 then
			surface.SetDrawColor(255, 0, 0, 255)
			surface.DrawRect(0, 0, hp, h)
		end
	end
	
	petStatXPLabel = vgui.Create("DLabel", petStatPanel)
	petStatXPLabel:SetPos(25, 150)
	petStatXPLabel:SetFont("Pets_Stats")
	petStatXPLabel:SetText("XP")
	
	petStatXPBar = vgui.Create("DPanel", petStatPanel)
	petStatXPBar:SetPos( 25, 175 )
	petStatXPBar:SetSize( 350, 25 )
	petStatXPBar.Paint = function(self, w, h)
		surface.SetDrawColor(70, 70, 70 , 255)
		surface.DrawRect(0,0, LocalPlayer():GetNWInt("PetMaxXP"), h)
		
		surface.SetDrawColor(50, 165, 255, 255)
		surface.DrawRect(0,0, LocalPlayer():GetNWInt("PetXP"), h)
	end
	
	petStatXPStatusLabel = vgui.Create("DLabel", petStatPanel)
	petStatXPStatusLabel:SetPos(petStatXPBar:GetWide() - 315, petStatXPBar:GetTall() + 150)
	petStatXPStatusLabel:SetFont("Pets_Stats")
	petStatXPStatusLabel:SetText(LocalPlayer():GetNWInt("PetXP") .. "/" .. LocalPlayer():GetNWInt("PetMaxXP"))
	petStatXPStatusLabel:SizeToContents()
	
	petStatFrame:Add(petStatPanel)
	
	petStatFrame:MoveTo(0, ScrH() / 2 - 200 , 1, 0, -1)
	petStatPanel.Think = function()
		if entPet:IsValid() then
			petStatLevelLabel:SetText("Level: " .. LocalPlayer():GetNWInt("PetLevel"))
			petStatLevelLabel:SizeToContents()
			
			petStatXPBar.Paint = function(self, w, h)
				--Empty XP
				surface.SetDrawColor(70, 70, 70 , 255)
				surface.DrawRect(0, 0, LocalPlayer():GetNWInt("PetMaxXP"), h)
				
				--Filled XP
				surface.SetDrawColor(50, 165, 255, 255)
				surface.DrawRect(0, 0, LocalPlayer():GetNWInt("PetXP"), h)
			end
			
			petStatXPStatusLabel:SetText(LocalPlayer():GetNWInt("PetXP") .. "/" .. LocalPlayer():GetNWInt("PetMaxXP"))
			petStatXPStatusLabel:SizeToContents()

			petStatHealthBar.Paint = function(self, w, h)
				if entPet:Health() >= 75 then
					surface.SetDrawColor(0, 255, 0, 255)
					surface.DrawRect(0, 0, entPet:Health(), h)
				elseif entPet:Health() <= 75 and entPet:Health() >= 25 then
					surface.SetDrawColor(255, 255, 0, 255)
					surface.DrawRect(0, 0, entPet:Health(), h)
				elseif entPet:Health() <= 25 then
					surface.SetDrawColor(255, 0, 0, 255)
					surface.DrawRect(0, 0, entPet:Health(), h)
				end
			end
		else
			petStatHealthBar.Paint = function(self, w, h)
			end
			petStatXPBar.Paint = function(self, w, h)
			end
			
		end
	end
	
	terminatedLabel = vgui.Create("DLabel", petStatPanel)
	terminatedLabel:SetText("")
	terminatedLabel:SetPos(65, 85)
	terminatedLabel:SetFont("Pets_Stats_Dead")
	terminatedLabel:SetColor(Color(255, 0, 0))
	terminatedLabel:SizeToContents()
	
	petStatFrame:Add(terminatedLabel)
end

function clientClosePets()	
	petStatFrame:MoveTo(-400, ScrH() / 2 - 200, 1, 0, -1, function()
		petStatFrame:Close()
	end)
end

net.Receive("ClosePets", function()
	petStatFrame:MoveTo(-400, ScrH() / 2 - 200, 1, 0, -1, function()
		petStatFrame:Close()
	end)
end)

net.Receive("PetDead", function()
	terminatedLabel = vgui.Create("DLabel", petStatFrame)
	terminatedLabel:SetText("TERMINATED")
	terminatedLabel:SetPos(65, 85)
	terminatedLabel:SetFont("Pets_Stats_Dead")
	terminatedLabel:SetColor(Color(255, 0, 0))
	terminatedLabel:SizeToContents()
	
	petStatFrame:Add(terminatedLabel)
	petStatFrame:MoveTo(-400, ScrH() / 2 - 200, 1, 0, -1, function()
		petStatFrame:Close()
		petStatFrame:SetVisible(false)
	end)
end)

net.Receive("PetKilled", function()
	petStatFrame:SetVisible(false)
	petStatPanel:Close()
end)

net.Receive("PetPanic", function()
	petStatFrame:ShowCloseButton(true)
	for k, v in pairs(petStatFrame) do
		v:Close()
	end
end)

surface.CreateFont("Pets_Stats", {
	font = "Arial",
	size = 26,
})

surface.CreateFont("Pets_Stats_Dead", {
	font = "Arial",
	size = 48,
})

net.Receive("OpenPetStats", function(len, ply)
	local pet = net.ReadEntity()
	petStats(pet)
end)
