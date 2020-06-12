AddCSLuaFile()

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
	if petStage == 0 then
		petIcon:SetImage("entities/npc_headcrab.png")
	elseif petStage == 1 then
		petIcon:SetImage("entities/npc_zombie_torso.png")
	elseif petStage == 2 then
		petIcon:SetImage("entities/npc_zombie.png")
	end
	petIcon:SetPos(335, 350)
	petIcon:SetSize(200, 200)
	
	petSheet:AddSheet("Select Pet", petMenuPanel, nil)
	local defaultColour = Color(255, 255, 255)
	local green = Color(0, 255, 0)
	
	local petEvolPanel = vgui.Create("DPanel", petFrame)
	petEvolPanel.Paint = function( self, w, h ) 
		draw.RoundedBox( 4, 0, 0, w, h, COLOUR_PET_EVOL_PANEL)
		
		if petStage == 0 then
			if curSkill == 0 then
				surface.SetDrawColor(255, 0, 0)
				surface.DrawLine(275, 500, 275, 450)
			else
				surface.SetDrawColor(0, 255, 0)
				surface.DrawLine(275, 500, 275, 450)
			end
			
			if curSkill == 1 then
				surface.SetDrawColor(255, 0, 0)
				surface.DrawLine(275, 450, 275, 325)
			else
				surface.SetDrawColor(0, 255, 0)
				surface.DrawLine(275, 450, 275, 325)
			end
			
			if curSkill == 2 then
				surface.SetDrawColor(255, 0, 0)
				surface.DrawLine(275, 350, 275, 225)
			else
				surface.SetDrawColor(0, 255, 0)
				surface.DrawLine(275, 350, 275, 225)
			end
			
			if curSkill == 3 then
				surface.SetDrawColor(255, 0, 0)
				surface.DrawLine(275, 225, 275, 100)
			else
				surface.SetDrawColor(0, 255, 0)
				surface.DrawLine(275, 225, 275, 100)
			end
		
		elseif petStage == 1 then
			
			if curSkill == 0 then
				surface.SetDrawColor(255, 0, 0)
				surface.DrawLine(275, 425, 275, 500)
			else
				surface.SetDrawColor(0, 255, 0)
				surface.DrawLine(275, 425, 275, 500)
			end
			
			if curSkill == 1 then
				surface.SetDrawColor(255, 0, 0)
				surface.DrawLine(275, 425, 375, 425)
				surface.DrawLine(275, 425, 175, 425)
			else
				surface.SetDrawColor(0, 255, 0)
				surface.DrawLine(275, 425, 375, 425)
				surface.DrawLine(275, 425, 175, 425)
			end
			
			if curSkill == 2 then
				surface.SetDrawColor(255, 0, 0)
				surface.DrawLine(375, 425, 375, 325)
			else
				surface.SetDrawColor(0, 255, 0)
				surface.DrawLine(375, 425, 375, 325)
			end
			
			if curSkill == 3 then
				surface.SetDrawColor(255, 0, 0)
				surface.DrawLine(375, 325, 375, 225)
			else
				surface.SetDrawColor(0, 255, 0)
				surface.DrawLine(375, 325, 375, 225)
			end
			
			if curSkill == 4 then
				surface.SetDrawColor(255, 0, 0)
				surface.DrawLine(375, 225, 275, 225)
			else
				surface.SetDrawColor(0, 255, 0)
				surface.DrawLine(375, 225, 275, 225)
			end
			
			if curSkill == 5 then
				surface.SetDrawColor(255, 0, 0)
				surface.DrawLine(275, 225, 275, 125)
			else
				surface.SetDrawColor(0, 255, 0)
				surface.DrawLine(275, 225, 275, 125)
			end

			if curSkill == 6 then
				surface.SetDrawColor(255, 0, 0)
				surface.DrawLine(175, 425, 175, 325)
			else
				surface.SetDrawColor(0, 255, 0)
				surface.DrawLine(175, 425, 175, 325)
			end
			
			if curSkill == 7 then
				surface.SetDrawColor(255, 0, 0)
				surface.DrawLine(175, 325, 175, 225)
			else
				surface.SetDrawColor(0, 255, 0)
				surface.DrawLine(175, 325, 175, 225)
			end
			
			if curSkill == 8 then
				surface.SetDrawColor(255, 0, 0)
				surface.DrawLine(175, 225, 275, 225)
			else
				surface.SetDrawColor(0, 255, 0)
				surface.DrawLine(175, 225, 275, 225)
			end
		elseif petStage == 2 then
			
			if curSkill == 0 then
				surface.SetDrawColor(255, 0, 0)
				surface.DrawLine(275, 525, 175, 425)
				
				surface.SetDrawColor(255, 0, 0)
				surface.DrawLine(275, 525, 375, 425)
			else
				surface.SetDrawColor(0, 255, 0)
				surface.DrawLine(275, 525, 175, 425)
				
				surface.SetDrawColor(0, 255, 0)
				surface.DrawLine(275, 525, 375, 425)
			end
			
			if curSkill == 1 then
				surface.SetDrawColor(255, 0, 0)
				surface.DrawLine(375, 450, 175, 325)
			else
				surface.SetDrawColor(0, 255, 0)
				surface.DrawLine(375, 450, 175, 325)
			end
			
			if curSkill == 2 then
				surface.SetDrawColor(255, 0, 0)
				surface.DrawLine(175, 350, 375, 225)
			else
				surface.SetDrawColor(0, 255, 0)
				surface.DrawLine(175, 350, 375, 225)
			end
			
			if curSkill == 3 then
				surface.SetDrawColor(255, 0, 0)
				surface.DrawLine(375, 250, 175, 125)
			else
				surface.SetDrawColor(0, 255, 0)
				surface.DrawLine(375, 250, 175, 125)
			end
			
			if curSkill == 4 then
				surface.SetDrawColor(255, 0, 0)
				surface.DrawLine(175, 150, 275, 75)
			else
				surface.SetDrawColor(0, 255, 0)
				surface.DrawLine(175, 150, 275, 75)
			end
			
			if curSkill == 5 then
				surface.SetDrawColor(255, 0, 0)
				surface.DrawLine(175, 450, 375, 325)
			else
				surface.SetDrawColor(0, 255, 0)
				surface.DrawLine(175, 450, 375, 325)
			end
			
			if curSkill == 6 then
				surface.SetDrawColor(255, 0, 0)
				surface.DrawLine(375, 350, 175, 225)
			else
				surface.SetDrawColor(0, 255, 0)
				surface.DrawLine(375, 350, 175, 225)
			end
			
			if curSkill == 7 then
				surface.SetDrawColor(255, 0, 0)
				surface.DrawLine(175, 250, 375, 125)
			else
				surface.SetDrawColor(0, 255, 0)
				surface.DrawLine(175, 250, 375, 125)
			end
			
			if curSkill == 8 then
				surface.SetDrawColor(255, 0, 0)
				surface.DrawLine(375, 150, 275, 75)
			else
				surface.SetDrawColor(0, 255, 0)
				surface.DrawLine(375, 150, 275, 75)
			end
		
		end
	end
	local petEvolModel = vgui.Create("DModelPanel", petEvolPanel)
	if petStage == 0 then
		petEvolModel:SetModel("models/headcrabclassic.mdl")
	elseif petStage == 1 then
		petEvolModel:SetModel("models/zombie/Classic_torso.mdl")
	elseif petStage == 2 then
		petEvolModel:SetModel("models/zombie/Classic.mdl")
	end
	
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
			if points <= 0 then
				self:ChatPrint("You don't have enough pet skill points")
				surface.PlaySound("buttons/button8.wav")
			elseif curSkill == 1 then
				self:ChatPrint("You already unlocked this!")
				surface.PlaySound("buttons/button8.wav")
			else
				curSkill = 1
				ply.hl2cPersistent.PetSkills1 = 1
				points = points - 1
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local headcrabTree2 = vgui.Create("DImageButton", petEvolPanel)
		headcrabTree2:SetImage("vgui/achievements/hl2_beat_cemetery.png")
		headcrabTree2:SetPos(250, 400)
		headcrabTree2:SetSize(50, 50)
		headcrabTree2:SetToolTip("Endurance:\nIncrease Max HP by 5")
		headcrabTree2.DoClick = function()
			if headSkill1 == 0 then
				self:ChatPrint("You need to unlock the previous skill")
				surface.PlaySound("buttons/button8.wav")
			elseif points <= 0 then
				self:ChatPrint("You don't have enough pet skill points")
				surface.PlaySound("buttons/button8.wav")
			elseif headSkill2 == 1 then
				self:ChatPrint("You already unlocked this!")
				surface.PlaySound("buttons/button8.wav")
			else
				headSkill2 = 1
				ply.hl2cPersistent.PetSkills2 = 1
				points = points - 1
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local headcrabTree3 = vgui.Create("DImageButton", petEvolPanel)
		headcrabTree3:SetImage("vgui/achievements/hl2_get_crowbar.png")
		headcrabTree3:SetPos(250, 300)
		headcrabTree3:SetSize(50, 50)
		headcrabTree3:SetToolTip("Strength:\nIncrease damage by 1")
		headcrabTree3.DoClick = function()
			if headSkill2 == 0 then
				self:ChatPrint("You need to unlock the previous skill")
				surface.PlaySound("buttons/button8.wav")
			elseif points <= 0 then
				self:ChatPrint("You don't have enough pet skill points")
				surface.PlaySound("buttons/button8.wav")
			elseif headSkill3 == 1 then
				self:ChatPrint("You already unlocked this!")
				surface.PlaySound("buttons/button8.wav")
			else
				headSkill3 = 1
				ply.hl2cPersistent.PetSkills = 3
				points = points - 1
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local headcrabTree4 = vgui.Create("DImageButton", petEvolPanel)
		headcrabTree4:SetImage("vgui/achievements/hl2_get_crowbar.png")
		headcrabTree4:SetPos(250, 200)
		headcrabTree4:SetSize(50, 50)
		headcrabTree4:SetToolTip("Strength:\nIncrease damage by 1")
		headcrabTree4.DoClick = function()
			if headSkill3 == 0 then
				self:ChatPrint("You need to unlock the previous skill")
				surface.PlaySound("buttons/button8.wav")
			elseif points <= 0 then
				self:ChatPrint("You don't have enough pet skill points")
				surface.PlaySound("buttons/button8.wav")
			elseif headSkill4 == 1 then
				self:ChatPrint("You already unlocked this!")
				surface.PlaySound("buttons/button8.wav")
			else
				headSkill4 = 1
				net.Start("UpdateSkills")
					net.WriteInt(4, 16)
				net.SendToServer()
				points = points - 1
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
	
		local headcrabTree5 = vgui.Create("DImageButton", petEvolPanel)
		headcrabTree5:SetImage("vgui/achievements/hl2_beat_game.png")
		headcrabTree5:SetPos(250, 100)
		headcrabTree5:SetSize(50, 50)
		headcrabTree5:SetToolTip("Genetic Mutation:\nAllow your pet to become something stronger")
		headcrabTree5.DoClick = function()
			if headSkill4 == 0 then
				self:ChatPrint("You need to unlock the previous skill")
				surface.PlaySound("buttons/button8.wav")
			elseif points <= 0 then
				self:ChatPrint("You don't have enough pet skill points")
				surface.PlaySound("buttons/button8.wav")
			elseif headSkill5 == 1 then
				self:ChatPrint("You already unlocked this!")
				surface.PlaySound("buttons/button8.wav")
			else
				headSkill5 = 1
				net.Start("UpdateSkills")
					net.WriteInt(5, 16)
				net.SendToServer()
				points = points - 1
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
			if points <= 0 then
				self:ChatPrint("You don't have enough pet skill points")
				surface.PlaySound("buttons/button8.wav")
			elseif headSkill1 == 1 then
				self:ChatPrint("You already unlocked this!")
				surface.PlaySound("buttons/button8.wav")
			else
				headSkill1 = 1
				net.Start("UpdateSkills")
					net.WriteInt(1, 16)
				net.SendToServer()
				points = points - 1
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		local torsozombTree2 = vgui.Create("DImageButton", petEvolPanel)
		torsozombTree2:SetImage("vgui/achievements/hlx_kill_elitesoldier_withhisenergyball.png")
		torsozombTree2:SetPos(250, 400)
		torsozombTree2:SetSize(50, 50)
		torsozombTree2:SetToolTip("Recovery:\nIncrease recovery by 5")
		torsozombTree2.DoClick = function()
			if headSkill1 == 0 then
				self:ChatPrint("You need to unlock the previous skill")
				surface.PlaySound("buttons/button8.wav")
			elseif points <= 0 then
				self:ChatPrint("You don't have enough pet skill points")
				surface.PlaySound("buttons/button8.wav")
			elseif headSkill2 == 1 then
				self:ChatPrint("You already unlocked this!")
				surface.PlaySound("buttons/button8.wav")
			else
				headSkill2 = 1
				net.Start("UpdateSkills")
					net.WriteInt(2, 16)
				net.SendToServer()
				points = points - 1
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		local torsozombTree3 = vgui.Create("DImageButton", petEvolPanel)
		torsozombTree3:SetImage("vgui/achievements/hl2_get_crowbar.png")
		torsozombTree3:SetPos(350, 400)
		torsozombTree3:SetSize(50, 50)
		torsozombTree3:SetToolTip("Strength:\nIncrease damage by 1")
		torsozombTree3.DoClick = function()
			if headSkill2 == 0 then
				self:ChatPrint("You need to unlock the previous skill")
				surface.PlaySound("buttons/button8.wav")
			elseif points <= 0 then
				self:ChatPrint("You don't have enough pet skill points")
				surface.PlaySound("buttons/button8.wav")
			elseif headSkill3 == 1 then
				self:ChatPrint("You already unlocked this!")
				surface.PlaySound("buttons/button8.wav")
			else
				headSkill3 = 1
				points = points - 1
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
			if headSkill3 == 0 then
				self:ChatPrint("You need to unlock the previous skill")
				surface.PlaySound("buttons/button8.wav")
			elseif points <= 0 then
				self:ChatPrint("You don't have enough pet skill points")
				surface.PlaySound("buttons/button8.wav")
			elseif headSkill4 == 1 then
				self:ChatPrint("You already unlocked this!")
				surface.PlaySound("buttons/button8.wav")
			else
				headSkill4 = 1
				surface.PlaySound("beams/beamstart5.wav")
				points = points - 1
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
			if headSkill4 == 0 then
				self:ChatPrint("You need to unlock the previous skill")
				surface.PlaySound("buttons/button8.wav")
			elseif points <= 0 then
				self:ChatPrint("You don't have enough pet skill points")
				surface.PlaySound("buttons/button8.wav")
			elseif headSkill5 == 1 then
				self:ChatPrint("You already unlocked this!")
				surface.PlaySound("buttons/button8.wav")
			else
				headSkill5 = 1
				surface.PlaySound("beams/beamstart5.wav")
				points = points - 1
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
			if headSkill5 == 0 or headSkill9 == 0 then
				self:ChatPrint("You need to unlock the connecting skills")
				surface.PlaySound("buttons/button8.wav")
			elseif points <= 0 then
				self:ChatPrint("You don't have enough pet skill points")
				surface.PlaySound("buttons/button8.wav")
			elseif headSkill6 == 1 then
				self:ChatPrint("You already unlocked this!")
				surface.PlaySound("buttons/button8.wav")
			else
				headSkill6 = 1
				points = points - 1
				surface.PlaySound("beams/beamstart5.wav")
				net.Start("UpdateSkills")
					net.WriteInt(6, 16)
				net.SendToServer()
			end
		end
		
		local torsozombTree7 = vgui.Create("DImageButton", petEvolPanel)
		torsozombTree7:SetImage("vgui/achievements/hl2_get_crowbar.png")
		torsozombTree7:SetPos(150, 400)
		torsozombTree7:SetSize(50, 50)
		torsozombTree7:SetToolTip("Strength:\nIncrease damage by 1")
		torsozombTree7.DoClick = function()
			if headSkill2 == 0 then
				self:ChatPrint("You need to unlock the previous skill")
				surface.PlaySound("buttons/button8.wav")
			elseif points <= 0 then
				self:ChatPrint("You don't have enough pet skill points")
				surface.PlaySound("buttons/button8.wav")
			elseif headSkill7 == 1 then
				self:ChatPrint("You already unlocked this!")
				surface.PlaySound("buttons/button8.wav")
			else 
				headSkill7 = 1
				surface.PlaySound("beams/beamstart5.wav")
				net.Start("UpdateSkills")
					net.WriteInt(7, 16)
				net.SendToServer()
				points = points - 1
			end
		end
		
		local torsozombTree8 = vgui.Create("DImageButton", petEvolPanel)
		torsozombTree8:SetImage("vgui/achievements/hl2_get_crowbar.png")
		torsozombTree8:SetPos(150, 300)
		torsozombTree8:SetSize(50, 50)
		torsozombTree8:SetToolTip("Strength:\nIncrease damage by 1")
		torsozombTree8.DoClick = function()
			if headSkill7 == 0 then
				self:ChatPrint("You need to unlock the previous skill")
				surface.PlaySound("buttons/button8.wav")
			elseif points <= 0 then
				self:ChatPrint("You don't have enough pet skill points")
				surface.PlaySound("buttons/button8.wav")
			elseif headSkill8 == 1 then
				self:ChatPrint("You already unlocked this!")
				surface.PlaySound("buttons/button8.wav")
			else
				headSkill8 = 1
				surface.PlaySound("beams/beamstart5.wav")
				net.Start("UpdateSkills")
					net.WriteInt(8, 16)
				net.SendToServer()
				points = points - 1
			end
		end
		
		local torsozombTree9 = vgui.Create("DImageButton", petEvolPanel)
		torsozombTree9:SetImage("vgui/achievements/hl2_get_crowbar.png")
		torsozombTree9:SetPos(150, 200)
		torsozombTree9:SetSize(50, 50)
		torsozombTree9:SetToolTip("Strength:\nIncrease damage by 1")
		torsozombTree9.DoClick = function()
			if headSkill8 == 0 then
				self:ChatPrint("You need to unlock the previous skill")
				surface.PlaySound("buttons/button8.wav")
			elseif points <= 0 then
				self:ChatPrint("You don't have enough pet skill points")
				surface.PlaySound("buttons/button8.wav")
			elseif headSkill9 == 1 then
				self:ChatPrint("You already unlocked this!")
				surface.PlaySound("buttons/button8.wav")
			else 
				headSkill9 = 1
				surface.PlaySound("beams/beamstart5.wav")
				net.Start("UpdateSkills")
					net.WriteInt(9, 16)
				net.SendToServer()
				points = points - 1
			end
		end
		
		local torsozombTree10 = vgui.Create("DImageButton", petEvolPanel)
		torsozombTree10:SetImage("vgui/achievements/hl2_beat_game.png")
		torsozombTree10:SetPos(250, 100)
		torsozombTree10:SetSize(50, 50)
		torsozombTree10:SetToolTip("Genetic Mutation:\nAllow your pet to become something stronger")
		torsozombTree10.DoClick = function()
			if headSkill9 == 0 then
				self:ChatPrint("You need to unlock the previous skill")
				surface.PlaySound("buttons/button8.wav")
			elseif points <= 0 then
				self:ChatPrint("You don't have enough pet skill points")
				surface.PlaySound("buttons/button8.wav")
			elseif headSkill10 == 1 then
				self:ChatPrint("You already unlocked this!")
				surface.PlaySound("buttons/button8.wav")
			else
				headSkill10 = 1
				net.Start("UpdateSkills")
					net.WriteInt(10, 16)
				net.SendToServer()
				points = points - 1
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
			if points <= 0 then
				self:ChatPrint("You don't have enough pet skill points")
				surface.PlaySound("buttons/button8.wav")
			elseif headSkill1 == 1 then
				self:ChatPrint("You already unlocked this!")
				surface.PlaySound("buttons/button8.wav")
			else
				headSkill1 = 1
				net.Start("UpdateSkills")
					net.WriteInt(1, 16)
				net.SendToServer()
				points = points - 1
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local zombTree2 = vgui.Create("DImageButton", petEvolPanel)
		zombTree2:SetImage("vgui/achievements/hlx_kill_elitesoldier_withhisenergyball.png")
		zombTree2:SetPos(350, 415)
		zombTree2:SetSize(50, 50)
		zombTree2:SetToolTip("Recovery:\nIncrease recovery by 5")
		zombTree2.DoClick = function()
			if headSkill1 == 0 then
				self:ChatPrint("You need to unlock the previous skill")
				surface.PlaySound("buttons/button8.wav")
			elseif points <= 0 then
				self:ChatPrint("You don't have enough pet skill points")
				surface.PlaySound("buttons/button8.wav")
			elseif headSkill2 == 1 then
				self:ChatPrint("You already unlocked this!")
				surface.PlaySound("buttons/button8.wav")
			else
				headSkill2 = 1
				net.Start("UpdateSkills")
					net.WriteInt(2, 16)
				net.SendToServer()
				points = points - 1
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local zombTree3 = vgui.Create("DImageButton", petEvolPanel)
		zombTree3:SetImage("vgui/achievements/hl2_beat_cemetery.png")
		zombTree3:SetPos(150, 315)
		zombTree3:SetSize(50, 50)
		zombTree3:SetToolTip("Endurance:\nIncrease Max HP by 5")
		zombTree3.DoClick = function()
			if headSkill2 == 0 then
				self:ChatPrint("You need to unlock the previous skill")
				surface.PlaySound("buttons/button8.wav")
			elseif points <= 0 then
				self:ChatPrint("You don't have enough pet skill points")
				surface.PlaySound("buttons/button8.wav")
			elseif headSkill3 == 2 then
				self:ChatPrint("You already unlocked this!")
				surface.PlaySound("buttons/button8.wav")
			else
				headSkill3 = 1
				net.Start("UpdateSkills")
					net.WriteInt(3, 16)
				net.SendToServer()
				points = points - 1
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local zombTree4 = vgui.Create("DImageButton", petEvolPanel)
		zombTree4:SetImage("vgui/achievements/hl2_get_crowbar.png")
		zombTree4:SetPos(350, 215)
		zombTree4:SetSize(50, 50)
		zombTree4:SetToolTip("Strength:\nIncrease damage by 1")
		zombTree4.DoClick = function()
			if headSkill3 == 0 then
				self:ChatPrint("You need to unlock the previous skill")
				surface.PlaySound("buttons/button8.wav")
			elseif points <= 0 then
				self:ChatPrint("You don't have enough pet skill points")
				surface.PlaySound("buttons/button8.wav")
			elseif headSkill4 == 1 then
				self:ChatPrint("You already unlocked this!")
				surface.PlaySound("buttons/button8.wav")
			else
				headSkill4 = 1
				net.Start("UpdateSkills")
					net.WriteInt(4, 16)
				net.SendToServer()
				points = points - 1
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local zombTree5 = vgui.Create("DImageButton", petEvolPanel)
		zombTree5:SetImage("vgui/achievements/hl2_beat_cemetery.png")
		zombTree5:SetPos(150, 115)
		zombTree5:SetSize(50, 50)
		zombTree5:SetToolTip("Endurance:\nIncrease Max HP by 10")
		zombTree5.DoClick = function()
			if headSkill4 == 0 then
				self:ChatPrint("You need to unlock the previous skill")
				surface.PlaySound("buttons/button8.wav")
			elseif points <= 0 then
				self:ChatPrint("You don't have enough pet skill points")
				surface.PlaySound("buttons/button8.wav")
			elseif headSkill5 == 1 then
				self:ChatPrint("You already unlocked this!")
				surface.PlaySound("buttons/button8.wav")
			else
				headSkill5 = 1
				net.Start("UpdateSkills")
					net.WriteInt(5, 16)
				net.SendToServer()
				points = points - 1
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local zombTree6 = vgui.Create("DImageButton", petEvolPanel)
		zombTree6:SetImage("vgui/achievements/hl2_get_crowbar.png")
		zombTree6:SetPos(150, 415)
		zombTree6:SetSize(50, 50)
		zombTree6:SetToolTip("Strength:\nIncrease damage by 1")
		zombTree6.DoClick = function()
			if headSkill1 == 0 then
				self:ChatPrint("You need to unlock the previous skill")
				surface.PlaySound("buttons/button8.wav")
			elseif points <= 0 then
				self:ChatPrint("You don't have enough pet skill points")
				surface.PlaySound("buttons/button8.wav")
			elseif headSkill6 == 1 then
				self:ChatPrint("You already unlocked this!")
				surface.PlaySound("buttons/button8.wav")
			else
				headSkill6 = 1
				net.Start("UpdateSkills")
					net.WriteInt(6, 16)
				net.SendToServer()
				points = points - 1
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local zombTree7 = vgui.Create("DImageButton", petEvolPanel)
		zombTree7:SetImage("vgui/achievements/hl2_beat_cemetery.png")
		zombTree7:SetPos(350, 315)
		zombTree7:SetSize(50, 50)
		zombTree7:SetToolTip("Endurance:\nIncrease Max HP by 5")
		zombTree7.DoClick = function()
			if headSkill6 == 0 then
				self:ChatPrint("You need to unlock the previous skill")
				surface.PlaySound("buttons/button8.wav")
			elseif points <= 0 then
				self:ChatPrint("You don't have enough pet skill points")
				surface.PlaySound("buttons/button8.wav")
			elseif headSkill7 == 1 then
				self:ChatPrint("You already unlocked this!")
				surface.PlaySound("buttons/button8.wav")
			else
				headSkill7 = 1
				net.Start("UpdateSkills")
					net.WriteInt(7, 16)
				net.SendToServer()
				points = points - 1
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local zombTree8 = vgui.Create("DImageButton", petEvolPanel)
		zombTree8:SetImage("vgui/achievements/hl2_beat_cemetery.png")
		zombTree8:SetPos(150, 215)
		zombTree8:SetSize(50, 50)
		zombTree8:SetToolTip("Endurance:\nIncrease Max HP by 10")
		zombTree8.DoClick = function()
			if headSkill7 == 0 then
				self:ChatPrint("You need to unlock the previous skill")
				surface.PlaySound("buttons/button8.wav")
			elseif points <= 0 then
				self:ChatPrint("You don't have enough pet skill points")
				surface.PlaySound("buttons/button8.wav")
			elseif headSkill8 == 1 then
				self:ChatPrint("You already unlocked this!")
				surface.PlaySound("buttons/button8.wav")
			else
				headSkill8 = 1
				net.Start("UpdateSkills")
					net.WriteInt(8, 16)
				net.SendToServer()
				points = points - 1
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local zombTree9 = vgui.Create("DImageButton", petEvolPanel)
		zombTree9:SetImage("vgui/achievements/hl2_get_crowbar.png")
		zombTree9:SetPos(350, 115)
		zombTree9:SetSize(50, 50)
		zombTree9:SetToolTip("Strength:\nIncrease damage by 1")
		zombTree9.DoClick = function()
			if headSkill8 == 0 then
				self:ChatPrint("You need to unlock the previous skill")
				surface.PlaySound("buttons/button8.wav")
			elseif points <= 0 then
				self:ChatPrint("You don't have enough pet skill points")
				surface.PlaySound("buttons/button8.wav")
			elseif headSkill9 == 1 then
				self:ChatPrint("You already unlocked this!")
				surface.PlaySound("buttons/button8.wav")
			else
				headSkill9 = 1
				net.Start("UpdateSkills")
					net.WriteInt(9, 16)
				net.SendToServer()
				points = points - 1
				surface.PlaySound("beams/beamstart5.wav")
			end
		end
		
		local zombTree10 = vgui.Create("DImageButton", petEvolPanel)
		zombTree10:SetImage("vgui/achievements/hl2_get_crowbar.png")
		zombTree10:SetPos(250, 65)
		zombTree10:SetSize(50, 50)
		zombTree10:SetToolTip("Strength:\nIncrease damage by 2")
		zombTree10.DoClick = function()
			if headSkill9 == 0 or headSkill5 == 0 then
				self:ChatPrint("You need to unlock the connecting skills")
				surface.PlaySound("buttons/button8.wav")
			elseif points <= 0 then
				self:ChatPrint("You don't have enough pet skill points")
				surface.PlaySound("buttons/button8.wav")
			elseif headSkill10 == 1 then
				self:ChatPrint("You already unlocked this!")
				surface.PlaySound("buttons/button8.wav")
			else
				headSkill10 = 1
				net.Start("UpdateSkills")
					net.WriteInt(10, 16)
				net.SendToServer()
				net.Start("Ach_Pet_Zombie")
				net.SendToServer()
				points = points - 1
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
			if curSkill == 4 then
				isOpenPets = false
				petStatFrame:Close()
				net.Start("Evolving")
				net.SendToServer()
				timer.Simple(5, function()
					self:ChatPrint("Your pet has evolved, Congratulations!")
				end)
			else
				self:ChatPrint("Your pet isn't ready to evolve")
			end
		elseif petStage == 1 then
			if curSkill == 9 then
				isOpenPets = false
				petStatFrame:Close()
				net.Start("Evolving")
				net.SendToServer()
				timer.Simple(5, function()
					self:ChatPrint("Your pet has evolved, Congratulations!")
				end)
			else
				self:ChatPrint("Your pet isn't ready to evolve")
			end
		elseif petStage == 2 then
			if curSkill == 9 then
				self:ChatPrint("Your pet cannot evolve any further")
			end
		end
	end
	petSheet:AddSheet("Evolution Tree", petEvolPanel, nil)
	
end
net.Receive("Open_Pet_Menu", function(len, ply)
	local skills = tonumber(ply:GetNWInt("PetSkill"))
	local points = tonumber(ply:GetNWInt("PetSkillPoints"))
	local stage = tonumber(ply:GetNWInt("PetStage"))
	PetMenu(skills, points, stage)
end)

