AddCSLuaFile() -- Add itself to files to be sent to the clients, as this file is shared
local startingWeapons = {}

hook.Add("PlayerInitialSpawn", "MiscSurv", function(ply)
	
	if GetConVar("hl2cr_survivalmode"):GetInt() == 1 and ply:Alive() and not ply.isAliveSurv then
		ply.isAliveSurv = false
	end
	if not game.SinglePlayer( ) then
		ply:SetCustomCollisionCheck( true );
	end
	ply.respawnTimer = 0
	ply.hasDiedOnce = false
	ply.crowbarOnly = true
	
	ply.BringPet = true
	
	ply.inSquad = false
	ply.canBecomeLoyal = false
	ply.loyal = false
end)


hook.Add("PlayerSpawn", "Misc", function(ply)
	
	--Give spawning items to player first
	for i, w in pairs(ents.FindByName("player_spawn_items")) do
		w:SetPos(ply:GetPos())
	end

	ply.isSpec = false

	local addHPUpg = 0
	local levelHPBoost = ply.hl2cPersistent.Level - 1
	local armourBoost = 0
	local addStatsHP = 0
	
	if string.find(ply.hl2cPersistent.TempUpg, "Health_Boost") then
		addHPUpg = addHPUpg + 5
	end
	
	ply.AllowSpawn = true
	ply.hasSeat = false
	
	if not isAliveSurv then
		ply:Kill()
		ply:ChatPrint("Nice try, don't do that next time")
		ply:Spectate(5)
	end
	for i, armSet in pairs(GAMEMODE.ArmourItem) do
		if ply.hl2cPersistent.Arm == "Health_Module_MK1" then
			addStatsHP = 5
			
		elseif ply.hl2cPersistent.Arm == "Health_Module_MK2" then
			addStatsHP = 10
			
		elseif ply.hl2cPersistent.Arm == "Health_Module_MK3" then
			addStatsHP = 15

		elseif ply.hl2cPersistent.Arm == "Suit_Battery_Pack_MK1" then
			armourBoost = 5
			
		elseif ply.hl2cPersistent.Arm == "Suit_Battery_Pack_MK2" then
			armourBoost = 10
			
		elseif ply.hl2cPersistent.Arm == "Suit_Battery_Pack_MK3" then
			armourBoost = 15
		end
	end
	
	
	local maxHP = 100 + levelHPBoost + addHPUpg + addStatsHP
	
	ply:SetMaxHealth(maxHP)
	ply:SetHealth(maxHP)
	ply:SetArmor(armourBoost)

	if not ply.loyal then
		ply:SetTeam(TEAM_ALIVE)
		--ply:SetCustomCollisionCheck(true)
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
	
	if game.GetMap() == "d3_breen_01" then
		timer.Simple(1, function()
			local enterPod = ents.FindByName("pod")
			if enterPod[1]:IsValid() then
				ply:EnterVehicle(enterPod[1])
			end
		end)
	end
	
	if game.GetMap() == "d3_citadel_03" then
		ply:Give("weapon_physcannon")
	end
end)

function GM:DoPlayerDeath(ply, attacker, dmgInfo)
	ply:CreateRagdoll()
	ply:SetTeam(TEAM_DEAD)
	
	net.Start("DisplayDeathTimer")
	net.WriteInt(GetConVar("hl2cr_difficulty"):GetInt() * GetConVar("hl2cr_respawntime"):GetInt(), 16)
	net.Send(ply)
end

local tempUpgHealTime = 0

hook.Add("PlayerHurt", "PlayerRecover", function(vic, att, hp, dmg)	
	tempUpgHealTime = 60 + CurTime()
	beginHealingTimer(vic)
end)

function beginHealingTimer(ply)
	local healthBoost = 0
	
	if not ply then return end
	
	if string.find(ply.hl2cPersistent.TempUpg, "Self_Healing") then
		healthBoost = healthBoost + 5
	end
	
	if string.find(ply.hl2cPersistent.TempUpg, "Self_Healing_2") then 
		healthBoost = healthBoost + 10
	end
	
	if string.find(ply.hl2cPersistent.TempUpg, "Self_Healing_3") then 
		healthBoost = healthBoost + 15
	end
	
	if healthBoost == 0 then return end
	hook.Add("Think", "healingThink", function()
		if tempUpgHealTime <= CurTime() then
			if ply:Health() <= ply:GetMaxHealth() and ply:IsValid() then
				ply:SetHealth(ply:Health() + healthBoost)
				if ply:Health() >= ply:GetMaxHealth() then
					ply:SetHealth(ply:GetMaxHealth())
				end
				tempUpgHealTime = 60 + CurTime() 
			end
		end
	end)
end

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

hook.Add("EntityTakeDamage", "BlastResist", function(ent, dmgInfo)
	local attacker = dmgInfo:GetAttacker()
	local dmg = dmgInfo:GetDamage()
	local dmgType = dmgInfo:GetDamageType()
	local expResist = 0
	
	if ent:IsPlayer() then 
		if string.find(ent.hl2cPersistent.TempUpg, "Blast_Resistance") then
			expResist = 50
		end
	end
	
	if attacker and ent:IsPlayer() and ent:IsPet() then
		dmgInfo:SetDamage(0)
	elseif not ent:IsPlayer() then
		dmgInfo:SetDamage(dmg)
	end
	
	if ent:IsPlayer() and dmgType == DMG_BLAST then
		dmgInfo:SetDamage(dmg - expResist)
	end
	
end)

hook.Add("PlayerShouldTakeDamage", "DisablePVP", function(ply, attacker)	
	if attacker == ply then
		return true
	end
	
	if attacker:IsPlayer() and (attacker:Team() == TEAM_ALIVE or attacker:Team() == TEAM_COMPLETED_MAP or attacker:Team() == TEAM_DEAD) then
		return false
	end
	
	if attacker:IsNPC() and (attacker:GetClass() != "npc_rollermine" and game.GetMap() != "d1_eli_02") then 
		return true 
	end
	
	if not attacker:IsPlayer() and attacker:EntIndex() == 0 then
		return true
	end
	
	if ply:Team() == TEAM_LOYAL and attacker:Team() == TEAM_LOYAL then
		return false
	end
		
	if (attacker:IsNPC() and attacker:GetClass() == "npc_rollermine") and game.GetMap() == "d1_eli_02" then
		return false
	end
	
	return true
end)

hook.Add("ScalePlayerDamage", "DiffScalingPly", function( ply, hitgroup, dmgInfo )
	local attacker = dmgInfo:GetAttacker()	
	local inflictor = dmgInfo:GetInflictor()
	local dmg = dmgInfo:GetDamage()
	local scaling = 0

	if attacker:IsPlayer() and attacker:Team() == TEAM_LOYAL then
		if (ply:IsPlayer() and ply:Team() == TEAM_ALIVE) and (attacker:IsPlayer() and attacker:Team() == TEAM_LOYAL) then
			if hitgroup == HITGROUP_HEAD then
				dmgInfo:ScaleDamage(0.75)
			elseif hitgroup == HITGROUP_CHEST then
				dmgInfo:ScaleDamage(0.65)
			end
		elseif (ply:IsPlayer() and ply:Team() == TEAM_LOYAL) and (attacker:IsPlayer() and attacker:Team() == TEAM_ALIVE) then
			dmgInfo:ScaleDamage(0.75)
		end
	elseif not attacker:IsPlayer() then
		local armour = ply.hl2cPersistent.Armour / 36
		if hitgroup == HITGROUP_HEAD and GetConVar("hl2cr_difficulty"):GetInt() != 1 then
			dmgInfo:ScaleDamage((1.25 * GetConVar("hl2cr_difficulty"):GetInt()) - armour)
			return
		elseif hitgroup == HITGROUP_CHEST and GetConVar("hl2cr_difficulty"):GetInt() != 1 then
			dmgInfo:ScaleDamage((1 * GetConVar("hl2cr_difficulty"):GetInt()) - armour)
			return
		end
	end
	
	
end)

hook.Add("PlayerCanPickupWeapon", "DisableWeaponsPickup", function(ply, weapon) 
	if ply:Team() == TEAM_LOYAL then
		return false
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
			if v:Team() == TEAM_ALIVE then
				if not v:HasWeapon(curWep) then
					v:Give(curWep)
				end
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
		
	if ply.loyal then		
		ply:SetTeam(TEAM_LOYAL)
		--ply:SetCustomCollisionCheck(false)
		ply:SetupHands()
		
		ply:SetModel("models/player/combine_soldier.mdl")
		ply:Give("weapon_stunstick")
		
		local weaponsRand = math.random(1, 3)
		local statsRand = math.random(1, 3)
		
		if weaponsRand == 1 then
			ply:Give("weapon_smg1")
			ply:GiveAmmo(225, "SMG1", true)
			ply:GiveAmmo(3, "weapon_frag", true)
		elseif weaponsRand == 2 then
			ply:Give("weapon_ar2")
			ply:GiveAmmo(60, "AR2", true)
			ply:GiveAmmo(3, "weapon_frag", true)
		elseif weaponsRand == 3 then
			ply:Give("weapon_shotgun")
			ply:GiveAmmo(30, "Buckshot", true)
			ply:GiveAmmo(3, "weapon_frag", true)
		end
		
		if statsRand == 1 then
			ply:SetMaxHealth(125)
			ply:SetHealth(125)
			ply:SetArmor(35)
		elseif statsRand == 2 then
			ply:SetMaxHealth(150)
			ply:SetHealth(150)
			ply:SetArmor(65)
		elseif statsRand == 3 then
			ply:SetMaxHealth(200)
			ply:SetHealth(200)
			ply:SetArmor(100)
		end
		
		if game.GetMap() == "d2_coast_10" then
			local randSpot = math.random(1, 3)
			if randSpot == 1 then
				ply:SetPos(Vector(6111, 208, 941))
			elseif randSpot == 2 then
				ply:SetPos(Vector(8226, 1486, 1235))
			elseif randSpot == 3 then
				ply:SetPos(Vector(5362, 1026, 1078))
			end
		end
	else
		ply:SetModel(ply.hl2cPersistent.Model)
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
	
	if #startingWeapons > 0 then
		for k, wep in pairs(startingWeapons) do
			ply:Give(wep)
		end
	end
	
	for k, v in pairs(player.GetAll()) do
		if v:Team() == TEAM_LOYAL or ply:Team() == TEAM_LOYAL then return end
		
		if v:GetWeapons() != nil and ply:GetWeapons() != v:GetWeapons() and game.GetMap() != "hl2c_lobby_remake" then
			for k, w in pairs(v:GetWeapons()) do
				ply:Give(w:GetClass())
			end	
		end
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
	if weapon:GetClass() != "weapon_frag" and ply:Team() == TEAM_ALIVE then 
		table.insert(startingWeapons, weapon:GetClass())
	end

	if weapon:GetClass() == "weapon_crowbar" and game.GetMap() == "d1_trainstation_06" then
		for k, v in pairs(player.GetAll()) do
			Achievement(v, "Trusty_Hardware", "HL2_Ach_List")
		end
	end
end)

hook.Add("PlayerDeathThink", "SpecThink", function(ply)		
	return false
end)

net.Receive("Squad_Disband", function(len, ply)
	ply.inSquad = false
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
					Achievement(v, "Survival_Lost", "Misc_Ach_List")
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

	if GetConVarNumber("hl2cr_respawntime") != 0 then
		if ply:Team() != TEAM_ALIVE then
			ply.respawnTimer = (GetConVarNumber("hl2cr_respawntime") * GetConVarNumber("hl2cr_difficulty")) + CurTime()
		end
	end
end

hook.Add("Think", "RespawnPlayersTimer", function()
	for k, p in pairs (player.GetAll()) do
		if not p.respawnTimer then return end
		if GetConVar("hl2cr_survivalmode"):GetInt() == 1 then return end
		if CurTime() >= p.respawnTimer then
			if not p:Alive() then
				p:Spawn()
			end
		end
	end
end)

deaths = 0
totalXPLoyal = 0
hook.Add("PlayerDeath", "RespawnTimer", function(victim, inflictor, attacker)
	victim.isSpec = true
	
	if attacker:IsPlayer() and attacker:Team() == TEAM_LOYAL then
		local giveLoyalXP = math.random(15, 150)
		attacker.totalXPLoyal = totalXPLoyal + giveLoyalXP
	end
	
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
	if not table.HasValue(ply.hl2cPersistent.Vortexes, map) then
	
		table.insert(ply.hl2cPersistent.Vortexes, map)
		Special(ply, map, "HL2_Vortex", 750)

		timer.Simple(0.01, function()
			local effectdata = EffectData()
			effectdata:SetOrigin(ply:GetPos())
			effectdata:SetScale(1.50)
			effectdata:SetMagnitude(0.05)
			util.Effect( "cball_explode", effectdata )
			ply:EmitSound("ambient/energy/zap7.wav", 100, 100)
		end)
	end
	
	if table.Count(ply.hl2cPersistent.Vortexes) == 24 then
		Achievement(ply, "Vortex_Locator", "HL2_Ach_List")
	end
end

function giveLambda(map, ply)
	if not table.HasValue(ply.hl2cPersistent.Lambdas, map) then
		table.insert(ply.hl2cPersistent.Lambdas, map)
		Special(ply, map, "HL2_Lambda", 500)
	end
	
	if table.Count(ply.hl2cPersistent.Lambdas) == 34 then
		Achievement(ply, "Lambda_Locator", "HL2_Ach_List")
	end
end