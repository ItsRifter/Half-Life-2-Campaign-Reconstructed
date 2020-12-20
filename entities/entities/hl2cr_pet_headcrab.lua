AddCSLuaFile()

ENT.Base 			= "base_nextbot"
ENT.Spawnable		= false
ENT.AdminSpawnable 	= true
ENT.StartleDist = 500
ENT.ShouldFollowOwner = false
ENT.Owner = nil
ENT.StrengthDMG = 5
ENT.Recovery = 5
ENT.Speed = 50
function ENT:Initialize()
	self:SetModel("models/headcrabclassic.mdl")
	self:EmitSound("npc/antlion/digdown1.wav", 65, 100)
	self:PlaySequenceAndWait("BurrowOut", 1)
	self.LoseTargetDist	= 250
	self.SearchRadius 	= 150
	self.CooldownAttack = 0
	if SERVER then
		--PrintTable(self:GetSequenceList())
		self:SetHealth(self.Owner.hl2cPersistent.PetHP)
		self:SetMaxHealth(self.Owner.hl2cPersistent.PetHP)
		self.loco:SetDesiredSpeed(self.Speed)
	end
end

function ENT:SetEnemy(hostile)
	self.Enemy = hostile
end

function ENT:GetEnemy()
	return self.Enemy
end

function ENT:SetPetOwner(ply)
	if not ply then return end
	self.Owner = ply
end

function ENT:GetPetOwner()
	return self.Owner
end

function ENT:OnInjured( dmgInfo )
	local dmg = dmgInfo:GetDamage()
	local att = dmgInfo:GetAttacker()
	if att:IsPlayer() then 
		dmgInfo:SetDamage(0)
		return 
	end
end

function ENT:NearOwner()
	if not self.ShouldFollowOwner then return false end
	
	if self:GetPos():Distance(self.Owner:GetPos()) < 300 then
		return ply
	end
	
	return false
end

function ENT:NearHostile()
	local npcInRange = ents.FindInSphere(self:GetPos(), self.SearchRadius)
	
	for k, v in pairs(npcInRange) do
		if v:IsNPC() and (not v:IsFriendly() and not v:IsPet()) and v:IsLineOfSightClear(self:GetPos()) then
			self:SetEnemy(v)
			return true
		end
	end
	self:SetEnemy(nil)
	return false
end

function ENT:RunBehaviour()
	coroutine.wait(2)
	while ( true ) do
		if ( self:NearHostile() ) then
			self.loco:FaceTowards(self:GetEnemy():GetPos())
			self:StartActivity( ACT_JUMP )
			self.loco:JumpAcrossGap(self:GetEnemy():GetPos(), self:GetEnemy():GetForward())
			self:PlaySequenceAndWait( "jumpattack_broadcast" )
			self:EmitSound("npc/headcrab/attack2.wav", 100, 100)
			self:ChaseEnemy()
			self:StartActivity(ACT_IDLE)
		elseif self:NearOwner() then
			self:MoveToPos(self.Owner:GetPos())
			self.loco:FaceTowards(self.Owner:GetPos())
		else
			self:StartActivity( ACT_WALK )
			self:PlaySequenceAndWait( "Run1" )
			self:MoveToPos( self:GetPos() + Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), 0 ) * 175 )
			self:PlaySequenceAndWait( "Idle01" )
			self:StartActivity( ACT_IDLE )
		end
		coroutine.wait(4)
		
	end

end

function ENT:OnContact(hostile)

	if hostile:IsNPC() and not hostile:IsFriendly() and self.CooldownAttack < CurTime() then
		local dmg = DamageInfo()
		dmg:SetDamage(self.StrengthDMG)
		dmg:SetAttacker(self)
		hostile:TakeDamageInfo(dmg)
		self.CooldownAttack = 3 + CurTime()
	end
end

function ENT:ChaseEnemy( options )

	local options = options or {}
	local path = Path( "Follow" )
	path:SetMinLookAheadDistance( options.lookahead or 300 )
	path:SetGoalTolerance( options.tolerance or 20 )
	path:Compute( self, self:GetEnemy():GetPos() )

	if ( !path:IsValid() ) then return "failed" end

	while ( path:IsValid() and self:NearHostile() ) do
	
		if ( path:GetAge() > 0.1 ) then
			path:Compute(self, self:GetEnemy():GetPos())
		end
		path:Update( self )	
		
		if ( options.draw ) then path:Draw() end
		if ( self.loco:IsStuck() ) then
			self:HandleStuck()
			return "stuck"
		end

		coroutine.yield()

	end

	return "ok"

end

function ENT:HandleStuck()
	print("OHH... SHIT")
end

function ENT:FindEnemy()
	local _ents = ents.FindInSphere( self:GetPos(), self.SearchRadius )
	for k,v in ipairs( _ents ) do
		if ( v:IsPlayer() ) then
			self:SetEnemy(v)
			return true
		end
	end	
	self:SetEnemy(nil)
	return false
end

function ENT:PlaySequenceAndWait(name, speed)
	local length = self:SetSequence(name)
	speed = speed or 1
	self:ResetSequenceInfo()
	self:SetCycle(0)
	self:SetPlaybackRate(speed)
end