ENT.Base = "base_brush"
ENT.Type = "brush"

function ENT:Initialize()
	
	if not TRIGGER_CHECKPOINT then
		return
	end

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
		file.Delete("hl2cr_data/babydoll3.txt")
		for k, v in pairs(player.GetAll()) do
			Achievement(v, "A_Red_Letter_Baby", "HL2_Ach_List", 1000)	
		end
	end
	
	if ent and ent:IsValid() and ent:IsPlayer() and ent:Team() == TEAM_ALIVE and not self.triggered then
		self.triggered = true
		local ang = ent:GetAngles()
		
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
		
		--If point1 triggered and sand achievement is achievable
		if point1 and game.GetMap() == "d2_coast_11" and sandAchEarnable then
			for k, v in pairs(player.GetAll()) do
				Achievement(v, "Keep_off_the_sand", "HL2_Ach_List", 4000)
			end
			surpassSand = true
		end
				
		--Chat print to all players and enable their one time command use
		for k, p in pairs(player.GetAll()) do
			p:ChatPrint("Checkpoint Reached")
			if p:Team() == TEAM_DEAD then
				p:Spawn()
				p:UnLock()
				p:UnSpectate()
				DisableSpec(p)
				p.isAliveSurv = true
				deaths = deaths - deaths
			end
			
			for l, spawn in pairs(ents.FindByClass("info_player_start")) do
				if p and IsValid(p) and p:Team() == TEAM_ALIVE and p != ent then
					if (game.GetMap() != "d1_trainstation_01" or game.GetMap() != "d1_trainstation_02" or game.GetMap() != "d1_trainstation_03" or 
					game.GetMap() != "d1_trainstation_04" or game.GetMap() != "d1_trainstation_05") then 
						p.CPTP = true
						ent.CPTP = false
					end

					if not (ent:GetVehicle() and ent:GetVehicle():IsValid()) and (p:GetVehicle() and p:GetVehicle():IsValid()) then
						p.AllowSpawn = true
						p:ExitVehicle()
					end
					
					if point1 then
						spawn:SetPos(point1)
						p:SetPos(point1)
					elseif point2 then
						spawn:SetPos(point2)
						p:SetPos(point2)
					elseif point3 then
						spawn:SetPos(point3)
						p:SetPos(point3)
					elseif point4 then
						spawn:SetPos(point4)
						p:SetPos(point4)
					elseif point5 then
						spawn:SetPos(point5)
						p:SetPos(point5)
					end
				elseif p == ent then
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
		if point1 then
			lambdaModel1:Remove()
		elseif point2 then
			lambdaModel2:Remove()
		elseif point3 then
			lambdaModel3:Remove()
		elseif point4 then
			lambdaModel4:Remove()
		elseif point5 then
			lambdaModel5:Remove()
		end
		
		if blocker and blocker:IsValid() then
			blocker:Remove()
		end
		
		if game.GetMap() == "d2_coast_10" and point1 then
			for k, v in pairs(player.GetAll()) do
				if v.spawnJeep then
					v.spawnJeep:Remove()
				end
			end
			lockedSpawn = true
			if GetConVar("hl2cr_survivalmode"):GetInt() == 0 then
				beginLoyal()
			end
		elseif game.GetMap() == "d2_coast_10" and point2 then
			endLoyal()
		end
		
		if game.GetMap() == "d3_citadel_04" and (point1 or point2) then
			local train = ents.FindByName("citadel_train_lift01_1")
			
			for k, resetSpawn in pairs(ents.FindByClass("info_player_start")) do
				resetSpawn:SetParent(train[1])
			end
		else
			for k, resetSpawn in pairs(ents.FindByClass("info_player_start")) do
				resetSpawn:SetParent(nil)
			end
		end
		self:EmitSound("hl1/ambience/port_suckin1.wav", 100, 100)
		self:Remove()
	end
end