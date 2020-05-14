local hasUserVoted = false

local difficulty = 1
local survivalMode = false

local startSurvival = false

local easyVotes = 0
local mediumVotes = 0
local hardVotes = 0
local survVotes = 0

local easyRequired = tonumber(LocalPlayer():GetNWInt("diffEasy"))
local mediumRequired = tonumber(LocalPlayer():GetNWInt("diffMed"))
local hardRequired = tonumber(LocalPlayer():GetNWInt("diffHard"))
local survRequired = tonumber(LocalPlayer():GetNWInt("survDiff"))

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
			for k, v in pairs(player.GetAll()) do
				v:ChatPrint(LocalPlayer():Nick() .. " has voted for 'Easy' difficulty")
			end
			if easyVotes >= math.Round(easyRequired) then
				net.Start("Diff_Change")
					net.WriteInt(1, 8)
				net.SendToServer()
			end
			timer.Create("VoteTimer", 300, 1, function()
				hasUserVoted = false
				timer.Remove("VoteTimer")
				LocalPlayer():ChatPrint("You can now vote for a difficulty")
			end)
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
			for k, v in pairs(player.GetAll()) do
				v:ChatPrint(LocalPlayer():Nick() .. " has voted for 'Medium' difficulty")
			end
			if mediumVotes >= math.Round(mediumRequired) then
				net.Start("Diff_Change")
					net.WriteInt(2, 8)
				net.SendToServer()
			end
			timer.Create("VoteTimer", 300, 1, function()
					hasUserVoted = false
					timer.Remove("VoteTimer")
					LocalPlayer():ChatPrint("You can now vote for a difficulty")
				end)
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
			for k, v in pairs(player.GetAll()) do
				v:ChatPrint(LocalPlayer():Nick() .. " has voted for 'Hard' difficulty")
			end
			if hardVotes >= math.Round(hardRequired) then
				net.Start("Diff_Change")
					net.WriteInt(3, 8)
				net.SendToServer()
			end
			timer.Create("VoteTimer", 300, 1, function()
				hasUserVoted = false
				timer.Remove("VoteTimer")
				LocalPlayer():ChatPrint("You can now vote for a difficulty")
			end)
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
			if survivalMode then
				for k, v in pairs(player.GetAll()) do
					v:ChatPrint(LocalPlayer():Nick() .. " has voted to enable 'Survival' mode")
				end
				if survVotes >= math.Round(survRequired) then
					net.Start("Diff_Change")
						net.WriteInt(4, 8)
					net.SendToServer()
				end
			else
				for k, v in pairs(player.GetAll()) do
					v:ChatPrint(LocalPlayer():Nick() .. " has voted to disable 'Survival' mode")
				end
				if survVotes >= math.Round(survRequired) then
					net.Start("Diff_Change")
						net.WriteInt(4, 8)
					net.SendToServer()
				end
			end
			if not timer.Exists("VoteTimer") then
			timer.Create("VoteTimer", 300, 1, function()
				hasUserVoted = false
				timer.Remove("VoteTimer")
				LocalPlayer():ChatPrint("You can now vote for a difficulty")
			end)
		end
		else
			LocalPlayer():ChatPrint("You have already voted for a difficulty, please wait " .. math.ceil(timer.TimeLeft("VoteTimer")) .. " Seconds")
			diffFrame:Close()
		end
	end
end

net.Receive("Open_Diff_Menu", function()
	local diff = net.ReadInt(8)
	local surv = net.ReadInt(8)
	OpenDiffMenu(ply, diff, surv)
end)