function SetupEP2Map()
	
	MapLua = ents.Create("lua_run")
	MapLua:SetName("triggerhook")
	MapLua:Spawn()
	
	for k, clip in pairs(ents.FindByName("*_clip")) do
		if game.GetMap() == "ep2_outland_10" then break end
		clip:Remove()
	end
	
	for k, playerBlock in pairs(ents.FindByName("func_brush")) do
		if game.GetMap() != "ep2_outland_4" then break end
		playerBlock:Remove()
	end
	
	if game.GetMap() == "ep2_outland_01" then
		for k, gravTrigger in pairs(ents.FindByName("trigger_Get_physgun")) do
			gravTrigger:Fire("AddOutput", "OnTrigger triggerhook:RunPassedCode:hook.Run( 'GiveGravgunEp2' ):0:-1" )
		end
		
		for k, fixAlyxJumpDown in pairs(ents.FindByName("SS_alyx_scrapyard_down")) do
			fixAlyxJumpDown:Fire("AddOutput", "OnEndSequence triggerhook:RunPassedCode:hook.Run( 'FixAlyxJump' ):0:-1" )
		end
				
	end
	if game.GetMap() == "ep2_outland_03" then
		for k, grub in pairs(ents.FindByClass("npc_antlion_grub")) do
			grub:Remove()
		end
	end
	
	if game.GetMap() == "ep2_outland_05" then
		for k, fixScript in pairs(ents.FindByName("ss_alyx_wait_0*")) do
			fixScript:Remove()
		end
	end
	
	if game.GetMap() == "ep2_outland_06" then
		local preventLeap = ents.Create("prop_dynamic")
		preventLeap:SetPos(Vector(65, 1042, 892))
		preventLeap:SetAngles(Angle(0, 0, 0))
		preventLeap:SetModel("models/props_c17/fence01a.mdl")
		preventLeap:PhysicsInit(SOLID_VPHYSICS)
		preventLeap:Spawn()
		
		local preventLeap2 = ents.Create("prop_dynamic")
		preventLeap2:SetPos(Vector(65, 1042, 1012))
		preventLeap2:SetAngles(Angle(0, 0, 0))
		preventLeap2:SetModel("models/props_c17/fence01a.mdl")
		preventLeap2:PhysicsInit(SOLID_VPHYSICS)
		preventLeap2:Spawn()
	end
	
	if game.GetMap() == "ep2_outland_07" then
		for i, fixSpawn in pairs(ents.FindByClass("info_player_start")) do
			fixSpawn:SetPos(Vector(-3053, -12260, 550))
		end
		
		for k, fixAdvisorCutscene in pairs(ents.FindByName("relay_start_player_vehicle")) do
			fixAdvisorCutscene:Fire("AddOutput", "OnTrigger triggerhook:RunPassedCode:hook.Run( 'AdvisorTrigger' ):0:-1")
		end
	end
	
	if game.GetMap() == "ep2_outland_09" then
		for i, fixSpawn in pairs(ents.FindByClass("info_player_start")) do
			fixSpawn:SetPos(Vector(1033, -9195, 78))
		end
	end
	
	if game.GetMap() == "ep2_outland_12" then
		for i, failBase in pairs(ents.FindByName("base_destroy_relay")) do
			failBase:Fire("AddOutput", "OnTrigger triggerhook:RunPassedCode:hook.Run( 'FailBaseMap' ):0:-1" )
		end
	end
	SetCheckpointsStageEP2()
end

hook.Add("GiveGravgunEp2", "GrantEP2GravGun", function()
	for k, v in pairs(player.GetAll()) do
		v:Give("weapon_physcannon")
	end
end)

hook.Add("FixAlyxJump", "AlyxScrapyard", function()
	for k, alyx in pairs(ents.FindByClass("npc_alyx")) do
		alyx:SetPos(Vector(-3972, 1682, 163))
	end
end)

hook.Add("AdvisorTrigger", "EnterVehicle", function()
	local pod = ents.FindByName("cvehicle_barn1")
	for k, v in pairs(player.GetAll()) do
		v:EnterVehicle(pod)
	end
end)

hook.Add("FailBaseMap", "BaseFailer", function()
	net.Start("FailedMap")
	net.Broadcast()
	timer.Simple(15, function()
		RunConsoleCommand("changelevel", game.GetMap())
	end)
end)

function SetCheckpointsStageEP2()
	--Remove the old checkpoints and changelevels
	for k, oldCheck in pairs(ents.FindByClass("trigger_checkpoint")) do
		oldCheck:Remove()
	end
	
	for k, oldChange in pairs(ents.FindByClass("trigger_changelevel")) do
		oldChange:Remove()
	end
	
	if game.GetMap() == "ep2_outland_01" then
		TRIGGER_CHANGELEVEL = {
			Vector(-6263, 3439, -1377), Vector(-6234, 3554, -1287)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(759, -66, -44), 			Vector(568, -82, 13),
			Vector(-3231, -640, 249), 		Vector(-3309, -847, 346),
			Vector(-6352, 3731, -1404), 	Vector(-6186, 3605, -1266)
		}
		
		TRIGGER_SPAWNPOINT = {
			Vector(702, -88, -42),	Vector(-3548, -716, 248),
			Vector(-6291, 3662, -1390)
		}
	elseif game.GetMap() == "ep2_outland_01a" then
		TRIGGER_CHANGELEVEL = {
			Vector(-2202, -8305, -486), Vector(-2276, -8217, -426)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(-10787, -7367, 1309), 	Vector(-11034, -7555, 1435),
			Vector(-6865, -7382, -49), 		Vector(-6648, -7488, 64)
		}
		
		TRIGGER_SPAWNPOINT = {
			Vector(-10986, -7129, 1303),	Vector(-6678, -7713, -95)
		}
	elseif game.GetMap() == "ep2_outland_02" then
		TRIGGER_CHANGELEVEL = {
			Vector(-562, -10307, -521), Vector(-725, -10197, -398)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(-2209, -9075, -702), 	Vector(-2313, -8682, -589),
			Vector(-17, -9814, -664), 		Vector(-134, -9898, -517)
		}
		
		TRIGGER_SPAWNPOINT = {
			Vector(-2426, -9471, -687),	Vector(211, -9609, -696)
		}
	elseif game.GetMap() == "ep2_outland_03" then
		TRIGGER_CHANGELEVEL = {
			Vector(5215, -7534, -489), Vector(5028, -7390, -260)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(903, -4077, -753), 	Vector(1016, -4175, -626),
			Vector(1005, -7308, -1646), 		Vector(1064, -7424, -1511),
			Vector(1092, -9623, -508), 		Vector(1290, -9773, -372),
			Vector(3947, -9273, -574), 		Vector(3696, -9269, -384)
		}
		
		TRIGGER_SPAWNPOINT = {
			Vector(971, -4013, -749),	Vector(789, -7348, -1620),
			Vector(1182, -9724, -502),	Vector(3791, -9275, -568)
		}
	elseif game.GetMap() == "ep2_outland_04" then
		TRIGGER_CHANGELEVEL = {
			Vector(4970, -1563, 2997), Vector(4889, -1655, 3180)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(4396, -1536, -1306), 	Vector(4615, -1631, -1142),
			Vector(5437, -3497, -2193), 		Vector(5249, -3204, -2301),
			Vector(4911, -1585, 2846), 		Vector(4971, -1657, 2958)
		}
		
		TRIGGER_SPAWNPOINT = {
			Vector(4510, -1537, -1305),	Vector(5334, -3633, -2284),
			Vector(4925, -1617, 3003)
		}
	elseif game.GetMap() == "ep2_outland_05" then
		TRIGGER_CHANGELEVEL = {
			Vector(2134, 6216, 513), Vector(2011, 6111, 659)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(1269, 5878, 642), 	Vector(1042, 5658, 757)
		}
		
		TRIGGER_SPAWNPOINT = {
			Vector(1433, 5756, 643)
		}
	elseif game.GetMap() == "ep2_outland_06" then
		TRIGGER_CHANGELEVEL = {
			Vector(-3286, 2083, 677), Vector(-2758, 2593, 847)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(604, 585, 234), 		Vector(773, 464, 358),
			Vector(289, 2258, 69), 		Vector(535, 2132, -6),
			Vector(2915, 1139, 73), 	Vector(3057, 1248, 186)
		}
		
		TRIGGER_SPAWNPOINT = {
			Vector(699, 471, 248),	Vector(419, 2179, 3),
			Vector(3306, 1273, 241)
		}
	elseif game.GetMap() == "ep2_outland_06a" then
		TRIGGER_CHANGELEVEL = {
			Vector(-10321, -3646, -2470), Vector(-9768, -4255, -2198)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(-3564, -9773, -1684), 		Vector(-3474, -9688, -1545),
			Vector(289, 2258, 69), 		Vector(535, 2132, -6),
		}
		
		TRIGGER_SPAWNPOINT = {
			Vector(-3238, -9715, -1519),	Vector(419, 2179, 3),
			Vector(3306, 1273, 241)
		}
	elseif game.GetMap() == "ep2_outland_07" then
		TRIGGER_CHANGELEVEL = {
			Vector(-3967, 12229, 46), Vector(-3394, 11794, 286)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(-9891, -9801, 59), 		Vector(-9941, -9870, 129)
		}
		
		TRIGGER_SPAWNPOINT = {
			Vector(-9739, -9609, 76)
		}
	elseif game.GetMap() == "ep2_outland_08" then
		TRIGGER_CHANGELEVEL = {
			Vector(-3272, 1871, 72), 		Vector(-3123, 2020, 199)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(-358, 1128, 191), 		Vector(-826, 1388, 68),
			Vector(-2960, 2021, 75), 		Vector(-3054, 1877, 184)
		}
		
		TRIGGER_SPAWNPOINT = {
			Vector(-949, 1719, 69),			Vector(-3047, 1942, 82)
		}
	elseif game.GetMap() == "ep2_outland_09" then
		TRIGGER_CHANGELEVEL = {
			Vector(3123, 8813, 195), 		Vector(3557, 8491, 441)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(689, -9113, 184), 		Vector(329, -9262, 74),
			Vector(-1538, -5550, 86), 		Vector(-1914, -5131, 283)
		}
		
		TRIGGER_SPAWNPOINT = {
			Vector(386, -9185, 82),			Vector(-1676, -4575, 83)
		}
	elseif game.GetMap() == "ep2_outland_10" then
		TRIGGER_CHANGELEVEL = {
			Vector(3629, 8191, -1338), 		Vector(2700, 7792, -1534)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(3295, -251, -124), 		Vector(3672, -419, 39),
			Vector(568, -2429, 163), 		Vector(704, -2210, 295)
		}
		
		TRIGGER_SPAWNPOINT = {
			Vector(3148, -763, -116),			Vector(744, -2316, 165)
		}
	elseif game.GetMap() == "ep2_outland_11" then
		TRIGGER_CHANGELEVEL = {
			Vector(1681, -9032, -1407), 		Vector(1581, -9259, -1250)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(-123, -10095, 64), 		Vector(79, -9972, 212),
			Vector(1600, -9810, -317), 		Vector(1445, -10030, -188),
			Vector(1447, -10016, -1300), 	Vector(1553, -9841, -1406),
			Vector(1985, -9170, -1406), 		Vector(2142, -9062, -1256)
		}
		
		TRIGGER_SPAWNPOINT = {
			Vector(-25, -9871, 74),			Vector(1575, -9934, -312),
			Vector(1580, -10187, -1398),			Vector(2098, -9070, -1400)
		}
	elseif game.GetMap() == "ep2_outland_11a" then
		TRIGGER_CHANGELEVEL = {
			Vector(2268, -11339, -64), 		Vector(2178, -11146, 24)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(1044, -9370, -1409), 		Vector(932, -9506, -1531),
			Vector(-1058, -9906, -1211), 		Vector(-1308, -9884, -1090),
			Vector(1800, -11527, -896), 		Vector(1847, -11480, -818)
		}
		
		TRIGGER_SPAWNPOINT = {
			Vector(987, -9402, -1517),			Vector(-1102, -9937, -1205),		
			Vector(1684, -11436, -1082),
			
		}
	elseif game.GetMap() == "ep2_outland_11b" then
		TRIGGER_CHANGELEVEL = {
			Vector(-204, -8880, -319), 		Vector(-368, -8761, -143)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(432, -8830, -318), 		Vector(277, -8625, -175),
			Vector(264, -8721, -219), 		Vector(432, -8830, -318),
			Vector(147, -9210, -185), 		Vector(281, -8962, -317),
			Vector(-115, -9164, -190), 		Vector(-50, -9009, -317)
		}
		
		TRIGGER_SPAWNPOINT = {
			Vector(360, -8705, -302),		Vector(379, -8613, -311),		
			Vector(234, -8994, -316),		Vector(-261, -9058, -327),
			Vector(-261, -9058, -327)
		}
	elseif game.GetMap() == "ep2_outland_12" then
		TRIGGER_CHANGELEVEL = {
			Vector(237, -8925, -317), 		Vector(86, -8795, -181)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(-485, -6159, -317), 		Vector(-858, -6010, -87),
			Vector(-906, 5282, 116), 		Vector(-248, 4482, 251),
			Vector(236, -8825, -137), 		Vector(91, -8567, -316)
		}
		
		TRIGGER_SPAWNPOINT = {
			Vector(-273, -5767, -234),		Vector(-574, 4858, 60),
			Vector(159, -8495, -310)
		}
	elseif game.GetMap() == "ep2_outland_12a" then
		TRIGGER_CHANGELEVEL = {
			Vector(1887, -2574, -1301), 		Vector(1980, -2438, -1215)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(-443, -2001, -1053), 		Vector(-291, -2093, -1198),
			Vector(445, -1924, -1049), 			Vector(344, -2029, -1172),
			Vector(1887, -2442, -1299), 		Vector(1762, -2583, -1225)
		}
		
		TRIGGER_SPAWNPOINT = {
			Vector(-140, -1968, -1173),			Vector(847, -1929, -1161),
			Vector(1816, -2503, -1215)
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
	end
end