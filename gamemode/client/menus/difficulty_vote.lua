function OpenDiffMenu(ply)

	local currentPlayers = #player.GetAll()
	local votes = net.ReadInt(16)
	
	votes = votes + currentPlayers / 0.40
	
	local diffFrame = vgui.Create("DFrame")
	diffFrame:SetSize(450, 750)
	diffFrame:Center()
	diffFrame:MakePopup()
	
	local easyButton = vgui.Create("DButton", diffFrame)
	easyButton:SetText("Easy")
	easyButton:SetSize(125, 50)
	easyButton:SetPos(165, 150)
	easyButton.DoClick = function()
		if not hasVoted then
			net.Start("Diff_Change")
				net.WriteInt(1, 16)
				net.WriteString(LocalPlayer():Nick())
			net.SendToServer()
		else
			LocalPlayer():ChatPrint("You have already voted for a difficulty!")
		end
		diffFrame:Close()
	end
	
	local mediumButton = vgui.Create("DButton", diffFrame)
	mediumButton:SetText("Medium")
	mediumButton:SetSize(125, 50)
	mediumButton:SetPos(165, 200)
	mediumButton.DoClick = function()
		if not hasVoted then
			net.Start("Diff_Change")
				net.WriteInt(2, 16)
				net.WriteString(LocalPlayer():Nick())
			net.SendToServer()
		else
			LocalPlayer():ChatPrint("You have already voted for a difficulty!")
		end
		diffFrame:Close()
	end
	
	local HardButton = vgui.Create("DButton", diffFrame)
	HardButton:SetText("Hard")
	HardButton:SetSize(125, 50)
	HardButton:SetPos(165, 250)
	HardButton.DoClick = function()
		if not hasVoted then
			net.Start("Diff_Change")
				net.WriteInt(3, 16)
				net.WriteString(LocalPlayer():Nick())
			net.SendToServer()
		else
			LocalPlayer():ChatPrint("You have already voted for a difficulty!")
		end
		diffFrame:Close()
	end
	
	local warningLabel = vgui.Create("DLabel", diffFrame)
	warningLabel:SetText("WARNING:")
	warningLabel:SetPos(205, 425)
	
	local warningMessage = vgui.Create("DLabel", diffFrame)
	warningMessage:SetText("Enabling this difficulty means if you die\nyou are out until next checkpoint\n\nIf everyone dies, the map restarts")
	warningMessage:SizeToContents()
	warningMessage:SetPos(145, 450)
	
	local survivalButton = vgui.Create("DButton", diffFrame)
	survivalButton:SetText("Survival")
	survivalButton:SetSize(125, 50)
	survivalButton:SetPos(165, 525)
	survivalButton.DoClick = function()
		if not hasVoted then
			net.Start("Diff_Change")
				net.WriteInt(4, 16)
				net.WriteString(LocalPlayer():Nick())
			net.SendToServer()
		else
			LocalPlayer():ChatPrint("You have already voted for a difficulty!")
		end
		diffFrame:Close()
	end
end

net.Receive("Open_Diff_Menu", OpenDiffMenu)