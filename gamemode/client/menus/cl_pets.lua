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

--[[
function petDuelMenu(enemyPet)
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
		else
			LocalPlayer():ChatPrint("Please wait " .. math.Round(timer.TimeLeft("CooldownDuel")) .. " seconds before challenging another opponent")
		end
	end
end
--]]

net.Receive("PetDuel", function()
	local enemyPet = net.ReadEntity()
	petDuelMenu(enemyPet)
end)

function petStats(ply, pet)
	
	XP = tonumber(LocalPlayer():GetNWInt("PetXP"))
	MaxXP = tonumber(LocalPlayer():GetNWInt("PetMaxXP"))
	
	
	local hp = pet:Health()
	local maxHp = pet:GetMaxHealth()
	
	net.Receive("UpdatePetsHealthDMG", function(len, ply)
		hp = pet:Health() + net.ReadInt(32)
	end)
	
	net.Receive("UpdatePetsXP", function()
		XP = tonumber(LocalPlayer():GetNWInt("PetXP")) + net.ReadInt(32)
	end)
	
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
		
	petStatLevelLabel = vgui.Create("DLabel", petStatFrame)
	petStatLevelLabel:SetPos(150, 25)
	petStatLevelLabel:SetFont("Pets_Stats")
	petStatLevelLabel:SizeToContents()
			
	petStatHPLabel = vgui.Create("DLabel", petStatFrame)
	petStatHPLabel:SetPos(25, 75)
	petStatHPLabel:SetFont("Pets_Stats")
	petStatHPLabel:SetText("HP")

	petStatHealthBar = vgui.Create("DProgress", petStatFrame)
	petStatHealthBar:SetPos( 25, 100 )
	petStatHealthBar:SetSize( 350, 25 )
	petStatHealthBar.Paint = function(self, w, h)
		surface.SetDrawColor(75, 75, 75, 255)
		surface.DrawRect(0,0, maxHp, h)
		if hp >= 75 then
			surface.SetDrawColor(0, 255, 0, 255)
			surface.DrawRect(0,0, hp, h)
		elseif hp <= 75 and hp >= 25 then
			surface.SetDrawColor(255, 255, 0, 255)
			surface.DrawRect(0,0, hp, h)
		elseif hp <= 25 then
			surface.SetDrawColor(255, 0, 0, 255)
			surface.DrawRect(0,0, hp, h)
		end
	end
	
	petStatXPLabel = vgui.Create("DLabel", petStatFrame)
	petStatXPLabel:SetPos(25, 150)
	petStatXPLabel:SetFont("Pets_Stats")
	petStatXPLabel:SetText("XP")
	
	petStatXPBar = vgui.Create("DProgress", petStatFrame)
	petStatXPBar:SetPos( 25, 175 )
	petStatXPBar:SetSize( 350, 25 )
	petStatXPBar:SetFraction( XP / MaxXP )
	petStatXPBar.Paint = function(self, w, h)
		surface.SetDrawColor(70, 70, 70 , 255)
		surface.DrawRect(0,0, w, h)
		
		surface.SetDrawColor(50, 165, 255, 255)
		surface.DrawRect(0,0, XP, h)
	end
	
	petStatFrame:Add(petStatLevelLabel)
	petStatFrame:Add(petStatHealthBar)
	petStatFrame:Add(petStatHPLabel)
	petStatFrame:Add(petStatXPLabel)
	petStatFrame:Add(petStatXPBar)
	petStatFrame:MoveTo(0, ScrH() / 2 - 200 , 1, 0, -1)

	petStatFrame.Think = function()
		petStatLevelLabel:SetText("Level: " .. LocalPlayer():GetNWInt("PetLevel"))
		petStatLevelLabel:SizeToContents()
		petStatHPLabel:SetText("HP")
		petStatHealthBar:SetFraction( pet:Health() * pet:GetMaxHealth())
		
		petStatXPBar.Paint = function(self, w, h)
			surface.SetDrawColor(70, 70, 70 , 255)
			surface.DrawRect(0,0, w, h)
			
			surface.SetDrawColor(50, 165, 255, 255)
			surface.DrawRect(0,0, XP, h)
		end
		
		petStatHealthBar.Paint = function(self, w, h)
			surface.SetDrawColor(75, 75, 75, 255)
			surface.DrawRect(0,0, maxHp, h)
				if hp >= 75 then
					surface.SetDrawColor(0, 255, 0, 255)
					surface.DrawRect(0,0, hp, h)
				elseif hp <= 75 and hp >= 25 then
					surface.SetDrawColor(255, 255, 0, 255)
					surface.DrawRect(0,0, hp, h)
				elseif hp <= 25 then
					surface.SetDrawColor(255, 0, 0, 255)
					surface.DrawRect(0,0, hp, h)
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
end

net.Receive("ClosePets", function()
	petStatFrame:MoveTo(-400, ScrH() / 2 - 200, 1, 0, -1, function()
		petStatFrame:Close()
	end)
end)

net.Receive("PetDead", function()
	terminatedLabel = vgui.Create("DLabel", petStatPanel)
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
	petStatPanel:Close()
end)

surface.CreateFont("Pets_Stats", {
	font = "Arial",
	size = 26,
})

surface.CreateFont("Pets_Stats_Dead", {
	font = "Arial",
	size = 48,
})

net.Receive("Open_Pet_Menu", PetMenu)

net.Receive("OpenPetStats", function(len, ply)
	local pet = net.ReadEntity()
	petStats(ply, pet)
end)


