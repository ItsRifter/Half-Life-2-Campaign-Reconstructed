include("shared.lua")

include("client/menus/cl_lobby_manager.lua")

include("client/achievements/cl_ach_base.lua")
include("client/menus/f4_menu.lua")

AddCSLuaFile("server/stats/sv_player_levels.lua")

AddCSLuaFile("server/commands/sv_commands_list.lua")

include("client/menus/cl_scoreboard.lua")

net.Receive("Failed_Command", function()
	surface.PlaySound("friends/friend_join.wav")
end)

concommand.Add("hl2c_givexp", function(ply, cmd, args)
	local int = tonumber(args[1])
	print(int)
	
	if int then
		net.Start("GiveXP")
			net.WriteInt(int, 16)
		net.SendToServer(ply)
	elseif not int then
		print("Invalid Value")
	end
end)
	