include("shared.lua")

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

AddCSLuaFile("lobby_manager/cl_lobby_manager.lua")

AddCSLuaFile("client/achievements/cl_ach_base.lua")
AddCSLuaFile("client/menus/f4_menu.lua")
AddCSLuaFile("client/menus/cl_lobby_manager.lua")

AddCSLuaFile("client/commands/commands_list.lua")

include("server/stats/sv_player_levels.lua")

include("lobby_manager/sv_lobby_manager.lua")

include("server/saving_modules/sv_data_flatfile.lua")

include("server/lobby_map_selector/sv_switch_map_from_lobby.lua")

include("server/extend/network.lua")

include("server/config/achievements/sv_ach.lua")

--include("shared/sh_init.lua")
include("shared/ach/sh_ach_lobby.lua")
--include("shared/ach/sh_ach_list.lua")

CreateConVar("hl2c_allowsuicide", "0", FCVAR_NONE, "Disable kill command", 0, 1) 

function GM:ShowHelp(ply)
	net.Start("Greetings_new_player")
	net.Send(ply)
end

function GM:ShowSpare2(ply)
	net.Start("Open_F4_Menu")
		net.WriteString(ply:GetModel())
	net.Send(ply)
end

hook.Add("PlayerSpawn", "LobbyWeapons", function(ply)

	if (game.GetMap() == "hl2c_lobby_remake") then
		ply:Give("weapon_crowbar")
		ply:Give("weapon_physcannon")
		if ply:IsAdmin() then
			ply:Give("weapon_physgun")
		end
		ply:AllowFlashlight(true)
	end
	
	ply:SetupHands()
end)

function GM:CanPlayerSuicide(ply)
	
	if game.GetMap("hl2c_lobby_remake") && GetConVar("hl2c_allowsuicide"):GetInt() == 0 then
		ply:ChatPrint("You can't commit suicide on this map!")
		return false
	else
		return true
	end
end

print("Files loaded")