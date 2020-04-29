include("shared.lua")

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

AddCSLuaFile("client/achievements/cl_ach_base.lua")
AddCSLuaFile("client/menus/cl_lobby_manager.lua")
AddCSLuaFile("client/menus/f4_menu.lua")
AddCSLuaFile("client/menus/cl_lobby_manager.lua")
AddCSLuaFile("client/menus/cl_scoreboard.lua")
AddCSLuaFile("client/menus/cl_difficulty_vote.lua")
AddCSLuaFile("client/commands/cl_commands_list.lua")
AddCSLuaFile("client/cl_hud.lua")

include("server/commands/sv_commands_list.lua")
include("server/stats/sv_player_levels.lua")
include("server/saving_modules/sv_data_flatfile.lua")
include("server/sv_change_map.lua")
include("server/extend/network.lua")
include("server/config/achievements/sv_ach.lua")

include("server/sv_unstuck.lua")

include("shared/sh_indicators.lua")
include("shared/sh_player.lua")
include("shared/sh_npc.lua")

include("server/config/maps/init_maps.lua")

CreateConVar("hl2c_allowsuicide", 1, FCVAR_NOTIFY, "Disable kill command", 0, 1) 
CreateConVar("hl2c_respawntime", 5, FCVAR_NOTIFY)
CreateConVar("hl2c_difficulty", 1, FCVAR_NONE, "Change Difficulty", 1, 3)

TEAM_ALIVE = 1
team.SetUp(TEAM_ALIVE, "Alive", Color(81, 124, 199, 255))

TEAM_COMPLETED_MAP = 2
team.SetUp(TEAM_COMPLETED_MAP, "Completed Map", Color(81, 124, 199, 255))

TEAM_DEAD = 3
team.SetUp(TEAM_DEAD, "Terminated", Color(81, 124, 199, 255))

function GM:Initialize()
	checkpointPos = {}
	startingWeapons = {}
end

function GM:ShowHelp(ply)
	net.Start("Greetings_new_player")
	net.Send(ply)
end

function GM:ShowSpare2(ply)
	net.Start("Open_F4_Menu")
		net.WriteString(ply:GetModel())
		net.WriteString(tostring(ply.hl2cPersistent.DeathCount))
		net.WriteString(tostring(ply.hl2cPersistent.KillCount))
		net.WriteInt(ply.hl2cPersistent.Level, 16)
		net.WriteInt(ply.hl2cPersistent.XP, 16)
		net.WriteInt(ply.hl2cPersistent.MaxXP, 16)
	net.Send(ply)
end

print("Files loaded")