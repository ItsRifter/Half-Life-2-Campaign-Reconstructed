local hasUserVoted = false

local difficulty = 1
local survivalMode = false

local startSurvival = false

local easyVotes = 0
local mediumVotes = 0
local hardVotes = 0
local survVotes = 0

local requiredVotesEasy = #player.GetAll() / 2
local requiredVotesMedium = #player.GetAll() / 2
local requiredVotesHard = #player.GetAll() / 2
local requiredVotesSurv = #player.GetAll()
surface.CreateFont("Diff_Font", {
	font = "Arial",
	size = 22,

})

surface.CreateFont("Diff_Warning_Font", {
	font = "Arial",
	size = 28,

})

function OpenDiffMenu(ply, diff, surv)

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
		if not hasUserVoted and Diff != 1 then
			hasUserVoted = true
			easyVotes = easyVotes + 1			
			net.Start("Diff_Vote")
				net.WriteString(tostring(LocalPlayer()))
				net.WriteInt(1, 8)
			net.SendToServer(LocalPlayer())
			timer.Create("VoteTimer", 300, 1, function()
				hasUserVoted = false
				timer.Remove("VoteTimer")
				LocalPlayer():ChatPrint("You can now vote for a difficulty")
			end)
			if easyVotes >= math.Round(requiredVotesEasy) then
				LocalPlayer():ChatPrint("Difficulty has changed to 'Easy' difficulty")
				net.Start("Diff_Change")
					net.WriteInt(1, 8)
				net.SendToServer()
				easyVotes = 0
			end
		elseif hasUserVoted then
			LocalPlayer():ChatPrint("You have already voted for a difficulty, please wait " .. math.ceil(timer.TimeLeft("VoteTimer")) .. " Seconds")
		elseif diff == 1 then
			LocalPlayer():ChatPrint("You are currently playing on that difficulty!")
			hasUserVoted = false
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
		if not hasUserVoted and Diff != 2 then
			hasUserVoted = true
			mediumVotes = mediumVotes + 1
			net.Start("Diff_Vote")
				net.WriteString(tostring(LocalPlayer()))
				net.WriteString("Medium")
				net.WriteInt(mediumVotes, 8)
			net.SendToServer()			
			timer.Create("VoteTimer", 300, 1, function()
				hasUserVoted = false
				timer.Remove("VoteTimer")
				LocalPlayer():ChatPrint("You can now vote for a difficulty")
			end)
			if mediumVotes >= math.Round(requiredVotesMedium)then
				LocalPlayer():ChatPrint("Difficulty has changed to 'Medium' difficulty")
				net.Start("Diff_Change")
					net.WriteInt(2, 8)
				net.SendToServer()
				mediumVotes = 0
			end
		elseif diff == 2 then
			LocalPlayer():ChatPrint("You are currently playing on that difficulty!")
			hasUserVoted = false
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
		if not hasUserVoted and Diff != 3 then
			hasUserVoted = true
			hardVotes = hardVotes + 1
			net.Start("Diff_Vote")
				net.WriteString(tostring(LocalPlayer()))
				net.WriteString("Hard")
				net.WriteInt(hardVotes, 8)
				net.WriteInt(3, 8)
			net.SendToServer()
			timer.Create("VoteTimer", 300, 1, function()
				hasUserVoted = false
				timer.Remove("VoteTimer")
				LocalPlayer():ChatPrint("You can now vote for a difficulty")
			end)
			if hardVotes >= math.Round(requiredVotesHard)then		
				LocalPlayer():ChatPrint("Difficulty has changed to 'Hard' difficulty")
				net.Start("Diff_Change")
					net.WriteInt(3, 8)
				net.SendToServer()
				hardVotes = 0
			end
		elseif diff == 3 then
			LocalPlayer():ChatPrint("You are currently playing on that difficulty!")
			hasUserVoted = false
			timer.Remove("VoteTimer")
			hardVotes = hardVotes - 1
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
			net.Start("Diff_Vote")
				net.WriteString(tostring(LocalPlayer()))
				net.WriteString("Survival")
				net.WriteInt(survVotes, 8)
			net.SendToServer()
			if survivalMode then
				d:ChatPrint(LocalPlayer():Nick() .. " has voted to enable 'Survival' mode")
			else
				d:ChatPrint(LocalPlayer():Nick() .. " has voted to disable 'Survival' mode")
			end
				if not timer.Exists("VoteTimer") then
				timer.Create("VoteTimer", 300, 1, function()
					hasUserVoted = false
					timer.Remove("VoteTimer")
					LocalPlayer():ChatPrint("You can now vote for a difficulty")
				end)
			end
			if survVotes >= math.Round(requiredVotesSurv) and surv == 0 then	
				survivalMode = true
				net.Start("Survival")
					net.WriteInt(1, 8)
				net.SendToServer()
				LocalPlayer():ChatPrint("Survival mode has been enabled")
			elseif survVotes >= math.Round(requiredVotesSurv) and surv == 1 then
				survivalMode = false
				net.Start("Survival")
					net.WriteInt(0, 8)
				net.SendToServer()
				LocalPlayer():ChatPrint("Survival mode has been disabled")
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
	OpenDiffMenu(ply, diff, surv)
end)