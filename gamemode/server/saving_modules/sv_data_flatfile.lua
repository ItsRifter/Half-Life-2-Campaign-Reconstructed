local function InitData(ply)
	-- Create persistent data field in ply
	ply.hl2cPersistent = ply.hl2cPersistent or {}

	-- Set some default settings
	ply.hl2cPersistent.Name = ply.hl2cPersistent.Name or ply:Nick()
	ply.hl2cPersistent.Level = ply.hl2cPersistent.Level or 1
	ply.hl2cPersistent.Prestige = ply.hl2cPersistent.Prestige or 0
	ply.hl2cPersistent.LevelCap = ply.hl2cPersistent.LevelCap or 20
	ply.hl2cPersistent.DeathCount = ply.hl2cPersistent.DeathCount or 0
	ply.hl2cPersistent.KillCount = ply.hl2cPersistent.KillCount or 0
	
	--Default Stats
	ply.hl2cPersistent.XP = ply.hl2cPersistent.XP or 0
	ply.hl2cPersistent.MaxXP = ply.hl2cPersistent.MaxXP or 500
	ply.hl2cPersistent.Armour = ply.hl2cPersistent.Armour or 0
	
	ply.hl2cPersistent.Coins = ply.hl2cPersistent.Coins or 0
	ply.hl2cPersistent.Essence = ply.hl2cPersistent.Essence or 0
	ply.hl2cPersistent.Cryst = ply.hl2cPersistent.Cryst or 0
	ply.hl2cPersistent.ScrapMetal = ply.hl2cPersistent.ScrapMetal or 0
	ply.hl2cPersistent.TempUpg = ply.hl2cPersistent.TempUpg or {}
	ply.hl2cPersistent.PermUpg = ply.hl2cPersistent.PermUpg or {}
	
	ply.hl2cPersistent.Model = ply.hl2cPersistent.Model or "models/player/Group01/male_07.mdl"
	
	-- Default Achievement, vortex and lambda settings
	ply.hl2cPersistent.Achievements = ply.hl2cPersistent.Achievements or {}
	ply.hl2cPersistent.Vortexes = ply.hl2cPersistent.Vortexes or {}
	ply.hl2cPersistent.Vortexes.EP1 = ply.hl2cPersistent.Vortexes.EP1 or {}
	ply.hl2cPersistent.Vortexes.EP2 = ply.hl2cPersistent.Vortexes.EP2 or {}
	ply.hl2cPersistent.Lambdas = ply.hl2cPersistent.Lambdas or {}
	
	-- Default Inventory settings
	ply.hl2cPersistent.Inventory = ply.hl2cPersistent.Inventory or {}
	ply.hl2cPersistent.InvSpace = ply.hl2cPersistent.InvSpace or 0
	ply.hl2cPersistent.MaxInvSpace = ply.hl2cPersistent.MaxInvSpace or 16
	
	ply.hl2cPersistent.Helmet = ply.hl2cPersistent.Helmet or ""
	ply.hl2cPersistent.Suit = ply.hl2cPersistent.Suit or ""
	ply.hl2cPersistent.Arm = ply.hl2cPersistent.Arm or ""
	ply.hl2cPersistent.Hands = ply.hl2cPersistent.Hands or ""
	ply.hl2cPersistent.Boot = ply.hl2cPersistent.Boot or ""
	ply.hl2cPersistent.InvWeapon = ply.hl2cPersistent.InvWeapon or ""
	
	ply.hl2cPersistent.HelmetImage = ply.hl2cPersistent.HelmetImage or ""
	ply.hl2cPersistent.SuitImage = ply.hl2cPersistent.SuitImage or ""
	ply.hl2cPersistent.ArmImage = ply.hl2cPersistent.ArmImage or ""
	ply.hl2cPersistent.HandsImage = ply.hl2cPersistent.HandsImage or ""
	ply.hl2cPersistent.BootImage = ply.hl2cPersistent.BootImage or ""
	ply.hl2cPersistent.InvWeaponImage = ply.hl2cPersistent.InvWeaponImage or ""
	
	ply.hl2cPersistent.OldHelmet = ply.hl2cPersistent.OldHelmet or 0
	ply.hl2cPersistent.OldSuit = ply.hl2cPersistent.OldSuit or 0
	ply.hl2cPersistent.OldArm = ply.hl2cPersistent.OldArm or 0
	ply.hl2cPersistent.OldHands = ply.hl2cPersistent.OldHands or 0
	ply.hl2cPersistent.OldBoot = ply.hl2cPersistent.OldBoot or 0

	-- Default pet settings
	ply.hl2cPersistent.PetName = ply.hl2cPersistent.PetName or ""
	ply.hl2cPersistent.PetXP = ply.hl2cPersistent.PetXP or 0
	ply.hl2cPersistent.PetMaxXP = ply.hl2cPersistent.PetMaxXP or 50
	ply.hl2cPersistent.PetLevel = ply.hl2cPersistent.PetLevel or 1
	ply.hl2cPersistent.PetPoints = ply.hl2cPersistent.PetPoints or 0
	ply.hl2cPersistent.PetHP = ply.hl2cPersistent.PetHP or 100
	ply.hl2cPersistent.PetStr = ply.hl2cPersistent.PetStr or 0
	ply.hl2cPersistent.PetRegen = ply.hl2cPersistent.PetRegen or 0
	ply.hl2cPersistent.PetMaxLvl = ply.hl2cPersistent.PetMaxLvl or 30
	ply.hl2cPersistent.PetIntendedLvl = ply.hl2cPersistent.PetIntendedLvl or 6
	ply.hl2cPersistent.PetStage = ply.hl2cPersistent.PetStage or 0
	
	-- Pet skills default settings
	ply.hl2cPersistent.PetSkills = ply.hl2cPersistent.PetSkills or 0

	--OTF 
	ply.hl2cPersistent.OTF = ply.hl2cPersistent.OTF or false
	ply.hl2cPersistent.HardOTF = ply.hl2cPersistent.HardOTF or false
	
	--Customizable Settings
	ply.hl2cPersistent.Options = {}
	ply.hl2cPersistent.Options.QuickInfo = ply.hl2cPersistent.Options.QuickInfo or 0
	
	ply.hl2cPersistent.NPCColourEnabled = ply.hl2cPersistent.NPCColourEnabled or true
	ply.hl2cPersistent.NPCColourSettings = ply.hl2cPersistent.NPCColourSettings or Color(255, 255, 255, 255)
	ply.hl2cPersistent.NPCFont = ply.hl2cPersistent.NPCFont or "Default"
	
	--Events
	ply.hl2cPersistent.EventItems = ply.hl2cPersistent.EventItems or 0
 	
	--Ach Progress
	ply.hl2cPersistent.AchProgress = ply.hl2cPersistent.AchProgress or {}
	ply.hl2cPersistent.AchProgress.CrowbarKiller = ply.hl2cPersistent.AchProgress.CrowbarKiller or 0
	ply.hl2cPersistent.AchProgress.CombineKiller = ply.hl2cPersistent.AchProgress.CombineKiller or 0
	ply.hl2cPersistent.AchProgress.ZombieKiller = ply.hl2cPersistent.AchProgress.ZombieKiller or 0
	
	--Squads
	ply.hl2cPersistent.SquadLeader = ply.hl2cPersistent.SquadLeader or false
	
	-- Also set/create networked variables
	ply:SetNWInt("Level", ply.hl2cPersistent.Level)
	ply:SetNWInt("Prestige", ply.hl2cPersistent.Prestige)
	
	ply:SetNWInt("Coins", math.Round(ply.hl2cPersistent.Coins))
	ply:SetNWInt("Essence", math.Round(ply.hl2cPersistent.Essence))
	ply:SetNWInt("Cryst", math.Round(ply.hl2cPersistent.Cryst))
	ply:SetNWInt("Armour", ply.hl2cPersistent.Armour)
	
	ply:SetNWInt("XP", math.Round(ply.hl2cPersistent.XP))
	ply:SetNWInt("Scrap", ply.hl2cPersistent.ScrapMetal)
	ply:SetNWInt("MaxXP", ply.hl2cPersistent.MaxXP)
	
	ply:SetNWInt("InvSpace", ply.hl2cPersistent.InvSpace)
	ply:SetNWInt("MaxInvSpace", ply.hl2cPersistent.MaxInvSpace)
	ply:SetNWString("Model", ply.hl2cPersistent.Model)
	ply:SetNWInt("Kills", ply.hl2cPersistent.KillCount)
	ply:SetNWInt("Deaths", ply.hl2cPersistent.DeathCount)
	
	ply:SetNWString("HelmetSlot", ply.hl2cPersistent.HelmetImage)
	ply:SetNWString("SuitSlot", ply.hl2cPersistent.SuitImage)
	ply:SetNWString("ArmSlot", ply.hl2cPersistent.ArmImage)
	ply:SetNWString("HandSlot", ply.hl2cPersistent.HandsImage)
	ply:SetNWString("BootSlot", ply.hl2cPersistent.BootImage)
	ply:SetNWString("WepSlot", ply.hl2cPersistent.InvWeaponImage)
	
	ply:SetNWInt("PetLevel", ply.hl2cPersistent.PetLevel)
	ply:SetNWString("PetName", ply.hl2cPersistent.PetName)
	ply:SetNWInt("PetXP", math.Round(ply.hl2cPersistent.PetXP))
	ply:SetNWInt("PetMaxXP", ply.hl2cPersistent.PetMaxXP)
	ply:SetNWInt("PetSkillPoints", ply.hl2cPersistent.PetPoints)
	ply:SetNWInt("PetStr", ply.hl2cPersistent.PetStr)
	ply:SetNWInt("PetHP", ply.hl2cPersistent.PetHP)
	ply:SetNWInt("PetRegen", ply.hl2cPersistent.PetRegen)
	ply:SetNWInt("PetStage", ply.hl2cPersistent.PetStage)
	
	ply:SetNWInt("PetSkill", ply.hl2cPersistent.PetSkills)
	
	ply:SetNWInt("EventItems", ply.hl2cPersistent.EventItems)

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
	
	return true -- Return true to signal that the settings could be loaded
end

local function SaveData(ply)
	local PlayerID = string.Replace(ply:SteamID(), ":", "!")

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

Cheating_Players_Survival = {}

--When the player disconnects, add kills and remove temporary upgrades (THIS SHOULDN'T HAPPEN ON SERVER CRASH)
hook.Add("PlayerDisconnected", "SavePlayerDataDisconnect", function(ply) 
	if ply.hl2cPersistent.SquadsLeader then
		ply.hl2cPersistent.SquadsLeader = nil
		for k, pl in pairs(ply.hl2cPersistent.SquadMembers) do
			net.Start("Squad_Leave_Disband")
			net.Send(pl)
		end
	end
	
	ply.hl2cPersistent.KillCount = ply.hl2cPersistent.KillCount + ply:Frags()
	table.Empty(ply.hl2cPersistent.TempUpg)
	
	if GetConVar("hl2cr_survivalmode"):GetInt() == 1 and deaths ~= 0 then
		deaths = deaths - 1
	end
	
	deadPlayers = deadPlayers - 1
	
	if ply.pet then
		ply.pet:Remove()
	end
	
	if ply.hl2cPersistent.OTF then
		ply.hl2cPersistent.OTF = false
	end

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
			net.WriteString(version)
		net.Send(ply)
	end
end)

hook.Add("PostPlayerDeath", "AddDeathCount", function(ply)
	if ply:Team() == TEAM_COMPLETED_MAP then return end
	ply.hl2cPersistent.DeathCount = ply.hl2cPersistent.DeathCount + 1
end)

net.Receive("Update_Model", function(len, ply) 
	local newModel = net.ReadString()
	ply.hl2cPersistent.Model = newModel
	ply:SetModel(ply.hl2cPersistent.Model)
	ply:SetNWString("Model", newModel)
	ply:SetupHands()
end)