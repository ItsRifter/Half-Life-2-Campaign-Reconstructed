surface.CreateFont("Pet_Congrat_Title_Font", {
	font = "Arial",
	size = 48,
})

surface.CreateFont("Pet_Desc_Font", {
	font = "Arial",
	size = 38,
})

surface.CreateFont("Pet_Evol_Font", {
	font = "Arial",
	size = 32,
})

function petDuelMenu(coins)
	
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
			
			local betAmt = math.Round(playerCoinAmountSlider:GetValue())
			
			if target == "" then
				LocalPlayer():ChatPrint("You need to select a target to challenge!")
				return
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
	local curCoins = net.ReadInt(64)
	petDuelMenu(curCoins)
end)

--Not really used, just reminders for what is what
PET_ZOMBIE_EVOL_ICON = {
	[0] = "entities/npc_headcrab.png",
	[1] = "entities/npc_zombie_torso.png",
	[2] = "entities/npc_zombie.png",
	[3] = "entities/npc_headcrab_fast.png",
	[4] = "entities/npc_fastzombie_torso.png",
	[5] = "entities/npc_fastzombie.png",
}

PET_ZOMBIE_EVOL_MODEL = {
	[0] = "models/headcrabclassic.mdl",
	[1] = "models/zombie/Classic_torso.mdl",
	[2] = "models/zombie/Classic.mdl",
	[3] = "models/headcrab.mdl",
	[4] = "models/gibs/fast_zombie_torso.mdl",
	[5] = "models/zombie/fast.mdl",
}

PET_COMBINE_EVOL_ICON = {
	[6] = "entities/npc_rollermine.png",
	[7] = "entities/npc_manhack.png",
	[8] = "entities/npc_stalker.png",
	[9] = "entities/npc_metropolice.png",
	[10] = "entities/npc_metropolice.png",
	[11] = "entities/npc_combine_s.png",
}
PET_COMBINE_EVOL_MODEL = {
	[6] = "models/Roller.mdl",
	[7] = "models/manhack.mdl",
	[8] = "models/stalker.mdl",
	[9] = "models/Police.mdl",
	[10] = "models/Police.mdl",
	[11] = "models/Combine_Soldier.mdl",
}

function PetMenu(curSkill, skillPoints, petStage)
	
	COLOUR_PET_MODEL_PANEL = Color(100, 100, 100)
	COLOUR_PET_MAIN_PANEL = Color(100, 100, 100)
	COLOUR_PET_EVOL_PANEL = Color(0, 0, 0)
	music = CreateSound(LocalPlayer(), "HL1/ambience/alien_powernode.wav")
	music:Play()
	
	local petFrame = vgui.Create("HL2CR.petFrame")
	petFrame:SetSize(900, 700)
	petFrame:Center()
	petFrame:MakePopup()

	local petBtns = vgui.Create("HL2CR.petBtn", petFrame)
	petBtns:AddTab("Genetics Lab")
	petBtns:AddTab("Adoption Centre")
	petBtns:SetActiveName("Genetics Lab")
	petBtns:SetSize(650, 32)
	
	local petSheet = vgui.Create("DPropertySheet", petFrame)
	petSheet:Dock(FILL)
	petSheet:SetSize(0, 0)
	
	local defaultColour = Color(255, 255, 255)
	
	petEvolPanel = vgui.Create("DPanel", petFrame)
	
	local petSkillPointsLabel = vgui.Create("DLabel", petEvolPanel) 
	petSkillPointsLabel:SetPos(25, 50)
	petSkillPointsLabel:SetFont("Pet_Evol_Font")
	petSkillPointsLabel:SetText("Skill Points: " .. skillPoints)
	petSkillPointsLabel:SizeToContents()
	
	local petEvolModel = vgui.Create("DModelPanel", petEvolPanel)
	petEvolModel:SetPos(450, 25)
	petEvolModel:SetSize(550, 550)
	petEvolModel:SetColor(defaultColour)
	
	local petStatsLabel = vgui.Create("DLabel", petEvolPanel)
	petStatsLabel:SetPos(25, 100)
	petStatsLabel:SetFont("Pet_Evol_Font")
	petStatsLabel:SetText("Max Health: " .. LocalPlayer():GetNWInt("PetHP") .. "\nStrength: " .. LocalPlayer():GetNWInt("PetStr") .. "\nRegen Amount: " .. LocalPlayer():GetNWInt("PetRegen"))
	petStatsLabel:SizeToContents()
	
	if petStage == 0 then
		
		showHeadcrabTree(curSkill, skillPoints)
		petEvolModel:SetModel(PET_ZOMBIE_EVOL_MODEL[petStage])

	elseif petStage == 1 then
		
		showZombTorsoTree(curSkill, skillPoints)
		petEvolModel:SetModel(PET_ZOMBIE_EVOL_MODEL[petStage])
		
	elseif petStage == 2 then
		
		showZombieTree(curSkill, skillPoints)
		petEvolModel:SetModel(PET_ZOMBIE_EVOL_MODEL[petStage])
		
	elseif petStage == 3 then
	
		showFastHeadcrabTree(curSkill, skillPoints)
		petEvolModel:SetModel(PET_ZOMBIE_EVOL_MODEL[petStage])
		
	elseif petStage == 4 then
		
		showFastTorsoTree(curSkill, skillPoints)
		petEvolModel:SetModel(PET_ZOMBIE_EVOL_MODEL[petStage])
		
	elseif petStage == 5 then
	
		showFastZombieTree(curSkill, skillPoints)
		petEvolModel:SetModel(PET_ZOMBIE_EVOL_MODEL[petStage])
	
	elseif petStage == 6 then
	
		showRollermineTree(curSkill, skillPoints)
		petEvolModel:SetModel(PET_COMBINE_EVOL_MODEL[petStage])
		
	elseif petStage == 7 then
	
		showManhackTree(curSkill, skillPoints)
		petEvolModel:SetModel(PET_COMBINE_EVOL_MODEL[petStage])
		
	elseif petStage == 8 then
		
		showStalkerTree(curSkill, skillPoints)
		petEvolModel:SetModel(PET_COMBINE_EVOL_MODEL[petStage])
		
	elseif petStage == 9 then
		
		showMetroStunTree(curSkill, skillPoints)
		petEvolModel:SetModel(PET_COMBINE_EVOL_MODEL[petStage])
		
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
			if curSkill >= 6 then
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
		elseif petStage == 6 then
			if curSkill >= 4 then
				petStatFrame:Close()
				net.Start("Evolving")
				net.SendToServer()
				timer.Simple(5, function()
					LocalPlayer():ChatPrint("Your pet has evolved, Congratulations!")
				end)
			else
				LocalPlayer():ChatPrint("Your pet isn't ready to evolve")
			end
		elseif petStage == 7 then
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
		elseif petStage == 8 then
			if curSkill >= 6 then
				petStatFrame:Close()
				net.Start("Evolving")
				net.SendToServer()
				timer.Simple(5, function()
					LocalPlayer():ChatPrint("Your pet has evolved, Congratulations!")
				end)
			else
				LocalPlayer():ChatPrint("Your pet isn't ready to evolve")
			end
		end
	end
	petSheet:AddSheet("", petEvolPanel, nil)
	
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
	if curSkill >= 6 and petStage == 2 then
		selectImage:SetImage(PET_ZOMBIE_EVOL_ICON[3])
		selectPetLabel:SetText("Fast Pet")
		selectPetLabel:SetPos(375, 75)
	else
		selectImage:SetImage("vgui/hud/icon_locked")
		selectPetLabel:SetText("There is currently no pet for adoption")
	end
	if curSkill >= 10 and petStage == 5 then
		selectImage:SetImage(PET_COMBINE_EVOL_ICON[6])
		selectPetLabel:SetText("Rollermine Pet")
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
		if curSkill >= 6 and petStage == 2 then
			net.Start("NewPet")
				net.WriteString("hl2cr_fastzombie_pet")
			net.SendToServer()
			if petStatFrame:IsValid() then
				petStatFrame:MoveTo(-400, ScrH() / 2 - 200, 1, 0, -1, function()
					petStatFrame:Close()
				end)
			end
		elseif curSkill >= 10 and petStage == 5 then
			net.Start("NewPet")
				net.WriteString("hl2cr_rollermine_pet")
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
	
	petSheet:AddSheet("", petSwitchPanel, nil)
	
	petFrame.Think = function()
		if petBtns.active == 1 then
			petSheet:SetActiveTab(petSheet:GetItems()[1].Tab)
		elseif petBtns.active == 2 then
			petSheet:SetActiveTab(petSheet:GetItems()[2].Tab)
		end
	end
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
	
	petStatHPStatusLabel = vgui.Create("DLabel", petStatPanel)
	petStatHPStatusLabel:SetPos(petStatHealthBar:GetWide() - 325, petStatHealthBar:GetTall() + 75)
	petStatHPStatusLabel:SetFont("Pets_Stats")
	petStatHPStatusLabel:SizeToContents()
	
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
			if entPet:GetClass() != "npc_rollermine" then
				petStatHPStatusLabel:SetText(entPet:Health() .. "/" .. entPet:GetMaxHealth())
				petStatHPStatusLabel:SizeToContents()
				
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
				petStatHPStatusLabel:SetText("INF")
				petStatHPStatusLabel:SizeToContents()
				petStatHealthBar.Paint = function(self, w, h)
				end
			end
			
		else
			petStatHealthBar.Paint = function(self, w, h)
			end
			petStatXPBar.Paint = function(self, w, h)
			end
			clientClosePets()
			net.Start("PetKilledBarnacle")
			net.SendToServer()
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
