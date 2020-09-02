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

local isOpenPets = false

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
			timer.Create("CooldownDuel", 10, 0, function()
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
	
	local petMenuPanel = vgui.Create("DPanel", petFrame)
	petMenuPanel:SetText("Menu")
	petMenuPanel.Paint = function( self, w, h ) 
		draw.RoundedBox( 4, 0, 0, w, h, COLOUR_PET_MODEL_PANEL ) 
	end
	local petTitleLabel = vgui.Create("DLabel", petMenuPanel)
	petTitleLabel:SetText("Current Pet")
	petTitleLabel:SetPos(345, 305)
	petTitleLabel:SetFont("Pet_Desc_Font")
	petTitleLabel:SizeToContents()
	
	local petIcon = vgui.Create("DImage", petMenuPanel)
	petIcon:SetImage(PET_NORMAL_ZOMBIE_EVOL_ICON[petStage])

	petIcon:SetPos(335, 350)
	petIcon:SetSize(200, 200)
	
	petSheet:AddSheet("Select Pet", petMenuPanel, nil)
	local defaultColour = Color(255, 255, 255)
	
	local petEvolPanel = vgui.Create("DPanel", petFrame)
	
	local petSkillPointsLabel = vgui.Create("DLabel", petEvolPanel) 
	petSkillPointsLabel:SetPos(25, 50)
	petSkillPointsLabel:SetFont("Pet_Evol_Font")
	petSkillPointsLabel:SetText("Skill Points: " .. skillPoints)
	petSkillPointsLabel:SizeToContents()
	
	petEvolPanel.Paint = function( self, w, h ) 
		draw.RoundedBox( 4, 0, 0, w, h, COLOUR_PET_EVOL_PANEL)
	
	--Optional paths for skill trees
	local optionalPath1 = false
	local optionalPath2 = false
	local optionalPath3 = false
	local optionalPath4 = false
	local optionalPath5 = false
	local optionalPath6 = false
	
		--Normal headcrab
		if petStage == 0 then
			if curSkill >= 1 then
				surface.SetDrawColor(0, 255, 0)
				surface.DrawLine(275, 500, 275, 450)
			else
				surface.SetDrawColor(255, 0, 0)
				surface.DrawLine(275, 500, 275, 450)
			end
			
			if curSkill >= 2 then
				surface.SetDrawColor(0, 255, 0)
				surface.DrawLine(275, 450, 275, 325)
			else
				surface.SetDrawColor(255, 0, 0)
				surface.DrawLine(275, 450, 275, 325)
			end
			
			if curSkill >= 3 then
				surface.SetDrawColor(0, 255, 0)
				surface.DrawLine(275, 350, 275, 225)
			else
				surface.SetDrawColor(255, 0, 0)
				surface.DrawLine(275, 350, 275, 225)
			end
			
			if curSkill >= 4 then
				surface.SetDrawColor(0, 255, 0)
				surface.DrawLine(275, 225, 275, 100)
			else
				surface.SetDrawColor(255, 0, 0)
				surface.DrawLine(275, 225, 275, 100)
			end
		
		--Zomb Torso
		elseif petStage == 1 then
			
			if curSkill >= 1 then
				surface.SetDrawColor(0, 255, 0)
				surface.DrawLine(275, 425, 275, 500)
			else
				surface.SetDrawColor(255, 0, 0)
				surface.DrawLine(275, 425, 275, 500)
			end
			
			if curSkill >= 2 then
				surface.SetDrawColor(0, 255, 0)
				surface.DrawLine(275, 425, 375, 425)
			else
				surface.SetDrawColor(255, 0, 0)
				surface.DrawLine(275, 425, 375, 425)
			end
			
			if curSkill >= 3 then
				surface.SetDrawColor(0, 255, 0)
				surface.DrawLine(375, 425, 375, 325)
			else
				surface.SetDrawColor(255, 0, 0)
				surface.DrawLine(375, 425, 375, 325)
			end
			
			if curSkill >= 4 then
				surface.SetDrawColor(0, 255, 0)
				surface.DrawLine(375, 325, 375, 225)
			else
				surface.SetDrawColor(255, 0, 0)
				surface.DrawLine(375, 325, 375, 225)
			end
			
			if curSkill >= 5 then
				surface.SetDrawColor(0, 255, 0)
				surface.DrawLine(375, 225, 275, 225)
			else
				surface.SetDrawColor(255, 0, 0)
				surface.DrawLine(375, 225, 275, 225)
			end
			
			if curSkill >= 6 then
				surface.SetDrawColor(0, 255, 0)
				surface.DrawLine(275, 225, 275, 125)
			else
				surface.SetDrawColor(255, 0, 0)
				surface.DrawLine(275, 225, 275, 125)
			end

		--Full bodied zombie
		elseif petStage == 2 then
			
			if curSkill >= 1 then
				
				surface.SetDrawColor(0, 255, 0)
				surface.DrawLine(275, 525, 375, 425)
			else
				
				surface.SetDrawColor(255, 0, 0)
				surface.DrawLine(275, 525, 375, 425)
			end
			
			if curSkill >= 2 then
				surface.SetDrawColor(0, 255, 0)
				surface.DrawLine(375, 450, 175, 325)
			else
				surface.SetDrawColor(255, 0, 0)
				surface.DrawLine(375, 450, 175, 325)
			end
			
			if curSkill >= 3 then
				surface.SetDrawColor(0, 255, 0)
				surface.DrawLine(175, 350, 375, 225)
			else
				surface.SetDrawColor(255, 0, 0)
				surface.DrawLine(175, 350, 375, 225)
			end
			
			if curSkill >= 4 then
				surface.SetDrawColor(0, 255, 0)
				surface.DrawLine(375, 250, 175, 125)
			else
				surface.SetDrawColor(255, 0, 0)
				surface.DrawLine(375, 250, 175, 125)
			end
			
			if curSkill >= 5 then
				surface.SetDrawColor(0, 255, 0)
				surface.DrawLine(175, 150, 275, 75)
			else
				surface.SetDrawColor(255, 0, 0)
				surface.DrawLine(175, 150, 275, 75)
			end
		
		end
	end
	local petEvolModel = vgui.Create("DModelPanel", petEvolPanel)
	petEvolModel:SetModel(PET_NORMAL_ZOMBIE_EVOL_MODEL[petStage])
	
	petEvolModel:SetPos(450, 25)
	petEvolModel:SetSize(550, 550)
	petEvolModel:SetColor(defaultColour)
	
	if petStage == 0 then
		local headcrabTree1 = vgui.Create("DImageButton", petEvolPanel)
		headcrabTree1:SetImage("vgui/achievements/hl2_beat_cemetery.png")
		headcrabTree1:SetPos(250, 500)
		headcrabTree1:SetSize(50, 50)
		headcrabTree1:SetToolTip("Endurance:\nIncrease Max HP by 5")
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
					net.WriteInt(1, 16)
				net.SendToServer()
				skillPoints = skillPoints - 1
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local headcrabTree2 = vgui.Create("DImageButton", petEvolPanel)
		headcrabTree2:SetImage("vgui/achievements/hl2_beat_cemetery.png")
		headcrabTree2:SetPos(250, 400)
		headcrabTree2:SetSize(50, 50)
		headcrabTree2:SetToolTip("Endurance:\nIncrease Max HP by 5")
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
					net.WriteInt(2, 16)
				net.SendToServer()
				skillPoints = skillPoints - 1
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local headcrabTree3 = vgui.Create("DImageButton", petEvolPanel)
		headcrabTree3:SetImage("vgui/achievements/hl2_get_crowbar.png")
		headcrabTree3:SetPos(250, 300)
		headcrabTree3:SetSize(50, 50)
		headcrabTree3:SetToolTip("Strength:\nIncrease damage by 1")
		headcrabTree3.DoClick = function()
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
					net.WriteInt(3, 16)
				net.SendToServer()
				skillPoints = skillPoints - 1
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local headcrabTree4 = vgui.Create("DImageButton", petEvolPanel)
		headcrabTree4:SetImage("vgui/achievements/hl2_get_crowbar.png")
		headcrabTree4:SetPos(250, 200)
		headcrabTree4:SetSize(50, 50)
		headcrabTree4:SetToolTip("Strength:\nIncrease damage by 1")
		headcrabTree4.DoClick = function()
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
				skillPoints = skillPoints - 1
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
	
		local headcrabTree5 = vgui.Create("DImageButton", petEvolPanel)
		headcrabTree5:SetImage("vgui/achievements/hl2_beat_game.png")
		headcrabTree5:SetPos(250, 100)
		headcrabTree5:SetSize(50, 50)
		headcrabTree5:SetToolTip("Genetic Mutation:\nAllow your pet to become something stronger")
		headcrabTree5.DoClick = function()
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
					net.WriteInt(5, 16)
				net.SendToServer()
				skillPoints = skillPoints - 1
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
	elseif petStage == 1 then
		local torsozombTree1 = vgui.Create("DImageButton", petEvolPanel)
		torsozombTree1:SetImage("vgui/achievements/hl2_beat_cemetery.png")
		torsozombTree1:SetPos(250, 500)
		torsozombTree1:SetSize(50, 50)
		torsozombTree1:SetToolTip("Endurance:\nIncrease Max HP by 10")
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
					net.WriteInt(1, 16)
				net.SendToServer()
				skillPoints = skillPoints - 1
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		local torsozombTree2 = vgui.Create("DImageButton", petEvolPanel)
		torsozombTree2:SetImage("vgui/achievements/hlx_kill_elitesoldier_withhisenergyball.png")
		torsozombTree2:SetPos(250, 400)
		torsozombTree2:SetSize(50, 50)
		torsozombTree2:SetToolTip("Recovery:\nIncrease recovery by 5")
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
					net.WriteInt(2, 16)
				net.SendToServer()
				skillPoints = skillPoints - 1
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		local torsozombTree3 = vgui.Create("DImageButton", petEvolPanel)
		torsozombTree3:SetImage("vgui/achievements/hl2_get_crowbar.png")
		torsozombTree3:SetPos(350, 400)
		torsozombTree3:SetSize(50, 50)
		torsozombTree3:SetToolTip("Strength:\nIncrease damage by 1")
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
				skillPoints = skillPoints - 1
				surface.PlaySound("beams/beamstart5.wav")
				net.Start("UpdateSkills")
					net.WriteInt(3, 16)
				net.SendToServer()
			end
		end
		local torsozombTree4 = vgui.Create("DImageButton", petEvolPanel)
		torsozombTree4:SetImage("vgui/achievements/hl2_beat_cemetery.png")
		torsozombTree4:SetPos(350, 300)
		torsozombTree4:SetSize(50, 50)
		torsozombTree4:SetToolTip("Endurance:\nIncrease Max HP by 10")
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
				skillPoints = skillPoints - 1
				net.Start("UpdateSkills")
					net.WriteInt(4, 16)
				net.SendToServer()
			end
		end
		local torsozombTree5 = vgui.Create("DImageButton", petEvolPanel)
		torsozombTree5:SetImage("vgui/achievements/hlx_kill_elitesoldier_withhisenergyball.png")
		torsozombTree5:SetPos(350, 200)
		torsozombTree5:SetSize(50, 50)
		torsozombTree5:SetToolTip("Recovery:\nIncrease recovery by 5")
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
				skillPoints = skillPoints - 1
				net.Start("UpdateSkills")
					net.WriteInt(5, 16)
				net.SendToServer()
			end
		end
		
		local torsozombTree6 = vgui.Create("DImageButton", petEvolPanel)
		torsozombTree6:SetImage("vgui/achievements/hl2_beat_cemetery.png")
		torsozombTree6:SetPos(250, 200)
		torsozombTree6:SetSize(50, 50)
		torsozombTree6:SetToolTip("Endurance:\nIncrease Max HP by 15")
		torsozombTree6.DoClick = function()
			if curSkill < 5 then
				LocalPlayer():ChatPrint("You need to unlock the connecting skills")
				surface.PlaySound("buttons/button8.wav")
			elseif skillPoints <= 0 then
				LocalPlayer():ChatPrint("You don't have enough pet skill points")
				surface.PlaySound("buttons/button8.wav")
			elseif curSkill >= 6 then
				LocalPlayer():ChatPrint("You already unlocked this!")
				surface.PlaySound("buttons/button8.wav")
			else
				curSkill = 6
				skillPoints = skillPoints - 1
				surface.PlaySound("beams/beamstart5.wav")
				net.Start("UpdateSkills")
					net.WriteInt(6, 16)
				net.SendToServer()
			end
		end
		
		local torsozombTree7 = vgui.Create("DImageButton", petEvolPanel)
		torsozombTree7:SetImage("vgui/achievements/hl2_beat_game.png")
		torsozombTree7:SetPos(250, 100)
		torsozombTree7:SetSize(50, 50)
		torsozombTree7:SetToolTip("Genetic Mutation:\nAllow your pet to become something stronger")
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
					net.WriteInt(7, 16)
				net.SendToServer()
				skillPoints = skillPoints - 1
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
	elseif petStage == 2 then
	
		local zombTree1 = vgui.Create("DImageButton", petEvolPanel)
		zombTree1:SetImage("vgui/achievements/hl2_beat_cemetery.png")
		zombTree1:SetPos(250, 500)
		zombTree1:SetSize(50, 50)
		zombTree1:SetToolTip("Endurance:\nIncrease Max HP by 5")
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
					net.WriteInt(1, 16)
				net.SendToServer()
				skillPoints = skillPoints - 1
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local zombTree2 = vgui.Create("DImageButton", petEvolPanel)
		zombTree2:SetImage("vgui/achievements/hlx_kill_elitesoldier_withhisenergyball.png")
		zombTree2:SetPos(350, 415)
		zombTree2:SetSize(50, 50)
		zombTree2:SetToolTip("Recovery:\nIncrease recovery by 5")
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
					net.WriteInt(2, 16)
				net.SendToServer()
				skillPoints = skillPoints - 1
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local zombTree3 = vgui.Create("DImageButton", petEvolPanel)
		zombTree3:SetImage("vgui/achievements/hl2_beat_cemetery.png")
		zombTree3:SetPos(150, 315)
		zombTree3:SetSize(50, 50)
		zombTree3:SetToolTip("Endurance:\nIncrease Max HP by 5")
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
					net.WriteInt(3, 16)
				net.SendToServer()
				skillPoints = skillPoints - 1
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local zombTree4 = vgui.Create("DImageButton", petEvolPanel)
		zombTree4:SetImage("vgui/achievements/hl2_get_crowbar.png")
		zombTree4:SetPos(350, 215)
		zombTree4:SetSize(50, 50)
		zombTree4:SetToolTip("Strength:\nIncrease damage by 1")
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
				skillPoints = skillPoints - 1
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local zombTree5 = vgui.Create("DImageButton", petEvolPanel)
		zombTree5:SetImage("vgui/achievements/hl2_beat_cemetery.png")
		zombTree5:SetPos(150, 115)
		zombTree5:SetSize(50, 50)
		zombTree5:SetToolTip("Endurance:\nIncrease Max HP by 10")
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
					net.WriteInt(5, 16)
				net.SendToServer()
				skillPoints = skillPoints - 1
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local zombTree6 = vgui.Create("DImageButton", petEvolPanel)
		zombTree6:SetImage("vgui/achievements/hl2_get_crowbar.png")
		zombTree6:SetPos(250, 65)
		zombTree6:SetSize(50, 50)
		zombTree6:SetToolTip("Strength:\nIncrease damage by 2")
		zombTree6.DoClick = function()
			if curSkill < 5 then
				LocalPlayer():ChatPrint("You need to unlock the connecting skills")
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
					net.WriteInt(6, 16)
				net.SendToServer()
				
				net.Start("Achievement")
					net.WriteString("Blast_that_little")
					net.WriteString("Misc_Ach_List")
				net.SendToServer()
				
				skillPoints = skillPoints - 1
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
			if curSkill == 5 then
				isOpenPets = false
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
			if curSkill == 7 then
				isOpenPets = false
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
			if curSkill == 9 then
				LocalPlayer():ChatPrint("Your pet cannot evolve any further")
			end
		end
	end
	petSheet:AddSheet("Evolution Tree", petEvolPanel, nil)
	
end
net.Receive("Open_Pet_Menu", function(len, ply)
	local skills = net.ReadInt(16)
	local points = net.ReadInt(16)
	local stage = net.ReadInt(16)
	PetMenu(skills, points, stage)
end)



function petStats()
	local hp = LocalPlayer():GetNWInt("PetHP")
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
	if pet then
		petStatFrame.Think = function()
			petStatLevelLabel:SetText("Level: " .. LocalPlayer():GetNWInt("PetLevel"))
			petStatLevelLabel:SizeToContents()
			
			petStatXPBar.Paint = function(self, w, h)
				surface.SetDrawColor(70, 70, 70 , 255)
				surface.DrawRect(0,0, LocalPlayer():GetNWInt("PetMaxXP"), h)
				
				surface.SetDrawColor(50, 165, 255, 255)
				surface.DrawRect(0,0, (LocalPlayer():GetNWInt("PetXP")), h)
			end
			
			petStatXPStatusLabel:SetText(LocalPlayer():GetNWInt("PetXP") .. "/" .. LocalPlayer():GetNWInt("PetMaxXP"))
			petStatXPStatusLabel:SizeToContents()
			
			
			
			petStatHealthBar.Paint = function(self, w, h)
				if hp >= 75 then
					surface.SetDrawColor(0, 255, 0, 255)
					surface.DrawRect(0,0, LocalPlayer():GetNWInt("PetHP"), h)
				elseif hp <= 75 and hp >= 25 then
					surface.SetDrawColor(255, 255, 0, 255)
					surface.DrawRect(0,0, LocalPlayer():GetNWInt("PetHP"), h)
				elseif hp <= 25 then
					surface.SetDrawColor(255, 0, 0, 255)
					surface.DrawRect(0,0, LocalPlayer():GetNWInt("PetHP"), h)
				end
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
	petStats()
end)
