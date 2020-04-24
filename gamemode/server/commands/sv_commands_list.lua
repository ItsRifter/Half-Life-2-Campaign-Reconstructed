hook.Add("PlayerSay", "Commands", function(ply, text)
	if (string.lower(text) == "!ach" or string.lower(text) == "!achievement" ) then
		net.Start("Open_Ach_Menu")
		net.Send(ply)
		return ""
	end
	
	if (string.lower(text) == "!diff" or string.lower(text) == "!difficulty" ) then
		net.Start("Open_Diff_Menu")
			net.WriteInt(totalVotes, 16)
		net.Send(ply)
		return ""
	end
end)

net.Receive("Diff_Change", function(len, ply)
	local diffValue = net.ReadInt(16)
	local user = net.ReadString()
	local startSurvival = false
	
	if diffValue == 1 and difficulty != 1 and not hasVoted then
		
		totalVotes = totalVotes + 1
		ply:ChatPrint(user .. " has voted for 'Easy' difficulty")
		hasVoted = true
		
	elseif diffValue == 2 and difficulty != 2 and not hasVoted then
		
		totalVotes = totalVotes + 1
		ply:ChatPrint(user .. " has voted for 'Medium' difficulty")
		hasVoted = true
		
	elseif diffValue == 3 and difficulty != 3 and not hasVoted then
		
		totalVotes = totalVotes + 1
		ply:ChatPrint(user .. " has voted for 'Hard' difficulty")
		hasVoted = true
		
	elseif diffValue == 4 and not survivalMode and not hasVoted then
		
		totalVotes = totalVotes + 1
		ply:ChatPrint(user .. " has voted to enable 'Survival' difficulty")
		hasVoted = true
		if totalVotes >= requiredVotes then
			startSurvival = true
		end
	elseif diffValue == 4 and survivalMode and not hasVoted then
		
		totalVotes = totalVotes + 1
		ply:ChatPrint(user .. " has voted to disable 'Survival' difficulty")
		hasVoted = true
		if totalVotes >= requiredVotes then
			startSurvival = false
		end
		
	elseif difficulty == diffValue then
		ply:ChatPrint("You are currently playing on that difficulty!")
	elseif startSurvival then
		ply:ChatPrint("Survival mode is already active!")
	end
	
	if totalVotes >= requiredVotes then
		totalVotes = 0
		if diffValue == 1 and not startSurvival then
			difficulty = 1
			ply:ChatPrint("Difficulty has changed to 'Easy' difficulty")
		elseif diffValue == 2 and not startSurvival then
			difficulty = 2
			ply:ChatPrint("Difficulty has changed to 'Medium' difficulty")
		elseif diffValue == 3 and not startSurvival then
			difficulty = 3	
			ply:ChatPrint("Difficulty has changed to 'Hard' difficulty")
		elseif startSurvival then
			survivalMode = true
			ply:ChatPrint("Survival mode has been enabled")
		elseif not startSurvival then
			survivalMode = false
			ply:ChatPrint("Survival mode has been disabled")
		end
	
	end
end)

net.Receive("SetSuicide", function()
	GetConVar("hl2c_allowsuicide"):SetInt(net.ReadInt(16))
end)
