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
	strength = ply:GetNWInt("StrBoost")
	if ply:IsValid() and ply:Team() == TEAM_ALIVE and not ply.petAlive then
		ply:SetNWBool("PetActive", true)
		local tr = util.TraceLine( {
			start = ply:EyePos(),
			endpos = ply:EyePos() + ply:EyeAngles():Forward() * 10000,
			filter = function( ent ) if ( ent:GetClass() == "prop_physics" ) then return true end end
		})
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
		
	else
		ply:ChatPrint("You can only summon your pet once per map!")
	end
end

targetName = ""
challengerName = ""
opposPet = nil
opposPly = nil
bet = 0
duelProgress = false

net.Receive("PetChallenge", function(len, ply)
	targetName = net.ReadString()
	challengerName = net.ReadString()
	bet = net.ReadInt(32)
	opposPet = net.ReadEntity()
	opposPly = net.ReadEntity()
	print(targetName)
	print(challengerName)
	for k, v in pairs(player.GetAll()) do
		if v:Nick() == targetName then
			v:ChatPrint(challengerName .. " has challenged you for " .. math.Round(bet) .. " Lambda Coins")
			v:ChatPrint("!acceptduel or !declineduel")
		elseif v:Nick() != targetName or v:Nick() != challengerName then
			ply:ChatPrint(challengerName .. " has challenged " .. targetName .. " for " .. bet .. " Lambda Coins" )
		end
	end
	duel = true
	
end)

function PetDuelBegin(ply1, ply2, pet1, pet2, bet)
	if pet1:IsValid() and pet2:IsValid() and pet1:IsPet() and pet2:IsPet() then
		pet1:AddEntityRelationship(pet2, D_HT, 99)
		pet2:AddEntityRelationship(pet1, D_HT, 99)
	end
end

hook.Add("EntityTakeDamage", "PetHurtAndDamage", function(pet, dmgInfo)
	local attacker = dmgInfo:GetAttacker()
	local inflictor = dmgInfo:GetInflictor()
	local dmg = dmgInfo:GetDamage()
		
	if pet:IsPet() and not attacker:IsPlayer() then
		if not timer.Exists("PetRecoveryTimer") then
			timer.Create("PetRecoveryTimer", GetConVar("hl2c_petrecovertime"):GetInt(), 0, function()
				if pet:Health() <= pet:GetMaxHealth() then
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
end)

net.Receive("SpawnPetConCommand", function(len, ply)
	if not ply.petAlive then
		spawnPet(ply)
		ply:SetNWString("PetOwnerName", ply:Nick())
	else
		ply:ChatPrint("You can only summon your pet once per map!")
	end
end)

net.Receive("UpdateSkills", function(len, ply)
	local skillUpdate = net.ReadInt(16)

	local removePoint = ply:GetNWInt("PetSkillPoints")
	removePoint = removePoint - 1
	if ply:GetNWInt("PetStage") == 0 then
		if skillUpdate == 1 then
			ply.hl2cPersistent.PetHP = ply.hl2cPersistent.PetHP + 10
			ply:SetNWInt("PetHP", ply.hl2cPersistent.PetHP)
			ply:SetNWInt("PetSkill1", 1)
			ply.hl2cPersistent.PetSkills1 = 1
		elseif skillUpdate == 2 then
			ply.hl2cPersistent.PetSkills2 = 1
			ply.hl2cPersistent.PetRegen = ply.hl2cPersistent.PetRegen + 5
			ply:SetNWInt("PetRegen", ply.hl2cPersistent.PetRegen)
			ply:SetNWInt("PetSkill2", 1)
		elseif skillUpdate == 3 then
			ply.hl2cPersistent.PetStr = ply.hl2cPersistent.PetStr + 1
			ply:SetNWInt("StrBoost", ply.hl2cPersistent.PetStr)
			ply:SetNWInt("PetSkill3", 1)
			ply.hl2cPersistent.PetSkills3 = 1
		elseif skillUpdate == 4 then
			ply.hl2cPersistent.PetStr = ply.hl2cPersistent.PetStr + 1
			ply:SetNWInt("StrBoost", ply.hl2cPersistent.PetStr)
			ply:SetNWInt("PetSkill3", 1)
			ply.hl2cPersistent.PetSkills4 = 1
			ply:SetNWInt("PetSkill4", 1)
		elseif skillUpdate == 5 then
			ply.hl2cPersistent.PetSkills5 = 1
			ply.hl2cPersistent.PetRegen = ply.hl2cPersistent.PetRegen + 5
			ply:SetNWInt("PetRegen", ply.hl2cPersistent.PetRegen)
			ply:SetNWInt("PetSkill5", 1)
		end
	elseif ply:GetNWInt("PetStage") == 1 then
			if skillUpdate == 1 then
				ply.hl2cPersistent.PetHP = ply.hl2cPersistent.PetHP + 30
				ply:SetNWInt("PetHP", ply.hl2cPersistent.PetHP)
				ply.hl2cPersistent.PetSkills6 = 1
				ply:SetNWInt("PetSkill1", 1)
			elseif skillUpdate == 2 then
				ply.hl2cPersistent.PetStr = ply.hl2cPersistent.PetStr + 1
				ply:SetNWInt("PetStr", ply.hl2cPersistent.PetStr)
				ply.hl2cPersistent.PetSkills7 = 1
				ply:SetNWInt("PetSkill2", 1)
			elseif skillUpdate == 3 then
				ply.hl2cPersistent.PetStr = ply.hl2cPersistent.PetStr + 1
				ply:SetNWInt("PetStr", ply.hl2cPersistent.PetStr)
				ply.hl2cPersistent.PetSkills8 = 1
				ply:SetNWInt("PetSkill3", 1)
			elseif skillUpdate == 4 then
				ply.hl2cPersistent.PetStr = ply.hl2cPersistent.PetStr + 2
				ply:SetNWInt("PetStr", ply.hl2cPersistent.PetStr)
				ply.hl2cPersistent.PetSkills9 = 1
				ply:SetNWInt("PetSkill4", ply.hl2cPersistent.PetSkills9)
			elseif skillUpdate == 5 then
				ply.hl2cPersistent.PetSkills10 = 1
				ply:SetNWInt("PetSkill5", 1)
		end
	end
	ply:SetNWInt("PetSkillPoints", removePoint)
end)

net.Receive("Evolving", function(len, ply)
	
	ply.pet:SetMaterial("models/props_combine/portalball001_sheet")
	
	ply.pet:EmitSound("npc/vort/health_charge.wav", 100, 100)
	
	ply.hl2cPersistent.PetSkills1 = 0
	ply.hl2cPersistent.PetSkills2 = 0
	ply.hl2cPersistent.PetSkills3 = 0
	ply.hl2cPersistent.PetSkills4 = 0
	ply.hl2cPersistent.PetSkills5 = 0
	ply.hl2cPersistent.PetSkills6 = 0
	ply.hl2cPersistent.PetSkills7 = 0
	ply.hl2cPersistent.PetSkills8 = 0
	ply.hl2cPersistent.PetSkills9 = 0
	ply.hl2cPersistent.PetSkills10 = 0
	
	ply.hl2cPersistent.PetLevel = 1
	
	ply.hl2cPersistent.PetHP = ply.hl2cPersistent.PetHP + 25
	ply.hl2cPersistent.PetStr = ply.hl2cPersistent.PetStr + 1
	ply.hl2cPersistent.PetRegen = 0
	
	ply:SetNWInt("PetSkill1", 0)
	ply:SetNWInt("PetSkill2", 0)
	ply:SetNWInt("PetSkill3", 0)
	ply:SetNWInt("PetSkill4", 0)
	ply:SetNWInt("PetSkill5", 0)
	ply:SetNWInt("PetSkill6", 0)
	ply:SetNWInt("PetSkill7", 0)
	ply:SetNWInt("PetSkill8", 0)
	ply:SetNWInt("PetSkill9", 0)
	ply:SetNWInt("PetSkill10", 0)
	
	ply:SetNWInt("PetStr", ply.hl2cPersistent.PetStr)
	ply:SetNWInt("PetHP", ply.hl2cPersistent.PetHP)
	ply:SetNWInt("PetRegen", ply.hl2cPersistent.PetRegen)
	
	ply.hl2cPersistent.PetMaxXP = 200
	ply.hl2cPersistent.PetStage = ply.hl2cPersistent.PetStage + 1
	ply:SetNWInt("PetStage", ply.hl2cPersistent.PetStage)
	ply:SetNWInt("PetLevel", ply.hl2cPersistent.PetLevel)
	ply:SetNWInt("PetMaxXP", ply.hl2cPersistent.PetMaxXP)
	
	if tonumber(ply:GetNWInt("PetStage")) == 0 then
		ply.hl2cPersistent.PetMaxLvl = 11
	elseif tonumber(ply:GetNWInt("PetStage")) == 1 then
		ply.hl2cPersistent.PetMaxLvl = 13
	end
	
	
	ply.petAlive = false
	timer.Simple(5, function()
		local oldPos = ply.pet:GetPos()
		ply.pet:Remove()
		spawnPet(ply, oldPos)
		ply.pet:EmitSound("weapons/physcannon/energy_sing_explosion2.wav", 100, 100)
		local vPoint = ply.pet:GetPos()
		local effectdata = EffectData()
		effectdata:SetOrigin( vPoint )
		util.Effect( "cball_explode", effectdata )
		ply.pet:SetMaterial("")
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
	if npc.owner then
		net.Start("PetDead")
		net.Send(npc.owner)
	end
end)