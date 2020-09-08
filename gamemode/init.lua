include("shared.lua")

-- Mark all client side only files to be sent to client
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("client/achievements/cl_ach_base.lua")
AddCSLuaFile("client/menus/cl_difficulty_vote.lua")
AddCSLuaFile("client/menus/cl_scoreboard.lua")
AddCSLuaFile("client/cl_hud.lua")
AddCSLuaFile("client/menus/cl_f4_menu.lua")
AddCSLuaFile("client/menus/cl_pets.lua")
AddCSLuaFile("client/menus/cl_new_player.lua")
AddCSLuaFile("client/menus/cl_squads.lua")

-- Server side files only
include("server/commands/sv_commands_list.lua")
include("server/stats/sv_player_levels.lua")
include("server/saving_modules/sv_data_flatfile.lua")
include("server/sv_change_map.lua")
include("server/extend/network.lua")
include("server/config/achievements/sv_ach.lua")
include("server/sv_unstuck.lua")
include("server/config/sv_difficulty.lua")
include("server/sv_spectate.lua")
include("server/stats/sv_pets_levels.lua")
include("server/config/maps/sv_loyal.lua")
include("server/sv_afkhandler.lua")


include("server/config/maps/sv_hl2_init_maps.lua")
include("server/config/maps/sv_coop_init_maps.lua")
include("server/config/maps/sv_vortex.lua")
include("server/config/maps/sv_lambda.lua")

--HL2C Convars
CreateConVar("hl2cr_allowsuicide", 1, {FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Disable kill command", 0, 1) 
CreateConVar("hl2cr_respawntime", 10, {FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_ARCHIVE})
CreateConVar("hl2cr_difficulty", 1, {FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Change Difficulty", 1, 3)
CreateConVar("hl2cr_survivalmode", 0, {FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Change Difficulty", 0, 1)

--Pet Convars
CreateConVar("hl2cr_petrecovertime", 15, FCVAR_NOTIFY, "Change Pets recovering time", 1, 999)
CreateConVar("hl2cr_petrecovery", 10, FCVAR_NOTIFY, "Change Pets recover HP", 1, 999)

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
team.SetUp(TEAM_LOYAL, "Loyal Combine", Color(0, 225, 255, 255))

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
	if self:IsValid() and self:IsNPC() and (self:GetClass() == "npc_kleiner" or self:GetClass() == "npc_monk" or self:GetClass() == "npc_alyx" or self:GetClass() == "npc_barney" or self:GetClass() == "npc_citizen") then
		return true
	else
		return false
	end
end

function GM:Initialize()
	isAliveSurv = true
	pets = false
	airboatSpawnable = false
	airboatGunSpawnable = false
end


function GM:ShowHelp(ply)
	net.Start("Greetings_new_player")
	net.Send(ply)
end

function GM:ShowTeam(ply)
	if ply.spawnJeep then
		ply.spawnJeep:Remove()
		ply.AllowSpawn = true
		ply.hasSeat = false
	end
	
	if ply.spawnAirboat then
		ply.spawnAirboat:Remove()
		ply.AllowSpawn = true
	end
	
	if ply.spawnAirboatGun then
		ply.spawnAirboatGun:Remove()
		ply.AllowSpawn = true
	end
end

if game.GetMap() != "hl2c_lobby_remake" then
	timer.Create("LobbyReturnAuto", 3600, 0, function()
	RunConsoleCommand("changelevel", "hl2c_lobby_remake")
	end)
end

function GM:ShouldCollide( ent1, ent2 )

    if IsValid(ent1) and IsValid(ent2) and ent1:IsPlayer() and ent2:IsPlayer() and ent1:Team() == TEAM_ALIVE and ent2:Team() == TEAM_ALIVE then
		return false 
	end
	
	if IsValid(ent1) and IsValid(ent2) and ent1:IsPlayer() and ent2:IsPlayer() and (ent1:Team() == TEAM_COMPLETED_MAP and ent2:Team() == TEAM_COMPLETED_MAP) then
		return false 
	end
	
	if IsValid(ent1) and IsValid(ent2) and ent1:IsPlayer() and ent2:IsPlayer() and (ent1:Team() == TEAM_ALIVE and ent2:Team() == TEAM_COMPLETED_MAP or ent1:Team() == TEAM_COMPLETED_MAP and ent2:Team() == TEAM_ALIVE) then
		return false
	end 
	
	if IsValid(ent1) and IsValid(ent2) and ent1:IsPlayer() and ent2:IsPet() then
		return false
	end
	
	if IsValid(ent1) and IsValid(ent2) and ent1:IsPlayer() and (ent2:GetClass() == "prop_vehicle_jeep" or ent2:GetClass() == "prop_vehicle_airboat") then

		return false
	end
	return true
end

lockedSpawn = false

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
	
	if ply.loyal then return end
	
	if game.GetMap() == "d2_coast_01" or game.GetMap() == "d2_coast_03" or game.GetMap() == "d2_coast_04" or game.GetMap() == "d2_coast_05" or game.GetMap() == "d2_coast_06" or game.GetMap() == "d2_coast_07" or game.GetMap() == "d2_coast_09" or (game.GetMap() == "d2_coast_10" and not lockedSpawn) then
		if ply.AllowSpawn then
			ply.spawnJeep = ents.Create(jeep.Class)
			ply.spawnJeep:SetModel(jeep.Model)
			for k, v in pairs( jeep.KeyValues ) do
				ply.spawnJeep:SetKeyValue(k, v)
			end
			ply.spawnJeep:SetPos(Vector(ply:EyePos().x, ply:EyePos().y, ply:EyePos().z - 35))
			ply.spawnJeep:Spawn()
			ply.spawnJeep:SetOwner(ply)
			ply.spawnJeep:Fire( "addoutput", "targetname jeep" )
			ply.AllowSpawn = false
		end
		
	elseif game.GetMap() == "d1_canals_06" or game.GetMap() == "d1_canals_07" or game.GetMap() == "d1_canals_08" or game.GetMap() == "d1_canals_09" or game.GetMap() == "d1_canals_10" or game.GetMap() == "d1_canals_11" and not airboatGunSpawnable or airboatSpawnable then
		if ply.AllowSpawn then
			ply.spawnAirboat = ents.Create(airboat.Class)
			ply.spawnAirboat:SetModel(airboat.Model)
			for k, v in pairs( airboat.KeyValues ) do
				ply.spawnAirboat:SetKeyValue(k, v)
			end
			ply.spawnAirboat:SetPos(Vector(ply:EyePos().x, ply:EyePos().y, ply:EyePos().z - 15))
			ply.spawnAirboat:Spawn()
			ply.spawnAirboat:SetOwner(ply)
			ply.spawnAirboat:Fire( "addoutput", "targetname airboat" )
			ply.AllowSpawn = false
		end
	elseif (game.GetMap() == "d1_canals_11" and airboatGunSpawnable) or game.GetMap() == "d1_canals_12" or game.GetMap() == "d1_canals_13" then
		if ply.AllowSpawn then
			ply.spawnAirboatGun = ents.Create(airboatGun.Class)
			ply.spawnAirboatGun:SetModel(airboatGun.Model)
			for k, v in pairs(airboatGun.KeyValues) do
				ply.spawnAirboatGun:SetKeyValue(k, v)
			end
			ply.spawnAirboatGun:SetPos(Vector(ply:EyePos().x, ply:EyePos().y, ply:EyePos().z - 15))
			ply.spawnAirboatGun:Spawn()
			ply.spawnAirboatGun:SetOwner(ply)
			ply.spawnAirboatGun:Fire( "addoutput", "targetname airboat" )
			ply.spawnAirboatGun:Activate()
			ply.AllowSpawn = false
		end
	else
		ply:ChatPrint("Vehicles are disabled on this map!")
	end
	
end

function GM:CanPlayerEnterVehicle(ply)
	if not ply.spawnJeep then
		return true
	end
	
	if ply.spawnJeep:GetOwner():IsValid() and ply.spawnJeep:GetOwner() == ply then
		return true
	end
	
	return false
end
function GM:ShowSpare2(ply)
	if ply.loyal then
		ply:ChatPrint("You cannot access the F4 menu while a loyal player")
	else
		net.Start("Open_F4_Menu")
			net.WriteTable(ply.hl2cPersistent.Inventory)
		net.Send(ply)
	end
end

hook.Add( "PrePACEditorOpen", "RestrictToSuperadmin", function( ply )
	if not ply:IsSuperAdmin( ) then
		return false
	end
end)