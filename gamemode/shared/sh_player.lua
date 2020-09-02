AddCSLuaFile() -- Add itself to files to be sent to the clients, as this file is shared
local startingWeapons = {}

hook.Add("PlayerInitialSpawn", "MiscSurv", function(ply)
	
	if GetConVar("hl2cr_survivalmode"):GetInt() == 1 and ply:Alive() and not ply.isAliveSurv then
		ply.isAliveSurv = false
	end
	
	ply.hasDiedOnce = false
	ply.crowbarOnly = true
end)


hook.Add("PlayerSpawn", "Misc", function(ply)
	local addHPUpg = 0
	local levelHPBoost = ply.hl2cPersistent.Level - 1
	local armourBoost = 0
	local addStats = 0
	
	if ply.loyal then
		ply:SetModel("models/player/combine_soldier.mdl")
	else
		ply:SetModel(ply.hl2cPersistent.Model)
	end
	
	if string.find(ply.hl2cPersistent.TempUpg, "Health Boost") then
		addHPUpg = addHPUpg + 5
	end
	
	ply.AllowSpawn = true
	ply.hasSeat = false
	
	if not isAliveSurv then
		ply:Kill()
		ply:ChatPrint("Nice try, don't do that next time")
		ply:Spectate(5)
	end
	
	if ply.hl2cPersistent.Arm == "hl2cr/armour_parts/health" then
		addStats = 10
	elseif ply.hl2cPersistent.Arm == "hl2cr/armour_parts/healthmk2" then
		addStats = 15
	elseif ply.hl2cPersistent.Arm == "hl2cr/armour_parts/battery" then
		armourBoost = 5
	end
	
	local maxHP = 100 + levelHPBoost + addHPUpg + addStats
	local starterArmour = armourBoost
	ply:SetMaxHealth(maxHP)
	ply:SetHealth(maxHP)
	ply:SetArmor(starterArmour)

	if ply.loyal then
		ply:SetTeam(TEAM_LOYAL)
		ply:SetCustomCollisionCheck(false)
		ply:SetupHands()
	else
		ply:SetTeam(TEAM_ALIVE)
		ply:SetCustomCollisionCheck(true)
		ply:SetupHands()
	end
	
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
				for k, v in pairs(player.GetAll()) do
					v:AllowFlashlight(true)
					v:SetRunSpeed( 240 )
					v:SetWalkSpeed( 180 )
				end
				RunConsoleCommand("gmod_suit", 1)
			end
		end
	else
		RunConsoleCommand("gmod_suit", 1)
		ply:AllowFlashlight(true)
	end
	
	if game.GetMap() == "d3_citadel_03" then
		ply:Give("weapon_physcannon")
	end
	
	if game.GetMap() == "d3_breen_01" then
		timer.Simple(1, function()
			local enterPod = ents.FindByName("pod")
			if enterPod[1]:IsValid() then
				ply:EnterVehicle(enterPod[1])
			end
		end)
	end
end)

function GM:DoPlayerDeath(ply, attacker, dmgInfo)
	ply:CreateRagdoll()
	ply:SetTeam(TEAM_DEAD)
end

hook.Add("PlayerHurt", "PlayerRecover", function(vic, att, hp, dmg)
	if string.find(vic.hl2cPersistent.TempUpg, "Self Healing") then
		if not timer.Exists("HealingTimer") then
			timer.Create("HealingTimer", 30, 0, function()
				if vic:Health() <= vic:GetMaxHealth() then
					vic:SetHealth(vic:Health() + 5)
					if vic:Health() >= vic:GetMaxHealth() then
						vic:SetHealth(vic:GetMaxHealth())
						timer.Remove("HealingTimer")
					end
				end
			end)
		end
	end
end)

hook.Add("CanExitVehicle", "PodCannotExit", function(veh, ply)
	if game.GetMap() == "d3_citadel_01" or game.GetMap() == "d3_breen_01" then
		return false
	end
	
	return true
end)

hook.Add("CanPlayerSuicide", "DefaultSuicide", function(ply)

	if game.GetMap() == "hl2c_lobby_remake" or game.GetMap() == "d1_trainstation_01" or game.GetMap() == "d1_trainstation_02" or game.GetMap() == "d1_trainstation_03" 
	or game.GetMap() == "d1_trainstation_04" or game.GetMap() == "d1_trainstation_05" or game.GetMap() == "d3_citadel_01" or game.GetMap() == "d3_citadel_05" or game.GetMap() == "d3_breen_01" then
		ply:ChatPrint("You can't commit suicide on this map!")
		return false
		
	elseif GetConVar("hl2cr_allowsuicide"):GetInt() == 0 then
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
	if ply:Team() != TEAM_ALIVE or (attacker:IsPlayer() and attacker != ply) or (attacker:IsPlayer() and attacker:InVehicle()) then
		return false
	end
	
	if attacker:GetClass() == "npc_rollermine" and game.GetMap() == "d1_eli_02" then
		return false
	end
	
	if attacker:IsPlayer() and attacker:Team() == TEAM_LOYAL then
		return true
	end
	
	return true
end)

hook.Add("ScalePlayerDamage", "DiffScalingPly", function( ply, hitgroup, dmgInfo )
	local attacker = dmgInfo:GetAttacker()	 
	local dmg = dmgInfo:GetDamage()
	
	 
	if attacker:IsPlayer() and attacker:Team() == TEAM_LOYAL then 
		dmgInfo:ScaleDamage(1.35)
		return
	else
		dmgInfo:SetDamage(0)
		return 
	end
	
	if hitgroup == HITGROUP_HEAD and GetConVar("hl2cr_difficulty"):GetInt() != 1 then
		dmgInfo:ScaleDamage( 1.25 * GetConVar("hl2cr_difficulty"):GetInt())
		return
	elseif hitgroup == HITGROUP_CHEST and GetConVar("hl2cr_difficulty"):GetInt() != 1 then
		dmgInfo:ScaleDamage( 1 * GetConVar("hl2cr_difficulty"):GetInt())
		return
	else
		dmgInfo:ScaleDamage( 0.75 * GetConVar("hl2cr_difficulty"):GetInt())
		return
	end
end)

local pickedOnce = false

hook.Add("PlayerCanPickupWeapon", "DisableWeaponsPickup", function(ply, weapon) 
	if ply:Team() == TEAM_LOYAL then
		return true
	end
	
	if weapon:GetClass() == "weapon_357" and ply:GetAmmoCount("357") >= GetConVar("max_357"):GetInt() then
		return false
	end
	
	if weapon:GetClass() == "weapon_ar2" and ply:GetAmmoCount("AR2") >= GetConVar("max_AR2"):GetInt() then
		return false
	end
	
	if weapon:GetClass() == "weapon_shotgun" and ply:GetAmmoCount("Buckshot") >= GetConVar("max_Buckshot"):GetInt() then
		return false
	end
	
	if weapon:GetClass() == "weapon_crossbow" and ply:GetAmmoCount("XBowBolt") >= GetConVar("max_crossbowbolt"):GetInt() then
		return false
	end
	
	if weapon:GetClass() == "weapon_pistol" and ply:GetAmmoCount("Pistol") >= GetConVar("max_Pistol"):GetInt() then
		return false
	end
	
	if weapon:GetClass() == "weapon_rpg" and ply:GetAmmoCount("RPG_Round") >= GetConVar("max_RPG_Round"):GetInt() then
		return false
	end
	
	if weapon:GetClass() == "weapon_smg1" and ply:GetAmmoCount("SMG1") >= GetConVar("max_SMG1"):GetInt() then
		return false
	end
	
	
	if ply:Team() != TEAM_ALIVE or weapon:GetClass() == "weapon_stunstick" or (weapon:GetClass() == "weapon_physgun" and not ply:IsAdmin()) then
		weapon:Remove()
		return false
	end
	
	if ply:Team() != TEAM_ALIVE or (game.GetMap() == "d3_citadel_03" or game.GetMap() == "d3_citadel_04" or game.GetMap() == "d3_citadel_05" or game.GetMap() == "d3_breen_01") and weapon:GetClass() != "weapon_physcannon" then
		weapon:Remove()
		return false
	end

	return true
end)

function GM:GetFallDamage( ply, speed )
    return ( speed / 16 )
end

hook.Add("Think", "HasWeaponThink", function()
	for k, curWep in pairs(startingWeapons) do
		for k, v in pairs(player.GetAll()) do
			if not v:HasWeapon(curWep) then
				v:Give(curWep)
			end
		end
	end
end)

hook.Add("PlayerLoadout", "StarterWeapons", function(ply)
	if (game.GetMap() == "hl2c_lobby_remake") then
		ply:Give("weapon_crowbar")
		ply:Give("weapon_physcannon")
		if ply:IsAdmin() then
			ply:Give("weapon_physgun")
		end
	end
	
	if #startingWeapons > 0 then
		for k, wep in pairs(startingWeapons) do
			ply:Give(wep)
		end
	end
	
	for k, v in pairs(player.GetAll()) do
		if v:GetWeapons() != nil and ply:GetWeapons() != v:GetWeapons() and game.GetMap() != "hl2c_lobby_remake" then
			for k, w in pairs(v:GetWeapons()) do
				ply:Give(w:GetClass())
			end	
		end
	end
	
	if ply.loyal then
		ply:Give("weapon_stunstick")
	end
	
	if game.GetMap() == "d1_town_02" and file.Exists("hl2cr_data/d1_town_02.txt", "DATA") then 
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
	if weapon:GetClass() != "weapon_frag" then 
		table.insert(startingWeapons, weapon:GetClass())
	end

	if weapon:GetClass() == "weapon_crowbar" and game.GetMap() == "d1_trainstation_06" then
		for k, v in pairs(player.GetAll()) do
			Achievement(v, "Trusty_Hardware", "HL2_Ach_List", 250)
		end
	end
end)

hook.Add("PlayerDeathThink", "SpecThink", function(ply)	
	return false
end)

function RespawnTimerActive(ply, deaths)
	ply.hasDiedOnce = true
	
	timer.Simple(5, function()
		SpectateMode(ply)
	end)
	
	if GetConVar("hl2cr_survivalmode"):GetInt() == 1 and game.GetMap() != "hl2c_lobby_remake" then
		ply.isAliveSurv = false
		local playersAlive = #player.GetAll()
		local playerDeaths = deaths
		
		ply:ChatPrint("You have died, awaiting next checkpoint")
		
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

	if GetConVarNumber("hl2cr_respawntime") ~= 0 and not timer.Exists("ResTime") then

		timer.Create("ResTime", GetConVarNumber("hl2cr_respawntime") * GetConVarNumber("hl2cr_difficulty"), 0, function()
			ply:Spawn()
			DisableSpec()
			timer.Remove("ResTime")
		end)
	end
end

deaths = 0
hook.Add("PlayerDeath", "RespawnTimer", function(victim, inflictor, attacker)
	if GetConVar("hl2cr_survivalmode"):GetInt() == 1 then
		deaths = deaths + 1
	end
	RespawnTimerActive(victim, deaths)
end)

function GM:IsSpawnpointSuitable( ply, spawnpointent, bMakeSuitable )
	return true
end

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

hook.Add("PlayerCanPickupItem", "AmmoPickup", function(ply, item)
	if item:GetClass() == "item_ammo_357" and ply:GetAmmoCount("357") >= GetConVar("max_357"):GetInt() then
		ply:RemoveAmmo( ply:GetAmmoCount("357") -GetConVar("max_357"):GetInt(), "357" )
		return false
	end
	
	if item:GetClass() == "item_ammo_ar2" and ply:GetAmmoCount("AR2") >= GetConVar("max_AR2"):GetInt() then		
		ply:RemoveAmmo( ply:GetAmmoCount("AR2") -GetConVar("max_AR2"):GetInt(), "AR2" )
		return false
	end
	
	if item:GetClass() == "item_ammo_ar2_altfire" and ply:GetAmmoCount("AR2AltFire") >= GetConVar("max_ar2_ball"):GetInt() then		
		ply:RemoveAmmo( ply:GetAmmoCount("AR2AltFire") -GetConVar("max_ar2_ball"):GetInt(), "AR2AltFire" )
		return false
	end
	
	if item:GetClass() == "item_box_buckshot" and ply:GetAmmoCount("Buckshot") >= GetConVar("max_Buckshot"):GetInt() then		
		ply:RemoveAmmo( ply:GetAmmoCount("Buckshot") -GetConVar("max_Buckshot"):GetInt(), "Buckshot" )
		return false
	end
	
	if item:GetClass() == "item_ammo_crossbow" and ply:GetAmmoCount("XBowBolt") >= GetConVar("max_crossbowbolt"):GetInt() then		
		ply:RemoveAmmo( ply:GetAmmoCount("XBowBolt") -GetConVar("max_crossbowbolt"):GetInt(), "XBowBolt" )
		return false
	end

	if item:GetClass() == "waepon_frag" and ply:GetAmmoCount("Grenade") >= GetConVar("max_grenade"):GetInt() then		
		ply:RemoveAmmo( ply:GetAmmoCount("Grenade") -GetConVar("max_grenade"):GetInt(), "Grenade" )
		return false
	end

	if item:GetClass() == "weapon_slam" and ply:GetAmmoCount("slam") >= GetConVar("max_slam"):GetInt() then		
		ply:RemoveAmmo( ply:GetAmmoCount("slam") -GetConVar("max_slam"):GetInt(), "slam" )
		return false
	end
	
	if item:GetClass() == "item_ammo_pistol" and ply:GetAmmoCount("Pistol") >= GetConVar("max_Pistol"):GetInt() then		
		ply:RemoveAmmo( ply:GetAmmoCount("Pistol") -GetConVar("max_Pistol"):GetInt(), "Pistol" )
		return false
	end
	
	if item:GetClass() == "item_rpg_round" and ply:GetAmmoCount("RPG_Round") >= GetConVar("max_RPG_Round"):GetInt() then		
		ply:RemoveAmmo( ply:GetAmmoCount("RPG_Round") -GetConVar("max_RPG_Round"):GetInt(), "RPG_Round" )
		return false
	end
	
	if item:GetClass() == "item_ammo_smg1" and ply:GetAmmoCount("SMG1") >= GetConVar("max_SMG1"):GetInt() then		
		ply:RemoveAmmo( ply:GetAmmoCount("SMG1") -GetConVar("max_SMG1"):GetInt(), "SMG1" )
		return false
	end
	
	if item:GetClass() == "item_ammo_smg1_grenade" and ply:GetAmmoCount("SMG1_Grenade") >= GetConVar("max_SMG1_Grenade"):GetInt() then		
		ply:RemoveAmmo( ply:GetAmmoCount("SMG1_Grenade") - GetConVar("max_SMG1_Grenade"):GetInt(), "SMG1_Grenade" )
		return false
	end
	
	if item:GetClass() == "item_battery" then
		return true
	end
	
	if item:GetClass() == "item_healthvial" then
		return true
	end
	
	if item:GetClass() == "item_healthkit" then
		return true
	end
end)


function giveVortex(map, ply)
	if not string.find(table.ToString(ply.hl2cPersistent.Vortexes), map) then
	
		table.insert(ply.hl2cPersistent.Vortexes, map)
		Special(ply, map, "HL2_Vortex", 250)

		timer.Simple(0.01, function()
			local effectdata = EffectData()
			effectdata:SetOrigin(ply:GetPos())
			effectdata:SetScale(1.50)
			effectdata:SetMagnitude(0.05)
			util.Effect( "cball_explode", effectdata )
			ply:EmitSound("ambient/energy/zap7.wav", 100, 100)
		end)
	end	
end

function giveLambda(map, ply)
	if not string.find(table.ToString(ply.hl2cPersistent.Lambdas), map) then
		table.insert(ply.hl2cPersistent.Lambdas, map)
		Special(ply, map, "HL2_Lambda", 250)
	end
	
	if table.Count(ply.hl2cPersistent.Lambdas) == 34 then
		Achievement(ply, "Lambda_Locator", "HL2_Ach_List", 5000)
	end
end