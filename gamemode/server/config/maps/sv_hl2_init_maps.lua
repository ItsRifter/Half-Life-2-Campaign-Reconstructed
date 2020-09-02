function SetupMap()
		
	CHECKPOINTS = CHECKPOINTS or {}

	--Create the lua entity
	MapLua = ents.Create("lua_run")
	MapLua:SetName("triggerhook")
	MapLua:Spawn()

	if game.GetMap() == "hl2c_lobby_remake" then
		for k, door in pairs(ents.FindByName("hl2_door")) do
			door:Fire("Open")
		end
		
		--Lost cause achievement trigger
		for a, LCAch in pairs(ents.FindByName("trigger_achievement_lostcause")) do
			LCAch:Fire("AddOutput", "OnTrigger triggerhook:RunPassedCode:hook.Run( 'GiveLostCause' ):0:-1" )
		end
	end
	
	--Remove the old checkpoints and changelevels
	for k, oldCheck in pairs(ents.FindByClass("trigger_checkpoint")) do
		oldCheck:Remove()
	end
	
	local newChangeLevel = ents.Create("trigger_changelevel")
	newChangeLevel:Spawn()

	--Fixes the spawnpoints
	if game.GetMap() == "d1_trainstation_02" then 
		for k, reset1 in pairs(ents.FindByClass("info_player_start")) do
			reset1:SetPos(Vector(-4315, -215, 0))
		end
	end
	
	if game.GetMap() == "d1_trainstation_06" then 
		for k, reset2 in pairs(ents.FindByClass("info_player_start")) do
			reset2:SetPos(Vector(-9946, -3660, 384))
		end
	end
	
	if game.GetMap() == "d1_canals_10" then 
		for k, fix1 in pairs(ents.FindByClass("info_player_start")) do
			fix1:SetPos(Vector(11808, -12450, -475))
		end
	end
	
	if game.GetMap() == "d2_coast_08" then
		blocker = ents.Create("prop_dynamic")
		blocker:SetModel("models/props_doors/door03_slotted_left.mdl")
		blocker:SetPos(Vector(3305, 1542, 1588))
		blocker:SetAngles(Angle(0, -90, 0))
		blocker:PhysicsInit(SOLID_VPHYSICS)
		blocker:Spawn()
	
		for k, fix2 in pairs(ents.FindByClass("info_player_start")) do
			fix2:SetPos(Vector(3330, 1471, 1600))
			fix2:SetAngles(Angle(0, -90, 0))
		end
	end
	
	if game.GetMap() == "d2_coast_10" then 
		for k, fix3 in pairs(ents.FindByClass("info_player_start")) do
			fix3:SetPos(Vector(2095, -5449, 1428))
			fix3:SetAngles(Angle(0, -0, 0))
		end
	end
	
	if game.GetMap() == "d2_prison_01" then 
		for k, fix4 in pairs(ents.FindByClass("info_player_start")) do
			fix4:SetPos(Vector(4138, -4441, 1088))
			fix4:SetAngles(Angle(0, 180, 0))
		end
	end
	
	if game.GetMap() == "d2_prison_03" then 
		for k, fix5 in pairs(ents.FindByClass("info_player_start")) do
			fix5:SetPos(Vector(-2405, 3192, 139))
			fix5:SetAngles(Angle(0, -180, 0))
		end
	end
	if game.GetMap() == "d2_prison_05" then 
		for k, fix6 in pairs(ents.FindByClass("info_player_start")) do
			fix6:SetPos(Vector(1446, 635, 404))
			fix6:SetAngles(Angle(0, 90, 0))
		end
	end
	
	if game.GetMap() == "d3_c17_07" then 
		for k, fix7 in pairs(ents.FindByClass("info_player_start")) do
			fix7:SetPos(Vector(4435, 1203, 297))
			fix7:SetAngles(Angle(90, 0, 0))
		end
	end
	
	if game.GetMap() == "d3_c17_10a" then 
		for k, fix7 in pairs(ents.FindByClass("info_player_start")) do
			fix7:SetPos(Vector(-3929, 6790, 22))
			fix7:SetAngles(Angle(90, 0, 0))
		end
	end
	
	if game.GetMap() == "d3_c17_12" then 
		for k, fix8 in pairs(ents.FindByClass("info_player_start")) do
			fix8:SetPos(Vector(1185, 3404, 790))
			fix8:SetAngles(Angle(0, -90, 0))
		end
	end
	
	--This map is self-aware
	if game.GetMap() == "d3_citadel_03" then 
		for k, fix9 in pairs(ents.FindByClass("info_player_start")) do
			fix9:SetPos(Vector(7682, -914, 2138))
			fix9:SetAngles(Angle(0, 90, 0))
		end
	end
	
	if game.GetMap() == "d3_breen_01" then 
		for k, fix10 in pairs(ents.FindByClass("info_player_start")) do
			fix10:SetPos(Vector(-2184, 851, 640))
			fix10:SetAngles(Angle(0, -90, 0))
		end
	end
	
	if game.GetMap() == "d1_town_03" and not file.Exists("hl2cr_data/d1_town_02", "DATA") then 
		file.Write("hl2cr_data/d1_town_02.txt", "Map checker please don't delete this file")
	end
	
	if game.GetMap() == "d1_town_02" and file.Exists("hl2cr_data/d1_town_02.txt", "DATA") then 
		for k, returnMap in pairs(ents.FindByClass("info_player_start")) do
			returnMap:SetPos(Vector(-3759, -45, -3435))
			returnMap:SetAngles(Angle(0, 90, 0))
		end
	end
	
	if game.GetMap() == "d1_canals_05" then
		for k, air in pairs(ents.FindByClass("prop_vehicle_airboat")) do
			air:Fire("AddOutput", "PlayerOn triggerhook:RunPassedCode:hook.Run( 'Airboat' ):0:-1")
		end
	end
	
	if game.GetMap() == "d1_trainstation_03" then
		for k, fix3 in pairs(ents.FindByClass("info_player_start")) do
			fix3:SetPos(Vector(-5177, -4484, 44))
		end
		
		for k, pusher in pairs(ents.FindByClass("trigger_push")) do
			if pusher:EntIndex() == 709 then
				pusher:Remove()
			end
		end
	end
	
	--Fix super grav gun
	if game.GetMap() == "d3_citadel_03" or game.GetMap() == "d3_citadel_04" or game.GetMap() == "d3_citadel_05" or game.GetMap() == "d3_breen_01" then
		game.SetGlobalState("super_phys_gun", 1)
	else
		game.SetGlobalState("super_phys_gun", 0)
	end
	
	if game.GetMap() == "d1_trainstation_01" and game.GetMap() == "d1_trainstation_02" and game.GetMap() == "d1_trainstation_03" then 
		game.SetGlobalState("gordon_invulnerable", 1)
	else
		game.SetGlobalState("gordon_invulnerable", 0)
	end
	--Doll Achievement
	local dollAch = ents.Create("prop_physics")
	if game.GetMap() == "d1_trainstation_03" and file.Exists("hl2cr_data/babydoll.txt", "DATA") then
		dollAch:SetModel("models/props_c17/doll01.mdl")
		dollAch:SetPos(Vector(-5177, -4719, 64))
		dollAch:Spawn()
		file.Delete("hl2cr_data/babydoll.txt")
	elseif game.GetMap() == "d1_trainstation_04" and file.Exists("hl2cr_data/babydoll2.txt", "DATA") then
		dollAch:SetModel("models/props_c17/doll01.mdl")
		dollAch:SetPos(Vector(-3367, -3410, 628))
		dollAch:Spawn()
		file.Delete("hl2cr_data/babydoll2.txt")
	elseif game.GetMap() == "d1_trainstation_05" and file.Exists("hl2cr_data/babydoll3.txt", "DATA") then
		dollAch:SetModel("models/props_c17/doll01.mdl")
		dollAch:SetPos(Vector(-5833, -927, 128))
		dollAch:Spawn()
		file.Delete("hl2cr_data/babydoll3.txt")
	end
	
	--Ball achievement ravenholm
	local ballAch = ents.Create("prop_physics")
	if game.GetMap() == "d1_town_01" and file.Exists("hl2cr_data/ravenball1.txt", "DATA") then
		ballAch:SetModel("models/Roller.mdl")
		ballAch:SetPos(Vector(4672, -2222, -3718))
		ballAch:Spawn()
		file.Delete("hl2cr_data/ravenball1.txt")
	elseif game.GetMap() == "d1_town_01a" and file.Exists("hl2cr_data/ravenball2.txt", "DATA") then
		ballAch:SetModel("models/Roller.mdl")
		ballAch:SetPos(Vector(174, 177, -3263))
		ballAch:Spawn()
		file.Delete("hl2cr_data/ravenball2.txt")
	elseif game.GetMap() == "d1_town_02" and not file.Exists("hl2cr_data/d1_town_02.txt", "DATA") and file.Exists("hl2cr_data/ravenball3.txt", "DATA") then
		ballAch:SetModel("models/Roller.mdl")
		ballAch:SetPos(Vector(-955, 884, -3375))
		ballAch:Spawn()
		file.Delete("hl2cr_data/ravenball3.txt")
	elseif game.GetMap() == "d1_town_03" and file.Exists("hl2cr_data/ravenball4.txt", "DATA") then
		ballAch:SetModel("models/Roller.mdl")
		ballAch:SetPos(Vector(-3554, -725, -3519))
		ballAch:Spawn()
		file.Delete("hl2cr_data/ravenball4.txt")
	elseif game.GetMap() == "d1_town_02" and file.Exists("hl2cr_data/d1_town_02.txt", "DATA") and file.Exists("hl2cr_data/ravenball5.txt", "DATA") then
		ballAch:SetModel("models/Roller.mdl")
		ballAch:SetPos(Vector(-3587, 260, -3391))
		ballAch:Spawn()
		file.Delete("hl2cr_data/ravenball5.txt")
	elseif game.GetMap() == "d1_town_02a" and file.Exists("hl2cr_data/ravenball6.txt", "DATA") then
		ballAch:SetModel("models/Roller.mdl")
		ballAch:SetPos(Vector(-5361, 2333, -3218))
		ballAch:Spawn()
		file.Delete("hl2cr_data/ravenball6.txt")
	elseif game.GetMap() == "d1_town_04" and file.Exists("hl2cr_data/ravenball7.txt", "DATA") then
		ballAch:SetModel("models/Roller.mdl")
		ballAch:SetPos(Vector(818, -1190, -3583))
		ballAch:Spawn()
		file.Delete("hl2cr_data/ravenball7.txt")
	end
	
	if game.GetMap() == "d1_eli_02" then
		for k, g in pairs( ents.FindByName( "trigger_Get_physgun" )) do
			g:Fire("AddOutput", "OnTrigger triggerhook:RunPassedCode:hook.Run( 'GiveGravgun' ):0:-1" )
		end
	end
	
	local triggerMultiples = ents.FindByClass("trigger_multiple")
	for k, triggerFail in pairs(triggerMultiples) do
		if triggerFail:GetName() == "fall_trigger" then
			triggerFail:Remove()
		end
	end
	
	if game.GetMap() == "d1_town_02a" then
		file.Delete("hl2cr_data/d1_town_02.txt")
	end
	
	if game.GetMap() == "d2_coast_04" then
		local fixLeap = ents.Create("prop_dynamic")
		fixLeap:SetPos(Vector(-1813, 1204, 860))
		fixLeap:SetAngles(Angle(0, -90, 0))
		fixLeap:SetModel("models/props_wasteland/cargo_container01.mdl")
		fixLeap:PhysicsInit(SOLID_VPHYSICS)
		fixLeap:Spawn()
		
		local fixLeap2 = ents.Create("prop_dynamic")
		fixLeap2:SetPos(Vector(-1813, 1074, 860))
		fixLeap2:SetAngles(Angle(0, -90, 0))
		fixLeap2:SetModel("models/props_wasteland/cargo_container01.mdl")
		fixLeap2:PhysicsInit(SOLID_VPHYSICS)
		fixLeap2:Spawn()
	end
	
	if game.GetMap() == "d2_coast_11" then
		for k, sand in pairs(ents.FindByClass("env_player_surface_trigger")) do
			sand:Fire("AddOutput", "OnSurfaceChangedToTarget triggerhook:RunPassedCode:hook.Run( 'FailSand' ):0:-1")
		end
	end
	
	if game.GetMap() == "d3_citadel_03" then
		timer.Simple(5, function()
			for k, removeWeaponAmmo in pairs(ents.FindByName("global_newgame_spawner_*")) do
				removeWeaponAmmo:Remove()
			end
		end)
	end
	
	if game.GetMap() == "d3_breen_01" then
		for m, tele in pairs(ents.FindByName("teleport_end_swap_2")) do
			tele:Fire("AddOutput", "OnStartTouch triggerhook:RunPassedCode:hook.Run( 'EndHL2' ):0:-1")
		end
	end
	
	if game.GetMap() != "hl2c_lobby_remake" then
		SetCheckpointsStage()
	end
end

hook.Add("InitPostEntity", "SetupHL2Lua", SetupMap)
hook.Add("PostCleanupMap", "SetupHL2Lua", SetupMap)

function UpdateBaby()
	if game.GetMap() == "d1_trainstation_02" then
		file.Write("hl2cr_data/babydoll.txt", "Please leave this file alone unless you wanna disrupt someones achievement")
	elseif game.GetMap() == "d1_trainstation_03" then
		file.Write("hl2cr_data/babydoll2.txt", "Why are you back here?")
	elseif game.GetMap() == "d1_trainstation_04" then
		file.Write("hl2cr_data/babydoll3.txt", "Stop reading me every map change")
	end
end

function UpdateBall()
	
	if game.GetMap() == "d1_eli_02" then
		file.Write("hl2cr_data/ravenball1.txt", "Please leave this file alone unless you wanna disrupt someones achievement")
	elseif game.GetMap() == "d1_town_01" then
		file.Write("hl2cr_data/ravenball2.txt", "Why are you reading this?")
	elseif game.GetMap() == "d1_town_01a" then
		file.Write("hl2cr_data/ravenball3.txt", "Stop coming back to read this")
	elseif game.GetMap() == "d1_town_02" and not file.Exists("hl2cr_data/d1_town_02.txt", "DATA") then
		file.Write("hl2cr_data/ravenball4.txt", "Can you please stop coming back?")
	elseif game.GetMap() == "d1_town_03" then
		file.Write("hl2cr_data/ravenball5.txt", "Stop reading me!")
	elseif game.GetMap() == "d1_town_02" and file.Exists("hl2cr_data/d1_town_02.txt", "DATA") then
		file.Write("hl2cr_data/ravenball6.txt", "God damn you are a madlad")
	elseif game.GetMap() == "d1_town_02a" then
		file.Write("hl2cr_data/ravenball7.txt", "Easter egg?")
	elseif game.GetMap() == "d1_town_04" then
		file.Delete("hl2cr_data/RavenBall8.txt")
		for k, v in pairs(player.GetAll()) do
			Achievement(v, "Rave_Ball", "HL2_Ach_List", 2500)	
		end
	end
end

local enabled = false

hook.Add("Airboat", "AllowAirboat", function()
	if not enabled then
		for k, v in pairs(player.GetAll()) do
			v:ChatPrint("Airboat enabled")
			airboatSpawnable = true
			enabled = true
		end
	end
end)
hook.Add("FailSand", "FailureSandAch", function()	
	if sandAchEarnable then 
		for k, v in pairs(player.GetAll()) do
			v:ChatPrint("Keep off the Sand! Failed")
		end
	end
	sandAchEarnable = false
end)


hook.Add("GiveGravgun", "GrantGravgun", function()
	for k, v in pairs(player.GetAll()) do
		v:Give("weapon_physcannon")
		Achievement(v, "ZeroPoint_Energy", "HL2_Ach_List", 250)
		v:ChatPrint("Gravity gun is now enabled")
	end
end)

hook.Add("EndHL2", "FinishedHL2", function()
	for k, v in pairs(player.GetAll()) do
		Achievement(v, "Finish_HL2", "HL2_Ach_List", 250)
	end
	
	EndHL2Game()
end)

hook.Add("GiveLostCause", "GrantLobbyAch", function()
	for k, v in pairs(player.GetAll()) do
		Achievement(v, "Lost_Cause", "Lobby_Ach_List", 500)
	end
end)

local displayOnce = false

hook.Add( "OnChangeLevel", "ChangeMap", function()
	local map = game.GetMap()
	
	local HL2 = {
		"d1_trainstation_01",
		"d1_trainstation_02",
		"d1_trainstation_03",
		"d1_trainstation_04",
		"d1_trainstation_05",
		"d1_trainstation_06",
		"d1_canals_01",
		"d1_canals_01a",
		"d1_canals_02",
		"d1_canals_03",
		"d1_canals_05",
		"d1_canals_06",
		"d1_canals_07",
		"d1_canals_08",
		"d1_canals_09",
		"d1_canals_10",
		"d1_canals_11",
		"d1_canals_12",
		"d1_canals_13",
		"d1_eli_01",
		"d1_eli_02",
		"d1_town_01",
		"d1_town_01a",
		"d1_town_02",
		"d1_town_03",
		"d1_town_02",
		"d1_town_02a",
		"d1_town_04",
		"d1_town_05",
		"d2_coast_01",
		"d2_coast_03",
		"d2_coast_04",
		"d2_coast_05",
		"d2_coast_07",
		"d2_coast_08",
		"d2_coast_09",
		"d2_coast_10",
		"d2_coast_11",
		"d2_coast_12",
		"d2_prison_01",
		"d2_prison_02",
		"d2_prison_03",
		"d2_prison_04",
		"d2_prison_05",
		"d2_prison_06",
		"d2_prison_07",
		"d2_prison_08",
		"d3_c17_01",
		"d3_c17_02",
		"d3_c17_03",
		"d3_c17_04",
		"d3_c17_05",
		"d3_c17_06a",
		"d3_c17_06b",
		"d3_c17_07",
		"d3_c17_08",
		"d3_c17_09",
		"d3_c17_10a",
		"d3_c17_10b",
		"d3_c17_11",
		"d3_c17_12",
		"d3_c17_12b",
		"d3_c17_13",
		"d3_citadel_01",
		"d3_citadel_03",
		"d3_citadel_04",
		"d3_citadel_05",
		"d3_breen_01",
		"hl2c_lobby_remake"
	}
	for k = 1, #HL2 do
		if (map == HL2[k]) and not (map == "d1_town_02" and not map == "d2_coast_07") then
			RunConsoleCommand("changelevel", HL2[k+1])
		elseif map == "d1_town_02" and not file.Exists("hl2cr_data/d1_town_02.txt", "DATA") or not map == "d2_coast_07" then
			RunConsoleCommand("changelevel", "d1_town_03")
		elseif map == "d1_town_02" and file.Exists("hl2cr_data/d1_town_02.txt", "DATA") or not map == "d2_coast_07" then
			RunConsoleCommand("changelevel", "d1_town_02a")
		elseif map == "d2_coast_07" and not file.Exists("hl2cr_data/d2_coast_07.txt", "DATA") or not map == "d1_town_02" then
			RunConsoleCommand("changelevel", "d2_coast_08")
		elseif map == "d2_coast_08" and file.Exists("hl2cr_data/d2_coast_07.txt", "DATA") or not map == "d1_town_02" then
			RunConsoleCommand("changelevel", "d2_coast_07")
		end
	end
end)

function SetCheckpointsStage()
	
	if game.GetMap() == "d1_trainstation_01" then
		TRIGGER_CHECKPOINT = {
			Vector(-5513, -1985, -18), Vector(-5163, -1933, 142),
			Vector(-3475, -444, -23), Vector(-3600, -320, 81),
			Vector(-3275, -76, -25), Vector(-3512, -6, 71),
		}
		
		TRIGGER_SPAWNPOINT = {
			Vector(-3596, 12, 3), Vector(-5262, -2105, 12),
			Vector(-4208, -522, -10), Vector(-3461, -278, -23),
			Vector(-3503, 31, 32)
		}

	elseif game.GetMap() == "d1_trainstation_03" then

		TRIGGER_CHECKPOINT = {
			Vector( -5002, -4710, 522 ), Vector( -4899, -4821, 630 ), 
		}
		TRIGGER_SPAWNPOINT = {
			Vector(-4964, -4824, 518)
		}
		
	elseif game.GetMap() == "d1_trainstation_04" then
		TRIGGER_CHECKPOINT = {
			Vector(-6861, -4255, 543), Vector(-7102, -4104, 670),
			Vector( -7882, -4154, -242 ), Vector( -7796, -4024, -153 ),
			Vector( -7904, -4158, -251 ), Vector( -7807, -4098, -128 ),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(-7031, -4004, 584), Vector(-7485, -4141, -236),
			Vector(-7864, -4125, -242)
		}
		
	elseif game.GetMap() == "d1_trainstation_05" then
		TRIGGER_CHECKPOINT = {
			 Vector(-6526, -1120, 17), Vector(-6421, -1203, 119),
			 Vector(-7073, -1325, 14), Vector(-7252, -1457, 116),
			 Vector(-10272, -4752, 321), Vector(-10427, -4703, 427),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(-6534, -1458, 64), Vector(-7170, -1389, 64),
			Vector(-10235, -4719, 329)
		}	
		
	elseif game.GetMap() == "d1_canals_01" then
		TRIGGER_CHECKPOINT = {
			 Vector(707, 2727, -87), Vector(758, 2756, -0),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(512, 2882, -31)
		}
		
	elseif game.GetMap() == "d1_canals_01a" then
		TRIGGER_CHECKPOINT = {
			 Vector(-2931, 5371, -56), Vector(-3012, 5216, 112),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(-3200, 5180, -78)
		}
		
	elseif game.GetMap() == "d1_canals_03" then
		TRIGGER_CHECKPOINT = {
			 Vector(-2180, -885, -1028), Vector(-2108, -829, -1076),
		}
		
		TRIGGER_SPAWNPOINT = {
			Vector(-2073, -871, -1167),
		}		
	
	elseif game.GetMap() == "d1_canals_05" then
		TRIGGER_CHECKPOINT = {
			 Vector(4281, 1474, -453), Vector(4114, 1549, -294),
			 Vector(6745, 1598, -446), Vector(6775, 1534, -337),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(4187, 1559, -448), Vector(7261, 1608, -383)
		}
			
	elseif game.GetMap() == "d1_canals_07" then
		TRIGGER_CHECKPOINT = {
			 Vector(7361, 1410, -251), Vector(7319, 1358, -142)
		}
		TRIGGER_SPAWNPOINT = {
			Vector(7356, 1849, -319)
		}

	elseif game.GetMap() == "d1_canals_08" then
		TRIGGER_CHECKPOINT = {
			 Vector(-777, -388, -575), Vector(-675, -272, -457),
			 Vector(-2993, -4486, -638), Vector(-2371, -3692, -258)
		}
		TRIGGER_SPAWNPOINT = {
			Vector(-783, -577, -540), Vector(-3391, -4081, -549)
		}	
			
	elseif game.GetMap() == "d1_canals_11" then
		TRIGGER_CHECKPOINT = {
			 Vector(6228, 5310, -889), Vector(6276, 5247, -777),
			 Vector(5117, 5052, -945), Vector(4830, 4725, -764),
			 Vector(2349, -7427, -999), Vector(2066, -8069, -760),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(6329, 5405, -893), Vector(5348, 4912, -939),
			Vector(1961, -7257, -863)
		}	
		
	elseif game.GetMap() == "d1_eli_01" then
		TRIGGER_CHECKPOINT = {
			 Vector(15, 2847, -1271), Vector(-110, 2837, -1180),
			 Vector(397, 1716, -1256), Vector(510, 1669, -1175),
			 Vector(508, 1770, -2726), Vector(383, 1881, -2603),
			 Vector(19, 2075, -2727), Vector(-79, 2181, -2606),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(-107, 2747, -1270), Vector(453, 1660, -1284),
			Vector(434, 1949, -2671), Vector(-329, 2132, -2671)
		}
		
	elseif game.GetMap() == "d1_eli_02" then
		TRIGGER_CHECKPOINT = {
			 Vector(-677, 864, -2676), Vector(-519, 779, -2566),
			 Vector(-525, 1186, -2681), Vector(-681, 1320, -2573),
			 Vector(-1905, 2007, -2726), Vector(-2056, 1851, -2592),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(-604, 639, -2623), Vector(-722, 1469, -2633),
			Vector(-2331, 2092, -2671)
		}
		
	elseif game.GetMap() == "d1_town_02" and file.Exists("hl2cr_data/d1_town_02.txt", "DATA") then
		TRIGGER_CHECKPOINT = {
			 Vector(-4522, 869, -3050), Vector(-4647, 957, -2914),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(-4712, 586, -3199)
		}
		
	elseif game.GetMap() == "d1_town_02a" then
		TRIGGER_CHECKPOINT = {
			 Vector(-7539, -287, -3404), Vector(-7461, -150, -3279),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(-7412, -370, -3338)
		}
				
	elseif game.GetMap() == "d1_town_05" then
		TRIGGER_CHECKPOINT = {
			 Vector(-1078, 10319, 901), Vector(-1156, 10377, 1007),
			 Vector(1714, 10868, 910), Vector(-1714, 10972, 1011),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(-1227, 10663, 930), Vector(-1699, 10887, 909)
		}
	
	elseif game.GetMap() == "d2_coast_08" then
		TRIGGER_CHECKPOINT = {
			 Vector(3060, -6922, 1923), Vector(2972, -6988, 2034),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(2954, -7059, 1937)
		}
	
	elseif game.GetMap() == "d2_coast_09" then
		TRIGGER_CHECKPOINT = {
			 Vector(10870, 8391, -185), Vector(11160, 8727, -45),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(10968, 8648, -163)
		}

	elseif game.GetMap() == "d2_coast_11" then
		TRIGGER_CHECKPOINT = {
			 Vector(4548, 6434, 580), Vector(4145, 6676, 818),
			 Vector(5038, 10047, 172), Vector(4856, 9808, 314),
			 Vector(815, 11598, 507), Vector(755, 11476, 652),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(4406, 6555, 655), Vector(4967, 9917, 233),
			Vector(315, 11606, 436),
		}
		
	elseif game.GetMap() == "d2_coast_12" then
		TRIGGER_CHECKPOINT = {
			 Vector(2236, -317, 672), Vector(2055, -188, 815),
			 Vector(8521, 7965, 1041), Vector(8680, 7835, 1247),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(2086, -77, 694)
		}
		
	elseif game.GetMap() == "d2_prison_01" then
		TRIGGER_CHECKPOINT = {
			 Vector(1156, -1410, 1602), Vector(1000, -1582, 1777),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(846, -1497, 1621)
		}
		
	elseif game.GetMap() == "d2_prison_03" then
		TRIGGER_CHECKPOINT = {
			 Vector(-3395, 3390, 4), Vector(-3574, 3325, 191),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(-3515, 3524, 64)
		}
		
	elseif game.GetMap() == "d2_prison_05" then
		TRIGGER_CHECKPOINT = {
			 Vector(-3478, -468, 511), Vector(-3640, -665, 858),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(-3797, -557, 523)
		}
		
	elseif game.GetMap() == "d2_prison_06" then
		TRIGGER_CHECKPOINT = {
			 Vector(1614, 749, -186), Vector(1487, 609, -67),
			 Vector(428, 49, 2), Vector(506, 172, 130),
			 Vector(252, -333, -57), Vector(347, -472, 121),
			 Vector(634, -839, 4), Vector(492, -1083, 130),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(1563, 673, -176), Vector(569, 99, 16),
			Vector(311, -525, -38), Vector(717, -918, 9)
		}
		
	elseif game.GetMap() == "d2_prison_07" then
		TRIGGER_CHECKPOINT = {
			 Vector(-345, -2957, -238), Vector(-532, -2794, -110),
			 Vector(1604, -3354, -678), Vector(1434, -3268, -493),
			 Vector(4333, -3907, -539), Vector(3988, -4088, -418),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(-439, -2879, -228), Vector(1727, -3308, -663),
			Vector(4153, -3977, -528)
		}
		
	elseif game.GetMap() == "d2_prison_08" then
		TRIGGER_CHECKPOINT = {
			Vector(-467, 685, 933), Vector(-371, 603, 1081),
			Vector(436, 396, 994), Vector(-82, 102, 1154),
			Vector(97, 23, 1181), Vector(150, -18, 1229),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(-474, 518, 941), Vector(131, 300, 1003),
			Vector(128, 28, 1224)
		}
		
	elseif game.GetMap() == "d3_c17_01" then
		TRIGGER_CHECKPOINT = {
			 Vector(-6993, -1223, 6), Vector(-6923, -1619, 98),
			 Vector(-6841, -1384, 13), Vector(-6413, -777, 140),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(-6841, -1384, 13), Vector(-6476, -918, 11)
		}
		
	elseif game.GetMap() == "d3_c17_02" then
		TRIGGER_CHECKPOINT = {
			 Vector(-5586, -5702, 0), Vector(-5478, -5565, 150),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(-5449, -5753, 22)
		}
		
	elseif game.GetMap() == "d3_c17_06a" then
		TRIGGER_CHECKPOINT = {
			 Vector(3002, 2404, -310), Vector(2882, 2506, -169),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(2751, 2763, -301)
		}
		
	elseif game.GetMap() == "d3_c17_07" then
		TRIGGER_CHECKPOINT = {
			 Vector(5520, 1383, 0), Vector(5525, 1432, 109),
			 Vector(7275, 1282, 3), Vector(7499, 1788, 270),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(6585, 1531, 19), Vector(7840, 1531, 6)
		}
		
	elseif game.GetMap() == "d3_c17_08" then
		TRIGGER_CHECKPOINT = {
			Vector(1310, -754, -320), Vector(1220, -682, -225),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(1473, -596, -377)
		}
	
	elseif game.GetMap() == "d3_c17_10b" then
		TRIGGER_CHECKPOINT = {
			Vector(2836, -956, 276), Vector(2512, -858, 472),
			Vector(2718, 1083, 263), Vector(2668, 1004, 362)
		}
		TRIGGER_SPAWNPOINT = {
			Vector(2424, -943, 320), Vector(2802, 1015, 320)
		}
		
	elseif game.GetMap() == "d3_c17_13" then
		TRIGGER_CHECKPOINT = {
			Vector(5009, 255, 258), Vector(5207, 338, 419),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(5179, 1042, 20)
		}
		
	elseif game.GetMap() == "d3_citadel_01" then
		TRIGGER_CHECKPOINT = {
			Vector(10545, 4302, -1774), Vector(10484, 4156, -1603),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(10201, 4225, -1779)
		}
		
	elseif game.GetMap() == "d3_citadel_04" then
		TRIGGER_CHECKPOINT = {
			Vector(435, 640, 2793), Vector(68, 974, 3087),
			Vector(459, 639, 4123), Vector(74, 1016, 4600),
			Vector(445, 252, 6403), Vector(72, 31, 6655),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(264, 837, 2853), Vector(240, 825, 4186),
			Vector(236, -245, 6422)
		}
		
	elseif game.GetMap() == "d3_breen_01" then
		TRIGGER_CHECKPOINT = {
			Vector(-769, 123, -250), Vector(-672, -130, -54),
			Vector(-762, -470, 1285), Vector(-519, -276, 1479)
		}
		TRIGGER_SPAWNPOINT = {
			Vector(-649, 16, -244), Vector(-692, 1, 1311)
		}	
	end
	
	if TRIGGER_CHECKPOINT[1] and TRIGGER_CHECKPOINT[2] then
		local Checkpoint1 = ents.Create("trigger_checkpoint")
		Checkpoint1.forcePlyTP = true
		Checkpoint1.Min = Vector(TRIGGER_CHECKPOINT[1])
		Checkpoint1.Max = Vector(TRIGGER_CHECKPOINT[2])
		Checkpoint1.Pos = Vector(TRIGGER_CHECKPOINT[2]) - ( ( Vector(TRIGGER_CHECKPOINT[2]) - Vector(TRIGGER_CHECKPOINT[1])) / 2 )
		Checkpoint1.Point1 = Vector(TRIGGER_SPAWNPOINT[1])
		Checkpoint1:SetPos(Checkpoint1.Pos)
		Checkpoint1:Spawn()
			
		lambdaModel1 = ents.Create("prop_dynamic")
		lambdaModel1:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel1:SetMaterial("models/props_combine/com_shield001a")
		lambdaModel1:SetPos(Checkpoint1.Pos)
		lambdaModel1:Spawn()
	end
	
	if TRIGGER_CHECKPOINT[3] and TRIGGER_CHECKPOINT[4] then
		local Checkpoint2 = ents.Create("trigger_checkpoint")
		Checkpoint2.forcePlyTP = true
		Checkpoint2.Min = Vector(TRIGGER_CHECKPOINT[3])
		Checkpoint2.Max = Vector(TRIGGER_CHECKPOINT[4])
		Checkpoint2.Pos = Vector(TRIGGER_CHECKPOINT[4]) - ( ( Vector(TRIGGER_CHECKPOINT[4]) - Vector(TRIGGER_CHECKPOINT[3])) / 2 )
		Checkpoint2.Point2 = Vector(TRIGGER_SPAWNPOINT[2])
		Checkpoint2:SetPos(Checkpoint2.Pos)
		Checkpoint2:Spawn()
		
		lambdaModel2 = ents.Create("prop_dynamic")
		lambdaModel2:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel2:SetMaterial("models/props_combine/com_shield001a")
		lambdaModel2:SetPos(Checkpoint2.Pos)
		lambdaModel2:Spawn()
	end
	
	if TRIGGER_CHECKPOINT[5] and TRIGGER_CHECKPOINT[6] then
		local Checkpoint3 = ents.Create("trigger_checkpoint")
		Checkpoint3.forcePlyTP = true
		Checkpoint3.Min = Vector(TRIGGER_CHECKPOINT[5])
		Checkpoint3.Max = Vector(TRIGGER_CHECKPOINT[6])
		Checkpoint3.Pos = Vector(TRIGGER_CHECKPOINT[6]) - ( ( Vector(TRIGGER_CHECKPOINT[6]) - Vector(TRIGGER_CHECKPOINT[5])) / 2 )
		Checkpoint3.Point3 = Vector(TRIGGER_SPAWNPOINT[3])
		Checkpoint3:SetPos(Checkpoint3.Pos)
		Checkpoint3:Spawn()
		
		lambdaModel3 = ents.Create("prop_dynamic")
		lambdaModel3:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel3:SetMaterial("models/props_combine/com_shield001a")
		lambdaModel3:SetPos(Checkpoint3.Pos)
		lambdaModel3:Spawn()
	end
	
	if TRIGGER_CHECKPOINT[7] and TRIGGER_CHECKPOINT[8] then
		local Checkpoint4 = ents.Create("trigger_checkpoint")
		Checkpoint4.forcePlyTP = true
		Checkpoint4.Min = Vector(TRIGGER_CHECKPOINT[7])
		Checkpoint4.Max = Vector(TRIGGER_CHECKPOINT[8])
		Checkpoint4.Pos = Vector(TRIGGER_CHECKPOINT[8]) - ( ( Vector(TRIGGER_CHECKPOINT[8]) - Vector(TRIGGER_CHECKPOINT[7])) / 2 )
		Checkpoint4.Point4 = Vector(TRIGGER_SPAWNPOINT[4])
		Checkpoint4:SetPos(Checkpoint4.Pos)
		Checkpoint4:Spawn()
		
		lambdaModel4 = ents.Create("prop_dynamic")
		lambdaModel4:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel4:SetMaterial("models/props_combine/com_shield001a")
		lambdaModel4:SetPos(Checkpoint4.Pos)
		lambdaModel4:Spawn()
	end
end
