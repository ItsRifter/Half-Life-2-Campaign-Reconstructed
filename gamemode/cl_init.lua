include("shared.lua")

include("client/menus/cl_lobby_manager.lua")

include("client/achievements/cl_ach_base.lua")
include("client/menus/f4_menu.lua")

AddCSLuaFile("server/stats/sv_player_levels.lua")

AddCSLuaFile("server/commands/sv_commands_list.lua")

include("client/menus/cl_scoreboard.lua")


net.Receive("Staff_Join", function()
	
	local name = net.ReadString()
	
	if name == "SuperSponer" then
		surface.PlaySound("ambient/levels/gman/gman_sgnature_shrt.wav")
	end
	
	if name == "D3" then
		surface.PlaySound("vo/eli_lab/eli_handle_b.wav")
	end
end)

