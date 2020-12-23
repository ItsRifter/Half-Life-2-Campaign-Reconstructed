local MAPS_NOPETS = {
	["d1_trainstation_01"] = true,
	["d1_trainstation_02"] = true,
	["d1_trainstation_03"] = true,
	["d1_trainstation_04"] = true,
	["d1_trainstation_05"] = true,
	["d1_eli_01"] = true,
	["d3_breen_01"] = true,
	["ep1_citadel_01"] = true
}

function spawnPet(ply, pos)

	if ply:IsValid() and ply:Team() == TEAM_ALIVE and not ply.petAlive then
		ply:SetNWBool("PetActive", true)
		
		if MAPS_NOPETS[game.GetMap()] then
			ply:ChatPrint("Pets are disabled on this map")
		else
		
			if tonumber(ply:GetNWInt("PetStage")) <= 0 then
				ply.pet = ents.Create("npc_headcrab")
			elseif tonumber(ply:GetNWInt("PetStage")) == 1 then
				ply.pet = ents.Create("npc_zombie_torso")
			elseif tonumber(ply:GetNWInt("PetStage")) == 2 then
				ply.pet = ents.Create("npc_zombie")	
			elseif tonumber(ply:GetNWInt("PetStage")) == 3 then
				ply.pet = ents.Create("npc_headcrab_fast")
			elseif tonumber(ply:GetNWInt("PetStage")) == 4 then
				ply.pet = ents.Create("npc_fastzombie_torso")
			elseif tonumber(ply:GetNWInt("PetStage")) == 5 then
				ply.pet = ents.Create("npc_fastzombie")	
			elseif tonumber(ply:GetNWInt("PetStage")) == 6 then
				ply.pet = ents.Create("npc_rollermine")
				if ply.hl2cPersistent.PetStr < 1 then
					ply.hl2cPersistent.PetStr = 5
				end
			elseif tonumber(ply:GetNWInt("PetStage")) == 7 then
				ply.pet = ents.Create("npc_manhack")
			elseif tonumber(ply:GetNWInt("PetStage")) == 8 then
				ply.pet = ents.Create("npc_stalker")
			elseif tonumber(ply:GetNWInt("PetStage")) == 9 then
				ply.pet = ents.Create("npc_metropolice")
				ply.pet:Give("weapon_stunstick")
			end
		end
		if not pos then
			ply.pet:SetPos(ply:GetPos())
		else
			ply.pet:SetPos(pos)
		end
		ply.pet:SetNWBool("PetActive", true)
		ply.pet:Spawn()
		for k, v in pairs(player.GetAll()) do
			ply.pet:AddEntityRelationship(v, D_LI, 99)
		end
		for k, v in pairs(ents.FindByClass("npc_*")) do
			if v:IsPet() then
				ply.pet:AddEntityRelationship(v, D_LI, 99)
				v:AddEntityRelationship(ply.pet, D_LI, 99)
			end
		end
		ply.pet:SetOwner(ply)
		ply.pet.owner = ply.pet:GetOwner()
		ply.pet:SetCustomCollisionCheck(false)
		ply.petAlive = true
		local health = ply.hl2cPersistent.PetHP
		ply.pet:SetHealth(health)
		ply.pet:SetMaxHealth(health)
		ply.pet:SetNWEntity("PetEntity", ply.pet)
		timer.Simple(1, function()
			net.Start("OpenPetStats")
				net.WriteEntity(ply.pet)
			net.Send(ply)
		end)
		ply.pet:SetNWInt("PetStr", ply.hl2cPersistent.PetStr)
		ply.pet:SetNWInt("PetRegen", ply.hl2cPersistent.PetRegen)
	end
end

-- Registry of all duels, accepted or not
duelRegistry = {}

net.Receive("PetChallenge", function(len, ply)
	local challengeeName = net.ReadString()
	local bet = net.ReadInt(32)

	if not ply.pet then
		ply:ChatPrint("Spawn your pet first before challenging " .. challengeeName)
		return
	end
	local challengee
	for k, v in pairs(player.GetAll()) do
		if v:Nick() == challengeeName then
			challengee = v
			break
		end
	end
	
	-- Check if challengee exists
	if not challengee:IsValid() then
		ply:ChatPrint(string.format("%s not found, they must have left the game", challengeeName))
		return
	end
	
	if challengee.hl2cPersistent.Level < 10 or challengee.hl2cPersistent.Prestige < 0 then
		ply:ChatPrint(string.format("%s is too low of a level or prestige to spawn their pet", challengeeName))
		return
	end

	-- Check for negative
	if bet < 0 then
		ply:ChatPrint(string.format("LUL, don't do that please"))
		return
	end
	
	--Check if bet is above challengee's coins
	if bet > challengee.hl2cPersistent.Coins then
		ply:ChatPrint(string.format("%s doesn't have enough coins to fulfil that bet", challengeeName))
		return
	end

	-- Remove old duels, or stop if an active one is found
	for k, duel in ipairs(duelRegistry) do
		if (duel.challenger == ply or duel.challenger == ply) and (duel.challengee == challengee or duel.challengee == challengee) then
			if duel.accepted then
				ply:ChatPrint(string.format("There is already an active duel with %s", duel.challengee))
				return
			else
				table.remove(duelRegistry, k)
			end
		end
	end

	local duel = {
		challenger = ply,
		challengee = challengee,
		bet = bet,
		accepted = false, -- If set to true, the bet is removed from the players
	}

	-- Add duel to registry
	table.insert(duelRegistry, duel)

	-- Ask challengee to accept or decline
	duel.challengee:ChatPrint(string.format("%s has challenged you for %s Lambda Coins", duel.challenger:Nick(), math.Round(duel.bet)))
	duel.challengee:ChatPrint(string.format("!acceptduel or !declineduel"))

	for k, v in pairs(player.GetAll()) do
		if v ~= duel.challenger or v ~= duel.challengee then
			ply:ChatPrint(string.format("%s has challenged %s for %s Lambda Coins", duel.challenger:Nick(), duel.challengee:Nick(), math.Round(duel.bet)))
		end
	end
end)

-- Searches the registry and returns a duel with the given challengee.
function GetDuelByChallengee(ply, acceptedState)
	for k, duel in ipairs(duelRegistry) do
		if ply == duel.challengee and acceptedState == duel.accepted then
			return duel
		end
	end
end

-- Searches the registry and returns a duel, if found.
-- Only accepted. If this returns a duel, players are in a duel.
function GetDuelAccepted(ply)
	for k, duel in ipairs(duelRegistry) do
		if (ply == duel.challengee or ply == duel.challenger) and duel.accepted then
			return duel
		end
	end
end

-- Removes the entry from the registry, and returns it
function RemoveDuel(challenger, challengee)
	for k, duel in ipairs(duelRegistry) do
		if duel.challenger == challenger and duel.challengee == challengee then
			return table.remove(duelRegistry, k)
		end
	end
end

function PetDuelBegin(ply1, ply2, bet)
	local ply1Pet = ply1.pet
	local ply2Pet = ply2.pet
	if ply1Pet:IsValid() and ply2Pet:IsValid() and ply1Pet:IsPet() and ply2Pet:IsPet() then
		ply1Pet:AddEntityRelationship(ply2Pet, D_HT, 99)
		ply2Pet:AddEntityRelationship(ply1Pet, D_HT, 99)
	end
end

local healingTime = 0

hook.Add("PostEntityTakeDamage", "PetExtinguish", function(pet, dmgInfo, took)
	local attacker = dmgInfo:GetAttacker()
	local inflictor = dmgInfo:GetInflictor()
	local dmg = dmgInfo:GetDamage()
	local dmgType = dmgInfo:GetDamageType()
	
	if not pet:IsPet() then return end
	
	if dmgType == DMG_BURN or attacker:GetClass() == "entityflame" then
		pet:Extinguish()
	end
	
end)

hook.Add("EntityTakeDamage", "PetHurtAndDamage", function(pet, dmgInfo)
	local attacker = dmgInfo:GetAttacker()
	local inflictor = dmgInfo:GetInflictor()
	local dmg = dmgInfo:GetDamage()
	local dmgType = dmgInfo:GetDamageType()
	
	if pet:IsPlayer() or not pet:IsPet() then return end
	local ply = pet.owner 
	
	if not attacker:IsPlayer() then
		healingTime = GetConVar("hl2cr_petrecovertime"):GetInt() + CurTime()
		runHealTime(ply, pet)
	elseif attacker:IsPlayer() then
		dmgInfo:SetDamage(0)
	end
	
	if not pet:IsValid() then
		pet.owner.petAlive = false
		timer.Remove("PetRecoveryTimer")
	end
end)

function runHealTime(ply, pet)
	hook.Add("Think", "petHealingThink", function()
		if healingTime <= CurTime() then
			if not pet:IsValid() then return end
			pet:SetHealth(pet:Health() + (GetConVar("hl2cr_petrecovery"):GetInt() + ply:GetNWInt("PetRegen")))
			healingTime = GetConVar("hl2cr_petrecovertime"):GetInt() + CurTime()
			if pet:Health() >= pet:GetMaxHealth() and pet:IsValid() then
				pet:SetHealth(pet:GetMaxHealth())
				timer.Remove("PetRecoveryTimer")
			end
		end
	end)
end

net.Receive("SpawnPetConCommand", function(len, ply)
	if not ply.petAlive then
		spawnPet(ply)
		ply:SetNWString("PetOwnerName", ply:Nick())
	else
		ply:ChatPrint("You can only summon your pet once every life!")
	end
end)

net.Receive("UpdateSkills", function(len, ply)
	
	if not ply then return end
	
	ply.hl2cPersistent.PetPoints = ply.hl2cPersistent.PetPoints - 1
	ply.hl2cPersistent.PetSkills = ply.hl2cPersistent.PetSkills + 1
	
	ply:SetNWInt("PetSkill", ply.hl2cPersistent.PetSkills)
	--Headcrab
	if ply.hl2cPersistent.PetStage == 0 then
		if ply.hl2cPersistent.PetSkills == 1 then
			ply.hl2cPersistent.PetHP = ply.hl2cPersistent.PetHP + 10
			
		elseif ply.hl2cPersistent.PetSkills == 2 then
			ply.hl2cPersistent.PetRegen = ply.hl2cPersistent.PetRegen + 5
			
		elseif ply.hl2cPersistent.PetSkills == 3 then
			ply.hl2cPersistent.PetStr = ply.hl2cPersistent.PetStr + 1
			
		elseif ply.hl2cPersistent.PetSkills == 4 then
			ply.hl2cPersistent.PetStr = ply.hl2cPersistent.PetStr + 1
			
		elseif ply.hl2cPersistent.PetSkills == 5 then
			ply.hl2cPersistent.PetRegen = ply.hl2cPersistent.PetRegen + 5
		end
	--Torso Zombie
	elseif ply.hl2cPersistent.PetStage == 1 then
		if ply.hl2cPersistent.PetSkills == 1 then
			ply.hl2cPersistent.PetHP = ply.hl2cPersistent.PetHP + 10
	
		elseif ply.hl2cPersistent.PetSkills == 2 then
			ply.hl2cPersistent.PetRegen = ply.hl2cPersistent.PetRegen + 5
			
		elseif ply.hl2cPersistent.PetSkills == 3 then	
			ply.hl2cPersistent.PetStr = ply.hl2cPersistent.PetStr + 1
			
		elseif ply.hl2cPersistent.PetSkills == 4 then
			ply.hl2cPersistent.PetStr = ply.hl2cPersistent.PetStr + 2
			
		elseif ply.hl2cPersistent.PetSkills == 5 then
			ply.hl2cPersistent.PetRegen = ply.hl2cPersistent.PetRegen + 5
			ply:SetNWInt("PetRegen", ply.hl2cPersistent.PetRegen)
			
		elseif ply.hl2cPersistent.PetSkills == 6 then
			ply.hl2cPersistent.PetStr = ply.hl2cPersistent.PetStr + 1
			
		elseif ply.hl2cPersistent.PetSkills == 7 then
			ply.hl2cPersistent.PetStr = ply.hl2cPersistent.PetStr + 1
		end
	--Full Zombie
	elseif ply.hl2cPersistent.PetStage == 2 then
		if ply.hl2cPersistent.PetSkills == 1 then
			ply.hl2cPersistent.PetHP = ply.hl2cPersistent.PetHP + 5
	
		elseif ply.hl2cPersistent.PetSkills == 2 then
			ply.hl2cPersistent.PetRegen = ply.hl2cPersistent.PetRegen + 5
			
		elseif ply.hl2cPersistent.PetSkills == 3 then
			ply.hl2cPersistent.PetHP = ply.hl2cPersistent.PetHP + 5
			
		elseif ply.hl2cPersistent.PetSkills == 4 then
			ply.hl2cPersistent.PetStr = ply.hl2cPersistent.PetStr + 1
			
		elseif ply.hl2cPersistent.PetSkills == 5 then
			ply.hl2cPersistent.PetHP = ply.hl2cPersistent.PetHP + 5
			
		elseif ply.hl2cPersistent.PetSkills == 6 then
			ply.hl2cPersistent.PetStr = ply.hl2cPersistent.PetStr + 1
			
		elseif ply.hl2cPersistent.PetSkills == 7 then
			ply.hl2cPersistent.PetStr = ply.hl2cPersistent.PetStr + 2
		end
	--Fast Headcrab
	elseif ply.hl2cPersistent.PetStage == 3 then
		if ply.hl2cPersistent.PetSkills == 1 then
			ply.hl2cPersistent.PetStr = ply.hl2cPersistent.PetStr + 1
			
		elseif ply.hl2cPersistent.PetSkills == 2 then
			ply.hl2cPersistent.PetRegen = ply.hl2cPersistent.PetRegen + 5
			
		elseif ply.hl2cPersistent.PetSkills == 3 then
			ply.hl2cPersistent.PetRegen = ply.hl2cPersistent.PetRegen + 5
		
		elseif ply.hl2cPersistent.PetSkills == 4 then
			ply.hl2cPersistent.PetHP = ply.hl2cPersistent.PetHP + 5
		
		elseif ply.hl2cPersistent.PetSkills == 5 then
			ply.hl2cPersistent.PetStr = ply.hl2cPersistent.PetStr + 1
		
		elseif ply.hl2cPersistent.PetSkills == 6 then
			ply.hl2cPersistent.PetStr = ply.hl2cPersistent.PetStr + 1
			
		elseif ply.hl2cPersistent.PetSkills == 7 then
			ply.hl2cPersistent.PetStr = ply.hl2cPersistent.PetStr + 1
			
		end	
	--Fast Torso Zombie
	elseif ply.hl2cPersistent.PetStage == 4 then
		if ply.hl2cPersistent.PetSkills == 1 then
			ply.hl2cPersistent.PetHP = ply.hl2cPersistent.PetHP + 10
			
		elseif ply.hl2cPersistent.PetSkills == 2 then
			ply.hl2cPersistent.PetHP = ply.hl2cPersistent.PetHP + 15
			
		elseif ply.hl2cPersistent.PetSkills == 3 then
			ply.hl2cPersistent.PetHP = ply.hl2cPersistent.PetHP + 20
			
		elseif ply.hl2cPersistent.PetSkills == 4 then
			ply.hl2cPersistent.PetStr = ply.hl2cPersistent.PetStr + 1
			
		elseif ply.hl2cPersistent.PetSkills == 5 then
			ply.hl2cPersistent.PetStr = ply.hl2cPersistent.PetStr + 2
			
		elseif ply.hl2cPersistent.PetSkills == 6 then
			ply.hl2cPersistent.PetRegen = ply.hl2cPersistent.PetRegen + 5
			
		elseif ply.hl2cPersistent.PetSkills == 7 then
			ply.hl2cPersistent.PetRegen = ply.hl2cPersistent.PetRegen + 10
			
		elseif ply.hl2cPersistent.PetSkills == 8 then
			ply.hl2cPersistent.PetStr = ply.hl2cPersistent.PetStr + 2
		elseif ply.hl2cPersistent.PetSkills == 9 then
			ply.hl2cPersistent.PetRegen = ply.hl2cPersistent.PetRegen + 10
		end
	--Full Fast Zombie
	elseif ply.hl2cPersistent.PetStage == 5 then
		if ply.hl2cPersistent.PetSkills == 1 then
			ply.hl2cPersistent.PetStr = ply.hl2cPersistent.PetStr + 2
			
		elseif ply.hl2cPersistent.PetSkills == 2 then
			ply.hl2cPersistent.PetRegen = ply.hl2cPersistent.PetRegen + 10
			
		elseif ply.hl2cPersistent.PetSkills == 3 then
			ply.hl2cPersistent.PetHP = ply.hl2cPersistent.PetHP + 15
			
		elseif ply.hl2cPersistent.PetSkills == 4 then
			ply.hl2cPersistent.PetHP = ply.hl2cPersistent.PetHP + 25
			
		elseif ply.hl2cPersistent.PetSkills == 5 then
			ply.hl2cPersistent.PetStr = ply.hl2cPersistent.PetStr + 2
		
		elseif ply.hl2cPersistent.PetSkills == 6 then
			ply.hl2cPersistent.PetStr = ply.hl2cPersistent.PetStr + 3
			
		elseif ply.hl2cPersistent.PetSkills == 7 then
			ply.hl2cPersistent.PetRegen = ply.hl2cPersistent.PetRegen + 15
			
		elseif ply.hl2cPersistent.PetSkills == 8 then
			ply.hl2cPersistent.PetHP = ply.hl2cPersistent.PetHP + 25
		
		elseif ply.hl2cPersistent.PetSkills == 9 then
			ply.hl2cPersistent.PetHP = ply.hl2cPersistent.PetHP + 25
		end
	--Rollermine
	elseif ply.hl2cPersistent.PetStage == 6 then
		if ply.hl2cPersistent.PetSkills == 1 then
			ply.hl2cPersistent.PetStr = ply.hl2cPersistent.PetStr + 1
			
		elseif ply.hl2cPersistent.PetSkills == 2 then
			ply.hl2cPersistent.PetStr = ply.hl2cPersistent.PetStr + 2
			
		elseif ply.hl2cPersistent.PetSkills == 3 then
			ply.hl2cPersistent.PetStr = ply.hl2cPersistent.PetStr + 3
		end
	--Manhack
	elseif ply.hl2cPersistent.PetStage == 7 then
		if ply.hl2cPersistent.PetSkills == 1 then
			ply.hl2cPersistent.PetRegen = ply.hl2cPersistent.PetRegen + 10
			
		elseif ply.hl2cPersistent.PetSkills == 2 then
			ply.hl2cPersistent.PetHP = ply.hl2cPersistent.PetHP + 15
			
		elseif ply.hl2cPersistent.PetSkills == 3 then
			ply.hl2cPersistent.PetHP = ply.hl2cPersistent.PetHP + 20
			
		elseif ply.hl2cPersistent.PetSkills == 4 then
			ply.hl2cPersistent.PetRegen = ply.hl2cPersistent.PetRegen + 10
			
		elseif ply.hl2cPersistent.PetSkills == 5 then
			ply.hl2cPersistent.PetRegen = ply.hl2cPersistent.PetRegen + 15
			
		elseif ply.hl2cPersistent.PetSkills == 6 then
			ply.hl2cPersistent.PetStr = ply.hl2cPersistent.PetStr + 3
		end
	end
	ply:SetNWInt("PetStr", ply.hl2cPersistent.PetStr)
	ply:SetNWInt("PetHP", ply.hl2cPersistent.PetHP)
	ply:SetNWInt("PetRegen", ply.hl2cPersistent.PetRegen)
	
	ply:SetNWInt("PetSkillPoints", ply.hl2cPersistent.PetPoints)
end)

hook.Add("GravGunOnPickedUp", "PetPreventPickup", function(ply, ent)
	if ent:IsPet() then
		ply:DropObject()
	end
end)

function GM:GravGunPunt(ply, ent)
	if ent:IsPet() then
		return false
	end
	return true
end

net.Receive("NewPet", function(len, ply)
	local newPet = net.ReadString()
	
	if not ply then return end
	ply.hl2cPersistent.PetXP = 0
	ply:SetNWInt("PetXP", 0)
	if newPet == "hl2cr_fastzombie_pet" then
		ply.hl2cPersistent.PetMaxXP = 300
		ply.hl2cPersistent.PetHP = 125
		ply.hl2cPersistent.PetLevel = 1
		
		ply.hl2cPersistent.PetStage = 3
		
		ply.hl2cPersistent.PetRegen = 0
		ply.hl2cPersistent.PetSkills = 0
		ply.hl2cPersistent.PetStr = 1
		
		if ply.pet:IsValid() then
			ply.pet:Remove()
		end
		
		ply:ChatPrint("You've adopted a fast headcrab, Congratulations!")
		ply.petAlive = false
	
	end
	
	if newPet == "hl2cr_rollermine_pet" then
		ply.hl2cPersistent.PetMaxXP = 500
		ply.hl2cPersistent.PetHP = 150
		ply.hl2cPersistent.PetLevel = 1
		
		ply.hl2cPersistent.PetStage = 6
		
		ply.hl2cPersistent.PetRegen = 0
		ply.hl2cPersistent.PetSkills = 0
		ply.hl2cPersistent.PetStr = 0
		
		if ply.pet:IsValid() then
			ply.pet:Remove()
		end
		
		ply:ChatPrint("You've adopted a combine rollermine, Congratulations!")
		ply.petAlive = false
	
	end
	
	ply:SetNWInt("PetSkill", ply.hl2cPersistent.PetLevel)

	ply:SetNWInt("PetStr", ply.hl2cPersistent.PetStr)
	ply:SetNWInt("PetHP", ply.hl2cPersistent.PetHP)
	ply:SetNWInt("PetRegen", ply.hl2cPersistent.PetRegen)
	
	ply:SetNWInt("PetStage", ply.hl2cPersistent.PetStage)
	ply:SetNWInt("PetLevel", ply.hl2cPersistent.PetLevel)
	ply:SetNWInt("PetMaxXP", ply.hl2cPersistent.PetMaxXP)
end)

net.Receive("Evolving", function(len, ply)
	
	ply.pet:SetMaterial("models/props_combine/portalball001_sheet")
	
	ply.pet:EmitSound("npc/vort/health_charge.wav", 100, 100)
	
	ply.hl2cPersistent.PetSkills = 0
	
	ply.hl2cPersistent.PetLevel = 1
	
	ply.hl2cPersistent.PetHP = ply.hl2cPersistent.PetHP + 25
	ply.hl2cPersistent.PetStr = math.Round(ply.hl2cPersistent.PetStr / 2, 0) + 1
	ply.hl2cPersistent.PetRegen = 0
	
	ply:SetNWInt("PetSkill", ply.hl2cPersistent.PetLevel)
	ply.hl2cPersistent.PetPoints = 0
	ply:SetNWInt("PetSkillPoints", ply.hl2cPersistent.PetPoints)
	
	ply:SetNWInt("PetStr", ply.hl2cPersistent.PetStr)
	ply:SetNWInt("PetHP", ply.hl2cPersistent.PetHP)
	ply:SetNWInt("PetRegen", ply.hl2cPersistent.PetRegen)
	
	ply.hl2cPersistent.PetXP = 0
	ply:SetNWInt("PetXP", 0)
	ply.hl2cPersistent.PetMaxXP = 100 + (ply.hl2cPersistent.PetMaxXP + 50)
	ply.hl2cPersistent.PetStage = ply.hl2cPersistent.PetStage + 1
	ply:SetNWInt("PetStage", ply.hl2cPersistent.PetStage)
	ply:SetNWInt("PetLevel", ply.hl2cPersistent.PetLevel)
	ply:SetNWInt("PetMaxXP", ply.hl2cPersistent.PetMaxXP)
	
	if ply.hl2cPersistent.PetStage == 1 then
		ply.hl2cPersistent.PetIntendedLvl = 8
	elseif ply.hl2cPersistent.PetStage == 2 then
		ply.hl2cPersistent.PetIntendedLvl = 9
	end
	if ply.hl2cPersistent.PetStage == 3 then
		ply.hl2cPersistent.PetIntendedLvl = 9
	elseif ply.hl2cPersistent.PetStage == 4 then
		ply.hl2cPersistent.PetIntendedLvl = 10
	elseif ply.hl2cPersistent.PetStage == 5 then
		ply.hl2cPersistent.PetIntendedLvl = 11
	elseif ply.hl2cPersistent.PetStage == 6 then
		ply.hl2cPersistent.PetIntendedLvl = 4
	elseif ply.hl2cPersistent.PetStage == 7 then
		ply.hl2cPersistent.PetIntendedLvl = 7
	end
	
	timer.Simple(5, function()
		ply.pet:Remove()
		ply.pet:EmitSound("weapons/physcannon/energy_sing_explosion2.wav", 100, 100)
		local vPoint = ply.pet:GetPos()
		local effectdata = EffectData()
		effectdata:SetOrigin( vPoint )
		util.Effect( "cball_explode", effectdata )
		ply.pet:SetMaterial("")
		ply.petAlive = false
	end)
end)

function addPetXP(ply, amt)
	
	ply.hl2cPersistent.PetXP = ply.hl2cPersistent.PetXP + amt
	ply:SetNWInt("PetXP", ply.hl2cPersistent.PetXP)
	ply.hl2cPersistent.PetPoints = ply:GetNWInt("PetSkillPoints")
	
	
	if ply.hl2cPersistent.PetLevel >= ply.hl2cPersistent.PetMaxLvl then
		ply.hl2cPersistent.PetXP = 0
		ply:SetNWInt("PetXP", math.Round(ply.hl2cPersistent.PetXP))
	end

	if ply.hl2cPersistent.PetXP >= ply.hl2cPersistent.PetMaxXP then
		ply.hl2cPersistent.PetXP = 0
		
		if ply.hl2cPersistent.PetLevel != ply.hl2cPersistent.PetIntendedLvl then
			ply.hl2cPersistent.PetMaxXP = ply.hl2cPersistent.PetMaxXP + 25
		end
		
		ply.hl2cPersistent.PetLevel = ply.hl2cPersistent.PetLevel + 1
		ply.hl2cPersistent.PetPoints = ply.hl2cPersistent.PetPoints + 1
		
		ply:SetNWInt("PetLevel", ply.hl2cPersistent.PetLevel)
		ply:SetNWInt("PetXP", ply.hl2cPersistent.PetXP)
		ply:SetNWInt("PetMaxXP", ply.hl2cPersistent.PetMaxXP)
		ply:SetNWInt("PetSkillPoints", ply.hl2cPersistent.PetPoints)
		
		net.Start("UpdateSkillPoints")
			net.WriteInt(1, 16)
		net.Send(ply)
		ply:ChatPrint("Your pet has leveled up to " .. ply:GetNWInt("PetLevel"))
	end
end

net.Receive("PetKilledBarnacle", function(len, ply)
	if not ply then return end
	
	ply.petAlive = false
end)

hook.Add( "OnNPCKilled", "PetDeath", function(npc, attacker, inflictor)
	if npc:IsPet() then
		net.Start("PetDead")
		net.Send(npc.owner)
		npc.owner.petAlive = false
	end
	
	if attacker:IsPlayer() and not npc.owner and npc:IsPet() then
		npc.owner:ChatPrint(attacker:Nick() .. " killed your pet!")
	end
end)