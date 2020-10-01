ENT.Base = "base_brush"
ENT.Type = "brush"

local series = nil

if string.match(game.GetMap(), "d1_") or string.match(game.GetMap(), "d2_") 
or string.match(game.GetMap(), "d3_") then
	series = "hl2"
elseif string.match(game.GetMap(), "ep1_") then
	series = "ep1"
elseif string.match(game.GetMap(), "ep2_") then
	series = "ep2"
end

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
		if series == "hl2" then
			giveVortex(game.GetMap(), ent)
		elseif series == "ep1" then
			giveVortexEP1(game.GetMap(), ent)
		elseif series == "ep2" then
			giveVortexEP2(game.GetMap(), ent)
		end
	end
end
