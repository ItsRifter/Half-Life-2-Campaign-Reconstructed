include("shared.lua")

include("client/menus/cl_new_player.lua")

include("client/achievements/cl_ach_base.lua")
include("client/menus/cl_f4_menu.lua")
include("client/menus/cl_difficulty_vote.lua")
include("client/commands/cl_commands_list.lua")
include("client/menus/cl_scoreboard.lua")
include("client/cl_hud.lua")
include("client/menus/cl_pets.lua")

AddCSLuaFile("server/stats/sv_player_levels.lua")
AddCSLuaFile("server/commands/sv_commands_list.lua")
AddCSLuaFile("server/modules/checkpoint.lua")
AddCSLuaFile("server/sv_spectate.lua")

AddCSLuaFile("shared/sh_indicators.lua")
AddCSLuaFile("server/maps/config/init_maps.lua")
AddCSLuaFile("shared/sh_player.lua")
AddCSLuaFile("shared/sh_npc.lua")
AddCSLuaFile("shared/items/sh_items_hats.lua")

AddCSLuaFile("server/stats/sv_pets_levels.lua")
