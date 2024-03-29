ENT.Base = "base_brush"
ENT.Type = "brush"

function ENT:Initialize()

	if not TRIGGER_CHECKPOINT then
		return
	end

	--Set width, length and height of the checkpoint
	
	local w = self.Max.x - self.Min.x
	local l = self.Max.y - self.Min.y
	local h = self.Max.z - self.Min.z

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
			Achievement(v, "A_Red_Letter_Baby", "HL2_Ach_List")
			if not table.HasValue(v.hl2cPersistent.HatTable, "baby_head") then
				table.insert(v.hl2cPersistent.HatTable, "baby_head")
				v:ChatPrint("You earned a 'baby head' hat")
			end
		end
	end

	if ent and ent:IsValid() and ent:IsPlayer() and ent:Team() == TEAM_ALIVE and not self.triggered then
		self.triggered = true
		--local ang = ent:GetAngles() --Unused Variable: ang

		--Checkpoint points
		local point1 = self.Point1
		local point2 = self.Point2
		local point3 = self.Point3
		local point4 = self.Point4
		local point5 = self.Point5
		local point6 = self.Point6
		if self.OnTouchRun then
			self:OnTouchRun()
		end

		--If the map is canals 11 and point1 has been triggered, allow the airboat gun
		if point1 and game.GetMap() == "d1_canals_11" then
			airboatGunSpawnable = true
			AllowSpawn = true
			for k, v in pairs(player.GetAll()) do
				v:ChatPrint("Airboat weapon is now available")
				v.AllowSpawn = true
			end
		end

		--If point1 triggered and sand achievement is achievable
		if point1 and game.GetMap() == "d2_coast_11" and sandAchEarnable then
			for k, v in pairs(player.GetAll()) do
				Achievement(v, "Keep_off_the_sand", "HL2_Ach_List")
			end
			surpassSand = true
		end
		
		--[[
		if game.GetMap() == "ep1_citadel_00" and point1 then
			timer.Simple(5, function()
				ent:ExitVehicle()
				ent:SetPos(Vector(-8980, 5789, -117))
			end)
		end

		if game.GetMap() == "ep1_citadel_00" and point2 then
			for k, alyx in pairs(ents.FindByClass("npc_alyx")) do
				alyx:SetPos(Vector(-8636, 5987, -65))
			end
			for k, dog in pairs(ents.FindByClass("npc_dog")) do
				dog:SetPos(Vector(-7953, 5700, 48))
			end
		elseif game.GetMap() == "ep1_citadel_00" and point3 then
			for k, dog in pairs(ents.FindByClass("npc_dog")) do
				dog:SetPos(Vector(-6549, 6258, -71))
			end
		end
		--]]
		
		if game.GetMap() == "ep1_citadel_01" and point1 then
			for k, alyx in pairs(ents.FindByClass("npc_alyx")) do
				alyx:SetPos(Vector(-4637, 7798, 2537))
			end
			for k, removeBrush in pairs(ents.FindByClass("func_brush")) do
				if removeBrush:GetName() == "clip_combineshieldwall6" then
					removeBrush:Remove()
				end
			end
		end
		
		if game.GetMap() == "ep1_citadel_02b" and point2 then
			for k, v in pairs(player.GetAll()) do
				Achievement(v, "Watch_Your_Head", "EP1_Ach_List")
			end
		end
		
		if game.GetMap() == "ep1_citadel_03" and point4 then
			for k, v in pairs(player.GetAll()) do
				Achievement(v, "Containment", "EP1_Ach_List")
			end
			if pacifistAchEarnable then
				for k, v in pairs(player.GetAll()) do
					Achievement(v, "Pacifist", "EP1_Ach_List")
				end
				surpassPacifist = true
			end
		end

		--Chat print to all players and enable their one time command use
		for k, p in pairs(player.GetAll()) do
			p:ChatPrint("Checkpoint Reached")
			if p:Team() == TEAM_DEAD then
				p:UnSpectate()
				deaths = deaths - deaths
				deadPlayers = deaths
				table.Empty(Cheating_Players_Survival)
				p:Spawn()
			end
			local MAPS_TRAINSTATION = {
				["d1_trainstation_01"] = true,
				["d1_trainstation_02"] = true,
				["d1_trainstation_03"] = true,
				["d1_trainstation_04"] = true,
				["d1_trainstation_05"] = true
			}
			for l, spawn in pairs(ents.FindByClass("info_player_start")) do
				if p and IsValid(p) and p:Team() == TEAM_ALIVE then
					if not MAPS_TRAINSTATION[game.GetMap()] then
						p.CPTP = true
						ent.CPTP = false
					end
					if game.GetMap() == "d1_trainstation_03" then
						activateHostility = true
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
					elseif point6 then
						spawn:SetPos(point6)
						p:SetPos(point6)
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
					elseif point6 then
						spawn:SetPos(point6)
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
		elseif point6 then
			lambdaModel6:Remove()
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
				--beginLoyal()
			end
		elseif game.GetMap() == "d2_coast_10" and point2 then
			endLoyal()
		end

		if game.GetMap() == "d3_c17_10a" then
			for k, v in pairs(ents.FindByClass("npc_barney")) do
				v:SetPos(Vector(-2460, 6721, 514))
			end
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
		
		if game.GetMap() == "ep1_citadel_02b" and point1 then
			local train = ents.FindByName("citadel_train_lift01_1")

			for k, resetSpawn in pairs(ents.FindByClass("info_player_start")) do
				resetSpawn:SetParent(train[1])
			end
		else
			for k, resetSpawn in pairs(ents.FindByClass("info_player_start")) do
				resetSpawn:SetParent(nil)
			end
		end
		
		if game.GetMap() == "ep2_outland_05" and point1 then
			for k, v in pairs(player.GetAll()) do
				Achievement(v, "Twofer", "EP2_Ach_List")
			end
		end
		
		if game.GetMap() == "ep2_outland_06" and point3 then
			jalopySpawnable = true
		end
		
		if game.GetMap() == "ep2_outland_10" and point2 then
			for k, v in pairs(player.GetAll()) do
				Achievement(v, "Quiet_Mountain_Getaway", "EP2_Ach_List")
			end
		end
		
		if game.GetMap() == "ep2_outland_12" and point3 then
			for k, v in pairs(player.GetAll()) do
				Achievement(v, "Defense_of_the_Armament", "EP2_Ach_List")
			end
		end
		
		if game.GetMap() == "ep2_outland_07" and point1 then
			for k, removeDoor in pairs(ents.FindByName("barn_door_1")) do
				removeDoor:Remove()
			end
			
			for k, removeGateBrush in pairs(ents.FindByName("clip_gate_closed")) do
				removeGateBrush:Remove()
			end
			
			for k, removeGate in pairs(ents.FindByName("gate_closed")) do
				removeGate:Remove()
			end
		end
		
		if game.GetMap() == "syn_trials4b" and point5 then
			for k, logic in pairs(ents.FindByName("finale_logic_start")) do
				logic:Fire("Trigger")
			end
		end
		
		if game.GetMap() == "syn_trials4c" and point1 then
			for k, sound in pairs(ents.FindByName("prelude_stripper_s_port")) do
				sound:Fire("PlaySound")
			end
			for l, ply in pairs(player.GetAll()) do
				ply:StripWeapons()
			end
			table.Empty(startingWeapons)
		end
		
		self:EmitSound("hl1/ambience/port_suckin1.wav", 100, 100)
		self:Remove()
	end
end