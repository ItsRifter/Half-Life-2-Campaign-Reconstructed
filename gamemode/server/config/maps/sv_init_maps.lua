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
	
	disableField = false
	if game.GetMap() == "d1_canals_10" then 
		for k, fix1 in pairs(ents.FindByClass("info_player_start")) do
			fix1:SetPos(Vector(11808, -12450, -475))
		end
	end
	
	if game.GetMap() == "d2_coast_08" then 
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
	end
	
	if game.GetMap() == "d1_trainstation_03" then
		for k, pusher in pairs(ents.FindByClass("trigger_push")) do
			if pusher:EntIndex() == 709 then
				pusher:Remove()
			end
		end
	end
	
	--Doll Achievement
	local dollAch = ents.Create("prop_physics")
	dollAch:SetModel("models/props_c17/doll01.mdl")
	if game.GetMap() == "d1_trainstation_03" and file.Exists("hl2cr_data/babydoll.txt", "DATA") then
		dollAch:SetPos(Vector(-5177, -4719, 64))
		dollAch:Spawn()
		file.Delete("hl2cr_data/babydoll.txt")
	elseif game.GetMap() == "d1_trainstation_04" and file.Exists("hl2cr_data/babydoll2.txt", "DATA") then
		dollAch:SetPos(Vector(-3367, -3410, 628))
		dollAch:Spawn()
		file.Delete("hl2cr_data/babydoll2.txt")
	elseif game.GetMap() == "d1_trainstation_05" and file.Exists("hl2cr_data/babydoll3.txt", "DATA") then
		dollAch:SetPos(Vector(-5833, -927, 128))
		dollAch:Spawn()
		file.Delete("hl2cr_data/babydoll3.txt")
	end
	
	--Ball achievement ravenholm
	local ballAch = ents.Create("prop_physics")
	ballAch:SetModel("models/Roller.mdl")
	if game.GetMap() == "d1_town_01" and file.Exists("hl2cr_data/ravenball1.txt", "DATA") then
		ballAch:SetPos(Vector(4672, -2222, -3718))
		ballAch:Spawn()
		file.Delete("hl2cr_data/ravenball1.txt")
	elseif game.GetMap() == "d1_town_01a" and file.Exists("hl2cr_data/ravenball2.txt", "DATA") then
		ballAch:SetPos(Vector(174, 177, -3263))
		ballAch:Spawn()
		file.Delete("hl2cr_data/ravenball2.txt")
	elseif game.GetMap() == "d1_town_02" and not file.Exists("hl2cr_data/d1_town_02.txt", "DATA") and file.Exists("hl2cr_data/ravenball3.txt", "DATA") then
		ballAch:SetPos(Vector(-955, 884, -3375))
		ballAch:Spawn()
		file.Delete("hl2cr_data/ravenball3.txt")
	elseif game.GetMap() == "d1_town_03" and file.Exists("hl2cr_data/ravenball4.txt", "DATA") then
		ballAch:SetPos(Vector(-3554, -725, -3519))
		ballAch:Spawn()
		file.Delete("hl2cr_data/ravenball4.txt")
	elseif game.GetMap() == "d1_town_02" and file.Exists("hl2cr_data/d1_town_02.txt", "DATA") and file.Exists("hl2cr_data/ravenball5.txt", "DATA") then
		ballAch:SetPos(Vector(-3587, 260, -3391))
		ballAch:Spawn()
		file.Delete("hl2cr_data/ravenball5.txt")
	elseif game.GetMap() == "d1_town_02a" and file.Exists("hl2cr_data/ravenball6.txt", "DATA") then
		ballAch:SetPos(Vector(-5361, 2333, -3218))
		ballAch:Spawn()
		file.Delete("hl2cr_data/ravenball6.txt")
	elseif game.GetMap() == "d1_town_04" and file.Exists("hl2cr_data/ravenball7.txt", "DATA") then
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
	if game.GetMap() == "d3_citadel_03" or game.GetMap() == "d3_citadel_04" or game.GetMap() == "d3_citadel_05" or game.GetMap() == "d3_breen_01" then
		for k, l in pairs(ents.FindByClass("logic_auto")) do
			l:Remove()
		end
	end

	SetCheckpointsStage()
	
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

hook.Add("PlayerSpawn", "GiveWeapons", function(ply)
	ply.givenWeapons = {}
end)

hook.Add("Think", "MapWeapons", function()
	for _, p in pairs(player.GetAll()) do
		if not p:Alive() or p:Team() ~= TEAM_ALIVE then
			return
		end
		
		for _, pl2 in pairs(player.GetAll()) do
			if p ~= pl2 and pl2:Alive() and not p:InVehicle() and not pl2:InVehicle() and pl2:GetActiveWeapon():IsValid()
			and not p:HasWeapon(pl2:GetActiveWeapon():GetClass()) 
			and not table.HasValue(p.givenWeapons, pl2:GetActiveWeapon():GetClass()) and pl2:GetActiveWeapon():GetClass() ~= "weapon_physgun" then
				p:Give(pl2:GetActiveWeapon():GetClass())
				table.insert(p.givenWeapons, pl2:GetActiveWeapon():GetClass())
			end
		end
	end
end)

function SetCheckpointsStage()
	
	if game.GetMap() == "d1_trainstation_01" then
		TRIGGER_CHECKPOINT = {
			Vector(-5513, -1985, -18), Vector(-5163, -1933, 142),
			Vector(-3475, -444, -23), Vector(-3600, -320, 81),
			Vector(-3288, -111, -17), Vector(-3512, -6, 71),
		}
		local Checkpoint1 = ents.Create("trigger_checkpoint")
		Checkpoint1.forcePlyTP = true
		Checkpoint1.Min = Vector(-9533, -2564, 22)
		Checkpoint1.Max = Vector(-9343, -2405, 121)
		Checkpoint1.Pos = Vector(-9343, -2405, 121) - ( ( Vector(-9343, -2405, 121) - Vector(-9533, -2564, 22)) / 2 )
		Checkpoint1.Point1 = Vector( -8954, -2316, 50)
		Checkpoint1:SetPos(Checkpoint1.Pos)
		Checkpoint1:Spawn()
		
		local Checkpoint2 = ents.Create("trigger_checkpoint")
		Checkpoint2.forcePlyTP = true
		Checkpoint2.Min = Vector(-5211, -1932, -22)
		Checkpoint2.Max = Vector(-5501, -2015, 157)
		Checkpoint2.Pos = Vector(-5501, -2015, 157) - ( ( Vector(-5501, -2015, 157) - Vector(-5211, -1932, -22)) / 2 )
		Checkpoint2.Point2 = Vector(-5262, -2105, 12)
		Checkpoint2:SetPos(Checkpoint2.Pos)
		Checkpoint2:Spawn()
		
		local Checkpoint3 = ents.Create("trigger_checkpoint")
		Checkpoint3.forcePlyTP = true
		Checkpoint3.Min = Vector(-4170, -589, -13)
		Checkpoint3.Max = Vector(-4320, -531, 99)
		Checkpoint3.Pos = Vector(-4320, -531, 99) - ( ( Vector(-4320, -531, 99) - Vector(-4170, -589, -13)) / 2 )
		Checkpoint3.Point3 = Vector(-4208, -522, -10)
		Checkpoint3:SetPos(Checkpoint3.Pos)
		Checkpoint3:Spawn()
		
		local Checkpoint4 = ents.Create("trigger_checkpoint")
		Checkpoint4.forcePlyTP = true
		Checkpoint4.Min = Vector(-3476, -442, -25)
		Checkpoint4.Max = Vector(-3601, -289, 76)
		Checkpoint4.Pos = Vector(-3601, -289, 76) - ( ( Vector(-3601, -289, 76) - Vector(-3476, -442, -25)) / 2 )
		Checkpoint4.Point4 = Vector(-3461, -278, -23)
		Checkpoint4:SetPos(Checkpoint4.Pos)
		Checkpoint4:Spawn()
		
		local Checkpoint5 = ents.Create("trigger_checkpoint")
		Checkpoint5.forcePlyTP = true
		Checkpoint5.Min = Vector(-3277, -118, -25)
		Checkpoint5.Max = Vector(-3448, -19, 64)
		Checkpoint5.Pos = Vector(-3448, -19, 64) - ( ( Vector(-3448, -19, 64) - Vector(-3277, -118, -25)) / 2 )
		Checkpoint5.Point5 = Vector(-3503, 31, 32)
		Checkpoint5:SetPos(Checkpoint5.Pos)
		Checkpoint5:Spawn()
		
		lambdaModel1 = ents.Create("prop_dynamic")
		lambdaModel1:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel1:SetMaterial("models/player/shared/gold_player")
		lambdaModel1:SetPos(Checkpoint1.Pos)
		lambdaModel1:Spawn()
		
		lambdaModel2 = ents.Create("prop_dynamic")
		lambdaModel2:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel2:SetMaterial("models/player/shared/gold_player")
		lambdaModel2:SetPos(Checkpoint2.Pos)
		lambdaModel2:Spawn()
		
		lambdaModel3 = ents.Create("prop_dynamic")
		lambdaModel3:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel3:SetMaterial("models/player/shared/gold_player")
		lambdaModel3:SetPos(Checkpoint3.Pos)
		lambdaModel3:Spawn()
		
		lambdaModel4 = ents.Create("prop_dynamic")
		lambdaModel4:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel4:SetMaterial("models/player/shared/gold_player")
		lambdaModel4:SetPos(Checkpoint4.Pos)
		lambdaModel4:Spawn()
		
		lambdaModel5 = ents.Create("prop_dynamic")
		lambdaModel5:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel5:SetMaterial("models/player/shared/gold_player")
		lambdaModel5:SetPos(Checkpoint5.Pos)
		lambdaModel5:Spawn()

	elseif game.GetMap() == "d1_trainstation_03" then

		TRIGGER_CHECKPOINT = {
			Vector( -5002, -4710, 522 ), Vector( -4899, -4821, 630 ), 
		}
		
		local Checkpoint1 = ents.Create("trigger_checkpoint")
		Checkpoint1.forcePlyTP = true
		Checkpoint1.Min = Vector(-5002, -4710, 522)
		Checkpoint1.Max = Vector(-4899, -4821, 630)
		Checkpoint1.Pos = Vector(-4899, -4821, 630) - ( ( Vector(-4899, -4821, 630) - Vector(-5002, -4710, 522)) / 2 )
		Checkpoint1.Point1 = Vector(-4964, -4824, 518)
		Checkpoint1:SetPos(Checkpoint1.Pos)
		Checkpoint1:Spawn()
		
		lambdaModel1 = ents.Create("prop_dynamic")
		lambdaModel1:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel1:SetMaterial("models/player/shared/gold_player")
		lambdaModel1:SetPos(Checkpoint1.Pos)
		lambdaModel1:Spawn()
	
		
	elseif game.GetMap() == "d1_trainstation_04" then
		TRIGGER_CHECKPOINT = {
			Vector(-6861, -4255, 543), Vector(-7102, -4104, 670),
			Vector( -7882, -4154, -242 ), Vector( -7796, -4024, -153 ),
			Vector( -7904, -4158, -251 ), Vector( -7807, -4098, -128 ),
		}
		local Checkpoint1 = ents.Create("trigger_checkpoint")
		Checkpoint1.forcePlyTP = true
		Checkpoint1.Min = Vector(-6861, -4255, 543)
		Checkpoint1.Max = Vector(-7102, -4104, 670)
		Checkpoint1.Pos = Vector(-7102, -4104, 670) - ( ( Vector(-7102, -4104, 670) - Vector(-6861, -4255, 543)) / 2 )
		Checkpoint1.Point1 = Vector(-7031, -4004, 584)
		Checkpoint1:SetPos(Checkpoint1.Pos)
		Checkpoint1:Spawn()
		
		local Checkpoint2 = ents.Create("trigger_checkpoint")
		Checkpoint2.forcePlyTP = true
		Checkpoint2.Min = Vector(-7882, -4154, -242)
		Checkpoint2.Max = Vector(-7796, -4024, -153)
		Checkpoint2.Pos = Vector(-7796, -4024, -153) - ( ( Vector(-7796, -4024, -153) - Vector(-7653, -3879, -242)) / 2 )
		Checkpoint2.Point2 = Vector(-7485, -4141, -236)
		Checkpoint2:SetPos(Checkpoint2.Pos)
		Checkpoint2:Spawn()
		
		local Checkpoint3 = ents.Create("trigger_checkpoint")
		Checkpoint3.forcePlyTP = true
		Checkpoint3.Min = Vector(-7904, -4158, -251)
		Checkpoint3.Max = Vector(-7807, -4098, -128)
		Checkpoint3.Pos = Vector(-7807, -4098, -128) - ( ( Vector(-7807, -4098, -128) - Vector(-7904, -4158, -251)) / 2 )
		Checkpoint3.Point3 = Vector(-7864, -4125, -242)
		Checkpoint3:SetPos(Checkpoint3.Pos)
		Checkpoint3:Spawn()
		
		lambdaModel1 = ents.Create("prop_dynamic")
		lambdaModel1:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel1:SetMaterial("models/player/shared/gold_player")
		lambdaModel1:SetPos(Checkpoint1.Pos)
		lambdaModel1:Spawn()
		
		lambdaModel2 = ents.Create("prop_dynamic")
		lambdaModel2:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel2:SetMaterial("models/player/shared/gold_player")
		lambdaModel2:SetPos(Checkpoint2.Pos)
		lambdaModel2:Spawn()
		
		lambdaModel3 = ents.Create("prop_dynamic")
		lambdaModel3:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel3:SetMaterial("models/player/shared/gold_player")
		lambdaModel3:SetPos(Checkpoint3.Pos)
		lambdaModel3:Spawn()
		
	elseif game.GetMap() == "d1_trainstation_05" then
		TRIGGER_CHECKPOINT = {
			 Vector(-6526, -1120, 17), Vector(-6421, -1203, 119),
			 Vector(-7073, -1325, 14), Vector(-7252, -1457, 116),
			 Vector(-10272, -4752, 321), Vector(-10427, -4703, 427),
		}
		local Checkpoint1 = ents.Create("trigger_checkpoint")
		Checkpoint1.forcePlyTP = true
		Checkpoint1.Min = Vector(-6526, -1120, 17)
		Checkpoint1.Max = Vector(-6421, -1203, 119)
		Checkpoint1.Pos = Vector(-6421, -1203, 119) - ( ( Vector(-6421, -1203, 119) - Vector(-6526, -1120, 17)) / 2 )
		Checkpoint1.Point1 = Vector(-6534, -1458, 64)
		Checkpoint1:SetPos(Checkpoint1.Pos)
		Checkpoint1:Spawn()
		
		local Checkpoint2 = ents.Create("trigger_checkpoint")
		Checkpoint2.forcePlyTP = true
		Checkpoint2.Min = Vector(-7073, -1325, 14)
		Checkpoint2.Max = Vector(-7252, -1457, 116)
		Checkpoint2.Pos = Vector(-7252, -1457, 116) - ( ( Vector(-7252, -1457, 116) - Vector(-7073, -1325, 14)) / 2 )
		Checkpoint2.Point2 = Vector(-7170, -1389, 64)
		Checkpoint2:SetPos(Checkpoint2.Pos)
		Checkpoint2:Spawn()
		
		local Checkpoint3 = ents.Create("trigger_checkpoint")
		Checkpoint3.forcePlyTP = true
		Checkpoint3.Min = Vector(-10272, -4752, 321)
		Checkpoint3.Max = Vector(-10427, -4703, 427)
		Checkpoint3.Pos = Vector(-10427, -4703, 427) - ( ( Vector(-10427, -4703, 427) - Vector(-10272, -4752, 321)) / 2 )
		Checkpoint3.Point3 = Vector(-10235, -4719, 329)
		Checkpoint3:SetPos(Checkpoint3.Pos)
		Checkpoint3:Spawn()
		
		lambdaModel1 = ents.Create("prop_dynamic")
		lambdaModel1:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel1:SetMaterial("models/player/shared/gold_player")
		lambdaModel1:SetPos(Checkpoint1.Pos)
		lambdaModel1:Spawn()
		
		lambdaModel2 = ents.Create("prop_dynamic")
		lambdaModel2:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel2:SetMaterial("models/player/shared/gold_player")
		lambdaModel2:SetPos(Checkpoint2.Pos)
		lambdaModel2:Spawn()
		
		lambdaModel3 = ents.Create("prop_dynamic")
		lambdaModel3:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel3:SetMaterial("models/player/shared/gold_player")
		lambdaModel3:SetPos(Checkpoint3.Pos)
		lambdaModel3:Spawn()
		
	elseif game.GetMap() == "d1_canals_01" then
		TRIGGER_CHECKPOINT = {
			 Vector(707, 2727, -87), Vector(758, 2756, -0),
		}
		local Checkpoint1 = ents.Create("trigger_checkpoint")
		Checkpoint1.forcePlyTP = true
		Checkpoint1.Min = Vector(707, 2727, -87)
		Checkpoint1.Max = Vector(758, 2756, -0)
		Checkpoint1.Pos = Vector(758, 2756, -0) - ( ( Vector(758, 2756, -0) - Vector(707, 2727, -87)) / 2 )
		Checkpoint1.Point1 = Vector(512, 2882, -31)
		Checkpoint1:SetPos(Checkpoint1.Pos)
		Checkpoint1:Spawn()	
		
		lambdaModel1 = ents.Create("prop_dynamic")
		lambdaModel1:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel1:SetMaterial("models/player/shared/gold_player")
		lambdaModel1:SetPos(Checkpoint1.Pos)
		lambdaModel1:Spawn()
		
	elseif game.GetMap() == "d1_canals_01a" then
		TRIGGER_CHECKPOINT = {
			 Vector(-2931, 5371, -56), Vector(-3012, 5216, 112),
		}
		local Checkpoint1 = ents.Create("trigger_checkpoint")
		Checkpoint1.Min = Vector(-2931, 5371, -56)
		Checkpoint1.Max = Vector(-3012, 5216, 112)
		Checkpoint1.Pos = Vector(-3012, 5216, 112) - ( ( Vector(-3012, 5216, 112) - Vector(-2931, 5371, -56)) / 2 )
		Checkpoint1.Point1 = Vector(-3200, 5180, -78)
		Checkpoint1:SetPos(Checkpoint1.Pos)
		Checkpoint1:Spawn()
		
		lambdaModel1 = ents.Create("prop_dynamic")
		lambdaModel1:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel1:SetMaterial("models/player/shared/gold_player")
		lambdaModel1:SetPos(Checkpoint1.Pos)
		lambdaModel1:Spawn()
		
	elseif game.GetMap() == "d1_canals_03" then
		TRIGGER_CHECKPOINT = {
			 Vector(-2180, -885, -1028), Vector(-2108, -829, -1076),
		}
		local Checkpoint1 = ents.Create("trigger_checkpoint")
		Checkpoint1.Min = Vector(-2180, -885, -1028)
		Checkpoint1.Max = Vector(-2108, -829, -1076)
		Checkpoint1.Pos = Vector(-2108, -829, -1076) - ( ( Vector(-2108, -829, -1076) - Vector(-2180, -885, -1028)) / 2 )
		Checkpoint1.Point1 = Vector(-2073, -871, -1167)
		Checkpoint1:SetPos(Checkpoint1.Pos)
		Checkpoint1:Spawn()
		
		lambdaModel1 = ents.Create("prop_dynamic")
		lambdaModel1:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel1:SetMaterial("models/player/shared/gold_player")
		lambdaModel1:SetPos(Checkpoint1.Pos)
		lambdaModel1:Spawn()
		
		
	elseif game.GetMap() == "d1_canals_05" then
		TRIGGER_CHECKPOINT = {
			 Vector(4281, 1474, -453), Vector(4114, 1549, -294),
			 Vector(6745, 1598, -446), Vector(6775, 1534, -337),
		}
		local Checkpoint1 = ents.Create("trigger_checkpoint")
		Checkpoint1.Min = Vector(4281, 1474, -453)
		Checkpoint1.Max = Vector(4114, 1549, -294)
		Checkpoint1.Pos = Vector(4114, 1549, -294) - ( ( Vector(4114, 1549, -294) - Vector(4281, 1474, -453)) / 2 )
		Checkpoint1.Point1 = Vector(4187, 1559, -448)
		Checkpoint1:SetPos(Checkpoint1.Pos)
		Checkpoint1:Spawn()
		
		local Checkpoint2 = ents.Create("trigger_checkpoint")
		Checkpoint2.Min = Vector(6745, 1598, -446)
		Checkpoint2.Max = Vector(6775, 1534, -337)
		Checkpoint2.Pos = Vector(6775, 1534, -337) - ( ( Vector(6775, 1534, -337) - Vector(6745, 1598, -446)) / 2 )
		Checkpoint2.Point1 = Vector(7261, 1608, -383)
		Checkpoint2:SetPos(Checkpoint2.Pos)
		Checkpoint2:Spawn()
		
		lambdaModel1 = ents.Create("prop_dynamic")
		lambdaModel1:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel1:SetMaterial("models/player/shared/gold_player")
		lambdaModel1:SetPos(Checkpoint1.Pos)
		lambdaModel1:Spawn()
		
		lambdaModel2 = ents.Create("prop_dynamic")
		lambdaModel2:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel2:SetMaterial("models/player/shared/gold_player")
		lambdaModel2:SetPos(Checkpoint2.Pos)
		lambdaModel2:Spawn()
		
	elseif game.GetMap() == "d1_canals_07" then
		TRIGGER_CHECKPOINT = {
			 Vector(7361, 1410, -251), Vector(7319, 1358, -142),
		}
		local Checkpoint1 = ents.Create("trigger_checkpoint")
		Checkpoint1.Min = Vector(7361, 1410, -251)
		Checkpoint1.Max = Vector(7319, 1358, -142)
		Checkpoint1.Pos = Vector(7319, 1358, -142) - ( ( Vector(7319, 1358, -142) - Vector(7361, 1410, -251)) / 2 )
		Checkpoint1.Point1 = Vector(7356, 1849, -319)
		Checkpoint1:SetPos(Checkpoint1.Pos)
		Checkpoint1:Spawn()
		
		lambdaModel1 = ents.Create("prop_dynamic")
		lambdaModel1:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel1:SetMaterial("models/player/shared/gold_player")
		lambdaModel1:SetPos(Checkpoint1.Pos)
		lambdaModel1:Spawn()	
			
	elseif game.GetMap() == "d1_canals_11" then
		TRIGGER_CHECKPOINT = {
			 Vector(6228, 5310, -889), Vector(6276, 5247, -777),
			 Vector(5117, 5052, -945), Vector(4830, 4725, -764),
		}
		
		local Checkpoint1 = ents.Create("trigger_checkpoint")
		Checkpoint1.Min = Vector(6228, 5310, -889)
		Checkpoint1.Max = Vector(6276, 5247, -777)
		Checkpoint1.Pos = Vector(6276, 5247, -777) - ( ( Vector(6276, 5247, -777) - Vector(6228, 5310, -889)) / 2 )
		Checkpoint1.Point1 = Vector(6329, 5405, -893)
		Checkpoint1:SetPos(Checkpoint1.Pos)
		Checkpoint1:Spawn()
		
		local Checkpoint2 = ents.Create("trigger_checkpoint")
		Checkpoint2.Min = Vector(5117, 5052, -945)
		Checkpoint2.Max = Vector(4830, 4725, -764)
		Checkpoint2.Pos = Vector(4830, 4725, -764) - ( ( Vector(4830, 4725, -764) - Vector(5117, 5052, -945)) / 2 )
		Checkpoint2.Point2 = Vector(5348, 4912, -939)
		Checkpoint2:SetPos(Checkpoint2.Pos)
		Checkpoint2:Spawn()
		
		lambdaModel1 = ents.Create("prop_dynamic")
		lambdaModel1:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel1:SetMaterial("models/player/shared/gold_player")
		lambdaModel1:SetPos(Checkpoint1.Pos)
		lambdaModel1:Spawn()
		
		lambdaModel2 = ents.Create("prop_dynamic")
		lambdaModel2:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel2:SetMaterial("models/player/shared/gold_player")
		lambdaModel2:SetPos(Checkpoint2.Pos)
		lambdaModel2:Spawn()
		
	elseif game.GetMap() == "d1_eli_01" then
		TRIGGER_CHECKPOINT = {
			 Vector(15, 2847, -1271), Vector(-110, 2837, -1180),
			 Vector(397, 1716, -1256), Vector(510, 1669, -1175),
			 Vector(508, 1770, -2726), Vector(383, 1881, -2603),
			 Vector(19, 2075, -2727), Vector(-79, 2181, -2606),
		}
		local Checkpoint1 = ents.Create("trigger_checkpoint")
		Checkpoint1.Min = Vector(15, 2847, -1271)
		Checkpoint1.Max = Vector(-110, 2837, -1180)
		Checkpoint1.Pos = Vector(-110, 2837, -1180) - ( ( Vector(-110, 2837, -1180) - Vector(15, 2847, -1271)) / 2 )
		Checkpoint1.Point1 = Vector(-107, 2747, -1270)
		Checkpoint1:SetPos(Checkpoint1.Pos)
		Checkpoint1:Spawn()
		
		local Checkpoint2 = ents.Create("trigger_checkpoint")
		Checkpoint2.Min = Vector(397, 1716, -1256)
		Checkpoint2.Max = Vector(510, 1669, -1175)
		Checkpoint2.Pos = Vector(510, 1669, -1175) - ( ( Vector(510, 1669, -1175) - Vector(397, 1716, -1256)) / 2 )
		Checkpoint2.Point2 = Vector(453, 1660, -1284)
		Checkpoint2:SetPos(Checkpoint2.Pos)
		Checkpoint2:Spawn()
		
		local Checkpoint3 = ents.Create("trigger_checkpoint")
		Checkpoint3.Min = Vector(508, 1770, -2726)
		Checkpoint3.Max = Vector(383, 1881, -2603)
		Checkpoint3.Pos = Vector(383, 1881, -2603) - ( ( Vector(383, 1881, -2603) - Vector(508, 1770, -2726)) / 2 )
		Checkpoint3.Point3 = Vector(434, 1949, -2671)
		Checkpoint3:SetPos(Checkpoint3.Pos)
		Checkpoint3:Spawn()
		
		local Checkpoint4 = ents.Create("trigger_checkpoint")
		Checkpoint4.Min = Vector(19, 2075, -2727)
		Checkpoint4.Max = Vector(-79, 2181, -2606)
		Checkpoint4.Pos = Vector(-79, 2181, -2606) - ( ( Vector(-79, 2181, -2606) - Vector(19, 2075, -2727)) / 2 )
		Checkpoint4.Point4 = Vector(-329, 2132, -2671)
		Checkpoint4:SetPos(Checkpoint4.Pos)
		Checkpoint4:Spawn()
		
		lambdaModel1 = ents.Create("prop_dynamic")
		lambdaModel1:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel1:SetMaterial("models/player/shared/gold_player")
		lambdaModel1:SetPos(Checkpoint1.Pos)
		lambdaModel1:Spawn()
		
		lambdaModel2 = ents.Create("prop_dynamic")
		lambdaModel2:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel2:SetMaterial("models/player/shared/gold_player")
		lambdaModel2:SetPos(Checkpoint2.Pos)
		lambdaModel2:Spawn()
		
		lambdaModel3 = ents.Create("prop_dynamic")
		lambdaModel3:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel3:SetMaterial("models/player/shared/gold_player")
		lambdaModel3:SetPos(Checkpoint3.Pos)
		lambdaModel3:Spawn()
		
		lambdaModel4 = ents.Create("prop_dynamic")
		lambdaModel4:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel4:SetMaterial("models/player/shared/gold_player")
		lambdaModel4:SetPos(Checkpoint4.Pos)
		lambdaModel4:Spawn()
		
	elseif game.GetMap() == "d1_eli_02" then
		TRIGGER_CHECKPOINT = {
			 Vector(-677, 864, -2676), Vector(-519, 779, -2566),
			 Vector(-525, 1186, -2681), Vector(-681, 1320, -2573),
			 Vector(-1905, 2007, -2726), Vector(-2056, 1851, -2592),
		}
		local Checkpoint1 = ents.Create("trigger_checkpoint")
		Checkpoint1.Min = Vector(-677, 864, -2676)
		Checkpoint1.Max = Vector(-519, 779, -2566)
		Checkpoint1.Pos = Vector(-519, 779, -2566) - ( ( Vector(-519, 779, -2566) - Vector(-677, 864, -2676)) / 2 )
		Checkpoint1.Point1 = Vector(-604, 639, -2623)
		Checkpoint1:SetPos(Checkpoint1.Pos)
		Checkpoint1:Spawn()
		
		local Checkpoint2 = ents.Create("trigger_checkpoint")
		Checkpoint2.Min = Vector(-525, 1186, -2681)
		Checkpoint2.Max = Vector(-681, 1320, -2573)
		Checkpoint2.Pos = Vector(-681, 1320, -2573) - ( ( Vector(-681, 1320, -2573) - Vector(-525, 1186, -2681)) / 2 )
		Checkpoint2.Point2 = Vector(-722, 1469, -2633)
		Checkpoint2:SetPos(Checkpoint2.Pos)
		Checkpoint2:Spawn()
		
		local Checkpoint3 = ents.Create("trigger_checkpoint")
		Checkpoint3.Min = Vector(-1905, 2007, -2726)
		Checkpoint3.Max = Vector(-2056, 1851, -2592)
		Checkpoint3.Pos = Vector(-2056, 1851, -2592) - ( ( Vector(-2056, 1851, -2592) - Vector(-1905, 2007, -2726)) / 2 )
		Checkpoint3.Point3 = Vector(-2331, 2092, -2671)
		Checkpoint3:SetPos(Checkpoint3.Pos)
		Checkpoint3:Spawn()
		
		lambdaModel1 = ents.Create("prop_dynamic")
		lambdaModel1:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel1:SetMaterial("models/player/shared/gold_player")
		lambdaModel1:SetPos(Checkpoint1.Pos)
		lambdaModel1:Spawn()
		
		lambdaModel2 = ents.Create("prop_dynamic")
		lambdaModel2:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel2:SetMaterial("models/player/shared/gold_player")
		lambdaModel2:SetPos(Checkpoint2.Pos)
		lambdaModel2:Spawn()
		
		lambdaModel3 = ents.Create("prop_dynamic")
		lambdaModel3:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel3:SetMaterial("models/player/shared/gold_player")
		lambdaModel3:SetPos(Checkpoint3.Pos)
		lambdaModel3:Spawn()
		
	elseif game.GetMap() == "d1_town_02" and file.Exists("hl2cr_data/d1_town_02.txt", "DATA") then
		TRIGGER_CHECKPOINT = {
			 Vector(-4522, 869, -3050), Vector(-4647, 957, -2914),
		}
		local Checkpoint1 = ents.Create("trigger_checkpoint")
		Checkpoint1.forcePlyTP = true
		Checkpoint1.Min = Vector(-4522, 869, -3050)
		Checkpoint1.Max = Vector(-4647, 957, -2914)
		Checkpoint1.Pos = Vector(-4647, 957, -2914) - ( ( Vector(-4647, 957, -2914) - Vector(-4522, 869, -3050)) / 2 )
		Checkpoint1.Point1 = Vector(-4712, 586, -3199)
		Checkpoint1:SetPos(Checkpoint1.Pos)
		Checkpoint1:Spawn()
		
		lambdaModel1 = ents.Create("prop_dynamic")
		lambdaModel1:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel1:SetMaterial("models/player/shared/gold_player")
		lambdaModel1:SetPos(Checkpoint1.Pos)
		lambdaModel1:Spawn()
		
	elseif game.GetMap() == "d1_town_02a" then
		TRIGGER_CHECKPOINT = {
			 Vector(-7539, -287, -3404), Vector(-7461, -150, -3279),
		}
		local Checkpoint1 = ents.Create("trigger_checkpoint")
		Checkpoint1.forcePlyTP = true
		Checkpoint1.Min = Vector(-7539, -287, -3404)
		Checkpoint1.Max = Vector(-7442, -155, -3275)
		Checkpoint1.Pos = Vector(-7442, -155, -3275) - ( ( Vector(-7442, -155, -3275) - Vector(-7539, -287, -3404)) / 2 )
		Checkpoint1.Point1 = Vector(-7412, -370, -3338)
		Checkpoint1:SetPos(Checkpoint1.Pos)
		Checkpoint1:Spawn()
				
		lambdaModel1 = ents.Create("prop_dynamic")
		lambdaModel1:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel1:SetMaterial("models/player/shared/gold_player")
		lambdaModel1:SetPos(Checkpoint1.Pos)
		lambdaModel1:Spawn()
				
	elseif game.GetMap() == "d1_town_05" then
		TRIGGER_CHECKPOINT = {
			 Vector(-1078, 10319, 901), Vector(-1156, 10377, 1007),
			 Vector(1714, 10868, 910), Vector(-1714, 10972, 1011),
		}
		local Checkpoint1 = ents.Create("trigger_checkpoint")
		Checkpoint1.forcePlyTP = true
		Checkpoint1.Min = Vector(-1078, 10319, 901)
		Checkpoint1.Max = Vector(-1156, 10377, 1007)
		Checkpoint1.Pos = Vector(-1156, 10377, 1007) - ( ( Vector(-1156, 10377, 1007) - Vector(-1078, 10319, 901)) / 2 )
		Checkpoint1.Point1 = Vector(-1227, 10663, 930)
		Checkpoint1:SetPos(Checkpoint1.Pos)
		Checkpoint1:Spawn()
		
		local Checkpoint2 = ents.Create("trigger_checkpoint")
		Checkpoint2.forcePlyTP = true
		Checkpoint2.Min = Vector(-1714, 10868, 910)
		Checkpoint2.Max = Vector(-1714, 10972, 1011)
		Checkpoint2.Pos = Vector(-1714, 10972, 1011) - ( ( Vector(-1714, 10972, 1011) - Vector(1714, 10868, 910)) / 2 )
		Checkpoint2.Point2 = Vector(-1699, 10887, 909)
		Checkpoint2:SetPos(Checkpoint2.Pos)
		Checkpoint2:Spawn()		
		
		lambdaModel1 = ents.Create("prop_dynamic")
		lambdaModel1:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel1:SetMaterial("models/player/shared/gold_player")
		lambdaModel1:SetPos(Checkpoint1.Pos)
		lambdaModel1:Spawn()
		
		lambdaModel2 = ents.Create("prop_dynamic")
		lambdaModel2:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel2:SetMaterial("models/player/shared/gold_player")
		lambdaModel2:SetPos(Checkpoint2.Pos)
		lambdaModel2:Spawn()
		
	elseif game.GetMap() == "d2_coast_11" then
		TRIGGER_CHECKPOINT = {
			 Vector(4548, 6434, 580), Vector(4145, 6676, 818),
			 Vector(5038, 10047, 172), Vector(4856, 9808, 314),
			 Vector(815, 11598, 507), Vector(755, 11476, 652),
		}
		local Checkpoint1 = ents.Create("trigger_checkpoint")
		Checkpoint1.forcePlyTP = true
		Checkpoint1.Min = Vector(4548, 6434, 580)
		Checkpoint1.Max = Vector(4145, 6676, 818)
		Checkpoint1.Pos = Vector(4145, 6676, 818) - ( ( Vector(4145, 6676, 818) - Vector(4548, 6434, 580)) / 2 )
		Checkpoint1.Point1 = Vector(4406, 6555, 655)
		Checkpoint1:SetPos(Checkpoint1.Pos)
		Checkpoint1:Spawn()

		local Checkpoint2 = ents.Create("trigger_checkpoint")
		Checkpoint2.forcePlyTP = true
		Checkpoint2.Min = Vector(5150, 10034, 172)
		Checkpoint2.Max = Vector(4856, 9808, 314)
		Checkpoint2.Pos = Vector(4856, 9808, 314) - ( ( Vector(4856, 9808, 314) - Vector(5038, 10047, 314)) / 2 )
		Checkpoint2.Point2 = Vector(4967, 9917, 233)
		Checkpoint2:SetPos(Checkpoint2.Pos)
		Checkpoint2:Spawn()
		
		local Checkpoint3 = ents.Create("trigger_checkpoint")
		Checkpoint3.Min = Vector(815, 11598, 507)
		Checkpoint3.Max = Vector(755, 11476, 652)
		Checkpoint3.Pos = Vector(755, 11476, 652) - ( ( Vector(755, 11476, 652) - Vector(815, 11598, 507)) / 2 )
		Checkpoint3.Point3 = Vector(315, 11606, 436)
		Checkpoint3:SetPos(Checkpoint3.Pos)
		Checkpoint3:Spawn()
		
		lambdaModel1 = ents.Create("prop_dynamic")
		lambdaModel1:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel1:SetMaterial("models/player/shared/gold_player")
		lambdaModel1:SetPos(Checkpoint1.Pos)
		lambdaModel1:Spawn()
		
		lambdaModel2 = ents.Create("prop_dynamic")
		lambdaModel2:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel2:SetMaterial("models/player/shared/gold_player")
		lambdaModel2:SetPos(Checkpoint2.Pos)
		lambdaModel2:Spawn()
		
		lambdaModel3 = ents.Create("prop_dynamic")
		lambdaModel3:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel3:SetMaterial("models/player/shared/gold_player")
		lambdaModel3:SetPos(Checkpoint3.Pos)
		lambdaModel3:Spawn()
		
	elseif game.GetMap() == "d2_coast_12" then
		TRIGGER_CHECKPOINT = {
			 Vector(2236, -317, 672), Vector(2055, -188, 815),
			 Vector(8521, 7965, 1041), Vector(8680, 7835, 1247),
		}
		local Checkpoint1 = ents.Create("trigger_checkpoint")
		Checkpoint1.Min = Vector(2236, -317, 672)
		Checkpoint1.Max = Vector(2055, -188, 815)
		Checkpoint1.Pos = Vector(2055, -188, 815) - ( ( Vector(2055, -188, 815) - Vector(2236, -317, 672)) / 2 )
		Checkpoint1.Point1 = Vector(2086, -77, 694)
		Checkpoint1:SetPos(Checkpoint1.Pos)
		Checkpoint1:Spawn()	
		
		lambdaModel1 = ents.Create("prop_dynamic")
		lambdaModel1:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel1:SetMaterial("models/player/shared/gold_player")
		lambdaModel1:SetPos(Checkpoint1.Pos)
		lambdaModel1:Spawn()
		
	elseif game.GetMap() == "d2_prison_01" then
		TRIGGER_CHECKPOINT = {
			 Vector(1156, -1410, 1602), Vector(1000, -1582, 1777),
		}
		local Checkpoint1 = ents.Create("trigger_checkpoint")
		Checkpoint1.forcePlyTP = true
		Checkpoint1.Min = Vector(1156, -1410, 1602)
		Checkpoint1.Max = Vector(1000, -1582, 1777)
		Checkpoint1.Pos = Vector(1000, -1582, 1777) - ( ( Vector(1000, -1582, 1777) - Vector(1156, -1410, 1602)) / 2 )
		Checkpoint1.Point1 = Vector(846, -1497, 1621)
		Checkpoint1:SetPos(Checkpoint1.Pos)
		Checkpoint1:Spawn()
		
		lambdaModel1 = ents.Create("prop_dynamic")
		lambdaModel1:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel1:SetMaterial("models/player/shared/gold_player")
		lambdaModel1:SetPos(Checkpoint1.Pos)
		lambdaModel1:Spawn()
		
	elseif game.GetMap() == "d2_prison_03" then
		TRIGGER_CHECKPOINT = {
			 Vector(-3395, 3390, 4), Vector(-3574, 3325, 191),
		}
		local Checkpoint1 = ents.Create("trigger_checkpoint")
		Checkpoint1.forcePlyTP = false
		Checkpoint1.Min = Vector(-3395, 3390, 4)
		Checkpoint1.Max = Vector(-3574, 3325, 191)
		Checkpoint1.Pos = Vector(-3574, 3325, 191) - ( ( Vector(-3574, 3325, 191) - Vector(-3395, 3390, 4)) / 2 )
		Checkpoint1.Point1 = Vector(-3515, 3524, 64)
		Checkpoint1:SetPos(Checkpoint1.Pos)
		Checkpoint1:Spawn()	
		
		lambdaModel1 = ents.Create("prop_dynamic")
		lambdaModel1:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel1:SetMaterial("models/player/shared/gold_player")
		lambdaModel1:SetPos(Checkpoint1.Pos)
		lambdaModel1:Spawn()
		
	elseif game.GetMap() == "d2_prison_05" then
		TRIGGER_CHECKPOINT = {
			 Vector(-3478, -468, 511), Vector(-3640, -665, 858),
		}
		local Checkpoint1 = ents.Create("trigger_checkpoint")
		Checkpoint1.forcePlyTP = true
		Checkpoint1.Min = Vector(-3478, -468, 511)
		Checkpoint1.Max = Vector(-3640, -665, 858)
		Checkpoint1.Pos = Vector(-3640, -665, 858) - ( ( Vector(-3640, -665, 858) - Vector(-3478, -468, 511)) / 2 )
		Checkpoint1.Point1 = Vector(-3797, -557, 523)
		Checkpoint1:SetPos(Checkpoint1.Pos)
		Checkpoint1:Spawn()
		
		lambdaModel1 = ents.Create("prop_dynamic")
		lambdaModel1:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel1:SetMaterial("models/player/shared/gold_player")
		lambdaModel1:SetPos(Checkpoint1.Pos)
		lambdaModel1:Spawn()
		
	elseif game.GetMap() == "d2_prison_06" then
		TRIGGER_CHECKPOINT = {
			 Vector(1614, 749, -186), Vector(1487, 609, -67),
			 Vector(428, 49, 2), Vector(506, 172, 130),
			 Vector(357, -132, 6), Vector(357, -132, 6),
		}
		local Checkpoint1 = ents.Create("trigger_checkpoint")
		Checkpoint1.forcePlyTP = true
		Checkpoint1.Min = Vector(1614, 749, -186)
		Checkpoint1.Max = Vector(1487, 609, -67)
		Checkpoint1.Pos = Vector(1487, 609, -67) - ( ( Vector(1487, 609, -67) - Vector(1614, 749, -186)) / 2 )
		Checkpoint1.Point1 = Vector(1563, 673, -176)
		Checkpoint1:SetPos(Checkpoint1.Pos)
		Checkpoint1:Spawn()
		
		local Checkpoint2 = ents.Create("trigger_checkpoint")
		Checkpoint2.forcePlyTP = true
		Checkpoint2.Min = Vector(428, 49, 2)
		Checkpoint2.Max = Vector(506, 172, 130)
		Checkpoint2.Pos = Vector(506, 172, 130) - ( ( Vector(506, 172, 130) - Vector(428, 49, 2)) / 2 )
		Checkpoint2.Point2 = Vector(569, 99, 16)
		Checkpoint2:SetPos(Checkpoint2.Pos)
		Checkpoint2:Spawn()
		
		local Checkpoint3 = ents.Create("trigger_checkpoint")
		Checkpoint3.forcePlyTP = true
		Checkpoint3.Min = Vector(357, -132, 6)
		Checkpoint3.Max = Vector(269, -217, 122)
		Checkpoint3.Pos = Vector(269, -217, 122) - ( ( Vector(269, -217, 122) - Vector(357, -132, 6)) / 2 )
		Checkpoint3.Point3 = Vector(315, -433, 0)
		Checkpoint3:SetPos(Checkpoint3.Pos)
		Checkpoint3:Spawn()
		
		lambdaModel1 = ents.Create("prop_dynamic")
		lambdaModel1:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel1:SetMaterial("models/player/shared/gold_player")
		lambdaModel1:SetPos(Checkpoint1.Pos)
		lambdaModel1:Spawn()
		
		lambdaModel2 = ents.Create("prop_dynamic")
		lambdaModel2:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel2:SetMaterial("models/player/shared/gold_player")
		lambdaModel2:SetPos(Checkpoint2.Pos)
		lambdaModel2:Spawn()
		
		lambdaModel3 = ents.Create("prop_dynamic")
		lambdaModel3:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel3:SetMaterial("models/player/shared/gold_player")
		lambdaModel3:SetPos(Checkpoint3.Pos)
		lambdaModel3:Spawn()
		
	elseif game.GetMap() == "d2_prison_07" then
		TRIGGER_CHECKPOINT = {
			 Vector(1604, -3354, -678), Vector(1434, -3268, -493),
			 Vector(4333, -3907, -539), Vector(3988, -4088, -418),
		}
		local Checkpoint1 = ents.Create("trigger_checkpoint")
		Checkpoint1.forcePlyTP = false
		Checkpoint1.Min = Vector(1604, -3354, -678)
		Checkpoint1.Max = Vector(1434, -3268, -493)
		Checkpoint1.Pos = Vector(1434, -3268, -493) - ( ( Vector(1434, -3268, -493) - Vector(1604, -3354, -678)) / 2 )
		Checkpoint1.Point1 = Vector(1727, -3308, -663)
		Checkpoint1:SetPos(Checkpoint1.Pos)
		Checkpoint1:Spawn()
		
		local Checkpoint2 = ents.Create("trigger_checkpoint")
		Checkpoint2.forcePlyTP = true
		Checkpoint2.Min = Vector(4333, -3907, -539)
		Checkpoint2.Max = Vector(3988, -4088, -418)
		Checkpoint2.Pos = Vector(3988, -4088, -418) - ( ( Vector(3988, -4088, -418) - Vector(4333, -3907, -539)) / 2 )
		Checkpoint2.Point2 = Vector(4153, -3977, -528)
		Checkpoint2:SetPos(Checkpoint2.Pos)
		Checkpoint2:Spawn()	
		
		lambdaModel1 = ents.Create("prop_dynamic")
		lambdaModel1:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel1:SetMaterial("models/player/shared/gold_player")
		lambdaModel1:SetPos(Checkpoint1.Pos)
		lambdaModel1:Spawn()
		
		lambdaModel2 = ents.Create("prop_dynamic")
		lambdaModel2:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel2:SetMaterial("models/player/shared/gold_player")
		lambdaModel2:SetPos(Checkpoint2.Pos)
		lambdaModel2:Spawn()
		
	elseif game.GetMap() == "d2_prison_08" then
		TRIGGER_CHECKPOINT = {
			 Vector(-467, 685, 933), Vector(-371, 603, 1081),
			 Vector(-253, 645, 929), Vector(-168, 453, 1138),
			 Vector(97, 23, 1181), Vector(150, -18, 1229),
		}
		local Checkpoint1 = ents.Create("trigger_checkpoint")
		Checkpoint1.forcePlyTP = false
		Checkpoint1.Min = Vector(-467, 685, 933)
		Checkpoint1.Max = Vector(-371, 603, 1081)
		Checkpoint1.Pos = Vector(-371, 603, 1081) - ( ( Vector(-371, 603, 1081) - Vector(-467, 685, 933)) / 2 )
		Checkpoint1.Point1 = Vector(-474, 518, 941)
		Checkpoint1:SetPos(Checkpoint1.Pos)
		Checkpoint1:Spawn()
		
		local Checkpoint2 = ents.Create("trigger_checkpoint")
		Checkpoint2.forcePlyTP = true
		Checkpoint2.Min = Vector(-253, 645, 929)
		Checkpoint2.Max = Vector(-168, 453, 1138)
		Checkpoint2.Pos = Vector(-168, 453, 1138) - ( ( Vector(-168, 453, 1138) - Vector(-253, 645, 929)) / 2 )
		Checkpoint2.Point2 = Vector(131, 300, 1003)
		Checkpoint2:SetPos(Checkpoint2.Pos)
		Checkpoint2:Spawn()
		
		local Checkpoint3 = ents.Create("trigger_checkpoint")
		Checkpoint3.forcePlyTP = true
		Checkpoint3.Min = Vector(97, 23, 1181)
		Checkpoint3.Max = Vector(150, -18, 1229)
		Checkpoint3.Pos = Vector(150, -18, 1229) - ( ( Vector(150, -18, 1229) - Vector(97, 23, 1181)) / 2 )
		Checkpoint3.Point3 = Vector(128, 28, 1224)
		Checkpoint3:SetPos(Checkpoint3.Pos)
		Checkpoint3:Spawn()
		
		lambdaModel1 = ents.Create("prop_dynamic")
		lambdaModel1:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel1:SetMaterial("models/player/shared/gold_player")
		lambdaModel1:SetPos(Checkpoint1.Pos)
		lambdaModel1:Spawn()
		
		lambdaModel2 = ents.Create("prop_dynamic")
		lambdaModel2:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel2:SetMaterial("models/player/shared/gold_player")
		lambdaModel2:SetPos(Checkpoint2.Pos)
		lambdaModel2:Spawn()
		
		lambdaModel3 = ents.Create("prop_dynamic")
		lambdaModel3:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel3:SetMaterial("models/player/shared/gold_player")
		lambdaModel3:SetPos(Checkpoint3.Pos)
		lambdaModel3:Spawn()
		
	elseif game.GetMap() == "d3_c17_01" then
		TRIGGER_CHECKPOINT = {
			 Vector(-7047, -1500, 9), Vector(-7028, -1295, 123),
			 Vector(-6543, -1079, 6), Vector(-6366, -925, 164),
		}
		local Checkpoint1 = ents.Create("trigger_checkpoint")
		Checkpoint1.forcePlyTP = true
		Checkpoint1.Min = Vector(-7047, -1500, 9)
		Checkpoint1.Max = Vector(-7028, -1295, 123)
		Checkpoint1.Pos = Vector(-7028, -1295, 123) - ( ( Vector(-7028, -1295, 123) - Vector(-7047, -1500, 9)) / 2 )
		Checkpoint1.Point1 = Vector(-6841, -1384, 13)
		Checkpoint1:SetPos(Checkpoint1.Pos)
		Checkpoint1:Spawn()
		
		local Checkpoint2 = ents.Create("trigger_checkpoint")
		Checkpoint2.forcePlyTP = true
		Checkpoint2.Min = Vector(-6543, -1079, 6)
		Checkpoint2.Max = Vector(-6366, -925, 164)
		Checkpoint2.Pos = Vector(-6366, -925, 164) - ( ( Vector(-6366, -925, 164) - Vector(-6543, -1079, 6)) / 2 )
		Checkpoint2.Point2 = Vector(-6476, -918, 11)
		Checkpoint2:SetPos(Checkpoint2.Pos)
		Checkpoint2:Spawn()
		
		lambdaModel1 = ents.Create("prop_dynamic")
		lambdaModel1:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel1:SetMaterial("models/player/shared/gold_player")
		lambdaModel1:SetPos(Checkpoint1.Pos)
		lambdaModel1:Spawn()
		
		lambdaModel2 = ents.Create("prop_dynamic")
		lambdaModel2:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel2:SetMaterial("models/player/shared/gold_player")
		lambdaModel2:SetPos(Checkpoint2.Pos)
		lambdaModel2:Spawn()
		
	elseif game.GetMap() == "d3_c17_02" then
		TRIGGER_CHECKPOINT = {
			 Vector(-5586, -5702, 0), Vector(-5478, -5565, 150),
		}
		local Checkpoint1 = ents.Create("trigger_checkpoint")
		Checkpoint1.forcePlyTP = true
		Checkpoint1.Min = Vector(-5586, -5702, 0)
		Checkpoint1.Max = Vector(-5478, -5565, 150)
		Checkpoint1.Pos = Vector(-5478, -5565, 150) - ( ( Vector(-5478, -5565, 150) - Vector(-5586, -5702, 0)) / 2 )
		Checkpoint1.Point1 = Vector(-5449, -5753, 22)
		Checkpoint1:SetPos(Checkpoint1.Pos)
		Checkpoint1:Spawn()
		
		lambdaModel1 = ents.Create("prop_dynamic")
		lambdaModel1:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel1:SetMaterial("models/player/shared/gold_player")
		lambdaModel1:SetPos(Checkpoint1.Pos)
		lambdaModel1:Spawn()
		
	elseif game.GetMap() == "d3_c17_06a" then
		TRIGGER_CHECKPOINT = {
			 Vector(3002, 2404, -310), Vector(2882, 2506, -169),
		}
		local Checkpoint1 = ents.Create("trigger_checkpoint")
		Checkpoint1.forcePlyTP = true
		Checkpoint1.Min = Vector(3002, 2404, -310)
		Checkpoint1.Max = Vector(2882, 2506, -169)
		Checkpoint1.Pos = Vector(2882, 2506, -169) - ( ( Vector(2882, 2506, -169) - Vector(3002, 2404, -310)) / 2 )
		Checkpoint1.Point1 = Vector(2751, 2763, -301)
		Checkpoint1:SetPos(Checkpoint1.Pos)
		Checkpoint1:Spawn()
		
		lambdaModel1 = ents.Create("prop_dynamic")
		lambdaModel1:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel1:SetMaterial("models/player/shared/gold_player")
		lambdaModel1:SetPos(Checkpoint1.Pos)
		lambdaModel1:Spawn()
		
	elseif game.GetMap() == "d3_c17_07" then
		TRIGGER_CHECKPOINT = {
			 Vector(5520, 1383, 0), Vector(5525, 1432, 109),
			 Vector(7275, 1282, 3), Vector(7499, 1788, 270),
		}
		local Checkpoint1 = ents.Create("trigger_checkpoint")
		Checkpoint1.forcePlyTP = true
		Checkpoint1.Min = Vector(5520, 1383, 0)
		Checkpoint1.Max = Vector(5525, 1432, 109)
		Checkpoint1.Pos = Vector(5525, 1432, 109) - ( ( Vector(5525, 1432, 109) - Vector(5520, 1383, 0)) / 2 )
		Checkpoint1.Point1 = Vector(6585, 1531, 19)
		Checkpoint1:SetPos(Checkpoint1.Pos)
		Checkpoint1:Spawn()
	
		local Checkpoint2 = ents.Create("trigger_checkpoint")
		Checkpoint2.forcePlyTP = true
		Checkpoint2.Min = Vector(7275, 1282, 3)
		Checkpoint2.Max = Vector(7499, 1788, 270)
		Checkpoint2.Pos = Vector(7499, 1788, 270) - ( ( Vector(7499, 1788, 270) - Vector(7275, 1282, 3)) / 2 )
		Checkpoint2.Point2 = Vector(7840, 1531, 6)
		Checkpoint2:SetPos(Checkpoint2.Pos)
		Checkpoint2:Spawn()
		
		lambdaModel1 = ents.Create("prop_dynamic")
		lambdaModel1:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel1:SetMaterial("models/player/shared/gold_player")
		lambdaModel1:SetPos(Checkpoint1.Pos)
		lambdaModel1:Spawn()
		
		lambdaModel2 = ents.Create("prop_dynamic")
		lambdaModel2:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel2:SetMaterial("models/player/shared/gold_player")
		lambdaModel2:SetPos(Checkpoint2.Pos)
		lambdaModel2:Spawn()
		
	elseif game.GetMap() == "d3_c17_08" then
		TRIGGER_CHECKPOINT = {
			 Vector(1310, -754, -320), Vector(1220, -682, -225),
		}
		local Checkpoint1 = ents.Create("trigger_checkpoint")
		Checkpoint1.forcePlyTP = true
		Checkpoint1.Min = Vector(1310, -754, -320)
		Checkpoint1.Max = Vector(1220, -682, -225)
		Checkpoint1.Pos = Vector(1220, -682, -225) - ( ( Vector(1220, -682, -225) - Vector(1310, -754, -320)) / 2 )
		Checkpoint1.Point1 = Vector(1473, -596, -377)
		Checkpoint1:SetPos(Checkpoint1.Pos)
		Checkpoint1:Spawn()
	
	elseif game.GetMap() == "d3_c17_10a" then
		TRIGGER_CHECKPOINT = {
			 Vector(-2451, 8321, 130), Vector(-2579, 8441, 245),
		}
		local Checkpoint1 = ents.Create("trigger_checkpoint")
		Checkpoint1.forcePlyTP = true
		Checkpoint1.Min = Vector(-2451, 8321, 130)
		Checkpoint1.Max = Vector(-2579, 8441, 245)
		Checkpoint1.Pos = Vector(-2579, 8441, 245) - ( ( Vector(-2579, 8441, 245) - Vector(-2451, 8321, 130)) / 2 )
		Checkpoint1.Point1 = Vector(-2817, 8090, 143)
		Checkpoint1:SetPos(Checkpoint1.Pos)
		Checkpoint1:Spawn()
		
		lambdaModel1 = ents.Create("prop_dynamic")
		lambdaModel1:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel1:SetMaterial("models/player/shared/gold_player")
		lambdaModel1:SetPos(Checkpoint1.Pos)
		lambdaModel1:Spawn()

	elseif game.GetMap() == "d3_c17_13" then
		TRIGGER_CHECKPOINT = {
			 Vector(5009, 255, 258), Vector(5207, 338, 419),
		}
		local Checkpoint1 = ents.Create("trigger_checkpoint")
		Checkpoint1.forcePlyTP = true
		Checkpoint1.Min = Vector(5009, 255, 258)
		Checkpoint1.Max = Vector(5207, 338, 419)
		Checkpoint1.Pos = Vector(5207, 338, 419) - ( ( Vector(5207, 338, 419) - Vector(5009, 255, 258)) / 2 )
		Checkpoint1.Point1 = Vector(5179, 1042, 20)
		Checkpoint1:SetPos(Checkpoint1.Pos)
		Checkpoint1:Spawn()
		
		lambdaModel1 = ents.Create("prop_dynamic")
		lambdaModel1:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel1:SetMaterial("models/player/shared/gold_player")
		lambdaModel1:SetPos(Checkpoint1.Pos)
		lambdaModel1:Spawn()
		
	elseif game.GetMap() == "d3_citadel_01" then
		TRIGGER_CHECKPOINT = {
			 Vector(10545, 4302, -1774), Vector(10484, 4156, -1603),
		}
		local Checkpoint1 = ents.Create("trigger_checkpoint")
		Checkpoint1.forcePlyTP = true
		Checkpoint1.Min = Vector(10545, 4302, -1774)
		Checkpoint1.Max = Vector(10484, 4156, -1603)
		Checkpoint1.Pos = Vector(10484, 4156, -1603) - ( ( Vector(10484, 4156, -1603) - Vector(10545, 4302, -1774)) / 2 )
		Checkpoint1.Point1 = Vector(10201, 4225, -1779)
		Checkpoint1:SetPos(Checkpoint1.Pos)
		Checkpoint1:Spawn()
		
		lambdaModel1 = ents.Create("prop_dynamic")
		lambdaModel1:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel1:SetMaterial("models/player/shared/gold_player")
		lambdaModel1:SetPos(Checkpoint1.Pos)
		lambdaModel1:Spawn()
		
	elseif game.GetMap() == "d3_citadel_04" then
		TRIGGER_CHECKPOINT = {
			 Vector(435, 640, 2793), Vector(68, 974, 3087),
			 Vector(459, 639, 4123), Vector(74, 1016, 4600),
			 Vector(445, 252, 6403), Vector(72, 31, 6655),
		}
		local Checkpoint1 = ents.Create("trigger_checkpoint")
		Checkpoint1.forcePlyTP = true
		Checkpoint1.Min = Vector(435, 640, 2793)
		Checkpoint1.Max = Vector(68, 974, 3087)
		Checkpoint1.Pos = Vector(68, 974, 3087) - ( ( Vector(68, 974, 3087) - Vector(435, 640, 2793)) / 2 )
		Checkpoint1.Point1 = Vector(264, 837, 2853)
		Checkpoint1:SetPos(Checkpoint1.Pos)
		Checkpoint1:Spawn()
		
		local Checkpoint2 = ents.Create("trigger_checkpoint")
		Checkpoint2.forcePlyTP = true
		Checkpoint2.Min = Vector(459, 639, 4123)
		Checkpoint2.Max = Vector(74, 1016, 4600)
		Checkpoint2.Pos = Vector(74, 1016, 4600) - ( ( Vector(74, 1016, 4600) - Vector(459, 639, 4123)) / 2 )
		Checkpoint2.Point2 = Vector(240, 825, 4186)
		Checkpoint2:SetPos(Checkpoint2.Pos)
		Checkpoint2:Spawn()
		
		local Checkpoint3 = ents.Create("trigger_checkpoint")
		Checkpoint3.forcePlyTP = false
		Checkpoint3.Min = Vector(445, 252, 6403)
		Checkpoint3.Max = Vector(72, 31, 6655)
		Checkpoint3.Pos = Vector(72, 31, 6655) - ( ( Vector(72, 31, 6655) - Vector(445, 252, 6403)) / 2 )
		Checkpoint3.Point3 = Vector(236, -245, 6422)
		Checkpoint3:SetPos(Checkpoint3.Pos)
		Checkpoint3:Spawn()
		
		lambdaModel1 = ents.Create("prop_dynamic")
		lambdaModel1:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel1:SetMaterial("models/player/shared/gold_player")
		lambdaModel1:SetPos(Checkpoint1.Pos)
		lambdaModel1:Spawn()
		
		lambdaModel2 = ents.Create("prop_dynamic")
		lambdaModel2:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel2:SetMaterial("models/player/shared/gold_player")
		lambdaModel2:SetPos(Checkpoint2.Pos)
		lambdaModel2:Spawn()
		
		lambdaModel3 = ents.Create("prop_dynamic")
		lambdaModel3:SetModel("models/hl2cr_lambda.mdl")
		lambdaModel3:SetMaterial("models/player/shared/gold_player")
		lambdaModel3:SetPos(Checkpoint3.Pos)
		lambdaModel3:Spawn()
		
	end
end
