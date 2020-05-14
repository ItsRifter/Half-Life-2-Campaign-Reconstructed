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
			fix4:SetPos(Vector(3987, -4444, 1155))
			fix4:SetAngles(Angle(0, 180, 0))
		end
	end
	
	if game.GetMap() == "d1_town_03" and not file.Exists("hl2c_data/d1_town_02", "DATA") then 
		file.Write("hl2c_data/d1_town_02.txt", "Map checker please don't delete this file")
	end
	if game.GetMap() == "d1_town_02" and file.Exists("hl2c_data/d1_town_02.txt", "DATA") then 
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
	if game.GetMap() == "d1_trainstation_03" and file.Exists("hl2c_data/babydoll.txt", "DATA") then
		dollAch:SetPos(Vector(-5177, -4719, 64))
		dollAch:Spawn()
		file.Delete("hl2c_data/babydoll.txt")
	elseif game.GetMap() == "d1_trainstation_04" and file.Exists("hl2c_data/babydoll2.txt", "DATA") then
		dollAch:SetPos(Vector(-3367, -3410, 628))
		dollAch:Spawn()
		file.Delete("hl2c_data/babydoll2.txt")
	elseif game.GetMap() == "d1_trainstation_05" and file.Exists("hl2c_data/babydoll3.txt", "DATA") then
		dollAch:SetPos(Vector(-5833, -927, 128))
		dollAch:Spawn()
		file.Delete("hl2c_data/babydoll3.txt")
	else
		dollAch:Remove()
	end
	
	--Ball achievement ravenholm
	local ballAch = ents.Create("prop_physics")
	ballAch:SetModel("models/Roller.mdl")
	if game.GetMap() == "d1_town_01" and file.Exists("hl2c_data/ravenball1.txt", "DATA") then
		ballAch:SetPos(Vector(4672, -2222, -3718))
		ballAch:Spawn()
		file.Delete("hl2c_data/ravenball1.txt")
	elseif game.GetMap() == "d1_town_01a" and file.Exists("hl2c_data/ravenball2.txt", "DATA") then
		ballAch:SetPos(Vector(174, 177, -3263))
		ballAch:Spawn()
		file.Delete("hl2c_data/ravenball2.txt")
	elseif game.GetMap() == "d1_town_02" and not file.Exists("hl2c_data/d1_town_02.txt", "DATA") and file.Exists("hl2c_data/ravenball3.txt", "DATA") then
		ballAch:SetPos(Vector(-955, 884, -3375))
		ballAch:Spawn()
		file.Delete("hl2c_data/ravenball3.txt")
	elseif game.GetMap() == "d1_town_03" and file.Exists("hl2c_data/ravenball4.txt", "DATA") then
		ballAch:SetPos(Vector(-3554, -725, -3519))
		ballAch:Spawn()
		file.Delete("hl2c_data/ravenball4.txt")
	elseif game.GetMap() == "d1_town_02" and file.Exists("hl2c_data/d1_town_02.txt", "DATA") and file.Exists("hl2c_data/ravenball5.txt", "DATA") then
		ballAch:SetPos(Vector(-3587, 260, -3391))
		ballAch:Spawn()
		file.Delete("hl2c_data/ravenball5.txt")
	elseif game.GetMap() == "d1_town_02a" and file.Exists("hl2c_data/ravenball6.txt", "DATA") then
		ballAch:SetPos(Vector(-5361, 2333, -3218))
		ballAch:Spawn()
		file.Delete("hl2c_data/ravenball6.txt")
	elseif game.GetMap() == "d1_town_04" and file.Exists("hl2c_data/ravenball7.txt", "DATA") then
		ballAch:SetPos(Vector(818, -1190, -3583))
		ballAch:Spawn()
		file.Delete("hl2c_data/ravenball7.txt")
	else
		ballAch:Remove()
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
		file.Delete("hl2c_data/d1_town_02.txt")
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

	SetCheckpointsStage()
	
end

hook.Add("InitPostEntity", "SetupMapLua", SetupMap)
hook.Add("PostCleanupMap", "SetupMapLua", SetupMap)

hook.Add("UpdateBaby", "Babys", function()
	
	if game.GetMap() == "d1_trainstation_02" then
		file.Write("hl2c_data/babydoll.txt", "Please leave this file alone unless you wanna disrupt someones achievement")
	elseif game.GetMap() == "d1_trainstation_03" then
		file.Write("hl2c_data/babydoll2.txt", "Why are you back here?")
	elseif game.GetMap() == "d1_trainstation_04" then
		file.Write("hl2c_data/babydoll3.txt", "Secret: Sponer has plans for pet upgrades")
	end
end)

hook.Add("UpdateBall", "ravenball", function()
	
	if game.GetMap() == "d1_eli_02" then
		file.Write("hl2c_data/ravenball1.txt", "Please leave this file alone unless you wanna disrupt someones achievement")
	elseif game.GetMap() == "d1_town_01" then
		file.Write("hl2c_data/ravenball2.txt", "Why are you reading this?")
	elseif game.GetMap() == "d1_town_01a" then
		file.Write("hl2c_data/ravenball3.txt", "Stop coming back to read this")
	elseif game.GetMap() == "d1_town_02" and not file.Exists("hl2c_data/d1_town_02.txt", "DATA") then
		file.Write("hl2c_data/ravenball4.txt", "Can you please stop coming back?")
	elseif game.GetMap() == "d1_town_03" then
		file.Write("hl2c_data/ravenball5.txt", "Stop reading me!")
	elseif game.GetMap() == "d1_town_02" and file.Exists("hl2c_data/d1_town_02.txt", "DATA") then
		file.Write("hl2c_data/ravenball6.txt", "God damn you are a madlad")
	elseif game.GetMap() == "d1_town_02a" then
		file.Write("hl2c_data/ravenball7.txt", "Easter egg?")
	elseif game.GetMap() == "d1_town_04" then
		file.Delete("hl2c_data/RavenBall8.txt")
		for k, v in pairs(player.GetAll()) do
			Achievement(v, "RavenBall", "HL2_Ach_List", 2500)	
		end
	end
end)
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
		Achievement(v, "Gravgun", "HL2_Ach_List", 250)
		v:ChatPrint("Gravity gun is now enabled")
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
		"d3_citadel_02",
		"d3_citadel_03",
		"d3_citadel_04",
		"d3_citadel_05",
		"d3_breen_01",
		"hl2c_lobby_remake"
	}
	for k = 1, #HL2 do
		if (map == HL2[k]) and not (map == "d1_town_02" and not map == "d2_coast_07") then
			RunConsoleCommand("changelevel", HL2[k+1])
		elseif map == "d1_town_02" and not file.Exists("hl2c_data/d1_town_02.txt", "DATA") or not map == "d2_coast_07" then
			RunConsoleCommand("changelevel", "d1_town_03")
		elseif map == "d1_town_02" and file.Exists("hl2c_data/d1_town_02.txt", "DATA") or not map == "d2_coast_07" then
			RunConsoleCommand("changelevel", "d1_town_02a")
		elseif map == "d2_coast_07" and not file.Exists("hl2c_data/d2_coast_07.txt", "DATA") or not map == "d1_town_02" then
			RunConsoleCommand("changelevel", "d2_coast_08")
		elseif map == "d2_coast_08" and file.Exists("hl2c_data/d2_coast_07.txt", "DATA") or not map == "d1_town_02" then
			RunConsoleCommand("changelevel", "d2_coast_07")
		end
	end
end)

hook.Add("PlayerSpawn", "GiveWeapons", function(ply)
	ply.givenWeapons = {}
end)

hook.Add("Think", "MapWeapons", function()
	for _, p in pairs(player.GetAll()) do
		if not p:Alive() or p:Team() != TEAM_ALIVE then
			return
		end
		
		for _, pl2 in pairs(player.GetAll()) do
			if p != pl2 and pl2:Alive() and !p:InVehicle() and !pl2:InVehicle() and pl2:GetActiveWeapon():IsValid()
			and !p:HasWeapon(pl2:GetActiveWeapon():GetClass()) 
			and !table.HasValue(p.givenWeapons, pl2:GetActiveWeapon():GetClass()) and pl2:GetActiveWeapon():GetClass() != "weapon_physgun" then
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
		Checkpoint1.Min = Vector(-9533, -2564, 22)
		Checkpoint1.Max = Vector(-9343, -2405, 121)
		Checkpoint1.Pos = Vector(-9343, -2405, 121) - ( ( Vector(-9343, -2405, 121) - Vector(-9533, -2564, 22)) / 2 )
		Checkpoint1.Point1 = Vector( -8954, -2316, 50)
		Checkpoint1:SetPos(Checkpoint1.Pos)
		Checkpoint1:Spawn()
		
		local Checkpoint2 = ents.Create("trigger_checkpoint")
		Checkpoint2.Min = Vector(-5211, -1932, -22)
		Checkpoint2.Max = Vector(-5501, -2015, 157)
		Checkpoint2.Pos = Vector(-5501, -2015, 157) - ( ( Vector(-5501, -2015, 157) - Vector(-5211, -1932, -22)) / 2 )
		Checkpoint2.Point2 = Vector(-5262, -2105, 12)
		Checkpoint2:SetPos(Checkpoint2.Pos)
		Checkpoint2:Spawn()
		
		local Checkpoint3 = ents.Create("trigger_checkpoint")
		Checkpoint3.Min = Vector(-4170, -589, -13)
		Checkpoint3.Max = Vector(-4320, -531, 99)
		Checkpoint3.Pos = Vector(-4320, -531, 99) - ( ( Vector(-4320, -531, 99) - Vector(-4170, -589, -13)) / 2 )
		Checkpoint3.Point3 = Vector(-4208, -522, -10)
		Checkpoint3:SetPos(Checkpoint3.Pos)
		Checkpoint3:Spawn()
		
		local Checkpoint4 = ents.Create("trigger_checkpoint")
		Checkpoint4.Min = Vector(-3476, -442, -25)
		Checkpoint4.Max = Vector(-3601, -289, 76)
		Checkpoint4.Pos = Vector(-3601, -289, 76) - ( ( Vector(-3601, -289, 76) - Vector(-3476, -442, -25)) / 2 )
		Checkpoint4.Point4 = Vector(-3461, -278, -23)
		Checkpoint4:SetPos(Checkpoint4.Pos)
		Checkpoint4:Spawn()
		
		local Checkpoint5 = ents.Create("trigger_checkpoint")
		Checkpoint5.Min = Vector(-3277, -118, -25)
		Checkpoint5.Max = Vector(-3448, -19, 64)
		Checkpoint5.Pos = Vector(-3448, -19, 64) - ( ( Vector(-3448, -19, 64) - Vector(-3277, -118, -25)) / 2 )
		Checkpoint5.Point5 = Vector(-3503, 31, 32)
		Checkpoint5:SetPos(Checkpoint5.Pos)
		Checkpoint5:Spawn()

	elseif game.GetMap() == "d1_trainstation_03" then

		TRIGGER_CHECKPOINT = {
			Vector( -5002, -4710, 522 ), Vector( -4899, -4821, 630 ), 
		}
		
		local Checkpoint1 = ents.Create("trigger_checkpoint")
		Checkpoint1.Min = Vector(-5002, -4710, 522)
		Checkpoint1.Max = Vector(-4899, -4821, 630)
		Checkpoint1.Pos = Vector(-4899, -4821, 630) - ( ( Vector(-4899, -4821, 630) - Vector(-5002, -4710, 522)) / 2 )
		Checkpoint1.Point1 = Vector(-4964, -4824, 518)
		Checkpoint1:SetPos(Checkpoint1.Pos)
		Checkpoint1:Spawn()
		
	elseif game.GetMap() == "d1_trainstation_04" then
		TRIGGER_CHECKPOINT = {
			Vector(-6861, -4255, 543), Vector(-7102, -4104, 670),
			Vector( -7638, -4026, -253 ), Vector( -7653, -3879, -143 ),
		}
		local Checkpoint1 = ents.Create("trigger_checkpoint")
		Checkpoint1.Min = Vector(-6861, -4255, 543)
		Checkpoint1.Max = Vector(-7102, -4104, 670)
		Checkpoint1.Pos = Vector(-7102, -4104, 670) - ( ( Vector(-7102, -4104, 670) - Vector(-6861, -4255, 543)) / 2 )
		Checkpoint1.Point1 = Vector(-7031, -4004, 584)
		Checkpoint1:SetPos(Checkpoint1.Pos)
		Checkpoint1:Spawn()
		
		local Checkpoint2 = ents.Create("trigger_checkpoint")
		Checkpoint2.Min = Vector(-7638, -4026, -253)
		Checkpoint2.Max = Vector(-7653, -3879, -143)
		Checkpoint2.Pos = Vector(-7653, -3879, -143) - ( ( Vector(-7545, -3882, -158) - Vector(-7653, -3879, -143)) / 2 )
		Checkpoint2.Point2 = Vector(-7485, -4141, -236)
		Checkpoint2:SetPos(Checkpoint2.Pos)
		Checkpoint2:Spawn()
		
		local Checkpoint3 = ents.Create("trigger_checkpoint")
		Checkpoint3.Min = Vector(-7882, -4154, -248)
		Checkpoint3.Max = Vector(-7817, -4106, -170)
		Checkpoint3.Pos = Vector(-7882, -4154, -248) - ( ( Vector(-7882, -4154, -248) - Vector(-7817, -4106, -170)) / 2 )
		Checkpoint3.Point3 = Vector(-7864, -4125, -242)
		Checkpoint3:SetPos(Checkpoint3.Pos)
		Checkpoint3:Spawn()
		
	elseif game.GetMap() == "d1_trainstation_05" then
		TRIGGER_CHECKPOINT = {
			 Vector(-6526, -1120, 17), Vector(-6421, -1203, 119),
			 Vector(-7073, -1325, 14), Vector(-7252, -1457, 116),
		}
		local Checkpoint1 = ents.Create("trigger_checkpoint")
		Checkpoint1.Min = Vector(-6526, -1120, 17)
		Checkpoint1.Max = Vector(-6421, -1203, 119)
		Checkpoint1.Pos = Vector(-6421, -1203, 119) - ( ( Vector(-6421, -1203, 119) - Vector(-6526, -1120, 17)) / 2 )
		Checkpoint1.Point1 = Vector(-6534, -1458, 64)
		Checkpoint1:SetPos(Checkpoint1.Pos)
		Checkpoint1:Spawn()
		
		local Checkpoint2 = ents.Create("trigger_checkpoint")
		Checkpoint2.Min = Vector(-7073, -1325, 14)
		Checkpoint2.Max = Vector(-7252, -1457, 116)
		Checkpoint2.Pos = Vector(-7252, -1457, 116) - ( ( Vector(-7252, -1457, 116) - Vector(-7073, -1325, 14)) / 2 )
		Checkpoint2.Point2 = Vector(-7170, -1389, 64)
		Checkpoint2:SetPos(Checkpoint2.Pos)
		Checkpoint2:Spawn()
		
	elseif game.GetMap() == "d1_canals_01" then
		TRIGGER_CHECKPOINT = {
			 Vector(707, 2727, -87), Vector(758, 2756, -0),
		}
		local Checkpoint1 = ents.Create("trigger_checkpoint")
		Checkpoint1.Min = Vector(707, 2727, -87)
		Checkpoint1.Max = Vector(758, 2756, -0)
		Checkpoint1.Pos = Vector(758, 2756, -0) - ( ( Vector(758, 2756, -0) - Vector(707, 2727, -87)) / 2 )
		Checkpoint1.Point1 = Vector(512, 2882, -31)
		Checkpoint1:SetPos(Checkpoint1.Pos)
		Checkpoint1:Spawn()
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
		
	elseif game.GetMap() == "d1_town_02" and file.Exists("hl2c_data/d1_town_02.txt", "DATA") then
		TRIGGER_CHECKPOINT = {
			 Vector(-4522, 869, -3050), Vector(-4647, 957, -2914),
		}
		local Checkpoint1 = ents.Create("trigger_checkpoint")
		Checkpoint1.Min = Vector(-4522, 869, -3050)
		Checkpoint1.Max = Vector(-4647, 957, -2914)
		Checkpoint1.Pos = Vector(-4647, 957, -2914) - ( ( Vector(-4647, 957, -2914) - Vector(-4522, 869, -3050)) / 2 )
		Checkpoint1.Point1 = Vector(-4712, 586, -3199)
		Checkpoint1:SetPos(Checkpoint1.Pos)
		Checkpoint1:Spawn()
		
	elseif game.GetMap() == "d1_town_02a" then
		TRIGGER_CHECKPOINT = {
			 Vector(-7539, -287, -3404), Vector(-7461, -150, -3279),
		}
		local Checkpoint1 = ents.Create("trigger_checkpoint")
		Checkpoint1.Min = Vector(-7539, -287, -3404)
		Checkpoint1.Max = Vector(-7442, -155, -3275)
		Checkpoint1.Pos = Vector(-7442, -155, -3275) - ( ( Vector(-7442, -155, -3275) - Vector(-7539, -287, -3404)) / 2 )
		Checkpoint1.Point1 = Vector(-7412, -370, -3338)
		Checkpoint1:SetPos(Checkpoint1.Pos)
		Checkpoint1:Spawn()
				
	elseif game.GetMap() == "d1_town_05" then
		TRIGGER_CHECKPOINT = {
			 Vector(-1078, 10319, 901), Vector(-1156, 10377, 1007),
			 Vector(1714, 10868, 910), Vector(-1714, 10972, 1011),
		}
		local Checkpoint1 = ents.Create("trigger_checkpoint")
		Checkpoint1.Min = Vector(-1078, 10319, 901)
		Checkpoint1.Max = Vector(-1156, 10377, 1007)
		Checkpoint1.Pos = Vector(-1156, 10377, 1007) - ( ( Vector(-1156, 10377, 1007) - Vector(-1078, 10319, 901)) / 2 )
		Checkpoint1.Point1 = Vector(-1227, 10663, 930)
		Checkpoint1:SetPos(Checkpoint1.Pos)
		Checkpoint1:Spawn()
		
		local Checkpoint2 = ents.Create("trigger_checkpoint")
		Checkpoint2.Min = Vector(-1714, 10868, 910)
		Checkpoint2.Max = Vector(-1714, 10972, 1011)
		Checkpoint2.Pos = Vector(-1714, 10972, 1011) - ( ( Vector(-1714, 10972, 1011) - Vector(1714, 10868, 910)) / 2 )
		Checkpoint2.Point2 = Vector(-1699, 10887, 909)
		Checkpoint2:SetPos(Checkpoint2.Pos)
		Checkpoint2:Spawn()		
		
	elseif game.GetMap() == "d2_coast_11" then
		TRIGGER_CHECKPOINT = {
			 Vector(4548, 6434, 580), Vector(4145, 6676, 818),
			 Vector(5038, 10047, 172), Vector(4856, 9808, 314),
			 Vector(815, 11598, 507), Vector(755, 11476, 652),
		}
		local Checkpoint1 = ents.Create("trigger_checkpoint")
		Checkpoint1.Min = Vector(4548, 6434, 580)
		Checkpoint1.Max = Vector(4145, 6676, 818)
		Checkpoint1.Pos = Vector(4145, 6676, 818) - ( ( Vector(4145, 6676, 818) - Vector(4548, 6434, 580)) / 2 )
		Checkpoint1.Point1 = Vector(4406, 6555, 655)
		Checkpoint1:SetPos(Checkpoint1.Pos)
		Checkpoint1:Spawn()

		local Checkpoint2 = ents.Create("trigger_checkpoint")
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
		
	end

end

