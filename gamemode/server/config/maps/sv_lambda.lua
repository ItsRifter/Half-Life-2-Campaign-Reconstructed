function placeLambda()

	if game.GetMap() == "d1_trainstation_05" then
		LAMBDA_POSITION = { 
			Vector(-6513, -1084, 3), Vector(-6580, -1015, 109), 
		}
	elseif game.GetMap() == "d1_canals_01" then
		LAMBDA_POSITION = { 
			Vector(750, -6214, 513), Vector(800, -6169, 638), 
		}
	elseif game.GetMap() == "d1_canals_01a" then
		LAMBDA_POSITION = { 
			Vector(46, 6133, -75), Vector(83, 6022, 31), 
		}
	elseif game.GetMap() == "d1_canals_02" then
		LAMBDA_POSITION = { 
			Vector(-267, -1003, -1067), Vector(-152, -949, -983), 
		}
	elseif game.GetMap() == "d1_canals_03" then
		LAMBDA_POSITION = { 
			Vector(-189, -449, -1007), Vector(-86, -386, -872), 
		}
	elseif game.GetMap() == "d1_canals_05" then
		LAMBDA_POSITION = { 
			Vector(4027, 4938, -127), Vector(4145, 4969, -31), 
		}
	elseif game.GetMap() == "d1_canals_06" then
		LAMBDA_POSITION = { 
			Vector(7929, 9024, -229), Vector(7871, 9097, -84), 
		}
	elseif game.GetMap() == "d1_canals_07" then
		LAMBDA_POSITION = { 
			Vector(-4357, -14912, -892), Vector(-4508, -14762, -778), 
		}
	elseif game.GetMap() == "d1_canals_08" then
		LAMBDA_POSITION = { 
			Vector(10230, -7365, -437), Vector(10344, -7462, -326), 
		}
	elseif game.GetMap() == "d1_canals_09" then
		LAMBDA_POSITION = { 
			Vector(6915, -9296, -317), Vector(7161, -9222, -227), 
		}
	elseif game.GetMap() == "d1_canals_10" then
		LAMBDA_POSITION = { 
			Vector(12062, -1915, -186), Vector(11809, -1611, -16), 
		}
	elseif game.GetMap() == "d1_canals_12" then
		LAMBDA_POSITION = { 
			Vector(544, 10897, 513), Vector(454, 11081, 625), 
		}
	elseif game.GetMap() == "d1_eli_01" then
		LAMBDA_POSITION = { 
			Vector(183, 4418, -1400), Vector(125, 4449, -1303), 
		}
	elseif game.GetMap() == "d1_town_01" then
		LAMBDA_POSITION = { 
			Vector(843, 1059, -3642), Vector(787, 1137, -3570), 
		}
	elseif game.GetMap() == "d1_town_01a" then
		LAMBDA_POSITION = { 
			Vector(121, 263, -3321), Vector(42, 145, -3283), 
		}
	elseif game.GetMap() == "d1_town_05" then
		LAMBDA_POSITION = { 
			Vector(-11397, 4233, 1045), Vector(-11414, 4296, 1081), 
		}
	elseif game.GetMap() == "d2_coast_01" then
		LAMBDA_POSITION = { 
			Vector(-12868, 536, 1526), Vector(-12919, 809, 1670), 
		}
	elseif game.GetMap() == "d2_coast_03" then
		LAMBDA_POSITION = { 
			Vector(-3180, -6115, 589), Vector(-3435, -6283, 708), 
		}
	elseif game.GetMap() == "d2_coast_04" then
		LAMBDA_POSITION = { 
			Vector(2196, 6545, 1170), Vector(2224, 6670, 1233), 
		}
	elseif game.GetMap() == "d2_coast_05" then
		LAMBDA_POSITION = { 
			Vector(-3276, 1267, 1098), Vector(-3472, 1363, 1208), 
		}
	elseif game.GetMap() == "d2_coast_07" then
		LAMBDA_POSITION = { 
			Vector(1706, 9426, 1684), Vector(1808, 9320, 1860), 
		}
	elseif game.GetMap() == "d2_coast_09" then
		LAMBDA_POSITION = { 
			Vector(11083, 8856, -42), Vector(11169, 8762, -1), 
		}
	elseif game.GetMap() == "d2_coast_11" then
		LAMBDA_POSITION = { 
			Vector(3390, 745, 821), Vector(3290, 885, 938),
		}
	elseif game.GetMap() == "d2_prison_02" then
		LAMBDA_POSITION = { 
			Vector(-2259, 1720, 514), Vector(-2370, 1611, 672),
		}
	elseif game.GetMap() == "d2_prison_03" then
		LAMBDA_POSITION = { 
			Vector(-3595, 4140, 130), Vector(-3482, 4100, 273),
		}
	elseif game.GetMap() == "d2_prison_05" then
		LAMBDA_POSITION = { 
			Vector(-1348, 580, 388), Vector(-1461, 564, 499),
		}
	elseif game.GetMap() == "d2_prison_06" then
		LAMBDA_POSITION = { 
			Vector(720, -789, 98), Vector(699, -819, 124),
		}
	elseif game.GetMap() == "d3_c17_02" then
		LAMBDA_POSITION = { 
			Vector(-10176, -6164, 69), Vector(-10228, -6248, 160),
		}
	elseif game.GetMap() == "d3_c17_04" then
		LAMBDA_POSITION = { 
			Vector(-1031, -4975, 326), Vector(-1076, -4874, 439),
		}
	elseif game.GetMap() == "d3_c17_05" then
		LAMBDA_POSITION = { 
			Vector(2556, -4099, 132), Vector(2441, -4190, 264),
		}
	elseif game.GetMap() == "d3_c17_06a" then
		LAMBDA_POSITION = { 
			Vector(3828, -1945, -322), Vector(3553, -1700, -179),
		}
	elseif game.GetMap() == "d3_c17_06b" then
		LAMBDA_POSITION = { 
			Vector(4651, 1960, 386), Vector(4441, 2052, 518),
		}
	elseif game.GetMap() == "d3_c17_08" then
		LAMBDA_POSITION = { 
			Vector(2484, -951, -521), Vector(2567, -1019, -419),
		}
	elseif game.GetMap() == "d3_c17_12b" then
		LAMBDA_POSITION = { 
			Vector(-4335, 503, 107), Vector(-4260, 673, 219),
		}
	end
	
	
	if LAMBDA_POSITION then
		LambdaTrigger = ents.Create("trigger_lambda")
		
		LambdaTrigger.Min = Vector(LAMBDA_POSITION[1])
		LambdaTrigger.Max = Vector(LAMBDA_POSITION[2])
		LambdaTrigger.Pos = Vector(LAMBDA_POSITION[2]) - ( ( Vector(LAMBDA_POSITION[2]) - Vector(LAMBDA_POSITION[1])) / 2 )
		LambdaTrigger:SetPos(LambdaTrigger.Pos)
		LambdaTrigger:Spawn()
	end
	
end


hook.Add("InitPostEntity", "SetUpLambda", placeLambda)
hook.Add("PostCleanupMap", "SetUpLambda", placeLambda)