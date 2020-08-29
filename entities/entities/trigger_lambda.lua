ENT.Base = "base_brush"
ENT.Type = "brush"

function ENT:Initialize()

	--Set width, length and height of the lambda trigger
	local w = LAMBDA_POSITION[2].x - LAMBDA_POSITION[1].x
	local l = LAMBDA_POSITION[2].y - LAMBDA_POSITION[1].y
	local h = LAMBDA_POSITION[2].z - LAMBDA_POSITION[1].z
	local minPos = Vector(-1 - ( w / 2 ), -1 - ( l / 2 ), -1 - ( h / 2 ))
	local maxPos = Vector(w / 2, l / 2, h / 2)

	self:DrawShadow(false)
	self:SetCollisionBounds(minPos, maxPos)
	self:SetSolid(SOLID_BBOX)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetMoveType(0)
	self:SetTrigger(true)
end

--When the player touches the lambda trigger
function ENT:StartTouch(ent)	
	if ent and ent:IsValid() and ent:IsPlayer() and ent:Team() == TEAM_ALIVE then
		giveLambda(game.GetMap(), ent)
	end
end
