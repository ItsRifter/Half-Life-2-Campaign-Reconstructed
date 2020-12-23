function SetupCoastlineMap()
	--Create the lua entity
	MapLua = ents.Create("lua_run")
	MapLua:SetName("triggerhook")
	MapLua:Spawn()
	
	table.insert(startingWeapons, "weapon_crowbar")
	
	SetUpCheckpointsCoastline()
end

function SetUpCheckpointsCoastline()
	
	--Remove the old checkpoints and changelevels
	for k, oldCheck in pairs(ents.FindByClass("trigger_checkpoint")) do
		oldCheck:Remove()
	end
	
	for k, oldChange in pairs(ents.FindByClass("trigger_changelevel")) do
		oldChange:Remove()
	end
	
	if game.GetMap() == "leonhl2-2" then
		TRIGGER_CHANGELEVEL = {
			Vector(-3159, -5643, 534), 	Vector(-3296, -5774, 284)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(-2593, -772, 342),	Vector(-2693, -671, 443),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(-2641, -710, 366)
		}
		
	end
	if TRIGGER_CHANGELEVEL then
		local changeLevel = ents.Create("trigger_changelevel")
		changeLevel.Min = Vector(TRIGGER_CHANGELEVEL[1])
		changeLevel.Max = Vector(TRIGGER_CHANGELEVEL[2])
		changeLevel.Pos = Vector(TRIGGER_CHANGELEVEL[2]) - ( ( Vector(TRIGGER_CHANGELEVEL[2]) - Vector(TRIGGER_CHANGELEVEL[1])) / 2 )
		changeLevel:SetPos(changeLevel.Pos)
		changeLevel:Spawn()
	end
	
	if TRIGGER_CHECKPOINT then
	
		if TRIGGER_CHECKPOINT[1] and TRIGGER_CHECKPOINT[2] then
			Checkpoint1 = ents.Create("trigger_checkpoint")
			Checkpoint1.Min = Vector(TRIGGER_CHECKPOINT[1])
			Checkpoint1.Max = Vector(TRIGGER_CHECKPOINT[2])
			Checkpoint1.Pos = Vector(TRIGGER_CHECKPOINT[2]) - ( ( Vector(TRIGGER_CHECKPOINT[2]) - Vector(TRIGGER_CHECKPOINT[1])) / 2 )
			Checkpoint1.Point1 = Vector(TRIGGER_SPAWNPOINT[1])
			Checkpoint1:SetPos(Checkpoint1.Pos)
			Checkpoint1:Spawn()
				
			lambdaModel1 = ents.Create("prop_dynamic")
			lambdaModel1:SetModel("models/hl2cr_lambda.mdl")
			lambdaModel1:SetMaterial("editor/orange")
			lambdaModel1:SetPos(Checkpoint1.Pos)
			lambdaModel1:Spawn()
			lambdaModel1:SetName("lambdaCheckpoint")
			lambdaModel1:ResetSequence("idle")
		end
		
		if TRIGGER_CHECKPOINT[3] and TRIGGER_CHECKPOINT[4] then
			Checkpoint2 = ents.Create("trigger_checkpoint")
			Checkpoint2.Min = Vector(TRIGGER_CHECKPOINT[3])
			Checkpoint2.Max = Vector(TRIGGER_CHECKPOINT[4])
			Checkpoint2.Pos = Vector(TRIGGER_CHECKPOINT[4]) - ( ( Vector(TRIGGER_CHECKPOINT[4]) - Vector(TRIGGER_CHECKPOINT[3])) / 2 )
			Checkpoint2.Point2 = Vector(TRIGGER_SPAWNPOINT[2])
			Checkpoint2:SetPos(Checkpoint2.Pos)
			Checkpoint2:Spawn()
			
			lambdaModel2 = ents.Create("prop_dynamic")
			lambdaModel2:SetModel("models/hl2cr_lambda.mdl")
			lambdaModel2:SetMaterial("editor/orange")
			lambdaModel2:SetPos(Checkpoint2.Pos)
			lambdaModel2:Spawn()
			lambdaModel2:SetName("lambdaCheckpoint")
			lambdaModel2:ResetSequence("idle")
		end
		
		if TRIGGER_CHECKPOINT[5] and TRIGGER_CHECKPOINT[6] then
			Checkpoint3 = ents.Create("trigger_checkpoint")
			Checkpoint3.Min = Vector(TRIGGER_CHECKPOINT[5])
			Checkpoint3.Max = Vector(TRIGGER_CHECKPOINT[6])
			Checkpoint3.Pos = Vector(TRIGGER_CHECKPOINT[6]) - ( ( Vector(TRIGGER_CHECKPOINT[6]) - Vector(TRIGGER_CHECKPOINT[5])) / 2 )
			Checkpoint3.Point3 = Vector(TRIGGER_SPAWNPOINT[3])
			Checkpoint3:SetPos(Checkpoint3.Pos)
			Checkpoint3:Spawn()
			
			lambdaModel3 = ents.Create("prop_dynamic")
			lambdaModel3:SetModel("models/hl2cr_lambda.mdl")
			lambdaModel3:SetMaterial("editor/orange")
			lambdaModel3:SetPos(Checkpoint3.Pos)
			lambdaModel3:Spawn()
			lambdaModel3:SetName("lambdaCheckpoint")
			lambdaModel3:ResetSequence("idle")
		end
		
		if TRIGGER_CHECKPOINT[7] and TRIGGER_CHECKPOINT[8] then
			Checkpoint4 = ents.Create("trigger_checkpoint")
			Checkpoint4.Min = Vector(TRIGGER_CHECKPOINT[7])
			Checkpoint4.Max = Vector(TRIGGER_CHECKPOINT[8])
			Checkpoint4.Pos = Vector(TRIGGER_CHECKPOINT[8]) - ( ( Vector(TRIGGER_CHECKPOINT[8]) - Vector(TRIGGER_CHECKPOINT[7])) / 2 )
			Checkpoint4.Point4 = Vector(TRIGGER_SPAWNPOINT[4])
			Checkpoint4:SetPos(Checkpoint4.Pos)
			Checkpoint4:Spawn()
			
			lambdaModel4 = ents.Create("prop_dynamic")
			lambdaModel4:SetModel("models/hl2cr_lambda.mdl")
			lambdaModel4:SetMaterial("editor/orange")
			lambdaModel4:SetPos(Checkpoint4.Pos)
			lambdaModel4:Spawn()
			lambdaModel4:SetName("lambdaCheckpoint")
			lambdaModel4:ResetSequence("idle")
		end
		
		if TRIGGER_CHECKPOINT[9] and TRIGGER_CHECKPOINT[10] then
			Checkpoint5 = ents.Create("trigger_checkpoint")
			Checkpoint5.Min = Vector(TRIGGER_CHECKPOINT[9])
			Checkpoint5.Max = Vector(TRIGGER_CHECKPOINT[10])
			Checkpoint5.Pos = Vector(TRIGGER_CHECKPOINT[10]) - ( ( Vector(TRIGGER_CHECKPOINT[10]) - Vector(TRIGGER_CHECKPOINT[9])) / 2 )
			Checkpoint5.Point5 = Vector(TRIGGER_SPAWNPOINT[5])
			Checkpoint5:SetPos(Checkpoint5.Pos)
			Checkpoint5:Spawn()
			
			lambdaModel5 = ents.Create("prop_dynamic")
			lambdaModel5:SetModel("models/hl2cr_lambda.mdl")
			lambdaModel5:SetMaterial("editor/orange")
			lambdaModel5:SetPos(Checkpoint5.Pos)
			lambdaModel5:Spawn()
			lambdaModel5:SetName("lambdaCheckpoint")
			lambdaModel5:ResetSequence("idle")
		end
		
		if TRIGGER_CHECKPOINT[11] and TRIGGER_CHECKPOINT[12] then
			Checkpoint6 = ents.Create("trigger_checkpoint")
			Checkpoint6.Min = Vector(TRIGGER_CHECKPOINT[12])
			Checkpoint6.Max = Vector(TRIGGER_CHECKPOINT[11])
			Checkpoint6.Pos = Vector(TRIGGER_CHECKPOINT[11]) - ( ( Vector(TRIGGER_CHECKPOINT[11]) - Vector(TRIGGER_CHECKPOINT[12])) / 2 )
			Checkpoint6.Point6 = Vector(TRIGGER_SPAWNPOINT[6])
			Checkpoint6:SetPos(Checkpoint6.Pos)
			Checkpoint6:Spawn()
			
			lambdaModel6 = ents.Create("prop_dynamic")
			lambdaModel6:SetModel("models/hl2cr_lambda.mdl")
			lambdaModel6:SetMaterial("editor/orange")
			lambdaModel6:SetPos(Checkpoint6.Pos)
			lambdaModel6:Spawn()
			lambdaModel6:SetName("lambdaCheckpoint")
			lambdaModel6:ResetSequence("idle")
		end
	end
end