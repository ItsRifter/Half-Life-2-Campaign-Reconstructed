local hasUserVoted = false

local easyVotes = 0
local mediumVotes = 0
local hardVotes = 0
local survVotes = 0

surface.CreateFont("Diff_Font", {
	font = "Arial",
	size = 22,
})

surface.CreateFont("Diff_Warning_Title_Font", {
	font = "Arial",
	size = 32,
})

surface.CreateFont("Diff_Warning_Font", {
	font = "Arial",
	size = 30,
})

function OpenDiffMenu(diff, surv, easyReq, medReq, hardReq, survReq)

	local diffFrame = vgui.Create("DFrame")
	diffFrame:SetSize(450, 750)
	diffFrame:Center()
	diffFrame:MakePopup()
	
	local curDiffTextLabel = vgui.Create("DLabel", diffFrame)
	curDiffTextLabel:SetText("Current Difficulty:")
	curDiffTextLabel:SetFont("Diff_Font")
	curDiffTextLabel:SizeToContents()
	curDiffTextLabel:SetPos(155, 95)
	
	local curDiffLabel = vgui.Create("DLabel", diffFrame)
	
	if diff == 1 then
		curDiffLabel:SetText("Easy")
	elseif diff == 2 then
		curDiffLabel:SetText("Medium")
	elseif diff == 3 then
		curDiffLabel:SetText("Hard")
	end
	curDiffLabel:SetFont("Diff_Font")
	curDiffLabel:SizeToContents()
	curDiffLabel:SetPos(200, 115)
	
	local easyButton = vgui.Create("DButton", diffFrame)
	easyButton:SetText("Easy")
	easyButton:SetSize(125, 50)
	easyButton:SetPos(165, 150)
	easyButton.DoClick = function()
		if not hasUserVoted and Diff ~= 1 then
			LocalPlayer().hasUserVoted = true
			easyVotes = easyVotes + 1	
			net.Start("Diff_Vote")
				net.WriteInt(easyVotes, 8)
				net.WriteInt(1, 8)
				net.WriteString(LocalPlayer():Nick())
			net.SendToServer()
			timer.Create("VoteTimer", 300, 1, function()
				LocalPlayer().hasUserVoted = false
				timer.Remove("VoteTimer")
				LocalPlayer():ChatPrint("You can now vote for a difficulty")
			end)
		elseif LocalPlayer().hasUserVoted then
			LocalPlayer():ChatPrint("You have already voted for a difficulty, please wait " .. math.ceil(timer.TimeLeft("VoteTimer")) .. " Seconds")
		elseif diff == 1 then
			LocalPlayer():ChatPrint("You are currently playing on that difficulty!")
			LocalPlayer().hasUserVoted = false
			timer.Remove("VoteTimer")
			easyVotes = easyVotes - 1
			
		end
		diffFrame:Close()
	end
	
	local mediumButton = vgui.Create("DButton", diffFrame)
	mediumButton:SetText("Medium")
	mediumButton:SetSize(125, 50)
	mediumButton:SetPos(165, 200)
	mediumButton.DoClick = function()
		if not LocalPlayer().hasUserVoted and Diff ~= 2 then
			LocalPlayer().hasUserVoted = true
			mediumVotes = mediumVotes + 1	
			net.Start("Diff_Vote")
				net.WriteInt(mediumVotes, 8)
				net.WriteInt(2, 8)
				net.WriteString(LocalPlayer():Nick())
			net.SendToServer()
			timer.Create("VoteTimer", 300, 1, function()
					LocalPlayer().hasUserVoted = false
					timer.Remove("VoteTimer")
					LocalPlayer():ChatPrint("You can now vote for a difficulty")
				end)
		elseif diff == 2 then
			LocalPlayer():ChatPrint("You are currently playing on that difficulty!")
			LocalPlayer().hasUserVoted = false
			timer.Remove("VoteTimer")
			mediumVotes = mediumVotes - 1
		else
			LocalPlayer():ChatPrint("You have already voted for a difficulty, please wait " .. math.ceil(timer.TimeLeft("VoteTimer")) .. " Seconds")
		end
		diffFrame:Close()
	end
	
	local HardButton = vgui.Create("DButton", diffFrame)
	HardButton:SetText("Hard")
	HardButton:SetSize(125, 50)
	HardButton:SetPos(165, 250)
	HardButton.DoClick = function()
		if not LocalPlayer().hasUserVoted and Diff ~= 3 then
			LocalPlayer().hasUserVoted = true
			hardVotes = hardVotes + 1
			net.Start("Diff_Vote")
				net.WriteInt(hardVotes, 8)
				net.WriteInt(3, 8)
				net.WriteString(LocalPlayer():Nick())
			net.SendToServer()
			timer.Create("VoteTimer", 300, 1, function()
				LocalPlayer().hasUserVoted = false
				timer.Remove("VoteTimer")
				LocalPlayer():ChatPrint("You can now vote for a difficulty")
			end)
		elseif diff == 3 then
			LocalPlayer():ChatPrint("You are currently playing on that difficulty!")
			LocalPlayer().hasUserVoted = false
			timer.Remove("VoteTimer")
			hardVotes = hardVotes - 1
		else
			LocalPlayer():ChatPrint("You have already voted for a difficulty, please wait " .. math.ceil(timer.TimeLeft("VoteTimer")) .. " Seconds")
		end
		diffFrame:Close()
	end
	
	local warningLabel = vgui.Create("DLabel", diffFrame)
	warningLabel:SetText("WARNING:")
	warningLabel:SetFont("Diff_Warning_Title_Font")
	warningLabel:SizeToContents()
	warningLabel:SetPos(165, 415)
	
	local warningMessage = vgui.Create("DLabel", diffFrame)
	warningMessage:SetFont("Diff_Warning_Font")
	warningMessage:SetText("Enabling this difficulty means\nif you die\nyou are out until next checkpoint\n\nIf everyone dies, the map restarts")
	warningMessage:SizeToContents()
	warningMessage:SetPos(35, 450)
	
	local survivalEnabled = vgui.Create("DLabel", diffFrame)
	survivalEnabled:SetFont("Diff_Warning_Font")
	if surv == 0 then
		survivalEnabled:SetText("'Survival Disabled'")
	elseif surv == 1 then
		survivalEnabled:SetText("'Survival Enabled'")
	end
	survivalEnabled:SizeToContents()
	survivalEnabled:SetPos(125, 625)
	
	local survivalButton = vgui.Create("DButton", diffFrame)
	survivalButton:SetText("Survival")
	survivalButton:SetSize(125, 50)
	survivalButton:SetPos(165, 675)
	survivalButton.DoClick = function()
		if not LocalPlayer().hasUserVoted then
			LocalPlayer().hasUserVoted = true
			survVotes = survVotes + 1
			net.Start("Diff_Vote")
				net.WriteInt(survVotes, 8)
				net.WriteInt(4, 8)
				net.WriteString(LocalPlayer():Nick())
			net.SendToServer()
			if not timer.Exists("VoteTimer") then
			timer.Create("VoteTimer", 300, 1, function()
				LocalPlayer().hasUserVoted = false
				timer.Remove("VoteTimer")
				LocalPlayer():ChatPrint("You can now vote for a difficulty")
			end)
		end
		else
			LocalPlayer():ChatPrint("You have already voted for a difficulty, please wait " .. math.ceil(timer.TimeLeft("VoteTimer")) .. " Seconds")
		end
		diffFrame:Close()
	end
end

net.Receive("Open_Diff_Menu", function()
	local diff = net.ReadInt(8)
	local surv = net.ReadInt(8)
	local easyReq = net.ReadInt(8)
	local medReq = net.ReadInt(8)
	local hardReq = net.ReadInt(8)
	local survReq = net.ReadInt(8)
	
	OpenDiffMenu(diff, surv, easyReq, medReq, hardReq, survReq)
end)