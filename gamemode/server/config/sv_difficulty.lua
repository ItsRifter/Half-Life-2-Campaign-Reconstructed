function SetDiffMode(diff)
	GetConVar("hl2cr_difficulty"):SetInt(diff)
end
local votes = 0
local varVotes = 0
local votingUser = nil
net.Receive("Diff_Vote", function(len, ply)
	votes = votes + net.ReadInt(8)
	local diffMode = net.ReadInt(8)
	local voter = net.ReadString()
	
	for k, p in pairs(player.GetAll()) do
		if diffMode == 1 then
			p:ChatPrint(voter .. " Has voted for 'Easy' difficulty: " .. votes .. "/" .. VOTE_REQUIRED["EasyVotes"])
			
		elseif diffMode == 2 then
			p:ChatPrint(voter .. " Has voted for 'Medium' difficulty: " .. votes .. "/" .. VOTE_REQUIRED["MediumVotes"])
			
		elseif diffMode == 3 then
			p:ChatPrint(voter .. " Has voted for 'Hard' difficulty: " .. votes .. "/" .. VOTE_REQUIRED["HardVotes"])
			
		elseif diffMode == 4 and GetConVar("hl2cr_survivalmode"):GetInt() == 0 then
			p:ChatPrint(voter .. " Has voted to enable 'Survival' mode: " .. votes .. "/" .. VOTE_REQUIRED["SurvVotes"])
			
		elseif diffMode == 4 and GetConVar("hl2cr_survivalmode"):GetInt() == 1 then
			p:ChatPrint(voter .. " Has voted to disable 'Survival' mode: " .. votes .. "/" .. VOTE_REQUIRED["SurvVotes"])
		end
	end

	
	if votes >= VOTE_REQUIRED["EasyVotes"] and diffMode == 1 then
		diffVoted(1)
		VOTE_REQUIRED["EasyVotes"] = 0
	elseif votes >= VOTE_REQUIRED["MediumVotes"] and diffMode == 2 then
		diffVoted(2)
		VOTE_REQUIRED["MediumVotes"] = 0
	elseif votes >= VOTE_REQUIRED["HardVotes"] and diffMode == 3 then
		diffVoted(3)
		VOTE_REQUIRED["HardVotes"] = 0
	elseif votes >= VOTE_REQUIRED["SurvVotes"] and diffMode == 4 and GetConVar("hl2cr_survivalmode"):GetInt() == 0 then
		survivalVoted(1)
		VOTE_REQUIRED["SurvVotes"] = 0
	elseif votes >= VOTE_REQUIRED["SurvVotes"] and diffMode == 4 and GetConVar("hl2cr_survivalmode"):GetInt() == 1 then
		survivalVoted(0)
		VOTE_REQUIRED["SurvVotes"] = 0
	end
end)

net.Receive("VarientVote", function()
	local diffVar = net.ReadString()
	local voter = net.ReadEntity()
	varVotes = varVotes + 1
	
	if voter.votingUser == diffVar then 
		voter:ChatPrint("You have already voted for this variant")
		return
	end
	
	voter.votingUser = diffVar
	
	for k, p in pairs(player.GetAll()) do
		if diffVar == "SPECNPCS" and GetConVar("hl2cr_specials"):GetInt() == 0 then
			p:ChatPrint(voter:Nick() .. " Has voted to enable difficulty variant: 'Special NPCs' " .. varVotes .. "/" .. DIFFVAR_VOTE_REQUIRED["Special"])
		elseif diffVar == "SPECNPCS" and GetConVar("hl2cr_specials"):GetInt() == 1 then
			p:ChatPrint(voter:Nick() .. " Has voted to disable difficulty variant: 'Special NPCs' " .. varVotes .. "/" .. DIFFVAR_VOTE_REQUIRED["Special"])
		end
		
		if diffVar == "DOBNPCH" and GetConVar("hl2cr_doublehp"):GetInt() == 0 then
			p:ChatPrint(voter:Nick() .. " Has voted to enable difficulty variant: 'Double NPC Health' " .. varVotes .. "/" .. DIFFVAR_VOTE_REQUIRED["DoubleHP"])
		elseif diffVar == "DOBNPCH" and GetConVar("hl2cr_doublehp"):GetInt() == 1 then
			p:ChatPrint(voter:Nick() .. " Has voted to disable difficulty variant: 'Double NPC Health' " .. varVotes .. "/" .. DIFFVAR_VOTE_REQUIRED["DoubleHP"])
		end
	end
	
	if varVotes >= DIFFVAR_VOTE_REQUIRED["Special"] and diffVar == "SPECNPCS" and GetConVar("hl2cr_specials"):GetInt() == 0 then
		diffVarVoted("Special", 1)
		varVotes = 0
	elseif varVotes >= DIFFVAR_VOTE_REQUIRED["Special"] and diffVar == "SPECNPCS" and  GetConVar("hl2cr_specials"):GetInt() == 1 then
		diffVarVoted("Special", 0)
		varVotes = 0
	elseif varVotes >= DIFFVAR_VOTE_REQUIRED["DoubleHP"] and diffVar == "DOBNPCH" and GetConVar("hl2cr_doublehp"):GetInt() == 0 then
		diffVarVoted("DoubleHP", 1)
		varVotes = 0
	elseif varVotes >= DIFFVAR_VOTE_REQUIRED["DoubleHP"] and diffVar == "DOBNPCH" and GetConVar("hl2cr_doublehp"):GetInt() == 1 then
		diffVarVoted("DoubleHP", 0)
		varVotes = 0
	end
end)

function diffVarVoted(varMode, setting)
	if varMode == "Special" then
		GetConVar("hl2cr_specials"):SetInt(setting)
		DIFFVAR_VOTE_REQUIRED["Special"] = 0
	elseif varMode == "DoubleHP" then
		GetConVar("hl2cr_doublehp"):SetInt(setting)
		DIFFVAR_VOTE_REQUIRED["DoubleHP"] = 0
	end
	
	for k, v in pairs(player.GetAll()) do
		v.votingUser = nil
	end
end

function diffVoted(mode)
	GetConVar("hl2cr_difficulty"):SetInt(mode)
end

function survivalVoted(surv)
	GetConVar("hl2cr_survivalmode"):SetInt(surv)
end

function SetSurvMode(surv)
	GetConVar("hl2cr_survivalmode"):SetInt(surv)
end

--[[ D3's version (incase something goes wrong)
local votes = votes or {}
net.Receive("Diff_Vote", function(len, ply)
	local diffMode = net.ReadInt(8)

	votes[ply:SteamID()] = {diffMode = diffMode}

	local diffModes = {}
	for p, vote in pairs(votes) do
		diffModes[vote.diffMode] = diffModes[vote.diffMode] + 1
	end

	-- Iterate over all diff modes and check if there are enough votes for a single difficulty
end)
--]]
