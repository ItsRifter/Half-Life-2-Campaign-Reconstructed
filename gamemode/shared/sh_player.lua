AddCSLuaFile() -- Add itself to files to be sent to the clients, as this file is shared
startingWeapons = {}
hook.Add("PlayerInitialSpawn", "MiscSurv", function(ply)
	
	ply:SetNWInt("diffEasy", #player.GetAll())
	ply:SetNWInt("diffMed", #player.GetAll())
	ply:SetNWInt("diffHard", #player.GetAll())
	ply:SetNWInt("SurvDiff", #player.GetAll())
	
	ply:ConCommand("cl_tfa_hud_crosshair_enable_custom", 0)
	ply:ConCommand("hud_quickinfo", 1)
	ply:ConCommand("cl_tfa_hud_enabled", 0) 
	
	if GetConVar("hl2c_survivalmode"):GetInt() == 1 and ply:Alive() and not isAliveSurv then
		isAliveSurv = false
	end
	
	ply.hasDiedOnce = false
	ply.crowbarOnly = true
end)


hook.Add("PlayerSpawn", "Misc", function(ply)
	ply.AllowSpawn = true
	ply.hasSeat = false
	if not isAliveSurv then
		ply:Kill()
		ply:ChatPrint("Nice try, don't do that next time")
		ply:Spectate(5)
	end
	if tonumber(ply:GetNWInt("Milestone")) > 5 then
		local maxHP = 100 + ply:GetNWInt("Milestone")
		ply:SetMaxHealth(maxHP)
		ply:SetHealth(maxHP)
	end
	
	ply:SetTeam(TEAM_ALIVE)
	ply:SetCustomCollisionCheck(true)
	ply:SetupHands()
	
	if game.GetMap() == "d1_trainstation_01" or game.GetMap() == "d1_trainstation_02" or game.GetMap() == "d1_trainstation_03" or
	game.GetMap() == "d1_trainstation_04" then
		ply:AllowFlashlight(false)
		RunConsoleCommand("gmod_suit", 0)
		ply:SetRunSpeed( 160 )
		ply:SetWalkSpeed( 120 )
	elseif game.GetMap() == "d1_trainstation_05" then
		for p, hevFlash in pairs(ents.FindByClass("item_suit")) do
			if hevFlash:IsValid() then
				ply:AllowFlashlight(false)
				RunConsoleCommand("gmod_suit", 0)
				
			elseif not hevFlash:IsValid() then 
				ply:AllowFlashlight(true)
				RunConsoleCommand("gmod_suit", 1)
				ply:SetRunSpeed( 240 )
				ply:SetWalkSpeed( 180 )
			end
		end
	else
		RunConsoleCommand("gmod_suit", 1)
		ply:AllowFlashlight(true)
	end
	
	if game.GetMap() == "d3_citadel_03" then
		ply:Give("weapon_physcannon")
	end
	
	for k, curWep in pairs(ply:GetWeapons()) do
		local wepClass = curWep:GetClass()
			
		if ply[wepClass] then
			ply:GiveAmmo(tonumber(ply.info.loadout[wepClass][1]), curWep:GetPrimaryAmmoType())
			ply:GiveAmmo(tonumber(ply.info.loadout[wepClass][2]), curWep:GetSecondaryAmmoType())
		end
	end
	
	if #startingWeapons > 0 then
		for k, wep in pairs(startingWeapons) do
			ply:Give(wep)
		end
	end
end)

function GM:DoPlayerDeath(ply, attacker, dmgInfo)
	ply:CreateRagdoll()
	ply:SetTeam(TEAM_DEAD)
end

hook.Add("CanPlayerSuicide", "DefaultSuicide", function(ply)

	if game.GetMap() == "hl2c_lobby_remake" or game.GetMap() == "d1_trainstation_01" or game.GetMap() == "d1_trainstation_02" or game.GetMap() == "d1_trainstation_03" or game.GetMap() == "d1_trainstation_04" or game.GetMap() == "d1_trainstation_05" then
		ply:ChatPrint("You can't commit suicide on this map!")
		return false
	elseif GetConVar("hl2c_allowsuicide"):GetInt() == 0 then
		ply:ChatPrint("Suiciding is disabled")
		return false
	elseif ply:Team() == TEAM_COMPLETED_MAP then
		ply:ChatPrint("You cannot suicide once you've completed the map")
		return false
	elseif ply:Team() == TEAM_DEAD then
		ply:ChatPrint("You are already dead")
		return false
	end
end)

hook.Add("EntityTakeDamage", "DisableAR2DMG", function(ent, dmgInfo)
	local attacker = dmgInfo:GetAttacker()
	local dmg = dmgInfo:GetDamage()
	if attacker and ent:IsPlayer() and ent:IsPet() then
		dmgInfo:SetDamage(0)
	elseif not ent:IsPlayer() then
		dmgInfo:SetDamage(dmg)
	end
end)

hook.Add("PlayerShouldTakeDamage", "DisablePVP", function(ply, attacker)
	if ply:Team() != TEAM_ALIVE or (attacker:IsPlayer() and attacker != ply) then
		return false
	end
	return true
	
end)

function GM:PlayerCanPickupWeapon(ply, weapon) 
	if ply:Team() != TEAM_ALIVE or weapon:GetClass() == "weapon_stunstick" or (weapon:GetClass() == "weapon_physgun" and not ply:IsAdmin()) then
		weapon:Remove()
		return false
	end
	
	if (game.GetMap() == "d3_citadel_03" or game.GetMap() == "d3_citadel_04" or game.GetMap() == "d3_citadel_05" or game.GetMap() == "d3_breen_01") and weapon:GetClass() != "weapon_superphyscannon" then
		weapon:Remove()
		return false
	end
	return true
end

function GM:GetFallDamage( ply, speed )
    return ( speed / 16 )
end

hook.Add("PlayerLoadout", "StarterWeapons", function(ply)
	if (game.GetMap() == "hl2c_lobby_remake") then
		ply:Give("weapon_crowbar")
		ply:Give("weapon_physcannon")
		if ply:IsAdmin() then
			ply:Give("weapon_physgun")
		end
	end
	
	if game.GetMap() == "d1_town_02" and file.Exists("hl2c_data/d1_town_02.txt", "DATA") then 
		ply:Give("weapon_crowbar")
		ply:Give("weapon_physcannon")
		ply:Give("weapon_pistol")
		ply:Give("weapon_357")
		ply:Give("weapon_smg1")
		ply:Give("weapon_shotgun")
		ply:Give("weapon_frag")
	end
	
	if game.GetMap() == "d2_coast_08" then
		ply:Give("weapon_crowbar")
		ply:Give("weapon_physcannon")
		ply:Give("weapon_pistol")
		ply:Give("weapon_357")
		ply:Give("weapon_smg1")
		ply:Give("weapon_ar2")
		ply:Give("weapon_shotgun")
		ply:Give("weapon_crossbow")
		ply:Give("weapon_rpg")
		ply:Give("weapon_frag")
	end
	
	if game.GetMap() == "d2_prison_05" then
		ply:Give("weapon_crowbar")
		ply:Give("weapon_physcannon")
		ply:Give("weapon_pistol")
		ply:Give("weapon_357")
		ply:Give("weapon_smg1")
		ply:Give("weapon_ar2")
		ply:Give("weapon_shotgun")
		ply:Give("weapon_crossbow")
		ply:Give("weapon_rpg")
		ply:Give("weapon_frag")
		ply:Give("weapon_bugbait")
	end
end)

hook.Add("WeaponEquip", "WeaponPickedUp", function(weapon, ply)
	table.insert(startingWeapons, weapon:GetClass())
	
	if weapon:GetClass() == "weapon_crowbar" and game.GetMap() == "d1_trainstation_06" then
		for k, v in pairs(player.GetAll()) do
			Achievement(v, "Trusty_Hardware", "HL2_Ach_List", 250)
		end
	end
	
end)

function RespawnTimerActive(ply, deaths)
	ply.hasDiedOnce = true
	
	if GetConVar("hl2c_survivalmode"):GetInt() == 1 and game.GetMap() != "hl2c_lobby_remake" then
		ply:Lock()
		ply.isAliveSurv = false
		local playersAlive = #player.GetAll()
		local playerDeaths = deaths
		
		ply:ChatPrint("You have died, awaiting next checkpoint")
		timer.Simple(5, function()
			SpectateMode(ply)
		end)
		if playerDeaths == playersAlive then	
			if playerDeaths >= 4 then
				for k, v in pairs(player.GetAll()) do
					Achievement(v, "Survival_Lost", "Misc_Ach_List", 500)
				end
			end
			ply:ChatPrint("All players have died... restarting map")
			net.Start("SurvAllDead")
			net.Broadcast()
			timer.Simple(15, function()
				RunConsoleCommand("changelevel", game.GetMap())
			end)
		end
	return
	end

	if GetConVarNumber("hl2c_respawntime") ~= 0 then
		ply:Lock()
		timer.Simple(5, function()
			SpectateMode(ply)
		end)
		timer.Simple(GetConVarNumber("hl2c_respawntime"), function()
			ply:UnLock()
			ply:Spawn()
		end)
	end
end

deaths = 0
hook.Add("PlayerDeath", "RespawnTimer", function(victim, inflictor, attacker)
	if GetConVar("hl2c_survivalmode"):GetInt() == 1 then
		deaths = deaths + 1
	end
	RespawnTimerActive(victim, deaths)
end)

function GM:IsSpawnpointSuitable( ply, spawnpointent, bMakeSuitable )
	return true
end

net.Receive("Diff_Vote", function()

	local voter = net.ReadString()
	local diffVote = net.ReadInt(8)
	for k, v in pairs(player.GetAll()) do
		if diffVote == 1 then
			v:ChatPrint(voter .. " Has voted for 'Easy' Difficulty")
		elseif diffVote == 2 then
			v:ChatPrint(voter .. " Has voted for 'Medium' Difficulty")
		elseif diffVote == 3 then
			v:ChatPrint(voter .. " Has voted for 'Hard' Difficulty")
		elseif diffVote == 4 and not survivalMode then
			v:ChatPrint(voter .. " Has voted to enable 'Survival' Mode")
		elseif diffVote == 4 and survivalMode then
			v:ChatPrint(voter .. " Has voted to disable 'Survival' Mode")
		end
	end
end)

if SERVER then
	hook.Add("Think", "AmmoLimiter", function()
		for k, p in pairs(player.GetAll()) do
			if p:GetAmmoCount("357") > GetConVar("max_357"):GetInt() then		
				p:RemoveAmmo( p:GetAmmoCount("357") -GetConVar("max_357"):GetInt(), "357" )
			end
			
			if p:GetAmmoCount("AR2") > GetConVar("max_AR2"):GetInt() then		
				p:RemoveAmmo( p:GetAmmoCount("AR2") -GetConVar("max_AR2"):GetInt(), "AR2" )
			end
			
			if p:GetAmmoCount("AR2AltFire") > GetConVar("max_ar2_ball"):GetInt() then		
				p:RemoveAmmo( p:GetAmmoCount("AR2AltFire") -GetConVar("max_ar2_ball"):GetInt(), "AR2AltFire" )
			end
			
			if p:GetAmmoCount("Buckshot") > GetConVar("max_Buckshot"):GetInt() then		
				p:RemoveAmmo( p:GetAmmoCount("Buckshot") -GetConVar("max_Buckshot"):GetInt(), "Buckshot" )
			end
			
			if p:GetAmmoCount("XBowBolt") > GetConVar("max_crossbowbolt"):GetInt() then		
				p:RemoveAmmo( p:GetAmmoCount("XBowBolt") -GetConVar("max_crossbowbolt"):GetInt(), "XBowBolt" )
			end

			if p:GetAmmoCount("Grenade") > GetConVar("max_grenade"):GetInt() then		
				p:RemoveAmmo( p:GetAmmoCount("Grenade") -GetConVar("max_grenade"):GetInt(), "Grenade" )
			end

			if p:GetAmmoCount("slam") > GetConVar("max_slam"):GetInt() then		
				p:RemoveAmmo( p:GetAmmoCount("slam") -GetConVar("max_slam"):GetInt(), "slam" )
			end
			
			if p:GetAmmoCount("Pistol") > GetConVar("max_Pistol"):GetInt() then		
				p:RemoveAmmo( p:GetAmmoCount("Pistol") -GetConVar("max_Pistol"):GetInt(), "Pistol" )
			end
			
			if p:GetAmmoCount("RPG_Round") > GetConVar("max_RPG_Round"):GetInt() then		
				p:RemoveAmmo( p:GetAmmoCount("RPG_Round") -GetConVar("max_RPG_Round"):GetInt(), "RPG_Round" )
			end
			
			if p:GetAmmoCount("SMG1") > GetConVar("max_SMG1"):GetInt() then		
				p:RemoveAmmo( p:GetAmmoCount("SMG1") -GetConVar("max_SMG1"):GetInt(), "SMG1" )
			end
			
			if p:GetAmmoCount("SMG1_Grenade") > GetConVar("max_SMG1_Grenade"):GetInt() then		
				p:RemoveAmmo( p:GetAmmoCount("SMG1_Grenade") - GetConVar("max_SMG1_Grenade"):GetInt(), "SMG1_Grenade" )
			end
		end
	end)
end

local neededVotes = #player.GetAll()
local lobbyVotes = 0

net.Receive("ReturnLobby", function(ply)
	for k, p in pairs(player.GetAll()) do
		p:ChatPrint(ply:Nick() .. " has voted to return to the lobby: " .. lobbyVotes .. "/" .. neededVotes)
	end
end)

function giveVortex(map, ply)
	if not string.find(table.ToString(ply.hl2cPersistent.Vortexes), map) then
		ply:SetNWString("Vortex", table.concat(ply.hl2cPersistent.Vortexes, " "))
		table.insert(ply.hl2cPersistent.Vortexes, map .. " ")
		ply:ChatPrint("You found the vortex in " .. map .. ", 500XP")
		AddXP(ply, 500)
		print(ply:Nick() .. " found vortex in " .. map)
	end	
	
	
end