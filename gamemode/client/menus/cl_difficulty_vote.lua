local hasUserVoted = false
local curDiff = "Easy"

local easyVotes = 0
local mediumVotes = 0
local hardVotes = 0
local survVotes = 0

net.Receive("RefreshVote", function()
	curDiff = net.ReadString()
end)

surface.CreateFont("Diff_Font", {
	font = "Arial",
	size = 22,

})

surface.CreateFont("Diff_Warning_Font", {
	font = "Arial",
	size = 28,

})

function OpenDiffMenu(ply)
	
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
	curDiffLabel:SetText(curDiff)
	curDiffLabel:SetFont("Diff_Font")
	curDiffLabel:SizeToContents()
	curDiffLabel:SetPos(200, 115)
	
	local easyButton = vgui.Create("DButton", diffFrame)
	easyButton:SetText("Easy")
	easyButton:SetSize(125, 50)
	easyButton:SetPos(165, 150)
	easyButton.DoClick = function()
		if not hasUserVoted then
			hasUserVoted = true
			easyVotes = easyVotes + 1
			net.Start("Diff_Change")
				net.WriteInt(1, 16)
				net.WriteInt(easyVotes, 16)
				net.SendToServer()
			timer.Create("VoteTimer", 300, 1, function()
				net.Start("Diff_Change")
				net.SendToServer()
				hasUserVoted = false
				timer.Remove("VoteTimer")
			end)
		else
			LocalPlayer():ChatPrint("You have already voted for a difficulty, please wait " .. math.ceil(timer.TimeLeft("VoteTimer")) .. " Seconds")
		end
		diffFrame:Close()
	end
	
	local mediumButton = vgui.Create("DButton", diffFrame)
	mediumButton:SetText("Medium")
	mediumButton:SetSize(125, 50)
	mediumButton:SetPos(165, 200)
	mediumButton.DoClick = function()
		if not hasUserVoted then
			hasUserVoted = true
			mediumVotes = mediumVotes + 1
			net.Start("Diff_Change")
				net.WriteInt(2, 16)
				net.WriteInt(mediumVotes, 16)
			net.SendToServer() 
			timer.Create("VoteTimer", 300, 1, function()
				hasUserVoted = false
				timer.Remove("VoteTimer")
			end)
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
		if not hasUserVoted then
			hasUserVoted = true
			hardVotes = hardVotes + 1
			net.Start("Diff_Change")
				net.WriteInt(3, 16)
				net.WriteInt(hardVotes, 16)
			net.SendToServer()
			timer.Create("VoteTimer", 300, 1, function()
				hasUserVoted = false
				timer.Remove("VoteTimer")
			end)
		else
			LocalPlayer():ChatPrint("You have already voted for a difficulty, please wait " .. math.ceil(timer.TimeLeft("VoteTimer")) .. " Seconds")
		end
		diffFrame:Close()
	end
	
	local warningLabel = vgui.Create("DLabel", diffFrame)
	warningLabel:SetText("WARNING:")
	warningLabel:SetFont("Diff_Warning_Font")
	warningLabel:SizeToContents()
	warningLabel:SetPos(165, 415)
	
	local warningMessage = vgui.Create("DLabel", diffFrame)
	warningMessage:SetText("Enabling this difficulty means if you die\nyou are out until next checkpoint\n\nIf everyone dies, the map restarts")
	warningMessage:SizeToContents()
	warningMessage:SetPos(145, 450)
	
	local survivalButton = vgui.Create("DButton", diffFrame)
	survivalButton:SetText("Survival")
	survivalButton:SetSize(125, 50)
	survivalButton:SetPos(165, 525)
	survivalButton.DoClick = function()
		if not hasUserVoted then
			hasUserVoted = true
			survVotes = survVotes + 1
			net.Start("Diff_Change")
				net.WriteInt(4, 16)
				net.WriteInt(survVotes, 16)
			net.SendToServer()
			if not timer.Exists("VoteTimer") then
			timer.Create("VoteTimer", 300, 1, function()
				LocalPlayer():ChatPrint("You can now vote again")
				hasUserVoted = false
				timer.Remove("VoteTimer")
			end)
		end
		else
			LocalPlayer():ChatPrint("You have already voted for a difficulty, please wait " .. math.ceil(timer.TimeLeft("VoteTimer")) .. " Seconds")
		end
		diffFrame:Close()
	end
end
net.Receive("Open_Diff_Menu", OpenDiffMenu)