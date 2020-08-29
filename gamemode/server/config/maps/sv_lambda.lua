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