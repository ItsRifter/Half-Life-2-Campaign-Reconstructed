local function InitData(ply)
	-- Create persistent data field in ply
	ply.hl2cPersistent = ply.hl2cPersistent or {}

	-- Set some default settings
	ply.hl2cPersistent.Name = ply.hl2cPersistent.Name or ply:Nick()
	ply.hl2cPersistent.Level = ply.hl2cPersistent.Level or 1
	ply.hl2cPersistent.DeathCount = ply.hl2cPersistent.DeathCount or 0
	ply.hl2cPersistent.KillCount = ply.hl2cPersistent.KillCount or 0
	
	--Default Stats
	
	ply.hl2cPersistent.XP = ply.hl2cPersistent.XP or 0
	ply.hl2cPersistent.MaxXP = ply.hl2cPersistent.MaxXP or 500
	ply.hl2cPersistent.Armour = ply.hl2cPersistent.Armour or 0
	
	ply.hl2cPersistent.Coins = ply.hl2cPersistent.Coins or 0
	ply.hl2cPersistent.Essence = ply.hl2cPersistent.Essence or 0
	ply.hl2cPersistent.Cryst = ply.hl2cPersistent.Cryst or 0
	ply.hl2cPersistent.TempUpg = ply.hl2cPersistent.TempUpg or ""
	
	ply.hl2cPersistent.Model = ply.hl2cPersistent.Model or ply:GetModel()
	
	-- Default Achievement, vortex and lambda settings
	ply.hl2cPersistent.Achievements = ply.hl2cPersistent.Achievements or {}
	ply.hl2cPersistent.Vortexes = ply.hl2cPersistent.Vortexes or {}
	ply.hl2cPersistent.Lambdas = ply.hl2cPersistent.Lambdas or {}
	
	-- Default Inventory settings
	ply.hl2cPersistent.Inventory = ply.hl2cPersistent.Inventory or {}
	ply.hl2cPersistent.InvSpace = ply.hl2cPersistent.InvSpace or 0
	ply.hl2cPersistent.MaxInvSpace = ply.hl2cPersistent.MaxInvSpace or 16
	ply.hl2cPersistent.Suit = ply.hl2cPersistent.Suit or ""
	ply.hl2cPersistent.Helmet = ply.hl2cPersistent.Helmet or ""
	ply.hl2cPersistent.Arm = ply.hl2cPersistent.Arm or ""
	
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
	ply:SetNWInt("Essence", math.Round(ply.hl2cPersistent.Essence))
	ply:SetNWInt("Cryst", math.Round(ply.hl2cPersistent.Cryst))
	ply:SetNWInt("Armour", ply.hl2cPersistent.Armour)
	
	ply:SetNWInt("XP", math.Round(ply.hl2cPersistent.XP))
	ply:SetNWInt("MaxXP", ply.hl2cPersistent.MaxXP)
	
	ply:SetNWString("Ach", table.concat(ply.hl2cPersistent.Achievements, " "))
	ply:SetNWString("Vortex", table.concat(ply.hl2cPersistent.Vortexes, " "))
	ply:SetNWString("TempUpg", ply.hl2cPersistent.TempUpg)
	
	ply:SetNWInt("InvSpace", ply.hl2cPersistent.InvSpace)
	ply:SetNWInt("MaxInvSpace", ply.hl2cPersistent.MaxInvSpace)
	ply:SetNWString("Model", ply.hl2cPersistent.Model)
	ply:SetNWInt("Kills", ply.hl2cPersistent.KillCount)
	ply:SetNWInt("Deaths", ply.hl2cPersistent.DeathCount)
	
	ply:SetNWString("SuitSlot", ply.hl2cPersistent.Suit)
	ply:SetNWString("HelmetSlot", ply.hl2cPersistent.Helmet)
	ply:SetNWString("ArmSlot", ply.hl2cPersistent.Arm)
	
	ply:SetNWInt("PetLevel", ply.hl2cPersistent.PetLevel)
	ply:SetNWString("PetName", ply.hl2cPersistent.PetName)
	ply:SetNWInt("PetXP", math.Round(ply.hl2cPersistent.PetXP))
	ply:SetNWInt("PetMaxXP", ply.hl2cPersistent.PetMaxXP)
	ply:SetNWInt("PetSkillPoints", ply.hl2cPersistent.PetPoints)
	ply:SetNWInt("PetStr", ply.hl2cPersistent.PetStr)
	ply:SetNWInt("PetHP", ply.hl2cPersistent.PetHP)
	ply:SetNWInt("PetSpd", ply.hl2cPersistent.PetSpd)
	ply:SetNWInt("PetRegen", ply.hl2cPersistent.PetRegen)
	ply:SetNWInt("PetStage", ply.hl2cPersistent.PetStage)
	
	ply:SetNWInt("PetSkill", ply.hl2cPersistent.PetSkills)
end

local function CreateData(ply)
	local PlayerID = string.Replace(ply:SteamID(), ":", "!")
	
	-- Set default model
	ply:SetModel("models/player/Group01/male_07.mdl")
	
	-- Create and init persistent data fields
	InitData(ply)
	
	-- Store all persistent data as JSON
	file.Write("hl2cr_data/" .. PlayerID .. ".txt", util.TableToJSON(ply.hl2cPersistent, true))
end

local function LoadData(ply)
	local PlayerID = string.Replace(ply:SteamID(), ":", "!")
	local jsonContent = file.Read("hl2cr_data/" .. PlayerID .. ".txt", "DATA")
	if not jsonContent then return false end

	-- Read persistent data from JSON
	ply.hl2cPersistent = util.JSONToTable(jsonContent)

	-- Init not set fields of persistent data
	InitData(ply)
	
	-- Init player model and other stuff
	ply:SetModel(ply.hl2cPersistent.Model)
	
	local easyRequired = math.ceil(#player.GetAll() / 2)
	local mediumRequired = math.ceil(#player.GetAll() / 2)
	local hardRequired = math.ceil(#player.GetAll() / 2)

	local survRequired = #player.GetAll()
	local neededVotes = #player.GetAll()
	local neededVotesRestart = #player.GetAll()

	for k, v in pairs(player.GetAll()) do
		v:SetNWInt("EasyVotes", easyRequired)
		v:SetNWInt("MediumVotes", mediumRequired)
		v:SetNWInt("HardVotes", hardRequired)
		v:SetNWInt("SurvVotes", survRequired)
		
		v:SetNWInt("RestartVotes", neededVotesRestart)
		v:SetNWInt("LobbyVotes", neededVotes)
	end

	return true -- Return true to signal that the settings could be loaded
end

local function SaveData(ply)
	local PlayerID = string.Replace(ply:SteamID(), ":", "!")

	-- Fetch some data, that wouldn't be updated otherwise
	ply.hl2cPersistent.Name = ply:Nick()
	ply.hl2cPersistent.Model = ply:GetModel()

	-- Store all persistent data as JSON
	file.Write("hl2cr_data/" .. PlayerID .. ".txt", util.TableToJSON(ply.hl2cPersistent, true))
	
end

--If there isn't a HL2CR data folder, create one
hook.Add("Initialize", "CreateDataFolder", function()
	if not file.IsDir( "hl2cr_data", "DATA") then
		print("MISSING HL2CR FOLDER: Making new one")
		file.CreateDir("hl2cr_data", "DATA")
	end
end)

--When the player disconnects, add kills and remove temporary upgrades (THIS SHOULDN'T HAPPEN ON SERVER CRASH)
hook.Add("PlayerDisconnected", "SavePlayerDataDisconnect", function(ply) 
	ply.hl2cPersistent.KillCount = ply.hl2cPersistent.KillCount + ply:Frags()
	ply.hl2cPersistent.TempUpg = ""
	ply:SetNWString("TempUpg", "")
	SaveData(ply)
	
	ply:SetNWString("SquadLeader", nil)
	ply:SetNWString("TeamName", "")
	
	local easyRequired = math.ceil(#player.GetAll() / 2)
	local mediumRequired = math.ceil(#player.GetAll() / 2)
	local hardRequired = math.ceil(#player.GetAll() / 2)

	local survRequired = #player.GetAll()
	local neededVotes = #player.GetAll()
	local neededVotesRestart = #player.GetAll()

	for k, v in pairs(player.GetAll()) do
		v:SetNWInt("EasyVotes", easyRequired)
		v:SetNWInt("MediumVotes", mediumRequired)
		v:SetNWInt("HardVotes", hardRequired)
		v:SetNWInt("SurvVotes", survRequired)
		
		v:SetNWInt("RestartVotes", neededVotesRestart)
		v:SetNWInt("LobbyVotes", neededVotes)
	end
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

net.Receive("Update_Model", function(len, ply) 
	local newModel = net.ReadString()
	ply:SetModel(newModel)
	ply:SetNWString("Model", newModel)
	ply:SetupHands()
end)