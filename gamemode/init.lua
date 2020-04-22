include("shared.lua")

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

AddCSLuaFile("client/menus/cl_lobby_manager.lua")

AddCSLuaFile("client/achievements/cl_ach_base.lua")
AddCSLuaFile("client/menus/f4_menu.lua")
AddCSLuaFile("client/menus/cl_lobby_manager.lua")
AddCSLuaFile("client/menus/cl_scoreboard.lua")

include("server/commands/sv_commands_list.lua")

include("server/stats/sv_player_levels.lua")

include("server/saving_modules/sv_data_flatfile.lua")

include("server/sv_change_map.lua")

include("server/extend/network.lua")

include("server/config/achievements/sv_ach.lua")

include("shared/ach/sh_ach_lobby.lua")

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

coolDown = 0
canPlayOne = true
canPlayTwo = true

hook.Add("Think", "SoundCooldown", function()
	

	if CurTime() < coolDown then return
	else
		canPlayOne = true
		canPlayTwo = true
	end
	coolDown = CurTime() + 86400
end)

function StaffJoin(ply)
	
	id = ply:SteamID()
	
	if id == "STEAM_0:0:6009886" and canPlayOne then
		for k, v in pairs(player.GetAll()) do
			v:ChatPrint("The Creator 'SuperSponer' has joined the server!")
		end
		net.Start("Staff_Join")
			net.WriteString("SuperSponer")
		net.Broadcast()
		canPlayOne = false
		print("trigger")
		print(canPlayOne)
	end
	
	if id == "STEAM_0:0:22379160" and canPlayTwo then
		for k, v in pairs(player.GetAll()) do
			v:ChatPrint("A developer 'D3' has joined the server!")
		end
		net.Start("Staff_Join")
			net.WriteString("D3")
		net.Broadcast()
		canPlayTwo = false
	end
	
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