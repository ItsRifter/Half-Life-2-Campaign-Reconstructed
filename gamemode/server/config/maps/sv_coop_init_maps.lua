function SetupCoopMap()
	--Create the lua entity
	MapLua = ents.Create("lua_run")
	MapLua:SetName("triggerhook")
	MapLua:Spawn()
	
	if game.GetMap() == "syn_trials4" or game.GetMap() == "syn_trials4b" or game.GetMap() == "syn_trials4c" then
		for k, oldLogic in pairs(ents.FindByClass("logic_relay")) do
			if oldLogic:GetName() == "intro_stopwaiting" then
				oldLogic:Fire("Trigger")
			end
			
			if oldLogic:GetName() == "game_start" then
				oldLogic:Fire("Trigger")
			end
		end
		
		for k, removeManager in pairs(ents.FindByClass("info_spawn_manager")) do
			removeManager:Remove()
		end
		
		for k, resetSynLogic in pairs(ents.FindByClass("info_player_coop")) do
			resetSynLogic:Remove()
		end
		
		if game.GetMap() == "syn_trials4b" then			
			for k, removeBrush in pairs(ents.FindByClass("func_brush")) do
				if removeBrush:GetName() == "trial_d_field" or removeBrush:GetName() == "clip_combineshieldwall1" 
				or removeBrush:GetName() == "brush_combineshieldwall1" then
					removeBrush:Remove()
				end
			end
			for l, endlogic in pairs(ents.FindByName("finale_logic_done")) do
				endlogic:Fire("AddOutput", "OnTrigger triggerhook:RunPassedCode:hook.Run( 'EndMap' ):15:-1" )
			end
		end
		if game.GetMap() == "syn_trials4c" then
			for l, endlogic in pairs(ents.FindByName("trial_h_complete")) do
				endlogic:Fire("AddOutput", "OnTrigger triggerhook:RunPassedCode:hook.Run( 'EndMap' ):15:-1" )
			end
		end
	end
	
	table.insert(startingWeapons, "weapon_crowbar")
	
	if game.GetMap() == "syn_silent_house" then
		for k, v in pairs(ents.FindByClass("math_counter")) do
			if v:GetName() == "fz_count" then
				v:Fire("AddOutput", "OnHitMax triggerhook:RunPassedCode:hook.Run( 'EndMap' ):15:-1" )
			end
		end
	end
	
	if game.GetMap() == "syn_farm" then
		table.insert(startingWeapons, "weapon_pistol")
		table.insert(startingWeapons, "weapon_smg1")
		table.insert(startingWeapons, "weapon_shotgun")
		for k, v in pairs(ents.FindByClass("logic_timer")) do
			if v:GetName() == "starve_timer" then
				v:Fire("AddOutput", "OnTimer triggerhook:RunPassedCode:hook.Run( 'FailCoopMap' ):0:-1" )
			end
		end
		
		for k, v in pairs(ents.FindByClass("logic_timer")) do
			if v:GetName() == "win_timer" then
				v:Fire("AddOutput", "OnTimer triggerhook:RunPassedCode:hook.Run( 'EndMap' ):15:-1" )
			end
		end
	end
	
	if game.GetMap() == "cmbinv_survival" then
		table.insert(startingWeapons, "weapon_pistol")
		table.insert(startingWeapons, "weapon_smg1")
		table.insert(startingWeapons, "weapon_shotgun")
		table.insert(startingWeapons, "weapon_rpg")
		
		for k, v in pairs(ents.FindByClass("logic_relay")) do
			if v:GetName() == "relay_wave8done" then
				v:Fire("AddOutput", "OnTrigger triggerhook:RunPassedCode:hook.Run( 'EndMap' ):15:-1" )
			end
		end
	end

	
	SetUpCheckpointsCoop()
end

function SetUpCheckpointsCoop()
	
	if game.GetMap() == "syn_trials4" then
		TRIGGER_CHANGELEVEL = {
			Vector(7328, 3090, -855), 	Vector(7874, 3193, -1023)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(2097, 289, -829),	Vector(2285, -23, -703),
			Vector(3031, -541, -700), 	Vector(3151, -432, -576),
			Vector(4997, -990, -1117), 	Vector(4711, -834, -991),
			Vector(5766, 159, -704), 	Vector(5643, 33, -830),
			Vector(6430, 1475, -827), 	Vector(6555, 1581, -705),
			Vector(7323, 3056, -2942), 	Vector(7056, 2944, -3111),
		}
		
		TRIGGER_SPAWNPOINT = {
			Vector(2196, 116, -810), 	Vector(3086, -494, -696),	
			Vector(4838, -907, -1095),	Vector(5864, 90, -821), 
			Vector(6376, 1533, -821),	Vector(7176, 2991, -3092),
		}
	elseif game.GetMap() == "syn_trials4b" then
		TRIGGER_CHANGELEVEL = {
			Vector(0, 0, 0), 	Vector(0, 0, 0)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(525, -461, -446),	Vector(478, -228, -312),
			Vector(13, 1217, -445),		Vector(-225, 1364, -290),
			Vector(-1854, -33, -398),	Vector(-1763, -128, -287),
			Vector(447, -934, -205),	Vector(321, -882, -80),
			Vector(1552, -1410, -205),	Vector(1420, -1549, -79),
		}
		
		TRIGGER_SPAWNPOINT = {
			Vector(467, -392, -435), 	Vector(-96, 1451, -416),	
			Vector(-1828, -193, -378),	Vector(469, -1332, -194),
			Vector(1735, -1462, -184),
		}
	elseif game.GetMap() == "syn_trials4c" then
		TRIGGER_CHANGELEVEL = {
			Vector(0, 0, 0), 	Vector(0, 0, 0)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(6071, -1790, -126),	Vector(6126, -1616, 0),
			Vector(-366, -1486, -575),	Vector(-490, -1341, -450),
			Vector(-500, -4358, -279),	Vector(-543, -4486, -417),
			Vector(395, -353, -122),	Vector(522, -598, 6),
			Vector(2239, 2063, -318),	Vector(2112, 2222, -224),
			Vector(2170, 4590, -1054),	Vector(2265, 4460, -928),
		}
		
		TRIGGER_SPAWNPOINT = {
			Vector(1648, -2167, 370),	Vector(-225, -1419, -56),
			Vector(-606, -4409, -395),	Vector(562, -494, -111),
			Vector(2115, 4530, -1049),	Vector(2115, 4530, -1049),
		}
	elseif game.GetMap() == "syn_oldcanals" then
		TRIGGER_CHANGELEVEL = {
			Vector(4673, -6015, -45), 	Vector(5052, -6331, 221)
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

hook.Add("EndMap", "EndCoopMap", function()
	EndCoop()
end)

hook.Add("FailCoopMap", "EndCoopMap", function()
	net.Start("FailedMap")
	net.Broadcast()
	timer.Simple(15, function()
		RunConsoleCommand("changelevel", "hl2cr_lobby")
	end)
end)