local function InitData(ply)
	-- Create persistent data field in ply
	ply.hl2cPersistent = ply.hl2cPersistent or {}

	-- Set some default settings
	ply.hl2cPersistent.Name = ply.hl2cPersistent.Name or ply:Nick()
	ply.hl2cPersistent.Level = ply.hl2cPersistent.Level or 1
	ply.hl2cPersistent.DeathCount = ply.hl2cPersistent.DeathCount or 0
	ply.hl2cPersistent.KillCount = ply.hl2cPersistent.KillCount or 0
	ply.hl2cPersistent.XP = ply.hl2cPersistent.XP or 0
	ply.hl2cPersistent.MaxXP = ply.hl2cPersistent.MaxXP or 500
	ply.hl2cPersistent.Coins = ply.hl2cPersistent.Coins or 0
	ply.hl2cPersistent.Model = ply.hl2cPersistent.Model or ply:GetModel()
	ply.hl2cPersistent.Milestone = ply.hl2cPersistent.Milestone or 5
	ply.hl2cPersistent.Achievements = ply.hl2cPersistent.Achievements or {}
	ply.hl2cPersistent.Inventory = ply.hl2cPersistent.Inventory or ""
	ply.hl2cPersistent.InvSpace = ply.hl2cPersistent.InvSpace or 16
	
	-- Default pet settings
	ply.hl2cPersistent.PetName = ply.hl2cPersistent.PetName or ""
	ply.hl2cPersistent.PetXP = ply.hl2cPersistent.PetXP or 0
	ply.hl2cPersistent.PetMaxXP = ply.hl2cPersistent.PetMaxXP or 100
	ply.hl2cPersistent.PetLevel = ply.hl2cPersistent.PetLevel or 1
	ply.hl2cPersistent.PetPoints = ply.hl2cPersistent.PetPoints or 0
	ply.hl2cPersistent.PetHP = ply.hl2cPersistent.PetHP or 100
	ply.hl2cPersistent.PetStr = ply.hl2cPersistent.PetStr or 0
	ply.hl2cPersistent.PetRegen = ply.hl2cPersistent.PetRegen or 0
	ply.hl2cPersistent.PetMaxLvl = ply.hl2cPersistent.PetMaxLvl or 6
	ply.hl2cPersistent.PetStage = ply.hl2cPersistent.PetStage or 0
	
	-- Pet skills default settings
	ply.hl2cPersistent.PetSkills = ply.hl2cPersistent.PetSkills or 0

	-- Also set/create networked variables
	ply:SetNWInt("Level", ply.hl2cPersistent.Level)
	ply:SetNWInt("Coins", math.Round(ply.hl2cPersistent.Coins))
	ply:SetNWInt("XP", math.Round(ply.hl2cPersistent.XP))
	ply:SetNWInt("MaxXP", ply.hl2cPersistent.MaxXP)
	ply:SetNWInt("Milestone", ply.hl2cPersistent.Milestone)
	ply:SetNWString("Ach", table.concat(ply.hl2cPersistent.Achievements, " "))
	ply:SetNWString("Inventory", ply.hl2cPersistent.Inventory)
	ply:SetNWInt("InvSpace", ply.hl2cPersistent.InvSpace)
	ply:SetNWString("Model", ply.hl2cPersistent.Model)
	ply:SetNWInt("Kills", ply.hl2cPersistent.KillCount)
	ply:SetNWInt("Deaths", ply.hl2cPersistent.DeathCount)
	
	ply:SetNWInt("PetLevel", ply.hl2cPersistent.PetLevel)
	ply:SetNWString("PetName", ply.hl2cPersistent.PetName)
	ply:SetNWInt("PetXP", math.Round(ply.hl2cPersistent.PetXP))
	ply:SetNWInt("PetMaxXP", ply.hl2cPersistent.PetMaxXP)
	ply:SetNWInt("PetSkillPoints", ply.hl2cPersistent.PetPoints)
	ply:SetNWInt("PetStr", ply.hl2cPersistent.PetStr)
	ply:SetNWInt("PetHP", ply.hl2cPersistent.PetHP)
	ply:SetNWInt("PetSpd", ply.hl2cPersistent.PetSpd)
	ply:SetNWInt("PetRegen", ply.hl2cPersistent.PetRegen)
	ply:SetNWInt("PetStage", tonumber(ply.hl2cPersistent.PetStage))
	
	ply:SetNWInt("PetSkill", ply.hl2cPersistent.PetSkills)
end

local function CreateData(ply)
	local PlayerID = string.Replace(ply:SteamID(), ":", "!")
	
	-- Set default model
	ply:SetModel("models/player/Group01/male_07.mdl")
	
	-- Create and init persistent data fields
	InitData(ply)
	
	-- Store all persistent data as JSON
	file.Write("hl2c_data/" .. PlayerID .. ".txt", util.TableToJSON(ply.hl2cPersistent, true))
end

local function LoadData(ply)
	local PlayerID = string.Replace(ply:SteamID(), ":", "!")
	local jsonContent = file.Read("hl2c_data/" .. PlayerID .. ".txt", "DATA")
	if not jsonContent then return false end

	-- Read persistent data from JSON
	ply.hl2cPersistent = util.JSONToTable(jsonContent)

	-- Init not set fields of persistent data
	InitData(ply)
	
	-- Init player model and other stuff
	ply:SetModel(ply.hl2cPersistent.Model)

	return true -- Return true to signal that the settings could be loaded
end

local function SaveData(ply)
	local PlayerID = string.Replace(ply:SteamID(), ":", "!")

	-- Fetch some data, that wouldn't be updated otherwise
	ply.hl2cPersistent.Name = ply:Nick()
	ply.hl2cPersistent.Model = ply:GetModel()

	-- Store all persistent data as JSON
	file.Write("hl2c_data/" .. PlayerID .. ".txt", util.TableToJSON(ply.hl2cPersistent, true))
	
	print("Save committed")
end

--If there isn't a HL2CR data folder, create one
hook.Add("Initialize", "CreateDataFolder", function()
	if not file.IsDir( "hl2c_data", "DATA") then
		print("MISSING FOLDER: Making new one")
		file.CreateDir("hl2c_data", "DATA")
	end
end)

hook.Add("PlayerDisconnected", "SavePlayerDataDisconnect", function(ply) 
	ply.hl2cPersistent.KillCount = ply.hl2cPersistent.KillCount + ply:Frags()
	SaveData(ply)
end)


hook.Add( "ShutDown", "ChangeMapSave", function() 
	for _, ply in ipairs( player.GetAll() ) do
		ply.hl2cPersistent.KillCount = ply.hl2cPersistent.KillCount + ply:Frags()
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
end)

hook.Add("PostPlayerDeath", "AddDeathCount", function(ply)
	ply.hl2cPersistent.DeathCount = ply.hl2cPersistent.DeathCount + 1
end)

net.Receive("Purchase", function(len, ply)
	ply.hl2cPersistent.Coins = ply.hl2cPersistent.Coins - net.ReadInt(32)
	ply.hl2cPersistent.Inventory = ply.hl2cPersistent.Inventory .. " " .. net.ReadString()
	ply:SetNWInt("Coins", math.Round(ply.hl2cPersistent.Coins))
	ply:SetNWString("Inventory", ply.hl2cPersistent.Inventory)
end)

net.Receive("Update_Model", function(len, ply) 
	local newModel = net.ReadString()
	ply:SetModel(newModel)
	ply:SetNWString("Model", newModel)
	ply:SetupHands()
end)