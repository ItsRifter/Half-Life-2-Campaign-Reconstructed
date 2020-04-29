ENT.Base = "base_brush"
ENT.Type = "brush"

local createTrigger = true
if game.GetMap() == "hl2c_lobby_remake" then
	createTrigger = false

elseif game.GetMap() == "d1_trainstation_01" then

	ENT.PosA = Vector(-9386, -2488, 24)
	ENT.PosB = Vector(-9264, -2367, 92)

	
elseif game.GetMap() == "d1_trainstation_03" then return

elseif game.GetMap() == "d1_town_01" then 
createTrigger = false

elseif game.GetMap() == "d1_trainstation_03" then

	ENT.PosA = Vector(-4913, -4832, 638)
	ENT.PosB = Vector(-5087, -4767, 521)
	ENT.Checkpoint = Vector(-5006, -4823, 535)
	ENT.Angles = Angle(0, -90, 0)
end

function ENT:Initialize()
	if createTrigger then
		self:DrawShadow(false)
		self:SetCollisionBounds(self.PosA, self.PosB)
		self:SetSolid(SOLID_BBOX)
		self:SetCollisionGroup(COLLISION_GROUP_WORLD)
		self:SetTrigger(true)
	end
end

function ENT:StartTouch(ent)
	if ent and ent:IsValid() and ent:IsPlayer() and ent:Team() == TEAM_ALIVE and !self.triggered then
		self.triggered = true
		ent:ChatPrint("Checkpoint Reached")
		if self.OnTouchRun then
			self:OnTouchRun()
		end
		
		local ang = self.Angles
		
		for k, v in pairs(player.GetAll()) do
			if v and IsValid(v) and v:IsPlayer() and v:Team() == TEAM_ALIVE then
			print("Trigger")
				if v:GetVehicle() and v:GetVehicle():IsValid() then
					v:ExitVehicle()
					if self.Checkpoint != nil and isvector(self.Checkpoint) then
						v:SetPos(self.Checkpoint)
						v:SetPos(self.Checkpoint)
					else
						v:SetPos(self.Checkpoint)
						v:SetPos(self.Checkpoint)
					end
					
					v:SetAngles(ang)
				else
					if self.Checkpoint != nil and isvector(self.Checkpoint) then
						v:SetPos(self.Checkpoint)
						v:SetPos(self.Checkpoint)
					else
						v:SetPos(self.Checkpoint)
						v:SetPos(self.Checkpoint)
					end
					v:SetAngles(ang)
				end
			end
		end
	end
end
