local meta = FindMetaTable("Player")
if !meta then return end

function meta:RemoveVehicle()
	if CLIENT or !self:IsValid() then 
		return
	end
	
	if self.vehicle and self.vehicle:IsValid() then
		self.vehicle:Remove()
	end
end

hook.Add("PlayerSpawn", "Misc", function(ply)
	ply:SetTeam(TEAM_ALIVE)
	ply:SetNoCollideWithTeammates(true)
	ply:SetupHands()
	timer.Simple(12, function() ply:SetNoCollideWithTeammates(false) end)

	if game.GetMap() == "d1_trainstation_01" or game.GetMap() == "d1_trainstation_02" or game.GetMap() == "d1_trainstation_03" or
	game.GetMap() == "d1_trainstation_04" then
		ply:AllowFlashlight(false)
	elseif game.GetMap() == "d1_trainstation_05" then
		for p, hevFlash in pairs(ents.FindByClass("item_suit")) do
			if hevFlash:IsValid() then
				ply:AllowFlashlight(false)
			else
				ply:AllowFlashlight(true)
			end
		end
	else
		ply:AllowFlashlight(true)
	end
end)

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
	else
		return true
	end
	
	if hitGroup == HITGROUP_HEAD then
		hitGroupScale = 2
	else
		hitGroupScale = 1
	end
	
	dmgInfo:ScaleDamage(difficulty * hitGroupScale)
end)

function GM:PlayerCanPickupWeapon(ply, weapon) 
	if ply:Team() != TEAM_ALIVE or weapon:GetClass() == "weapon_stunstick" or (weapon:GetClass() == "weapon_physgun" and not ply:IsAdmin()) then
		weapon:Remove()
		return false
	end
	
	return true
end

function GM:PlayerLoadout(ply)
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
	if ply.info and ply.info.loadout then
		for wep, ammo in pairs(ply.info.loadout) do
			ply:Give(wep)
		end
		
		for k, curWep in pairs(ply:GetWeapons()) do
			local wepClass = curWep:GetClass()
			
			if ply.info.loadout[wepClass] then
				ply:GiveAmmo(tonumber(ply.info.loadout[wepClass][1]), curWep:GetPrimaryAmmoType())
				ply:GiveAmmo(tonumber(ply.info.loadout[wepClass][2]), curWep:GetSecondaryAmmoType())
			end
		end
	elseif startingWeapons and #startingWeapons > 0 then
		for k, wep in pairs(startingWeapons) do
			ply:Give(wep)
		end
	end
end

function GM:WeaponEquip(weapon)
	if weapon and weapon:IsValid() and weapon:GetClass() and not table.HasValue(startingWeapons, weapon:GetClass()) then
		table.insert(startingWeapons, weapon:GetClass())
	end
end

function RespawnTimerActive(ply)
		local playerCount = 0
	
	for k, v in pairs(player.GetAll()) do
		playerCount = playerCount + 1
	end
	
	if survivalMode then
		local deaths = 0
		ply:ChatPrint("You have died, awaiting next checkpoint")
		ply:Lock()
		
		if not ply:Alive() then
			deaths = deaths + 1
		else
			deaths = deaths - 1
		end
		if deaths == playerCount then
			ply:ChatPrint("All players have died... restarting map")
		end
		
	return end
	
	if GetConVarNumber("hl2c_respawntime") != 0 then
		ply:Lock()
		timer.Simple(GetConVarNumber("hl2c_respawntime"), function()
			ply:UnLock()
			ply:Spawn()
		end)
	end
end

hook.Add("PlayerDeath", "RespawnTimer", RespawnTimerActive)

function GM:IsSpawnpointSuitable( ply, spawnpointent, bMakeSuitable )
	local pos = ply:GetPos()
	ply:SetPos(Vector(pos.x, pos.y, pos.z + 75))
	return true
end

function CoinInv(amount)
	return ply.hl2cPersistent.Coins
end