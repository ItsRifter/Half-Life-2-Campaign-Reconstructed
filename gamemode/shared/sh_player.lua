AddCSLuaFile() -- Add itself to files to be sent to the clients, as this file is shared
startingWeapons = startingWeapons or {}

local RESTRICTED_WEPS = {
	["weapon_frag"] = true,
	["weapon_medkit"] = true,
	["zpn_partypopper"] = true,
	["hlashotty"] = true,
	["tfa_psmg"] = true,
	["the rusted bangstick"] = true,
	["tfa_heavyshotgun"] = true,
	["the bfhmg"] = true,
}

local GIVE_STARTER_WEAPONS = {
	["One_Handed_Autogun"] = "hlashotty",
	["Unbonded_Pulse_Rifle"] = "tfa_psmg",
	["Heavy_Shotgun"] = "tfa_heavyshotgun",
	["Rusty_DB"] = "the rusted bangstick",
	["BF_HMG"] = "the bfhmg",
	["Medkit"] = "weapon_medkit",
}

local RESTRICTED_MAPS = {
	["d1_trainstation_01"] = true,
	["d1_trainstation_02"] = true,
	["d1_trainstation_03"] = true,
	["d1_trainstation_04"] = true,
	["d1_trainstation_05"] = true,
	["d3_citadel_03"] = true,
	["d3_citadel_04"] = true,
	["d3_citadel_05"] = true,
	["d3_breen_01"] = true,
	["ep1_citadel_01"] = true,
	["ep1_citadel_02"] = true,
	["ep1_citadel_04"] = true,
}

net.Receive("UpdateOptions", function(len, ply)
	local optionToChange = net.ReadString()
	
	if optionToChange == "hl2cr_quickinfo" and ply.hl2cPersistent.Options.QuickInfo == 1 then
		ply.hl2cPersistent.Options.QuickInfo = 0
	elseif optionToChange == "hl2cr_quickinfo" and ply.hl2cPersistent.Options.QuickInfo == 0 then
		ply.hl2cPersistent.Options.QuickInfo = 1
	end
end)
hook.Add("PlayerInitialSpawn", "MiscSurv", function(ply)

	ply.Tank = {
		name = ply,
		tankSharedXP = 0,
		tankDmg = 0,
	}

	if ply.hl2cPersistent.SquadLeader != false then
		timer.Simple(1, function()
			HL2CR_Squad:ResumeSquad(ply:Nick(), ply)
		end)
	end
	
	for k, pet in pairs(ents.GetAll()) do
		if pet:IsPet() then
			pet:AddEntityRelationship(ply, D_LI, 99)
		end
	end

	if game.GetMap() == "d2_lostcoast" then
		Achievement(ply, "Lost_Coast", "HL2_Ach_List")
	end

	ply.sprintPower = 0
	timer.Simple(0.1, function()
		ply:UnSpectate()
	end)
	
	if not table.HasValue(ply.hl2cPersistent.Achievements, "First_Time") then
		Achievement(ply, "First_Time", "Lobby_Ach_List")
	end
	
	if not string.match(game.GetMap(), "d1_") and not string.match(game.GetMap(), "d2_") and not string.match(game.GetMap(), "d3_") and not
	string.match(game.GetMap(), "ep1_") and not string.match(game.GetMap(), "ep2_") then	
		ply.XPCap = math.ceil(ply.hl2cPersistent.MaxXP / ply.hl2cPersistent.MaxXP) - 100		
		ply.PetXPCap = math.ceil(ply.hl2cPersistent.PetMaxXP / 1.6)
		ply.totalXPGained = 0
		ply.totalPetXPGained = 0
	end
	
	if table.HasValue(ply.hl2cPersistent.Achievements, "Crowbar_Only_HL2") and table.HasValue(ply.hl2cPersistent.Achievements, "Crowbar_Only_EP1") 
	and table.HasValue(ply.hl2cPersistent.Achievements, "Crowbar_Only_EP2") then
		Achievement(ply, "One_True_Freeman", "Misc_Ach_List")
	end

	local red = ply.hl2cPersistent.NPCColourSettings.r
	local blue = ply.hl2cPersistent.NPCColourSettings.b
	local green = ply.hl2cPersistent.NPCColourSettings.g
	local alpha = ply.hl2cPersistent.NPCColourSettings.a
	
	if ply.hl2cPersistent.NPCColourEnabled then
		net.Start("SendClientColours")
			net.WriteColor(Color(red, green, blue, alpha))
			net.WriteBool(ply.hl2cPersistent.NPCColourEnabled)
			net.WriteString(ply.hl2cPersistent.NPCFont)
		net.Send(ply)
	end
	
	ply.canEarnCrowbar = false
	
	ply.tableRewards = {
		["HasDied"] = false,
		["CrowbarOnly"] = false,
		["Kills"] = 0,
		["Metal"] = 0,
		["Essence"] = 0,
		["Crystals"] = 0,
	}
	
	if game.GetMap() == "hl2cr_lobby" then
		ply.hl2cPersistent.OTF = false
	end

	if game.GetMap() == "ep1_citadel_01" and not table.HasValue(ply.hl2cPersistent.Achievements, "Crowbar_Only_EP1") then
		ply.EnableOTF = true
	end
	
	if game.GetMap() == "ep2_outland_01a" and not table.HasValue(ply.hl2cPersistent.Achievements, "Crowbar_Only_EP2") then
		ply.EnableOTF = true
	end
	
	if not fixAI and string.match(game.GetMap(), "ep1_") then
		timer.Simple(1, function()
			fixAI = true
			game.CleanUpMap(false)
		end)
	end
	
	ply.respawnTimer = 0
	ply.hasDiedOnce = false
	
	ply.BringPet = true
	
	ply.inSquad = false
	ply.canBecomeLoyal = false
	ply.loyal = false
	
	
	if ply.hl2cPersistent.Level >= ply.hl2cPersistent.LevelCap and ply.hl2cPersistent.Prestige < 7 then
		ply:ChatPrint("You will not earn anymore XP at this point, try !prestige")
	end
	timer.Simple(2, function()
		net.Start("UpdateConCmds")
			net.WriteInt(ply.hl2cPersistent.Options.QuickInfo, 8)
		net.Send(ply)
	end)
end)

hook.Add("EventPickUp", "EventItems", function(ply, amount)
	if not ply then return end
	ply.hl2cPersistent.EventItems = ply.hl2cPersistent.EventItems + amount
end)

net.Receive("UpdateNPCColour", function(len, ply)
	local colours = net.ReadColor()
	local enabled = net.ReadBool()
	local font = net.ReadString()
	
	if not ply then return end
	
	ply.hl2cPersistent.NPCColourSettings = Color(colours.r, colours.b, colours.g, colours.a)
	if enabled ~= nil then
		ply.hl2cPersistent.NPCColourEnabled = enabled
	end
	
	ply.hl2cPersistent.NPCFont = font
	
	--Send the client the new colours to their hud
	net.Start("SendClientColours")
		net.WriteColor(ply.hl2cPersistent.NPCColourSettings)
		net.WriteBool(ply.hl2cPersistent.NPCColourEnabled)
		net.WriteString(ply.hl2cPersistent.NPCFont)
	net.Send(ply)
	
end)
deadPlayers = 0
hook.Add("PlayerSpawn", "SpawnDefault", function(ply)
	
	if ply:IsBot() then 
		ply:SetTeam(TEAM_ALIVE)
		return
	end	
	ply:SetCustomCollisionCheck(true)
	ply:SetNoCollideWithTeammates(true)
	
	ply.Tank = {
		name = ply,
		tankSharedXP = 0,
		tankDmg = 0,
	}
	
	if deadPlayers < 0 then
		deadPlayers = 0
	end
	ply:UnSpectate()
	
	if table.HasValue(Cheating_Players_Survival, ply:Nick())then
		timer.Simple(0.1, function()
			ply:SetTeam(TEAM_DEAD)
			ply:ChatPrint("Nice try, don't rejoin while on survival")
			ply:Kill()
			table.remove(Cheating_Players_Survival, ply:Nick())
		end)
	end
	
	ply.waitVehicleSpawn = 0
	ply.petSpawntime = 0
	ply.petbringTime = 0
	ply.sprintPower = 0
	if table.HasValue(ply.hl2cPersistent.PermUpg, "Suit_Power_Boost") then
		ply:SetSuitPower(math.Clamp(150, 1, 100))
		ply.sprintPower = 150
	end
	
	if game.GetMap() == "hl2cr_lobby" and file.Exists("hl2cr_data/maprecovery.txt", "DATA") then
		ply:ChatPrint("It appears the server crashed or something went wrong")
		ply:ChatPrint("If no admins are present, type !restore")
	end
	
	--Give spawning items to player first
	for i, w in pairs(ents.FindByName("player_spawn_items")) do
		w:SetPos(ply:GetPos())
	end

	local addHPUpg = 0
	local levelHPBoost = ply.hl2cPersistent.Level - 1
	local armourBoost = 0
	local addStatsHP = 0
	
	if table.HasValue(ply.hl2cPersistent.TempUpg, "Health_Boost") then
		addHPUpg = addHPUpg + 5
	end
	
	ply.AllowSpawn = true
	ply.hasSeat = false
	
	if ply.hl2cPersistent.Arm == "Health_Module_MK1" then
		addStatsHP = 5
		
	elseif ply.hl2cPersistent.Arm == "Health_Module_MK2" then
		addStatsHP = 10
		
	elseif ply.hl2cPersistent.Arm == "Health_Module_MK3" then
		addStatsHP = 20

	elseif ply.hl2cPersistent.Arm == "Suit_Battery_Pack_MK1" then
		armourBoost = 5
		
	elseif ply.hl2cPersistent.Arm == "Suit_Battery_Pack_MK2" then
		armourBoost = 10
		
	elseif ply.hl2cPersistent.Arm == "Suit_Battery_Pack_MK3" then
		armourBoost = 30
	end
	
	
	local maxHP = 100 + levelHPBoost + addHPUpg + addStatsHP
	
	ply:SetMaxHealth(maxHP)
	ply:SetHealth(maxHP)
	ply:SetArmor(armourBoost)

	if not ply.loyal and ply:Team() ~= TEAM_COMPLETED_MAP then
		ply:SetTeam(TEAM_ALIVE)
		--ply:SetCustomCollisionCheck(true)
		ply:SetupHands()
	end
	
	if game.GetMap() == "d1_trainstation_01" or game.GetMap() == "d1_trainstation_02" or game.GetMap() == "d1_trainstation_03" or
	game.GetMap() == "d1_trainstation_04" then
		ply:AllowFlashlight(false)
		ply:SetRunSpeed( 160 )
		ply:SetWalkSpeed( 120 )
	elseif game.GetMap() == "d1_trainstation_05" then
		for p, hevFlash in pairs(ents.FindByClass("item_suit")) do
			if hevFlash:IsValid() then
				ply:AllowFlashlight(false)
			elseif not hevFlash:IsValid() then 
				for k, v in pairs(player.GetAll()) do
					v:AllowFlashlight(true)
					v:SetRunSpeed( 240 )
					v:SetWalkSpeed( 180 )
				end
			end
		end
	else
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

hook.Add("DoPlayerDeath", "DefaultDeaths", function(ply, attacker, dmgInfo)
	ply:CreateRagdoll()
	ply:SetTeam(TEAM_DEAD)
	deadPlayers = deadPlayers + 1
	net.Start("DisplayDeathTimer")
	net.WriteInt(GetConVar("hl2cr_difficulty"):GetInt() * GetConVar("hl2cr_respawntime"):GetInt(), 16)
	if GetConVar("hl2cr_survivalmode"):GetInt() == 1 then
		net.WriteBool(true)
	else
		net.WriteBool(false)
	end
	net.Send(ply)
end)

local tempUpgHealTime = 0

hook.Add("EntityTakeDamage", "EP1Fix", function(ply, dmgInfo)
	local attacker = dmgInfo:GetAttacker()
	local dmg = dmgInfo:GetDamage()
	if attacker:GetClass() == "func_door" then
		dmgInfo:SetDamage(0)
	end
end)

hook.Add("EntityTakeDamage", "EP2Fix", function(ply, dmgInfo)
	local attacker = dmgInfo:GetAttacker()
	local dmg = dmgInfo:GetDamage()
	if attacker:GetClass() == "func_tracktrain" then
		dmgInfo:SetDamage(0)
	end
end)

hook.Add("PlayerHurt", "PlayerRecover", function(vic, att, hp, dmg)	
	
	tempUpgHealTime = 60 + CurTime()
	if vic:IsPlayer() then
		beginHealingTimer(vic)
	end
end)

function beginHealingTimer(ply)
	local healthBoost = 0
	
	if not ply then return end
	
	if table.HasValue(ply.hl2cPersistent.TempUpg, "Self_Healing") then
		healthBoost = healthBoost + 5
	end
	
	if table.HasValue(ply.hl2cPersistent.TempUpg, "Self_Healing_2") then 
		healthBoost = healthBoost + 10
	end
	
	if table.HasValue(ply.hl2cPersistent.TempUpg, "Self_Healing_3") then 
		healthBoost = healthBoost + 15
	end
	
	if healthBoost <= 0 then return end
	hook.Add("Tick", "healingTick", function()
		if tempUpgHealTime <= CurTime() then
			if ply:IsValid() and ply:Health() <= ply:GetMaxHealth() and not ply:IsBot() then
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

local NO_SUICIDE_MAPS = {
	["hl2cr_lobby"] = true,
	["d1_trainstation_01"] = true,
	["d1_trainstation_02"] = true,
	["d1_trainstation_03"] = true,
	["d1_trainstation_04"] = true,
	["d1_trainstation_05"] = true,
	["d3_citadel_01"] = true,
	["d3_citadel_05"] = true,
	["d3_breen_01"] = true
	
}

hook.Add("CanPlayerSuicide", "DefaultSuicide", function(ply)

	if NO_SUICIDE_MAPS[game.GetMap()] then
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
	local fireResist = 0
	
	if ent:IsPlayer() then 
		if table.HasValue(ent.hl2cPersistent.TempUpg, "Blast_Resistance") then
			expResist = 50
		end
	end
	
	if ent:IsPlayer() then 
		if table.HasValue(ent.hl2cPersistent.PermUpg, "Fire_Resist") then
			fireResist = 10
		end
	end
	
	if ent:IsPlayer() and dmgType == DMG_BLAST then
		dmgInfo:SetDamage(dmg - expResist)
	end
	
	if ent:IsPlayer() and dmgType == DMG_BURN then
		dmgInfo:SetDamage(dmg - fireResist)
	end
	
	if attacker:IsPlayer() and (attacker:GetActiveWeapon():GetClass() ~= "weapon_crowbar" and table.HasValue(attacker.hl2cPersistent.PermUpg, "Fire_Bullets"))
	and not ent:IsPet() and not ent:IsFriendly() and not ent:IsPlayer() and ent:IsNPC() then
		local fireChance = math.random(1, 100)
		
		if fireChance >= 98 then
			ent:Ignite(30)
			ent.fireAttacker = attacker
		end
	end
	
end)

local ROLLER_MAPS = {
	["d1_eli_02"] = true,
	["ep1_citadel_02"] = true,
	["ep1_citadel_04"] = true
}

hook.Add("PlayerShouldTakeDamage", "DisablePVP", function(ply, attacker)	
	if attacker == ply then
		return true
	end
	
	if attacker:IsPlayer() and (attacker:Team() == TEAM_ALIVE or attacker:Team() == TEAM_COMPLETED_MAP or attacker:Team() == TEAM_DEAD) then
		return false
	end
	
	if attacker:IsNPC() and (attacker:GetClass() == "npc_rollermine" and ROLLER_MAPS[game.GetMap()]) then 
		return false
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
		if hitgroup == HITGROUP_HEAD and GetConVar("hl2cr_difficulty"):GetInt() ~= 1 then
			dmgInfo:ScaleDamage((1.25 * GetConVar("hl2cr_difficulty"):GetInt()) - armour)
			return
		elseif hitgroup == HITGROUP_CHEST and GetConVar("hl2cr_difficulty"):GetInt() ~= 1 then
			dmgInfo:ScaleDamage((1 * GetConVar("hl2cr_difficulty"):GetInt()) - armour)
			return
		end
	end
	
	
end)

local NO_PICKUPS = {
	["d3_citadel_03"] = true,
	["d3_citadel_04"] = true,
	["d3_citadel_05"] = true,
	["d3_breen_01"] = true,
	["ep1_citadel_01"] = true,
}

hook.Add("PlayerCanPickupWeapon", "DisableWeaponsPickup", function(ply, weapon) 
	if ply:Team() == TEAM_LOYAL then
		return false
	end
	
	if weapon:GetClass() == "weapon_357" and ply:HasWeapon(weapon:GetClass()) and ply:GetAmmoCount("357") >= GetConVar("max_357"):GetInt() then
		return false
	end
	
	if weapon:GetClass() == "weapon_ar2" and ply:HasWeapon(weapon:GetClass()) and ply:GetAmmoCount("AR2") >= GetConVar("max_AR2"):GetInt() then
		return false
	end
	
	if weapon:GetClass() == "weapon_shotgun" and ply:HasWeapon(weapon:GetClass()) and ply:GetAmmoCount("Buckshot") >= GetConVar("max_Buckshot"):GetInt() then
		return false
	end
	
	if weapon:GetClass() == "weapon_crossbow" and ply:HasWeapon(weapon:GetClass()) and ply:GetAmmoCount("XBowBolt") >= GetConVar("max_crossbowbolt"):GetInt() then
		return false
	end
	
	if weapon:GetClass() == "weapon_pistol" and ply:HasWeapon(weapon:GetClass())and ply:GetAmmoCount("Pistol") >= GetConVar("max_Pistol"):GetInt() then
		return false
	end
	
	if weapon:GetClass() == "weapon_rpg" and ply:HasWeapon(weapon:GetClass()) and ply:GetAmmoCount("RPG_Round") >= GetConVar("max_RPG_Round"):GetInt() then
		return false
	end
	
	if weapon:GetClass() == "weapon_smg1" and ply:HasWeapon(weapon:GetClass()) and ply:GetAmmoCount("SMG1") >= GetConVar("max_SMG1"):GetInt() then
		return false
	end
	
	if weapon:GetClass() == "weapon_frag" and ply:GetAmmoCount("Grenade") >= GetConVar("max_frags"):GetInt() then
		return false
	end
	
	
	if ply:Team() ~= TEAM_ALIVE or weapon:GetClass() == "weapon_stunstick" or (weapon:GetClass() == "weapon_physgun" and not ply:IsAdmin()) then
		weapon:Remove()
		return false
	end
	
	if ply:Team() ~= TEAM_ALIVE or NO_PICKUPS[game.GetMap()] and weapon:GetClass() ~= "weapon_physcannon" then
		weapon:Remove()
		return false
	end

	return true
end)

function GM:GetFallDamage( ply, speed )
	return (speed / 16)
end

hook.Add("Tick", "HasWeaponTick", function()
	for k, curWep in pairs(startingWeapons) do
		for k, v in pairs(player.GetAll()) do
			if v:Team() == TEAM_ALIVE and not table.HasValue(Cheating_Players_Survival, v:Nick()) then
				if not v:HasWeapon(curWep) then
					v:Give(curWep)
				end
			end
		end
	end
end)

hook.Add("PlayerLoadout", "StarterWeapons", function(ply)
	if (game.GetMap() == "hl2cr_lobby") then
		ply:Give("weapon_crowbar")
		ply:Give("weapon_physcannon")
		if ply:IsAdmin() then
			ply:Give("weapon_physgun")
		end
	end
	
	ply:GiveAmmo(45, "Pistol", true)
	ply:GiveAmmo(90, "SMG1", true)
	ply:GiveAmmo(30, "AR2", true)
	ply:GiveAmmo(12, "Buckshot", true)
	ply:GiveAmmo(6, "357", true)
	
	
	if not RESTRICTED_MAPS[game.GetMap()] then
		if GIVE_STARTER_WEAPONS[ply.hl2cPersistent.InvWeapon] then
			ply:Give(GIVE_STARTER_WEAPONS[ply.hl2cPersistent.InvWeapon])
		end
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
	
	if game.GetMap() == "d2_prison_05" then 
		ply:Give("weapon_crowbar")
		ply:Give("weapon_physcannon")
		ply:Give("weapon_pistol")
		ply:Give("weapon_357")
		ply:Give("weapon_smg1")
		ply:Give("weapon_shotgun")
		ply:Give("weapon_ar2")
		ply:Give("weapon_crossbow")
		ply:Give("weapon_rpg")
		ply:Give("weapon_bugbait")
		ply:Give("weapon_frag")
	end
	
	if #startingWeapons > 0 then
		for k, wep in pairs(startingWeapons) do
			ply:Give(wep)
		end
	end
	
	for k, v in pairs(player.GetAll()) do
		if v:Team() == TEAM_LOYAL or ply:Team() == TEAM_LOYAL then return end
		
		if v:GetWeapons() ~= nil and ply:GetWeapons() ~= v:GetWeapons() and game.GetMap() ~= "hl2cr_lobby" then
			for k, w in pairs(v:GetWeapons()) do
				if RESTRICTED_WEPS[w:GetClass()] then return end
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
	if not RESTRICTED_WEPS[weapon:GetClass()] and ply:Team() == TEAM_ALIVE then 
		table.insert(startingWeapons, weapon:GetClass())
	end

	if weapon:GetClass() == "weapon_crowbar" and game.GetMap() == "d1_trainstation_06" then
		for k, v in pairs(player.GetAll()) do
			Achievement(v, "Trusty_Hardware", "HL2_Ach_List")
			if not table.HasValue(v.hl2cPersistent.Achievements, "Crowbar_Only_HL2") then
				v.EnableOTF = true
				v:ChatPrint("OTF Enabled, type !otf to attempt the challenge")
			end
		end
	end
end)

net.Receive("BeginOTF", function(len, ply)
	if not ply then return end
	
	ply.EnableOTF = false
	ply.hl2cPersistent.OTF = true
	ply:ChatPrint("You have started 'One True Freeman', good luck")
end)

hook.Add("PlayerDeathTick", "SpecTick", function(ply)		
	return false
end)

function RespawnTimerActive(ply, deaths)
	
	ply.hasDiedOnce = true
	
	timer.Simple(5, function()
		if not ply:Alive() then
			SpectateMode(ply)
		end
	end)

	if GetConVar("hl2cr_survivalmode"):GetInt() == 1 and game.GetMap() ~= "hl2cr_lobby" then
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

	if GetConVarNumber("hl2cr_respawntime") ~= 0 then
		if ply:Team() ~= TEAM_ALIVE then
			ply.respawnTimer = (GetConVarNumber("hl2cr_respawntime") * GetConVarNumber("hl2cr_difficulty")) + CurTime()
		end
	end
end

hook.Add("Tick", "RespawnPlayersTimer", function()
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
	
	victim:Lock()
	
	timer.Simple(5, function()
		victim:UnLock()
	end)
	
	if attacker:IsPlayer() and attacker:Team() == TEAM_LOYAL then
		local giveLoyalXP = math.random(15, 150)
		attacker.totalXPLoyal = totalXPLoyal + giveLoyalXP
	end
	
	if GetConVar("hl2cr_survivalmode"):GetInt() == 1 then
		deaths = deaths + 1
		table.insert(Cheating_Players_Survival, victim:Nick() )
	end
	RespawnTimerActive(victim, deaths)
end)

function GM:IsSpawnpointSuitable( ply, spawnpointent, bMakeSuitable )
	return true
end

if SERVER then

	hook.Add("Tick", "SuitTick", function()
		for k, ply in pairs(player.GetAll()) do
			if table.HasValue(ply.hl2cPersistent.PermUpg, "Suit_Power_Boost") then
				if ply.sprintPower > 100 and ply:IsSprinting() then
					ply.sprintPower = ply.sprintPower - 0.1
					ply:SetSuitPower(99)
				end
				
				if ply:GetSuitPower() == 100 and not ply:IsSprinting() then
					ply.sprintPower = 150
				end
			end
		end
	end)
	
	hook.Add("Tick", "AmmoLimiter", function()
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
			
			if p:GetAmmoCount("Grenade") > GetConVar("max_frags"):GetInt() then
				p:RemoveAmmo( p:GetAmmoCount("Grenade") - GetConVar("max_frags"):GetInt(), "Grenade" )
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

	return true
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
	
	if table.Count(ply.hl2cPersistent.Vortexes) == 26 then
		Achievement(ply, "Vortex_Locator", "HL2_Ach_List")
	end
end

function giveVortexEP1(map, ply)
	if not table.HasValue(ply.hl2cPersistent.Vortexes.EP1, map) then
	
		table.insert(ply.hl2cPersistent.Vortexes.EP1, map)
		Special(ply, map, "EP1_Vortex", 1000)

		timer.Simple(0.01, function()
			local effectdata = EffectData()
			effectdata:SetOrigin(ply:GetPos())
			effectdata:SetScale(1.50)
			effectdata:SetMagnitude(0.05)
			util.Effect( "cball_explode", effectdata )
			ply:EmitSound("ambient/energy/zap7.wav", 100, 100)
		end)
	end
	
	if table.Count(ply.hl2cPersistent.Vortexes.EP1) == 6 then
		Achievement(ply, "Vortex_Locator_EP1", "EP1_Ach_List")
	end
end
function giveVortexEP2(map, ply)
	if not table.HasValue(ply.hl2cPersistent.Vortexes.EP2, map) then
	
		table.insert(ply.hl2cPersistent.Vortexes.EP2, map)
		Special(ply, map, "EP2_Vortex", 1250)

		timer.Simple(0.01, function()
			local effectdata = EffectData()
			effectdata:SetOrigin(ply:GetPos())
			effectdata:SetScale(1.50)
			effectdata:SetMagnitude(0.05)
			util.Effect( "cball_explode", effectdata )
			ply:EmitSound("ambient/energy/zap7.wav", 100, 100)
		end)
	end
	
	if table.Count(ply.hl2cPersistent.Vortexes.EP2) == 8 then
		Achievement(ply, "Vortex_Locator_EP2", "EP2_Ach_List")
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

local whackHits = 0
hook.Add("EntityTakeDamage", "WhackAch", function(gunship, dmg)
	local player = dmg:GetAttacker()
	
	if game.GetMap() == "ep1_c17_02a" and gunship:GetName() == "gunship_showdown_ragdoll" and player:IsPlayer() then
		if not player.whackHits then
			player.whackHits = 0
		end
		player.whackHits = player.whackHits + 1
		if player.whackHits >= 5 then
			Achievement(player, "Safety_Measure", "EP1_Ach_List")
		end
	end
end)

if CLIENT then
	net.Receive("UpdateConCmds", function(len, ply)
		local quickinfo = net.ReadInt(8)
		LocalPlayer():ConCommand("cl_tfa_hud_enabled 0")
		LocalPlayer():ConCommand("cl_tfa_hud_crosshair_enable_custom 0")
		if quickinfo == 1 then
			LocalPlayer():ConCommand("hud_quickinfo 1")
		else
			LocalPlayer():ConCommand("hud_quickinfo 0")
		end
	end)
end