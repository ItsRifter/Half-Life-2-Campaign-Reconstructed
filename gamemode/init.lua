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

function GM:Initialize()
	difficulty = 2
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
		net.WriteInt(ply.hl2cPersistent.Level, 32)
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
	
	if game.GetMap("hl2c_lobby_remake") and GetConVar("hl2c_allowsuicide"):GetInt() == 0 then
		ply:ChatPrint("You can't commit suicide on this map!")
		return false
	else
		return true
	end
end

function GM:CreateTeams()
	TEAM_ALIVE = 1
	team.SetUp(TEAM_ALIVE, "", Color(81, 124, 199, 255))
	
	TEAM_COMPLETED_MAP = 2
	team.SetUp(TEAM_COMPLETED_MAP, "Completed Map", Color(81, 124, 199, 255))
	
	TEAM_DEAD = 3
	team.SetUp(TEAM_DEAD, "Dead", Color(81, 124, 199, 255))
end

function GM:EntityKeyValue(ent, key, value)
	if ent:GetClass() == "trigger_changelevel" and key == "map" and SERVER then
		ent.map = key
	end
end

function GM:ShouldCollide(entA, entB)
	if entA and entB and ((entA:IsPlayer() and (entB:IsPlayer() or table.HasValue(INVUL_NPCS, entB:GetClass()) or table.HasValue(FRIENDLY_NPCS, entB:GetClass()))) or (entB:IsPlayer() and (entA:IsPlayer() or table.HasValue(INVUL_NPCS, entA:GetClass()) or table.HasValue(FRIENDLY_NPCS, entA:GetClass())))) then
		return false
	else
		return true
	end
end

FRIENDLY_NPCS = {
	"npc_citizen"
}
INVUL_NPCS = {
	"npc_alyx",
	"npc_barney",
	"npc_breen",
	"npc_dog",
	"npc_eli",
	"npc_fisherman",
	"npc_gman",
	"npc_kleiner",
	"npc_magnusson",
	"npc_monk",
	"npc_mossman",
	"npc_vortigaunt",
}

--function GM:PlayerShouldTakeDamage(ply, attacker)
--	if ply:Team() != TEAM_ALIVE or !ply.vulnerable or (attacker:IsPlayer() and attacker != ply) or (attacker:IsVehicle() and attacker:GetDriver():IsPlayer()) or table.HasValue(GODLIKE_NPCS, attacker:GetClass()) or table.HasValue(FRIENDLY_NPCS, attacker:GetClass()) then
--		return false
--	else
--		return true
--	end
--end


function GM:PlayerShouldTakeDamage(ply, attacker)
	if (attacker:IsPlayer() and attacker != ply) then
		return false
	else
		return true
	end
end

function GM:ScaleNPCDamage(npc, hitGroup, dmgInfo)
	
	local attacker = dmgInfo:GetAttacker()
	
	if table.HasValue(INVUL_NPCS, npc:GetClass()) or (attacker:IsPlayer() and table.HasValue(FRIENDLY_NPCS, npc:GetClass())) then
		dmgInfo:SetDamage(0)
		return
	end
	
	if attacker and attacker:IsValid() and attacker:IsPlayer() then
		if attacker:InVehicle() and attacker:GetVehicle() and attacker:GetVehicle():GetClass() == "prop_vehicle_airboat" then
			dmgInfo:SetDamage(1)
		elseif SUPER_GRAVITY_GUN and attacker:GetActiveWeapon() and attacker:GetActiveWeapon():GetClass() == "weapon_physcannon" then
			dmgInfo:SetDamage(100)
		end
	end
end

hook.Add("OnNPCKilled","UpdateXP", function(npc, attacker, inflictor)
	local giveXP = math.random(1, (10 * difficulty))
	attacker.hl2cPersistent.XP = attacker.hl2cPersistent.XP + giveXP
end)

print("Files loaded")