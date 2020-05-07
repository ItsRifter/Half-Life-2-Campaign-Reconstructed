startingWeapons = startingWeapons or {}
hook.Add("PlayerInitialSpawn", "MiscSurv", function(ply)
	
	if GetConVar("hl2c_survivalmode"):GetInt() == 1 and ply:Alive() and not isAliveSurv then
		isAliveSurv = false
	end
	
	hasDiedOnce = false
end)


hook.Add("PlayerSpawn", "Misc", function(ply)
	ply.petAlive = false
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
	
	ply:GiveAmmo(15, "Pistol", false)
	ply:GiveAmmo(6, "357", false)
	ply:GiveAmmo(90, "SMG1", false)
	ply:GiveAmmo(60, "AR2", false)
	ply:GiveAmmo(15, "Buckshot", false)
	ply:GiveAmmo(2, "Grenade", false)
	
	ply:SetTeam(TEAM_ALIVE)
	ply:SetCustomCollisionCheck(true)
	ply:SetupHands()
	
	if game.GetMap() == "d1_trainstation_01" or game.GetMap() == "d1_trainstation_02" or game.GetMap() == "d1_trainstation_03" or
	game.GetMap() == "d1_trainstation_04" then
		ply:AllowFlashlight(false)
		ply:SetRunSpeed( 160 )
		ply:SetWalkSpeed( 120 )
	elseif game.GetMap() == "d1_trainstation_05" then
		for p, hevFlash in pairs(ents.FindByClass("item_suit")) do
			if hevFlash:IsValid() then
				ply:AllowFlashlight(false)
				ply:SetMaxSpeed( 160 )
			else
				ply:AllowFlashlight(true)
				ply:SetMaxSpeed( 240 )
			end
		end
	else
		ply:AllowFlashlight(true)
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

hook.Add("WeaponEquip", "WeaponPickedUp", function(weapon, ply)
	if weapon and weapon:IsValid() and weapon:GetClass() and not table.HasValue(startingWeapons, weapon:GetClass()) then
		table.insert(startingWeapons, weapon:GetClass())
		ply:Give(weapon:GetClass())
	end
	if weapon:GetClass() == "weapon_crowbar" and game.GetMap() == "d1_trainstation_06" then
		for k, v in pairs(player.GetAll()) do
			Achievement(v, "Crowbar", "HL2_Ach_List", 250)
		end
	end
end)

function RespawnTimerActive(ply, deaths)
	hasDiedOnce = true
	
	if GetConVar("hl2c_survivalmode"):GetInt() == 1 and game.GetMap() != "hl2c_lobby_remake" then
		ply:Lock()
		isAliveSurv = false
		local playersAlive = #player.GetAll()
		local playerDeaths = deaths

		print(playersAlive)
		print(playerDeaths)
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

	if GetConVarNumber("hl2c_respawntime") != 0 then
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

local deaths = 0
hook.Add("PlayerDeath", "RespawnTimer", function(victim, inflictor, attacker)
	if GetConVar("hl2c_survivalmode"):GetInt() == 1 then
		deaths = deaths + 1
	end
	AllowSpawn = true
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

local neededVotes = #player.GetAll()
local lobbyVotes = 0
net.Receive("ReturnLobby", function(ply)

	for k, p in pairs(player.GetAll()) do
		p:ChatPrint(ply:Nick() .. " has voted to return to the lobby: " .. lobbyVotes .. "/" .. neededVotes)
	end
end)

AFK_WARN_TIME = 300

AFK_TIME = 900

hook.Add("PlayerInitialSpawn", "MakeAFKVar", function(ply)
	ply.NextAFK = CurTime() + AFK_TIME
end)

hook.Add("Think", "HandleAFKPlayers", function()
	for _, ply in pairs (player.GetAll()) do
		if (ply:IsConnected() and ply:IsFullyAuthenticated() and not ply:IsAdmin()) then
			if (!ply.NextAFK) then
				ply.NextAFK = CurTime() + AFK_TIME
			end
		
			local afktime = ply.NextAFK
			if (CurTime() >= afktime - AFK_WARN_TIME) and (!ply.Warning) then
				ply:ChatPrint("|WARNING| User Inactive")
				ply:ChatPrint("You will be disconnected if you remain AFK")
				
				ply.Warning = true
			elseif (CurTime() >= afktime) and (ply.Warning) then
				ply.Warning = nil
				ply.NextAFK = nil
				ply:Kick("\nKicked for AFK since 15 minutes !")
			end
		end
	end
end)

hook.Add("KeyPress", "PlayerActive", function(ply, key)
	ply.NextAFK = CurTime() + AFK_TIME
	if ply.Warning == true then
		ply.Warning = false
		ply:ChatPrint("You are no longer AFK !")
	end
end)
