function SetupEP1Map()
	pacifistAchEarnable = false
	MapLua = ents.Create("lua_run")
	MapLua:SetName("triggerhook")
	MapLua:Spawn()
		
	local SUPERGUN_MAPS = {
		["ep1_citadel_02"] = true,
		["ep1_citadel_02b"] = true,
		["ep1_citadel_03"] = true
	}
	if SUPERGUN_MAPS[game.GetMap()] then
		game.SetGlobalState("super_phys_gun", 1)
	else
		game.SetGlobalState("super_phys_gun", 0)
	end
	
	if game.GetMap() == "ep1_citadel_02b" then
		for k, fix1 in pairs(ents.FindByClass("info_player_start")) do
			fix1:SetPos(Vector(1917, 4313, 2545))
			fix1:SetAngles(Angle(0, 0, 0))
		end
		
		for k, failTrigger in pairs(ents.FindByClass("trigger_multiple")) do
			if failTrigger:GetName() == "impact_trigger" then
				failTrigger:Fire("AddOutput", "OnTrigger triggerhook:RunPassedCode:hook.Run( 'FailMap' ):0:-1")
			end
		end
	end
	
	if game.GetMap() == "ep1_citadel_03" then
		for k, fix1 in pairs(ents.FindByClass("info_player_start")) do
			fix1:SetPos(Vector(-704, 12181, 5332))
			fix1:SetAngles(Angle(0, 0, 0))
		end
		pacifistAchEarnable = true
	end
	
	if game.GetMap() == "ep1_c17_02" then
		for k, killTimer in pairs(ents.FindByName("timer_give_guard_health")) do
			killTimer:Remove()
		end
	end
	
	if game.GetMap() == "ep1_c17_02a" then
		for k, removeBrush in pairs(ents.FindByClass("func_brush")) do
			if removeBrush:GetName() == "brush_combineshieldwall3" then
				removeBrush:Remove()
			end
		end
		for k, removeClip in pairs(ents.FindByClass("func_brush")) do
			if removeClip:GetName() == "clip_combineshieldwall3" then
				removeClip:Remove()
			end
		end
	end
	
	if game.GetMap() == "ep1_c17_05" then
		GetConVar("fmod_enable"):SetInt(1)
	else
		GetConVar("fmod_enable"):SetInt(0)
	end
	
	SetCheckpointsStageEP1()
end

hook.Add("FailMap", "ElevatorFailer", function()
	net.Start("FailedMap")
	net.Broadcast()
	timer.Simple(15, function()
		RunConsoleCommand("changelevel", game.GetMap())
	end)
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
			Vector(-7010, 5458, -160), Vector(-6770, 5503, -23),
			Vector(4811, 4156, -6340), Vector(4511, 3986, -6173),
		}
		
		TRIGGER_SPAWNPOINT = {
			Vector(-8987, 5748, -124),	Vector(-8213, 5995, 69),
			Vector(-6549, 6258, -71),	Vector(4633, 3841, -6312)
		}
	elseif game.GetMap() == "ep1_citadel_01" then
		TRIGGER_CHANGELEVEL = {
			Vector(-3040, 1276, 2465), 	Vector(-3141, 1384, 2620)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(-4578, 7683, 2521), 	Vector(-4826, 7579, 2685),
			Vector(-4966, 1434, 2594), 	Vector(-5133, 1530, 2722),
		}
		
		TRIGGER_SPAWNPOINT = {
			Vector(-4726, 7696, 2542),	Vector(-4767, 1493, 2481)
		}
		
	elseif game.GetMap() == "ep1_citadel_02" then
		TRIGGER_CHANGELEVEL = {
			Vector(1837, -14, 833), 	Vector(1714, -266, 963)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(1258, 823, 835), 	Vector(1328, 759, 1009)
		}
		
		TRIGGER_SPAWNPOINT = {
			Vector(1294, 675, 849)
		}
	elseif game.GetMap() == "ep1_citadel_02b" then
		TRIGGER_CHANGELEVEL = {
			Vector(5329, 4481, -6717), 	Vector(5526, 4826, -6586)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(2999, 4590, 2500), 	Vector(3079, 4721, 2685),
			Vector(3778, 4482, -6716), 	Vector(3962, 4819, -6582)
		}
		
		TRIGGER_SPAWNPOINT = {
			Vector(3238, 4640, 2608),	Vector(4188, 4641, -6698)
		}
	elseif game.GetMap() == "ep1_citadel_03" then
		TRIGGER_CHANGELEVEL = {
			Vector(1270, 13278, 3713), 	Vector(923, 13122, 3918)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(1397, 11909, 5313), 	Vector(994, 11780, 5510),
			Vector(1871, 11633, 4225), 	Vector(1765, 11836, 4360),
			Vector(1982, 10610, 5627), 	Vector(1843, 10760, 5761),
			Vector(1232, 12736, 5312), 	Vector(1368, 12892, 5464),
			Vector(1246, 13711, 5033), 	Vector(1060, 13557, 4723)
		}
		
		TRIGGER_SPAWNPOINT = {
			Vector(1228, 11708, 5334),	Vector(2000, 11762, 4240),
			Vector(2004, 10894, 5638),	Vector(1118, 12845, 5352),	
			Vector(1146, 13637, 5033)
		}
	elseif game.GetMap() == "ep1_citadel_04" then
		TRIGGER_CHANGELEVEL = {
			Vector(4152, 8191, 3326), 	Vector(3947, 8124, 3431)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(3581, 11836, 3601), 	Vector(3449, 11664, 3719),
			Vector(3450, -93, 3451), 	Vector(3567, -221, 3549),
			Vector(3883, 7950, 3547), 	Vector(3718, 8072, 3705)
		}
		
		TRIGGER_SPAWNPOINT = {
			Vector(3339, 11743, 3643),	Vector(3538, -163, 3474),
			Vector(3818, 7976, 3570)
		}
	elseif game.GetMap() == "ep1_c17_00" then
		TRIGGER_CHANGELEVEL = {
			Vector(1899, 64, 333), 	Vector(1781, 141, 420)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(3926, -177, -102), 	Vector(4100, -199, -28),
		}
		
		TRIGGER_SPAWNPOINT = {
			Vector(4002, -269, -84)
		}
	elseif game.GetMap() == "ep1_c17_00a" then
		TRIGGER_CHANGELEVEL = {
			Vector(4522, 3523, 1791), 	Vector(4662, 3637, 2020)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(1240, 4225, 631), 	Vector(1143, 4345, 743),
			Vector(3144, 3882, 411), 	Vector(2931, 4199, 533),
			Vector(4525, 3528, 640), 	Vector(4664, 3641, 682)
		}
		
		TRIGGER_SPAWNPOINT = {
			Vector(894, 4310, 651),		Vector(4363, 3581, 421),	
			Vector(4586, 3577, 578)
		}
	elseif game.GetMap() == "ep1_c17_01" then
		TRIGGER_CHANGELEVEL = {
			Vector(-3601, 269, 1), Vector(-3661, 211, 113)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(2885, -1300, 14), 	Vector(2791, -1381, 118),
			Vector(1765, 2041, 196), 	Vector(1762, 1956, 335),
			Vector(-3539, 436, 114),	Vector(-3568, 348, 14)
		}
		
		TRIGGER_SPAWNPOINT = {
			Vector(2575, -1284, 21),	Vector(1583, 1964, 219),
			Vector(-3399, 459, 12)
		}
	elseif game.GetMap() == "ep1_c17_01" then
		TRIGGER_CHANGELEVEL = {
			Vector(-3601, 269, 1), Vector(-3661, 211, 113)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(2885, -1300, 14), 	Vector(2791, -1381, 118),
			Vector(1765, 2041, 196), 	Vector(1762, 1956, 335),
			Vector(-3539, 436, 114),	Vector(-3568, 348, 14)
		}
		
		TRIGGER_SPAWNPOINT = {
			Vector(2575, -1284, 21),	Vector(1583, 1964, 219)
		}
	elseif game.GetMap() == "ep1_c17_02" then
		TRIGGER_CHANGELEVEL = {
			Vector(-2274, 2405, -124), Vector(-2453, 2188, -9)
		}

		TRIGGER_CHECKPOINT = {
			Vector(1291, -257, 28), 	Vector(1474, -176, 194),
			Vector(-892, 1592, -1), 	Vector(-1192, 1783, 134)
		}
		TRIGGER_SPAWNPOINT = {
			Vector(1291, -257, 28),		Vector(-958, 1814, 14)
		}
	elseif game.GetMap() == "ep1_c17_02b" then
		TRIGGER_CHANGELEVEL = {
			Vector(-465, 4242, 322), Vector(-710, 4008, 492)
		}

		TRIGGER_CHECKPOINT = {
			Vector(1088, 1936, -253), 	Vector(1267, 1862, -138),
			Vector(1229, 1794, 250), 	Vector(1340, 1961, 132),
			Vector(1140, 2695, 68), 	Vector(986, 2838, 191)
		}
		TRIGGER_SPAWNPOINT = {
			Vector(1153, 1776, -233),	Vector(1082, 1916, 143),
			Vector(1153, 1776, -233)
		}
	elseif game.GetMap() == "ep1_c17_02a" then
		TRIGGER_CHANGELEVEL = {
			Vector(-2577, 8265, -2830), Vector(-2854, 8312, -2682)
		}

		TRIGGER_CHECKPOINT = {
			Vector(1150, 8757, -2559), 	Vector(964, 8803, -2433),
			Vector(333, 8466, -2944), 	Vector(209, 8607, -2836),
			Vector(-761, 9403, -2692), 	Vector(-594, 9719, -2556)
		}
		TRIGGER_SPAWNPOINT = {
			Vector(1048, 8663, -2548),	Vector(368, 8432, -2830),
			Vector(-437, 9930, -2811)
		}
	elseif game.GetMap() == "ep1_c17_06" then
		TRIGGER_CHANGELEVEL = {
			Vector(-7751, 6001, -926), Vector(-8260, 5549, -613)
		}

		TRIGGER_CHECKPOINT = {
			Vector(10150, 8306, -758), 	Vector(10223, 8421, -648),
			Vector(11881, 8409, -739), 	Vector(11783, 8324, -667)
		}
		TRIGGER_SPAWNPOINT = {
			Vector(10615, 8168, -723),	Vector(11626, 8368, -575)
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
		end
	end
end