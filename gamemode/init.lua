include("shared.lua")

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

AddCSLuaFile("client/achievements/cl_ach_base.lua")
AddCSLuaFile("client/menus/cl_lobby_manager.lua")
AddCSLuaFile("client/menus/f4_menu.lua")
AddCSLuaFile("client/menus/cl_lobby_manager.lua")
AddCSLuaFile("client/menus/cl_scoreboard.lua")
AddCSLuaFile("client/menus/difficulty_vote.lua")
AddCSLuaFile("client/commands/cl_commands_list.lua")

include("server/modules/checkpoint.lua")
include("server/commands/sv_commands_list.lua")
include("server/stats/sv_player_levels.lua")
include("server/saving_modules/sv_data_flatfile.lua")
include("server/sv_change_map.lua")
include("server/extend/network.lua")
include("server/config/achievements/sv_ach.lua")

include("shared/maps/init_checkpoints.lua")

include("shared/ach/sh_ach_lobby.lua")


CreateConVar("hl2c_allowsuicide", "0", FCVAR_NONE, "Disable kill command", 0, 1) 

function GM:Initialize()
	--Difficulty, voting and survival mode
	difficulty = 1
	survivalMode = false
	totalVotes = 0
	requiredVotes = 0
	hasVoted = false
end

function GM:ShowHelp(ply)
	net.Start("Greetings_new_player")
	net.Send(ply)
end

hook.Add("ScoreboardHide", "CloseHL2CScoreBoard", function()
	ToggleBoard(false)
end)

function GM:ShowSpare2(ply)
	net.Start("Open_F4_Menu")
		net.WriteString(ply:GetModel())
		net.WriteString(tostring(ply.hl2cPersistent.DeathCount))
		net.WriteString(tostring(ply.hl2cPersistent.KillCount))
	net.Send(ply)
end

function GM:ScoreboardShow(ply)
	net.Start("Scoreboard")
		net.WriteInt(ply.hl2cPersistent.Level, 16)
	net.Send()
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

--	if ply:Team() != TEAM_ALIVE or !ply.vulnerable or (attacker:IsPlayer() and attacker != ply) or (attacker:IsVehicle() and attacker:GetDriver():IsPlayer()) or table.HasValue(GODLIKE_NPCS, attacker:GetClass()) or table.HasValue(FRIENDLY_NPCS, attacker:GetClass()) then




function GM:PlayerShouldTakeDamage(ply, attacker)
	if (attacker:IsPlayer() and attacker != ply) then
		return false
	else
		return true
	end
	
	if hitGroup == HITGROUP_HEAD then
		hitGroupScale = 2
	else
		hitGroupScale = 1
	end
	
	dmgInfo:ScaleDamage(hitGroupScale * difficulty)
end

function GM:EntityTakeDamage( ent, dmgInfo )
	if table.HasValue(INVUL_NPCS, ent:GetClass()) or table.HasValue(FRIENDLY_NPCS, ent:GetClass()) then
		dmgInfo:SetDamage(0)
	return
	end
end
function GM:ScaleNPCDamage(npc, hitGroup, dmgInfo)
	
	local inflictor = dmgInfo:GetDamageType()
	local attacker = dmgInfo:GetAttacker()
 	
	if table.HasValue(INVUL_NPCS, npc:GetClass()) and attacker:IsPlayer() or table.HasValue(FRIENDLY_NPCS, npc:GetClass()) then
		dmgInfo:SetDamage(0)
	return
	end
	
	if hitGroup == HITGROUP_HEAD then
		hitGroupScale = 2
	else
		hitGroupScale = 1
	end
	
	dmgInfo:ScaleDamage(hitGroupScale / difficulty)
end

hook.Add("Think", "CooldownTimer", function()
	
	local cooldown = 0
	
	if hasVoted == true then
		cooldown = 600
	end
	
	cooldown = CurTime() + cooldown
	if cooldown >= CurTime() then
		hasVoted = false
	end
end)

hook.Add("OnNPCKilled", "UpdateXP", function(npc, attacker, inflictor)
	local giveXP = math.random(1, (10 * difficulty))
	attacker.hl2cPersistent.XP = attacker.hl2cPersistent.XP + giveXP
end)

hook.Add("PostPlayerDeath", "SurvivalModePost", function(ply)
	
end)

--[[
hook.Add("PlayerDeathThink", "SurvivalModeCheck", function()
	if survivalMode then
		return false
	else
		return true
	end
end)

hook.Add("PlayerSpawn", "SurvivalSpawn", function(ply)
	if survivalMode then
		GAMEMODE:PlayerSpawnAsSpectator(t)
	end
end)

--]]

print("Files loaded")