ENT.Base = "base_brush"
ENT.Type = "brush"

function ENT:Initialize()

	self:DrawShadow(false)
	self:SetSolid(SOLID_BBOX)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetMoveType(0)
	self:SetTrigger(true)
end

--When the player touches the vortex
function ENT:StartTouch(ent)	
	if ent and ent:IsValid() and ent:IsPlayer() and ent:Team() == TEAM_ALIVE then
		giveVortex(game.GetMap(), ent)
	end
end
