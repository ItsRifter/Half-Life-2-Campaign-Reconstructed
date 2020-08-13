PetAILike = {
	[1] = ents.FindByClass("npc_kleiner"),
	[2] = ents.FindByClass("npc_alyx"),
	[3] = ents.FindByClass("npc_barny"),
	[4] = ents.FindByClass("npc_citizen"),
	[5] = ents.FindByClass("npc_monk"),
}
PetAIHate = {
	[1] = ents.FindByClass("npc_zombie"),
	[2] = ents.FindByClass("npc_fastzombie"),
	[3] = ents.FindByClass("npc_poisonzombie"),
	[4] = ents.FindByClass("npc_citizen"),
	[5] = ents.FindByClass("npc_monk"),
}

function spawnPet(ply, pos)

	if ply:IsValid() and ply:Team() == TEAM_ALIVE and not ply.petAlive then
		ply:SetNWBool("PetActive", true)
		
		if game.GetMap() == "d1_trainstation_01" or game.GetMap() == "d1_trainstation_02" or game.GetMap() == "d1_trainstation_03" or game.GetMap() == "d1_trainstation_04" or game.GetMap() == "d1_trainstation_05" or game.GetMap() == "d1_eli_01" then
			ply:ChatPrint("Pets are disabled on this map")
		else
		
			if tonumber(ply:GetNWInt("PetStage")) <= 0 then
				ply.pet = ents.Create("npc_headcrab")
				ply.pet:AddRelationship("npc_zombie D_HT 99")
				ply.pet:AddRelationship("npc_headcrab D_HT 99")
			elseif tonumber(ply:GetNWInt("PetStage")) == 1 then
				ply.pet = ents.Create("npc_zombie_torso")
				ply.pet:AddRelationship("npc_zombie D_HT 99")
				ply.pet:AddRelationship("npc_headcrab D_HT 99")
			elseif tonumber(ply:GetNWInt("PetStage")) == 2 then
				ply.pet = ents.Create("npc_zombie")			
				ply.pet:AddRelationship("npc_zombie D_HT 99")
				ply.pet:AddRelationship("npc_headcrab D_HT 99")
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
		ply.pet:SetKeyValue("spawnflags", "SF_NPC_FADE_CORPSE")
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
		
		for k, v in pairs( ents.FindByClass( "npc_*" ) ) do
			if IsValid(v) and v:IsPet() then
				v:AddEntityRelationship(ply.pet, D_LI, 99)
				ply.pet:AddEntityRelationship(v, D_LI, 99)
			end
			
			for k, v in pairs( ents.FindByClass( "npc_*" ) ) do
				if v:IsValid() and v:IsPet() then
					v:AddEntityRelationship(ply.pet, D_LI, 99)
					ply.pet:AddEntityRelationship(v, D_LI, 99)
				elseif v:IsFriendly() then
					v:AddEntityRelationship(ply.pet, D_LI, 99)
					ply.pet:AddEntityRelationship(v, D_LI, 99)
				else
					ply.pet:AddEntityRelationship(v, D_HT, 99)
				end
			end
			net.Start("IndicPetSpawn")
			net.Send(ply)
		end
	end
end

-- Registry of all duels, accepted or not
duelRegistry = {}

net.Receive("PetChallenge", function(len, ply)
	local challengeeName = net.ReadString()
	local bet = net.ReadInt(32)

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

	-- Check for negative
	if bet < 0 then
		ply:ChatPrint(string.format("LUL, don't do that please"))
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

hook.Add("EntityTakeDamage", "PetHurtAndDamage", function(pet, dmgInfo)
	local attacker = dmgInfo:GetAttacker()
	local inflictor = dmgInfo:GetInflictor()
	local dmg = dmgInfo:GetDamage()
		
	if pet:IsPet() and not attacker:IsPlayer() then
		if not timer.Exists("PetRecoveryTimer") then
			timer.Create("PetRecoveryTimer", GetConVar("hl2c_petrecovertime"):GetInt(), 0, function()
				if pet:Health() <= pet:GetMaxHealth() and pet:IsValid() then
					pet:SetHealth(pet:Health() + GetConVar("hl2c_petrecovery"):GetInt() + pet:GetNWInt("PetRegen"))
					
					local regen = tonumber(pet:GetNWInt("PetRegen"))
					net.Start("UpdatePetsHealthDMG")
					net.WriteInt(regen, 32)
					net.Send(pet.owner)
					if pet:Health() >= pet:GetMaxHealth() then
						pet:SetHealth(pet:GetMaxHealth())
						timer.Remove("PetRecoveryTimer")
					end
				end
			end)
		end
	elseif pet:IsPet() and attacker:IsPlayer() then
		dmgInfo:SetDamage(0)
	end
	
	if not pet:IsValid() then
		pet.owner.petAlive = false
	end
end)

net.Receive("SpawnPetConCommand", function(len, ply)
	if not ply.petAlive then
		spawnPet(ply)
		ply:SetNWString("PetOwnerName", ply:Nick())
	else
		ply:ChatPrint("You can only summon your pet once every life!")
	end
end)

net.Receive("UpdateSkills", function(len, ply)
	local skillUpdate = net.ReadInt(16)
	ply.hl2cPersistent.PetPoints = ply.hl2cPersistent.PetPoints - 1
	
	if ply.hl2cPersistent.PetStage == 0 then
		if skillUpdate == 1 then
			ply.hl2cPersistent.PetHP = ply.hl2cPersistent.PetHP + 10
			ply:SetNWInt("PetHP", ply.hl2cPersistent.PetHP)
			ply.hl2cPersistent.PetSkills = 1
			
		elseif skillUpdate == 2 then
			ply.hl2cPersistent.PetSkills = 2
			ply.hl2cPersistent.PetRegen = ply.hl2cPersistent.PetRegen + 5
			ply:SetNWInt("PetRegen", ply.hl2cPersistent.PetRegen)
			
		elseif skillUpdate == 3 then
			ply.hl2cPersistent.PetStr = ply.hl2cPersistent.PetStr + 1
			ply:SetNWInt("StrBoost", ply.hl2cPersistent.PetStr)
			ply.hl2cPersistent.PetSkills = 3
			
		elseif skillUpdate == 4 then
			ply.hl2cPersistent.PetStr = ply.hl2cPersistent.PetStr + 1
			ply:SetNWInt("StrBoost", ply.hl2cPersistent.PetStr)
			ply.hl2cPersistent.PetSkills = 4
			
		elseif skillUpdate == 5 then
			ply.hl2cPersistent.PetSkills = 5
			ply.hl2cPersistent.PetRegen = ply.hl2cPersistent.PetRegen + 5
			ply:SetNWInt("PetRegen", ply.hl2cPersistent.PetRegen)
		end
	elseif ply.hl2cPersistent.PetStage == 1 then
			if skillUpdate == 1 then
				ply.hl2cPersistent.PetHP = ply.hl2cPersistent.PetHP + 10
				ply:SetNWInt("PetHP", ply.hl2cPersistent.PetHP)
				ply.hl2cPersistent.PetSkills = 1
		
			elseif skillUpdate == 2 then
				ply.hl2cPersistent.PetSkills = 2
				ply.hl2cPersistent.PetRegen = ply.hl2cPersistent.PetRegen + 5
				ply:SetNWInt("PetRegen", ply.hl2cPersistent.PetRegen)
				
			elseif skillUpdate == 3 then
				ply.hl2cPersistent.PetSkills = 3	
				ply.hl2cPersistent.PetStr = ply.hl2cPersistent.PetStr + 1
				ply:SetNWInt("PetStr", ply.hl2cPersistent.PetStr)
				
			elseif skillUpdate == 4 then
				ply.hl2cPersistent.PetStr = ply.hl2cPersistent.PetStr + 2
				ply:SetNWInt("PetStr", ply.hl2cPersistent.PetStr)
				ply.hl2cPersistent.PetSkills = 4
				
			elseif skillUpdate == 5 then
				ply.hl2cPersistent.PetSkills = 5
				ply.hl2cPersistent.PetRegen = ply.hl2cPersistent.PetRegen + 5
				ply:SetNWInt("PetRegen", ply.hl2cPersistent.PetRegen)
				
			elseif skillUpdate == 6 then
				ply.hl2cPersistent.PetSkills = 6
				ply.hl2cPersistent.PetStr = ply.hl2cPersistent.PetStr + 1
				ply:SetNWInt("PetStr", ply.hl2cPersistent.PetStr)
				
			elseif skillUpdate == 7 then
				ply.hl2cPersistent.PetSkills = 7
				ply.hl2cPersistent.PetStr = ply.hl2cPersistent.PetStr + 1
				ply:SetNWInt("PetStr", ply.hl2cPersistent.PetStr)
			end
			
	elseif ply.hl2cPersistent.PetStage == 2 then
			if skillUpdate == 1 then
				ply.hl2cPersistent.PetHP = ply.hl2cPersistent.PetHP + 5
				ply:SetNWInt("PetHP", ply.hl2cPersistent.PetHP)
				ply.hl2cPersistent.PetSkills = 1
		
			elseif skillUpdate == 2 then
				ply.hl2cPersistent.PetSkills = 2
				ply.hl2cPersistent.PetRegen = ply.hl2cPersistent.PetRegen + 5
				ply:SetNWInt("PetRegen", ply.hl2cPersistent.PetRegen)
				
			elseif skillUpdate == 3 then
				ply.hl2cPersistent.PetSkills = 3	
				ply.hl2cPersistent.PetHP = ply.hl2cPersistent.PetHP + 5
				ply:SetNWInt("PetHP", ply.hl2cPersistent.PetHP)
				
			elseif skillUpdate == 4 then
				ply.hl2cPersistent.PetStr = ply.hl2cPersistent.PetStr + 1
				ply:SetNWInt("PetStr", ply.hl2cPersistent.PetStr)
				ply.hl2cPersistent.PetSkills = 4
				
			elseif skillUpdate == 5 then
				ply.hl2cPersistent.PetSkills = 5
				ply.hl2cPersistent.PetHP = ply.hl2cPersistent.PetHP + 5
				ply:SetNWInt("PetHP", ply.hl2cPersistent.PetHP)
				
			elseif skillUpdate == 6 then
				ply.hl2cPersistent.PetSkills = 6
				ply.hl2cPersistent.PetStr = ply.hl2cPersistent.PetStr + 1
				ply:SetNWInt("PetStr", ply.hl2cPersistent.PetStr)
				
			elseif skillUpdate == 7 then
				ply.hl2cPersistent.PetSkills = 7
				ply.hl2cPersistent.PetStr = ply.hl2cPersistent.PetStr + 2
				ply:SetNWInt("PetStr", ply.hl2cPersistent.PetStr)
			end
		end
	ply:SetNWInt("PetSkillPoints", removePoint)
end)

net.Receive("Evolving", function(len, ply)
	
	ply.pet:SetMaterial("models/props_combine/portalball001_sheet")
	
	ply.pet:EmitSound("npc/vort/health_charge.wav", 100, 100)
	
	ply.hl2cPersistent.PetSkills = 0
	
	ply.hl2cPersistent.PetLevel = 1
	
	ply.hl2cPersistent.PetHP = ply.hl2cPersistent.PetHP + 25
	ply.hl2cPersistent.PetStr = ply.hl2cPersistent.PetStr + 1
	ply.hl2cPersistent.PetRegen = 0
	
	ply:SetNWInt("PetSkill", ply.hl2cPersistent.PetLevel)

	
	ply:SetNWInt("PetStr", ply.hl2cPersistent.PetStr)
	ply:SetNWInt("PetHP", ply.hl2cPersistent.PetHP)
	ply:SetNWInt("PetRegen", ply.hl2cPersistent.PetRegen)
	
	ply.hl2cPersistent.PetMaxXP = 200 + (ply.hl2cPersistent.PetMaxXP + 100)
	ply.hl2cPersistent.PetStage = ply.hl2cPersistent.PetStage + 1
	ply:SetNWInt("PetStage", ply.hl2cPersistent.PetStage)
	ply:SetNWInt("PetLevel", ply.hl2cPersistent.PetLevel)
	ply:SetNWInt("PetMaxXP", ply.hl2cPersistent.PetMaxXP)
	
	if ply.hl2cPersistent.PetStage == 1 then
		ply.hl2cPersistent.PetMaxLvl = 11
	elseif ply.hl2cPersistent.PetStage == 2 then
		ply.hl2cPersistent.PetMaxLvl = 13
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
	ply:SetNWInt("PetXP", math.Round(ply.hl2cPersistent.PetXP))
	ply.hl2cPersistent.PetPoints = ply:GetNWInt("PetSkillPoints")
	
	net.Start("UpdatePetsXP")
		net.WriteInt(ply.hl2cPersistent.PetXP, 32)
	net.Send(ply)
	if tonumber(ply.hl2cPersistent.PetLevel) >= tonumber(ply.hl2cPersistent.PetMaxLvl) then
		ply.hl2cPersistent.PetXP = 0
		ply:SetNWInt("PetXP", math.Round(ply.hl2cPersistent.PetXP))
		ply:ChatPrint("Your pet will not earn anymore XP at this stage, try evolving it")
	end
	ply.hl2cPersistent.PetLevel = ply:GetNWInt("PetLevel")
	ply.hl2cPersistent.PetPoints =  ply:GetNWInt("PetSkillPoints")
	if tonumber(ply.hl2cPersistent.PetXP) >= tonumber(ply.hl2cPersistent.PetMaxXP) then
		ply.hl2cPersistent.PetXP = 0
		ply.hl2cPersistent.PetMaxXP = ply.hl2cPersistent.PetMaxXP + 50
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