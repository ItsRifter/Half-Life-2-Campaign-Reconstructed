local diff = 1
local surv = 0

function SetDiffMode(diff)
	GetConVar("hl2c_difficulty"):SetInt(diff)
	file.Write("hl2c_data/config.txt", "WARNING: Unless you know what you're doing, I suggest you leave this file\n")
	file.Append("hl2c_data/config.txt", "Difficulty: \n")
	file.Append("hl2c_data/config.txt", diff .. "\n")
	file.Append("hl2c_data/config.txt", "Survival Mode: \n")
	file.Append("hl2c_data/config.txt", GetConVar("hl2c_survivalmode"):GetInt() .. "\n")
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
		elseif diffMode == 4 and GetConVar("hl2c_survivalmode"):GetInt() == 0 then
			p:ChatPrint(voter .. " Has voted to enable 'Survival' mode: " .. votes .. "/" .. requiredVotes)
		elseif diffMode == 4 and GetConVar("hl2c_survivalmode"):GetInt() == 1 then
			p:ChatPrint(voter .. " Has voted to disable 'Survival' mode: " .. votes .. "/" .. requiredVotes)
		end
	end
end)

net.Receive("Diff_Change", function() 
	diff = net.ReadInt(8)
	GetConVar("hl2c_difficulty"):SetInt(diff)
	file.Write("hl2c_data/config.txt", "WARNING: Unless you know what you're doing, I suggest you leave this file\n")
	file.Append("hl2c_data/config.txt", "Difficulty: \n")
	file.Append("hl2c_data/config.txt", diff .. "\n")
	file.Append("hl2c_data/config.txt", "Survival Mode: \n")
	file.Append("hl2c_data/config.txt", GetConVar("hl2c_survivalmode"):GetInt() .. "\n")
end)

net.Receive("Survival", function()
	surv = net.ReadInt(8)
	GetConVar("hl2c_survivalmode"):SetInt(surv)
	file.Write("hl2c_data/config.txt", "WARNING: Unless you know what you're doing, I suggest you leave this file\n")
	file.Append("hl2c_data/config.txt", "Difficulty:\n")
	file.Append("hl2c_data/config.txt", GetConVar("hl2c_difficulty"):GetInt() .. "\n")
	file.Append("hl2c_data/config.txt", "Survival Mode:\n")
	file.Append("hl2c_data/config.txt", surv)
end)

function SetSurvMode(surv)
	GetConVar("hl2c_survivalmode"):SetInt(surv)
	file.Write("hl2c_data/config.txt", "WARNING: Unless you know what you're doing, I suggest you leave this file\n")
	file.Append("hl2c_data/config.txt", "Difficulty:\n")
	file.Append("hl2c_data/config.txt", GetConVar("hl2c_difficulty"):GetInt() .. "\n")
	file.Append("hl2c_data/config.txt", "Survival Mode:\n")
	file.Append("hl2c_data/config.txt", surv)
end
