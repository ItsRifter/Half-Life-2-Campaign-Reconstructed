hook.Add("PlayerSay", "Commands", function(ply, text)
	if (string.lower(text) == "!ach" or string.lower(text) == "!achievement" ) then
		net.Start("Open_Ach_Menu")
		net.Send(ply)
		return ""
	end
	
	
	if (string.lower(text) == "!petsummon" or string.lower(text) == "!spawnpet" ) then
		ply:ChatPrint("Pets aren't in this yet... beg for sponer to add them next")
		return ""
	end
	
	if (string.lower(text) == "!diff" or string.lower(text) == "!difficulty" ) then
		net.Start("Open_Diff_Menu")
		net.Send(ply)
		return ""
	end
	
	if (string.lower(text) == "!unstuck") then
	ply:ChatPrint("Checking if you are stuck...")
		timer.Simple(5, function()
			if not ply:IsOnGround() and ply:GetSequence() != 199 and ply:GetSequence() != 122 then
				ply:ChatPrint("You appear to be stuck, Unstucking...")
				IsStuck(ply)
			else
				ply:ChatPrint("You don't appear to be stuck, if you really are ask an admin or commit suicide")
			end
		end)
		return ""
	end
end)

local difficulty = 1
local survivalMode = false

net.Receive("Diff_Change", function(len, ply)
	
	
	local diffValue = net.ReadInt(16)
	local startSurvival = false
	local currentPlayers = #player.GetAll()
	
	local requiredVotes = currentPlayers / 0.95
	local requiredVotesSurv = currentPlayers
	local votes = net.ReadInt(16)
	
	if not diffValue then return end
	
	if diffValue == 1 and difficulty != 1 then
		
		for k, v in pairs(player.GetAll()) do
			v:ChatPrint(ply:Nick() .. " has voted for 'Easy' difficulty: " .. votes .. "/" .. math.Round(requiredVotes, 0))
		end
		
	elseif diffValue == 2 and difficulty != 2 then
		
		for k, v in pairs(player.GetAll()) do
			v:ChatPrint(ply:Nick() .. " has voted for 'Medium' difficulty: " .. votes .. "/" .. math.Round(requiredVotes, 0))
		end
		
	elseif diffValue == 3 and difficulty != 3 then
		
		for k, v in pairs(player.GetAll()) do
			v:ChatPrint(ply:Nick() .. " has voted for 'Hard' difficulty: " .. votes .. "/" .. math.Round(requiredVotes, 0))
		end
		
	elseif diffValue == 4 and not survivalMode then
		
		for k, v in pairs(player.GetAll()) do
			v:ChatPrint(ply:Nick() .. " has voted to enable 'Survival' difficulty: " .. votes .. "/" .. requiredVotesSurv)
		end

		if survVotes >= requiredVotesSurv then
			startSurvival = true
		end
	elseif diffValue == 4 and survivalMode then
		
		for k, v in pairs(player.GetAll()) do
			v:ChatPrint(ply:Nick() .. " has voted to disable 'Survival' difficulty: " .. votes .. "/" .. requiredVotesSurv)
		end
		
		if survVotes >= requiredVotesSurv then
			startSurvival = false
		end
	
	elseif difficulty == diffValue then
		ply:ChatPrint("You are currently playing on that difficulty!")
		net.Start("RefreshVote")
		net.Send(ply)
	end
	
	if votes >= math.Round(requiredVotes, 0) and diffValue == 1 then
		difficulty = 1
		ply:ChatPrint("Difficulty has changed to 'Easy' difficulty")
		
		net.Start("RefreshVote")
			net.WriteString("Easy")
		net.Send(ply)
		GetConVar("hl2c_difficulty"):SetInt(1)
			
	elseif votes >= math.Round(requiredVotes, 0) and diffValue == 2 then
		difficulty = 2
		ply:ChatPrint("Difficulty has changed to 'Medium' difficulty: " )
		
		net.Start("RefreshVote")
			net.WriteString("Medium")
		net.Send(ply)
		GetConVar("hl2c_difficulty"):SetInt(2)
		
	elseif votes >= math.Round(requiredVotes, 0) and diffValue == 3 then		
		difficulty = 3	
		ply:ChatPrint("Difficulty has changed to 'Hard' difficulty")
		
		net.Start("RefreshVote")
			net.WriteString("Hard")
		net.Send(ply)
		GetConVar("hl2c_difficulty"):SetInt(3)
		
	elseif votes >= math.Round(requiredVotesSurv, 0) and diffValue == 4 and not survivalMode then	
		survivalMode = true
		ply:ChatPrint("Survival mode has been enabled")
		
	elseif votes >= math.Round(requiredVotesSurv, 0) and diffValue == 4 and survivalMode then
		survivalMode = false
		ply:ChatPrint("Survival mode has been disabled")

	end
end)

net.Receive("SetSuicide", function()
	GetConVar("hl2c_allowsuicide"):SetInt(net.ReadInt(16))
end)

net.Receive("AddCoins", function(len, ply, coin)
	local coins = net.ReadInt(16)
	ply.hl2cPersistent.Coins = ply.hl2cPersistent.Coins + coins
end)

