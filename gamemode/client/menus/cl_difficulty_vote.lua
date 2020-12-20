local hasUserVoted = false

local easyVotes = 0
local mediumVotes = 0
local hardVotes = 0
local survVotes = 0

surface.CreateFont("Diff_Font", {
	font = "Arial",
	size = 22,
})

surface.CreateFont("Panel_Font", {
	font = "Arial",
	bold = true,
	size = 32,
})

surface.CreateFont("Button_Font", {
	font = "Arial",
	bold = true,
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

function OpenDiffMenu(diff, surv, special, doublehp)

	DIFF_MENU = Color(50, 50, 50)
	
	local diffFrame = vgui.Create("DFrame")
	diffFrame:SetSize(450, 750)
	diffFrame:Center()
	diffFrame:MakePopup()
	
	local diffSheet = vgui.Create( "DPropertySheet", diffFrame )
	diffSheet:Dock(FILL)
	
	local standardPanel = vgui.Create("DPanel", diffFrame)
	standardPanel.Paint = function(self, w, h)
		draw.RoundedBox( 4, 0, 0, w, h, DIFF_MENU) 
	end
	
	local curDiffTextLabel = vgui.Create("DLabel", standardPanel)
	curDiffTextLabel:SetText("Current Difficulty:")
	curDiffTextLabel:SetFont("Diff_Font")
	curDiffTextLabel:SizeToContents()
	curDiffTextLabel:SetPos(145, 55)
	
	local curDiffLabel = vgui.Create("DLabel", standardPanel)
	
	if diff == 1 then
		curDiffLabel:SetText("Easy")
	elseif diff == 2 then
		curDiffLabel:SetText("Medium")
	elseif diff == 3 then
		curDiffLabel:SetText("Hard")
	end
	curDiffLabel:SetFont("Diff_Font")
	curDiffLabel:SizeToContents()
	curDiffLabel:SetPos(190, 80)
	
	local easyButton = vgui.Create("DButton", standardPanel)
	easyButton:SetText("Easy")
	easyButton:SetFont("Button_Font")
	easyButton:SetSize(125, 50)
	easyButton:SetPos(150, 120)
	easyButton.DoClick = function()
		if not LocalPlayer().hasUserVoted and diff ~= 1 then
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
	
	local mediumButton = vgui.Create("DButton", standardPanel)
	mediumButton:SetText("Medium")
	mediumButton:SetFont("Button_Font")
	mediumButton:SetSize(125, 50)
	mediumButton:SetPos(150, 170)
	mediumButton.DoClick = function()
		if not LocalPlayer().hasUserVoted and diff ~= 2 then
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
	
	local HardButton = vgui.Create("DButton", standardPanel)
	HardButton:SetText("Hard")
	HardButton:SetFont("Button_Font")
	HardButton:SetSize(125, 50)
	HardButton:SetPos(150, 220)
	HardButton.DoClick = function()
		if not LocalPlayer().hasUserVoted and diff ~= 3 then
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
	
	local warningLabel = vgui.Create("DLabel", standardPanel)
	warningLabel:SetText("WARNING:")
	warningLabel:SetFont("Diff_Warning_Title_Font")
	warningLabel:SizeToContents()
	warningLabel:SetPos(150, 325)
	
	local warningMessage = vgui.Create("DLabel", standardPanel)
	warningMessage:SetFont("Diff_Warning_Font")
	warningMessage:SetText("Enabling this difficulty means\nif you die\nyou are out until next checkpoint\n\nIf everyone dies, the map restarts")
	warningMessage:SizeToContents()
	warningMessage:SetPos(35, 375)
	
	local survivalEnabled = vgui.Create("DLabel", standardPanel)
	survivalEnabled:SetFont("Diff_Warning_Font")
	if surv == 0 then
		survivalEnabled:SetText("'Survival Disabled'")
	elseif surv == 1 then
		survivalEnabled:SetText("'Survival Enabled'")
	end
	survivalEnabled:SizeToContents()
	survivalEnabled:SetPos(115, 525)
	
	local survivalButton = vgui.Create("DButton", standardPanel)
	survivalButton:SetText("Survival")
	survivalButton:SetFont("Button_Font")
	survivalButton:SetSize(125, 50)
	survivalButton:SetPos(150, 575)
	survivalButton.DoClick = function()
		if not LocalPlayer().hasUserVoted then
		if not LocalPlayer():Alive() then
			LocalPlayer():ChatPrint("You can't vote for this difficulty while dead!")
			return
		end
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
	
	diffSheet:AddSheet("Standard Difficulty", standardPanel, nil)

	local variantPanel = vgui.Create("DPanel", diffFrame)
	variantPanel.Paint = function(self, w, h)
		draw.RoundedBox( 4, 0, 0, w, h, DIFF_MENU) 
	end	
	
	local enabledOne = false
	local enabledTwo = false
	
	if special == 1 then
		enabledOne = true
	end
	
	if doublehp == 1 then
		enabledTwo = true
	end
	
	local varientText = vgui.Create("DLabel", variantPanel)
	varientText:SetText("Variant Voting System")
	varientText:SetFont("Panel_Font")
	varientText:SetPos(75, 0)
	varientText:SizeToContents()

	varientButtonOne = vgui.Create("DButton", variantPanel)
	varientButtonOne:SetSize(175, 50)
	varientButtonOne:SetPos(5, 50)
	varientButtonOne:SetFont("Button_Font")
	varientButtonOne:SetText("Special NPCs\n" .. tostring(enabledOne))
	varientButtonOne.DoClick = function()
		LocalPlayer().hasUserVotedVarOne = true
		net.Start("VarientVote")
			net.WriteString("SPECNPCS")
			net.WriteEntity(LocalPlayer())
		net.SendToServer()
		diffFrame:Close()
	end
	
	varientButtonTwo = vgui.Create("DButton", variantPanel)
	varientButtonTwo:SetSize(175, 50)
	varientButtonTwo:SetPos(5, 125)
	varientButtonTwo:SetFont("Button_Font")
	varientButtonTwo:SetText("Double NPC Health\n" .. tostring(enabledTwo))
	varientButtonTwo.DoClick = function()
		net.Start("VarientVote")
			net.WriteString("DOBNPCH")
			net.WriteEntity(LocalPlayer())
		net.SendToServer()
		diffFrame:Close()
	end
	
	local varientNote = vgui.Create("DLabel", variantPanel)
	varientNote:SetText("Variants will reset\nonce in the lobby")
	varientNote:SetFont("Panel_Font")
	varientNote:SetPos(5, 600)
	varientNote:SizeToContents()
	
	
	diffSheet:AddSheet("Variant Difficulty", variantPanel, nil)
end

net.Receive("Open_Diff_Menu", function()
	local diff = net.ReadInt(8)
	local surv = net.ReadInt(8)
	local special = net.ReadInt(8)
	local doublehp = net.ReadInt(8)
	
	OpenDiffMenu(diff, surv, special, doublehp)
end)

net.Receive("ResetVotes", function()
	if timer.Exists("VoteTimer") then
		timer.Remove("VoteTimer")
		LocalPlayer():ChatPrint("An admin has reset the vote timer, you may vote again")
		LocalPlayer().hasUserVoted = false
	end
	
	easyVotes = 0
	mediumVotes = 0
	hardVotes = 0
	survVotes = 0
end)