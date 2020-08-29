function SetDiffMode(diff)
	GetConVar("hl2cr_difficulty"):SetInt(diff)
end

net.Receive("Diff_Vote", function(len, ply)
	local votes = net.ReadInt(8)
	local requiredVotes = net.ReadInt(8)
	local diffMode = net.ReadInt(8)
	local voter = net.ReadString()
	
	for k, p in pairs(player.GetAll()) do
		if diffMode == 1 then
			p:ChatPrint(voter .. " Has voted for 'Easy' difficulty: " .. votes .. "/" .. requiredVotes)
		elseif diffMode == 2 then
			p:ChatPrint(voter .. " Has voted for 'Medium' difficulty: " .. votes .. "/" .. requiredVotes)
		elseif diffMode == 3 then
			p:ChatPrint(voter .. " Has voted for 'Hard' difficulty: " .. votes .. "/" .. requiredVotes)
		elseif diffMode == 4 and GetConVar("hl2cr_survivalmode"):GetInt() == 0 then
			p:ChatPrint(voter .. " Has voted to enable 'Survival' mode: " .. votes .. "/" .. requiredVotes)
		elseif diffMode == 4 and GetConVar("hl2cr_survivalmode"):GetInt() == 1 then
			p:ChatPrint(voter .. " Has voted to disable 'Survival' mode: " .. votes .. "/" .. requiredVotes)
		end
	end
end)

net.Receive("Diff_Change", function() 
	local diff = net.ReadInt(8)
	GetConVar("hl2cr_difficulty"):SetInt(diff)
end)

net.Receive("Survival", function()
	local surv = net.ReadInt(8)
	GetConVar("hl2cr_survivalmode"):SetInt(surv)
end)

function SetSurvMode(surv)
	GetConVar("hl2cr_survivalmode"):SetInt(surv)
end
