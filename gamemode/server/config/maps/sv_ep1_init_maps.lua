function SetupEP1Map()
	if game.GetMap() == "ep1_citadel_00" then
		for k, h in pairs( ents.FindByName( "relay_givegravgun_1" )) do
			h:Fire("AddOutput", "OnTrigger triggerhook:RunPassedCode:hook.Run( 'GiveGravgunEp1' ):0:-1" )
		end		
	end
	
	SetCheckpointsStageEP1()
end


hook.Add("GiveGravgunEp1", "GrantGravgunEp1", function()
	for k, v in pairs(player.GetAll()) do
		v:Give("weapon_physcannon")
		v:ChatPrint("Gravity gun is now enabled")
	end
end)

function SetCheckpointsStageEP1()

	--Remove the old checkpoints and changelevels
	for k, oldCheck in pairs(ents.FindByClass("trigger_checkpoint")) do
		oldCheck:Remove()
	end
	
	for k, oldChange in pairs(ents.FindByClass("trigger_changelevel")) do
		oldChange:Remove()
	end
	
	if game.GetMap() == "ep1_citadel_00" then
		TRIGGER_CHANGELEVEL = {
			Vector(5378, 2908, -6342), Vector(5499, 2836, -6217)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(-9096, 5658, -143), Vector(-8892, 5752, -12),
			Vector(-8332, 6125, 187), Vector(-8519, 5880, -20),
		}
		
		TRIGGER_SPAWNPOINT = {
			Vector(-8987, 5748, -124),	Vector(-8213, 5995, 69)
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
		end
	end
end