include("shared.lua")

-- Mark all client side only files to be sent to client
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("client/achievements/cl_ach_base.lua")
AddCSLuaFile("client/menus/cl_f4_menu.lua")
AddCSLuaFile("client/menus/cl_difficulty_vote.lua")
AddCSLuaFile("client/menus/cl_scoreboard.lua")
AddCSLuaFile("client/cl_hud.lua")
AddCSLuaFile("client/menus/cl_pets.lua")
AddCSLuaFile("client/menus/cl_new_player.lua")

-- Server side files only
include("server/commands/sv_commands_list.lua")
include("server/stats/sv_player_levels.lua")
include("server/saving_modules/sv_data_flatfile.lua")
include("server/sv_change_map.lua")
include("server/extend/network.lua")
include("server/config/achievements/sv_ach.lua")
include("server/sv_unstuck.lua")
include("server/config/sv_difficulty.lua")
include("server/config/maps/sv_init_maps.lua")
include("server/sv_spectate.lua")
include("server/stats/sv_pets_levels.lua")

--HL2C Convars
CreateConVar("hl2c_allowsuicide", 1, FCVAR_NOTIFY, "Disable kill command", 0, 1) 
CreateConVar("hl2c_respawntime", 5, FCVAR_NOTIFY)
CreateConVar("hl2c_difficulty", 1, FCVAR_NOTIFY, "Change Difficulty", 1, 3)
CreateConVar("hl2c_survivalmode", 0, FCVAR_NOTIFY, "Change Difficulty", 0, 1)

--Pet Convars
CreateConVar("hl2c_petrecovertime", 15, FCVAR_NOTIFY, "Change Pets recovering time", 1, 999)
CreateConVar("hl2c_petrecovery", 10, FCVAR_NOTIFY, "Change Pets recovering time", 1, 999)

--Ammo Limits
CreateConVar("max_pistol", 				150, 	{FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_ARCHIVE}, true)
CreateConVar("max_357", 				12, 	{FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_ARCHIVE}, true)
CreateConVar("max_smg1", 				225, 	{FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_ARCHIVE}, true)
CreateConVar("max_smg1_grenade", 		3, 		{FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_ARCHIVE}, true)
CreateConVar("max_ar2", 				60, 	{FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_ARCHIVE}, true)
CreateConVar("max_ar2_ball", 			3, 		{FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_ARCHIVE}, true)
CreateConVar("max_buckshot", 			30, 	{FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_ARCHIVE}, true)
CreateConVar("max_crossbowbolt", 		10, 	{FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_ARCHIVE}, true)
CreateConVar("max_grenade", 			5, 		{FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_ARCHIVE}, true)
CreateConVar("max_slam", 				5, 		{FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_ARCHIVE}, true)
CreateConVar("max_rpg_round", 			3, 		{FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_ARCHIVE}, true)

TEAM_ALIVE = 1
team.SetUp(TEAM_ALIVE, "Alive", Color(81, 124, 199, 255))

TEAM_COMPLETED_MAP = 2
team.SetUp(TEAM_COMPLETED_MAP, "Completed Map", Color(81, 124, 199, 255))

TEAM_DEAD = 3
team.SetUp(TEAM_DEAD, "Terminated", Color(81, 124, 199, 255))

TEAM_LOYAL = 4
team.SetUp(TEAM_LOYAL, "Combine", Color(0, 225, 255, 255))

local meta = FindMetaTable( "Entity" )
if not meta then return end

function meta:IsPet()
	if self:IsValid() and self:IsNPC() and self:GetNWBool("PetActive") then
		return true
	else
		return false
	end
end

function meta:IsFriendly()
	if self:IsValid() and self:IsNPC() and (self:GetClass() == "npc_kleiner" or self:GetClass() == "npc_alyx" or self:GetClass() == "npc_barney" or self:GetClass() == "npc_citizen") then
		return true
	else
		return false
	end
end



function GM:Initialize(ply)
	if not file.Exists("hl2c_data/config.txt", "DATA") then
		print("CONFIG MISSING, CREATING DEFAULT")
		file.Write("hl2c_data/config.txt", "WARNING: Unless you know what you're doing, I suggest you leave this file\n")
		file.Append("hl2c_data/config.txt", "Difficulty: \n")
		file.Append("hl2c_data/config.txt", "1\n")
		file.Append("hl2c_data/config.txt", "Survival Mode: \n")
		file.Append("hl2c_data/config.txt", "0\n")
	end
	local file = file.Open("hl2c_data/config.txt", "r", "DATA")
	file:ReadLine()
	file:ReadLine()
	local difficulty = file:ReadLine()
	file:ReadLine()
	local survival = file:ReadLine()
	file:Close()
	GetConVar("hl2c_difficulty"):SetInt(tonumber(difficulty))
	GetConVar("hl2c_survivalmode"):SetInt(tonumber(survival))
	isAliveSurv = true
	pets = false
	startingWeapons = {}
	airboatSpawnable = false
	airboatGunSpawnable = false
end

function GM:ShowHelp(ply)
	net.Start("Greetings_new_player")
	net.Send(ply)
end

function GM:ShowTeam(ply)
	ply.AllowSpawn = true
end

net.Receive("KickUser", function(len, ply)
	local banTime = net.ReadInt(32)
	local reason = net.ReadString()
	RunConsoleCommand("ulx", "ban", ply:Nick(), banTime, reason)
end)


function GM:ShouldCollide( ent1, ent2 )

    if IsValid(ent1) and IsValid(ent2) and ent1:IsPlayer() and ent2:IsPlayer() and ent1:Team() == TEAM_ALIVE and ent2:Team() == TEAM_ALIVE then
		return false 
	end
	
	if IsValid(ent1) and IsValid(ent2) and ent1:IsPlayer() and ent2:IsPet() then
		return false
	else
		return true
	end
	return true
end

function GM:ShowSpare1(ply)
	local jeep = {
		Name = "Jeep",
		Class = "prop_vehicle_jeep_old",
		Model = "models/buggy.mdl",
		KeyValues = {
			vehiclescript = "scripts/vehicles/jeep_test.txt",
			EnableGun = 1
		}
	}
	list.Set( "Vehicles", "Jeep", jeep )
	
	local airboat = {
		Name = "Airboat",
		Class = "prop_vehicle_airboat",
		Category = Category,
		Model = "models/airboat.mdl",
		KeyValues = {
			vehiclescript = "scripts/vehicles/airboat.txt",
			EnableGun = 0
		}
	}
	
	list.Set( "Vehicles", "Airboat", airboat )
	
	local airboatGun = {
		Name = "AirboatGun",
		Class = "prop_vehicle_airboat",
		Category = Category,
		Model = "models/airboat.mdl",
		KeyValues = {
			vehiclescript = "scripts/vehicles/airboat.txt",
			EnableGun = 1
		}
	}
	
	list.Set( "Vehicles", "AirboatGun", airboatGun )
	
	if game.GetMap() == "d2_coast_01" or game.GetMap() == "d2_coast_03" or game.GetMap() == "d2_coast_04" or game.GetMap() == "d2_coast_05" or game.GetMap() == "d2_coast_06" or game.GetMap() == "d2_coast_07" or game.GetMap() == "d2_coast_09" or game.GetMap() == "d2_coast_10" then
		if ply.AllowSpawn then
			local spawnJeep = ents.Create(jeep.Class)
			spawnJeep:SetModel(jeep.Model)
			for k, v in pairs( jeep.KeyValues ) do
				spawnJeep:SetKeyValue(k, v)
			end
			spawnJeep:SetPos(Vector(ply:EyePos().x, ply:EyePos().y, ply:EyePos().z + 35))
			spawnJeep:Spawn()
			spawnJeep:SetOwner(ply)
			spawnJeep:Fire( "addoutput", "targetname jeep" )
			ply.AllowSpawn = false
		end
	
		
		
	elseif game.GetMap() == "d1_canals_06" or game.GetMap() == "d1_canals_07" or game.GetMap() == "d1_canals_08" or game.GetMap() == "d1_canals_09" or game.GetMap() == "d1_canals_10" or game.GetMap() == "d1_canals_11" and not airboatGunSpawnable or airboatSpawnable then
		if ply.AllowSpawn then
			local spawnAirboat = ents.Create(airboat.Class)
			spawnAirboat:SetModel(airboat.Model)
			for k, v in pairs( airboat.KeyValues ) do
				spawnAirboat:SetKeyValue(k, v)
			end
			spawnAirboat:SetPos(Vector(ply:EyePos().x, ply:EyePos().y, ply:EyePos().z + 35))
			spawnAirboat:Spawn()
			spawnAirboat:SetOwner(ply)
			spawnAirboat:Fire( "addoutput", "targetname airboat" )
			ply.AllowSpawn = false
		end
	elseif game.GetMap() == "d1_canals_11" and airboatGunSpawnable or game.GetMap() == "d1_canals_12" or game.GetMap() == "d1_canals_13" then
		if ply.AllowSpawn then
			local spawnAirboatGun = ents.Create(airboatGun.Class)
			spawnAirboatGun:SetModel(airboatGun.Model)
			for k, v in pairs(airboatGun.KeyValues) do
				spawnAirboatGun:SetKeyValue(k, v)
			end
			spawnAirboatGun:SetPos(Vector(ply:EyePos().x, ply:EyePos().y, ply:EyePos().z + 35))
			spawnAirboatGun:Spawn()
			spawnAirboatGun:SetOwner(ply)
			spawnAirboatGun:Fire( "addoutput", "targetname airboat" )
			ply.AllowSpawn = false
		end
	else
		ply:ChatPrint("Vehicles are disabled on this map!")
	end
end

function GM:CanPlayerEnterVehicle(ply)
	return true
end
function GM:ShowSpare2(ply)
	net.Start("Open_F4_Menu")
	net.Send(ply)
end