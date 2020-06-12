ENT.Base = "base_brush"
ENT.Type = "brush"

function ENT:Initialize()

	--Set width, length and height of the checkpoint
	local w = TRIGGER_CHECKPOINT[2].x - TRIGGER_CHECKPOINT[1].x
	local l = TRIGGER_CHECKPOINT[2].y - TRIGGER_CHECKPOINT[1].y
	local h = TRIGGER_CHECKPOINT[2].z - TRIGGER_CHECKPOINT[1].z
	local minPos = Vector(-1 - ( w / 2 ), -1 - ( l / 2 ), -1 - ( h / 2 ))
	local maxPos = Vector(w / 2, l / 2, h / 2)

	self:DrawShadow(false)
	self:SetCollisionBounds(minPos, maxPos)
	self:SetSolid(SOLID_BBOX)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetMoveType(0)
	self:SetTrigger(true)
end

--When the player touches the entity
function ENT:StartTouch(ent)	
	if ent and ent:IsValid() and ent:GetModel() == "models/props_c17/doll01.mdl" and game.GetMap() == "d1_trainstation_05" then
		ent:Remove()
		file.Delete("hl2c_data/babydoll3.txt")
		for k, v in pairs(player.GetAll()) do
			Achievement(v, "Baby", "HL2_Ach_List", 1000)	
		end
	end
	
	if ent and ent:IsValid() and ent:IsPlayer() and ent:Team() == TEAM_ALIVE and not self.triggered then
		self.triggered = true
		local ang = ent:GetAngles()
		
		--forceTP teleports the player to the checkpoint
		local forceTP = self.forcePlyTP
		--Checkpoint points
		local point1 = self.Point1
		local point2 = self.Point2
		local point3 = self.Point3
		local point4 = self.Point4
		local point5 = self.Point5
		if self.OnTouchRun then
			self:OnTouchRun()
		end
		
		--If the map is canals 11 and point1 has been triggered, allow the airboat gun
		if point1 and game.GetMap() == "d1_canals_11" then
			airboatGunSpawnable = true
			AllowSpawn = true
			for k, v in pairs(player.GetAll()) do
				v:ChatPrint("Airboat weapon is now available")
			end
		end
		
		--Achievement if the sand hasn't been touched and point1 hasn't been triggered
		if game.GetMap() == "d2_coast_11" and not point1 then
			for k, sand in pairs(ents.FindByClass("env_player_surface_trigger")) do
				sandAchEarnable = true
				sand:Fire("AddOutput", "OnSurfaceChangedToTarget triggerhook:RunPassedCode:hook.Run( 'FailSand' ):0:-1" )
				print(sand)
			end
		end
		
		--If point1 triggered and sand achievement is achievable
		if point1 and game.GetMap() == "d2_coast_11" and sandAchEarnable then
			for k, v in pairs(player.GetAll()) do
				Achievement(v, "Sand", "HL2_Ach_List", 4000)
			end
		end
		
		--Chat print to all players and enable their one time command use
		for k, p in pairs(player.GetAll()) do
			p:ChatPrint("Checkpoint Reached")
			for l, spawn in pairs(ents.FindByClass("info_player_start")) do
				if p and IsValid(p) and p != ent and p:Team() == TEAM_ALIVE then
					p.CPTP = true
					ent.CPTP = false
					if p:GetVehicle() and p:GetVehicle():IsValid() then
						p:ExitVehicle()
					end
					if forceTP then
						if point1 then
							p:SetPos(point1)
							spawn:SetPos(point1)
						elseif point2 then
							p:SetPos(point2)
							spawn:SetPos(point2)
						elseif point3 then
							p:SetPos(point3)
							spawn:SetPos(point3)
						elseif point4 then
							p:SetPos(point4)
							spawn:SetPos(point4)
						elseif point5 then
							p:SetPos(point5)
							spawn:SetPos(point5)
						end
						p:SetAngles(ang)	
					elseif not forceTP then
						if point1 then
							spawn:SetPos(point1)
						elseif point2 then

							spawn:SetPos(point2)
						elseif point3 then
							spawn:SetPos(point3)
						elseif point4 then
							spawn:SetPos(point4)
						elseif point5 then
							spawn:SetPos(point5)
						end
					end
				end
			end
		end
		self:Remove()
	end
end
