function showMenu()
	local prestFrame = vgui.Create("HL2CR.f4Frame")
	prestFrame:SetSize(900, 700)
	prestFrame:Center()
	prestFrame:MakePopup()
	
	local prestTextTitle = vgui.Create("DLabel", prestFrame)
	prestTextTitle:SetText("Welcome to the Prestige Menu")
	prestTextTitle:SetPos(180, 100)
	prestTextTitle:SetFont("Prestige_Title_font")
	prestTextTitle:SizeToContents()
	prestTextTitle:SetTextColor(Color(0, 0, 0))
	
	local prestTextLose = vgui.Create("DLabel", prestFrame)
	prestTextLose:SetText("You will lose:\nArmour\nStarting Weapons\nPerm Upgs")
	prestTextLose:SetFont("Prestige_font")
	prestTextLose:SetPos(125, 200)
	prestTextLose:SizeToContents()
	prestTextLose:SetTextColor(Color(0, 0, 0))
	
	local prestTextKeep = vgui.Create("DLabel", prestFrame)
	prestTextKeep:SetText("You will keep:\nPets\nAchievements")
	prestTextKeep:SetFont("Prestige_font")
	prestTextKeep:SetPos(625, 200)
	prestTextKeep:SizeToContents()
	prestTextKeep:SetTextColor(Color(0, 0, 0))
	
	local prestTextGain = vgui.Create("DLabel", prestFrame)
	prestTextGain:SetText("After prestiging\nyou'll be able to earn more levels and access to newer items\nas well as bonuses")
	prestTextGain:SetFont("Prestige_font")
	prestTextGain:SetPos(50, 400)
	prestTextGain:SizeToContents()
	prestTextGain:SetTextColor(Color(0, 0, 0))
	
	local prestButton = vgui.Create("DButton", prestFrame)
	prestButton:SetText("Prestige")
	prestButton:SetFont("Prestige_font")
	prestButton:SetPos(400, 625)
	prestButton:SizeToContents()
	prestButton:SetTextColor(Color(0, 0, 0))
	
	prestButton.DoClick = function()
		net.Start("BeginPrestige")
		net.SendToServer()
		prestFrame:Close()
	end
	
end

net.Receive("Prestige", function()
	showMenu()
end)