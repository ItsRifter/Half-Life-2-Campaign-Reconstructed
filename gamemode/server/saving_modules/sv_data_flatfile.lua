function CreateData(ply)
	local PlayerID = string.Replace(ply:SteamID(), ":", "!")
	
	-- Set default model
	ply:SetModel("models/player/Group01/male_07.mdl")
	
	-- Set some default settings. Also create its own field for all persistent data
	ply.hl2cPersistent = {}
	ply.hl2cPersistent.Name = ply:Nick()
	ply.hl2cPersistent.Level = 1
	ply.hl2cPersistent.DeathCount = 0
	ply.hl2cPersistent.KillCount = 0
	ply.hl2cPersistent.XP = 0
	ply.hl2cPersistent.MaxXP = 500
	ply.hl2cPersistent.Coins = 0
	ply.hl2cPersistent.Model = ply:GetModel()
	ply.hl2cPersistent.Milestone = 5
	ply.hl2cPersistent.Inventory = ""
	ply.hl2cPersistent.InvSpace = 16
	
	--Default pet settings
	ply.hl2cPersistent.PetName = ""
	ply.hl2cPersistent.PetXP = 0
	ply.hl2cPersistent.PetMaxXP = 100
	ply.hl2cPersistent.PetLevel = 1
	ply.hl2cPersistent.PetPoints = 0
	ply.hl2cPersistent.PetHP = 100
	ply.hl2cPersistent.PetStr = 0
	ply.hl2cPersistent.PetRegen = 0
	ply.hl2cPersistent.PetMaxLvl = 6
	ply.hl2cPersistent.PetStage = 0
	
	--Pet skills default settings
	ply.hl2cPersistent.PetSkills1 = 0
	ply.hl2cPersistent.PetSkills2 = 0
	ply.hl2cPersistent.PetSkills3 = 0
	ply.hl2cPersistent.PetSkills4 = 0
	ply.hl2cPersistent.PetSkills5 = 0
	ply.hl2cPersistent.PetSkills6 = 0
	ply.hl2cPersistent.PetSkills7 = 0
	ply.hl2cPersistent.PetSkills8 = 0
	ply.hl2cPersistent.PetSkills9 = 0
	ply.hl2cPersistent.PetSkills10 = 0

	-- Store all persistent data as JSON
	file.Write("hl2c_data/" .. PlayerID .. ".txt", util.TableToJSON(ply.hl2cPersistent, true))
	
	ply:SetNWString("Model", ply.hl2cPersistent.Model)
	
	ply:SetNWString("PetName", ply.hl2cPersistent.PetName)
	ply:SetNWInt("PetLevel", ply.hl2cPersistent.PetLevel)
	ply:SetNWInt("PetXP", math.Round(ply.hl2cPersistent.PetXP))
	ply:SetNWInt("PetMaxXP", ply.hl2cPersistent.PetMaxXP)
	ply:SetNWInt("PetStr", ply.hl2cPersistent.PetStr)
	ply:SetNWInt("PetHP", ply.hl2cPersistent.PetHP)
	ply:SetNWInt("PetRegen", ply.hl2cPersistent.PetRegen)
	
	ply:SetNWInt("PetStage", tonumber(ply.hl2cPersistent.PetStage))
	
	ply:SetNWString("Ach", table.concat(ply.hl2cPersistent.Achievements, " "))
	ply:SetNWString("Inventory", ply.hl2cPersistent.Inventory)
	ply:SetNWInt("InvSpace", ply.hl2cPersistent.InvSpace)
end

local function LoadData(ply)
	local PlayerID = string.Replace(ply:SteamID(), ":", "!")
	local jsonContent = file.Read("hl2c_data/" .. PlayerID .. ".txt", "DATA")
	if not jsonContent then return end

	-- Read persistent data from JSON
	ply.hl2cPersistent = util.JSONToTable(jsonContent)

	-- Init some maps, if they don't exist
	ply.hl2cPersistent.Achievements = ply.hl2cPersistent.Achievements or {}

	-- Init some networked variables
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
	ply:SetNWInt("PetXP", math.Round(ply.hl2cPersistent.PetXP))
	ply:SetNWInt("PetMaxXP", ply.hl2cPersistent.PetMaxXP)
	ply:SetNWInt("PetSkillPoints", ply.hl2cPersistent.PetPoints)
	ply:SetNWInt("PetStr", ply.hl2cPersistent.PetStr)
	ply:SetNWInt("PetHP", ply.hl2cPersistent.PetHP)
	ply:SetNWInt("PetSpd", ply.hl2cPersistent.PetSpd)
	
	ply:SetNWInt("PetSkill1", ply.hl2cPersistent.PetSkills1)
	ply:SetNWInt("PetSkill2", ply.hl2cPersistent.PetSkills2)
	ply:SetNWInt("PetSkill3", ply.hl2cPersistent.PetSkills3)
	ply:SetNWInt("PetSkill4", ply.hl2cPersistent.PetSkills4)
	ply:SetNWInt("PetSkill5", ply.hl2cPersistent.PetSkills5)
	ply:SetNWInt("PetSkill6", ply.hl2cPersistent.PetSkills6)
	ply:SetNWInt("PetSkill7", ply.hl2cPersistent.PetSkills7)
	ply:SetNWInt("PetSkill8", ply.hl2cPersistent.PetSkills8)
	ply:SetNWInt("PetSkill9", ply.hl2cPersistent.PetSkills9)
	ply:SetNWInt("PetSkill10", ply.hl2cPersistent.PetSkills10)
	
	ply:SetNWInt("PetStage", ply.hl2cPersistent.PetStage)
	
	-- Init player model and other stuff
	ply:SetModel(ply.hl2cPersistent.Model)

	return true -- Return true to signal that the settings could be loaded
end

local function SaveData(ply)
	local PlayerID = string.Replace(ply:SteamID(), ":", "!")

	-- Fetch some data, that wouldn't be updated otherwise
	ply.hl2cPersistent.Name = ply:Nick()
	ply.hl2cPersistent.Model = ply:GetModel()
	ply.hl2cPersistent.KillCount = ply.hl2cPersistent.KillCount + ply:Frags()

	-- Store all persistent data as JSON
	file.Write("hl2c_data/" .. PlayerID .. ".txt", util.TableToJSON(ply.hl2cPersistent, true))
	
	print("Save committed")
end

--function UpdateAchievements(ply)
--	print("Success")
--end

hook.Add("Initialize", "CreateDataFolder", function()
	if not file.IsDir( "hl2c_data", "DATA") then
		print("MISSING FOLDER: Making new one")
		file.CreateDir("hl2c_data", "DATA")
	end
end)

hook.Add("PlayerDisconnected", "SavePlayerDataDisconnect", function(ply) 
	SaveData(ply)
end)


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