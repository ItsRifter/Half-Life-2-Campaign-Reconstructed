include("shared.lua")

include("client/menus/cl_lobby_manager.lua")

include("client/achievements/cl_ach_base.lua")
include("client/menus/f4_menu.lua")
include("client/menus/cl_difficulty_vote.lua")
include("client/commands/cl_commands_list.lua")
include("client/menus/cl_scoreboard.lua")
include("client/cl_hud.lua")

AddCSLuaFile("server/stats/sv_player_levels.lua")
AddCSLuaFile("server/commands/sv_commands_list.lua")
AddCSLuaFile("server/modules/checkpoint.lua")

AddCSLuaFile("shared/sh_indicators.lua")
AddCSLuaFile("server/maps/config/init_maps.lua")
AddCSLuaFile("shared/sh_player.lua")
AddCSLuaFile("shared/sh_npc.lua")

net.Receive("Failed_Command", function()
	surface.PlaySound("friends/friend_join.wav")
end)

net.Receive("PlaySoundLevelUp", function()
	surface.PlaySound("items/battery_pickup.wav")
end)