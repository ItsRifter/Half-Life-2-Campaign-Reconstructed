function CreateData(ply)
	local PlayerID = string.Replace(ply:SteamID(), ":", "!")
	
	-- Set default model
	ply:SetModel("models/player/Group01/male_07.mdl")

	-- Set some default settings. Also create its own field for all persistent data
	ply.hl2cPersistent = {}
	ply.hl2cPersistent.Name = ply:Nick()
	ply.hl2cPersistent.Level = 1
	ply.hl2cPersistent.DeathCount = 0
	ply.hl2cPersistent.Model = ply:GetModel()
	-- Get all fields that should be stored
	local fields = {}
	for k, v in pairs(ply.hl2cPersistent) do
		table.insert(fields, k .. ": " .. v)
	end
	-- Store them delimited by a newline character
	file.Write("hl2c_data/" .. PlayerID .. ".txt", table.concat(fields, "\n"))
end

local function LoadData(ply)
	local PlayerID = string.Replace(ply:SteamID(), ":", "!")
	local content = file.Read("hl2c_data/" .. PlayerID .. ".txt", "DATA")
	if not content then return end
	local lines = string.Split(content, "\n")

	-- Create field for all persistent data
	ply.hl2cPersistent = {}

	-- Read line by line. And get key, value pairs. This will load the values directly into the player object
	for i, line in ipairs(lines) do
		key, val = line:match('^([^:]+): (.*)')
		ply.hl2cPersistent[key] = val
	end

	-- Init player model and other stuff
	ply:SetModel(ply.hl2cPersistent.Model)

	return true -- Return true to signal that the settings could be loaded
end

local function SaveData(ply)
	local PlayerID = string.Replace(ply:SteamID(), ":", "!")

	-- Fetch some data, that wouldn't be updated otherwise
	ply.hl2cPersistent.Name = ply:Nick()
	ply.hl2cPersistent.Model = ply:GetModel()

	-- Get all fields that should be stored
	local fields = {}
	for k, v in pairs(ply.hl2cPersistent) do
		table.insert(fields, k .. ": " .. v)
	end
	-- Store them delimited by a newline character
	file.Write("hl2c_data/" .. PlayerID .. ".txt", table.concat(fields, "\n"))
	
	print("Save committed")
end

hook.Add("Initialize", "CreateDataFolder", function()
	if not file.IsDir( "hl2c_data", "DATA") then
		print("MISSING FOLDER: Making new one")
		file.CreateDir("hl2c_data", "DATA")
	end
end)

hook.Add("PlayerDisconnected", "SavePlayerDataDisconnect", SaveData)

hook.Add( "ShutDown", "ChangeMapSave", function() 
	for _, ply in ipairs( player.GetAll() ) do
		SaveData(ply)
	end
end)

hook.Add("PlayerInitialSpawn", "NewPlayerCheck", function(ply)
	-- Try to load data, if that failed create a new file
	if not LoadData(ply) then
		CreateData(ply)
		net.Start("Greetings_new_player")
		net.Send(ply)
	end
	
	--Check if a staff joined
	StaffJoin(ply)
end)

hook.Add("PostPlayerDeath", "AddDeathCount", function(ply)
	ply.hl2cPersistent.DeathCount = ply.hl2cPersistent.DeathCount + 1
	print(ply:Nick() .. " has died about " .. ply.hl2cPersistent.DeathCount .. " times")
end)

net.Receive("Update_Model", function(len, ply) 
	local newModel = net.ReadString()
	ply:SetModel(newModel)
	ply:SetupHands()
end)