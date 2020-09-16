function SetDiffMode(diff)
	GetConVar("hl2cr_difficulty"):SetInt(diff)
end
local votes = 0
net.Receive("Diff_Vote", function(len, ply)
	votes = votes + net.ReadInt(8)
	local diffMode = net.ReadInt(8)
	local voter = net.ReadString()
	
	for k, p in pairs(player.GetAll()) do
		if diffMode == 1 then
			p:ChatPrint(voter .. " Has voted for 'Easy' difficulty: " .. votes .. "/" .. ply:GetNWInt("EasyVotes"))
		elseif diffMode == 2 then
			p:ChatPrint(voter .. " Has voted for 'Medium' difficulty: " .. votes .. "/" .. ply:GetNWInt("MediumVotes"))
		elseif diffMode == 3 then
			p:ChatPrint(voter .. " Has voted for 'Hard' difficulty: " .. votes .. "/" .. ply:GetNWInt("HardVotes"))
		elseif diffMode == 4 and GetConVar("hl2cr_survivalmode"):GetInt() == 0 then
			p:ChatPrint(voter .. " Has voted to enable 'Survival' mode: " .. votes .. "/" .. ply:GetNWInt("SurvVotes"))
		elseif diffMode == 4 and GetConVar("hl2cr_survivalmode"):GetInt() == 1 then
			p:ChatPrint(voter .. " Has voted to disable 'Survival' mode: " .. votes .. "/" .. ply:GetNWInt("SurvVotes"))
		end
	end

	
	if votes >= ply:GetNWInt("EasyVotes") and diffMode == 1 then
		diffVoted(1)
		votes = 0
	elseif votes >= ply:GetNWInt("MediumVotes") and diffMode == 2 then
		diffVoted(2)
		votes = 0
	elseif votes >= ply:GetNWInt("HardVotes") and diffMode == 3 then
		diffVoted(3)
		votes = 0
	elseif votes >= ply:GetNWInt("SurvVotes") and diffMode == 4 and GetConVar("hl2cr_survivalmode"):GetInt() == 0 then
		survivalVoted(1)
		votes = 0
	elseif votes >= ply:GetNWInt("SurvVotes") and diffMode == 4 and GetConVar("hl2cr_survivalmode"):GetInt() == 1 then
		survivalVoted(0)
		votes = 0
	end
end)

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
