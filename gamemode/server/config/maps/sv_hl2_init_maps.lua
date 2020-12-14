NO_SPECIAL_MAPS = {
	["d1_trainstation_01"] = true,
	["d1_trainstation_02"] = true,
	["d1_trainstation_03"] = true,
	["d1_trainstation_04"] = true,
	["d1_trainstation_05"] = true,
	["d2_prison_06"] = true,
	["d2_prison_07"] = true,
	["d3_breen_01"] = true,
}

function SetupHL2Map()
	sandAchEarnable = false
	surpassSand = false
	game.SetGlobalState("friendly_encounter", 0)
	noSubmissive = false
	noDefiant = false
	--Create the lua entity
	MapLua = ents.Create("lua_run")
	MapLua:SetName("triggerhook")
	MapLua:Spawn()
		
	--Fix the spawnpoints
	if game.GetMap() == "d1_trainstation_02" then 
		for k, reset1 in pairs(ents.FindByClass("info_player_start")) do
			reset1:SetPos(Vector(-4315, -215, 0))
		end
	end
		
	if game.GetMap() == "d1_trainstation_05" then
		for a, catAch in pairs(ents.FindByName("kill_mtport_rl_1")) do
			catAch:Fire("AddOutput", "OnTrigger triggerhook:RunPassedCode:hook.Run( 'GiveWhatCat' ):0:-1" )
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
	
	if game.GetMap() == "d1_canals_13" then 
		for k, singer in pairs(ents.FindByClass("trigger_once")) do
			if singer:GetPos() == Vector(11328, 672, -288) then
				singer:Fire("AddOutput", "OnTrigger triggerhook:RunPassedCode:hook.Run( 'GiveSinger' ):0:-1" )
			end
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
		
		for k, fog in pairs(ents.FindByClass("env_fog_controller")) do
			fog:Remove()
		end
	end
	
	if game.GetMap() == "d2_coast_07" and file.Exists("hl2cr_data/d2_coast_07.txt", "DATA") then 
		for k, reset3 in pairs(ents.FindByClass("info_player_start")) do
			reset3:SetPos(Vector(3143, 5218, 1547))
			reset3:SetAngles(Angle(0, 180, 0))
		end
		
		for k, trigger in pairs(ents.FindByName("field_trigger")) do
			trigger:Remove()
		end
		for k, field in pairs(ents.FindByName("bridge_field_02")) do
			field:Remove()
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
	
	if game.GetMap() == "d1_town_03" and not file.Exists("hl2cr_data/d1_town_02.txt", "DATA") then 
		file.Write("hl2cr_data/d1_town_02.txt", "Map checker please don't delete this file")
	end
	
	if game.GetMap() == "d2_coast_08" and not file.Exists("hl2cr_data/d2_coast_07.txt", "DATA") then 
		file.Write("hl2cr_data/d2_coast_07.txt", "Map checker please don't delete this file")
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
	
	local SUPER_GUN = {
		["d3_citadel_03"] = true,
		["d3_citadel_04"] = true,
		["d3_citadel_05"] = true,
		["d3_breen_01"] = true
	}
	
	--Fix super grav gun
	if SUPER_GUN[game.GetMap()] then
		game.SetGlobalState("super_phys_gun", 1)
	else
		game.SetGlobalState("super_phys_gun", 0)
	end

	if game.GetMap() == "d1_trainstation_01" and game.GetMap() == "d1_trainstation_02" then
		for k, cop in pairs(ents.FindByClass("npc_metropolice")) do
			for i, citz in pairs(ents.FindByClass("npc_citizen")) do
				for i, strider in pairs(ents.FindByClass("npc_strider")) do
					for i, ply in pairs(player.GetAll()) do
						cop:AddRelationship(ply, D_NU, 99)
						cop:AddRelationship(citz, D_NU, 99)
						strider:AddRelationship(citz, D_NU, 99)
					end
				end
			end
		end
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
	
	for k, triggerFail in pairs(ents.FindByName("fall_trigger")) do
		triggerFail:Remove()
	end
	
	if game.GetMap() == "d1_town_02a" then
		file.Delete("hl2cr_data/d1_town_02.txt")
	end
	
	if game.GetMap() == "d2_coast_09" then
		file.Delete("hl2cr_data/d2_coast_07.txt")
	end
	
	if game.GetMap() == "d2_coast_01" then
		local fixLeap = ents.Create("prop_dynamic")
		fixLeap:SetPos(Vector(-8606, 476, 961))
		fixLeap:SetAngles(Angle(0, 180, 0))
		fixLeap:SetModel("models/props_wasteland/cargo_container01.mdl")
		fixLeap:PhysicsInit(SOLID_VPHYSICS)
		fixLeap:Spawn()
		
		local fixLeap2 = ents.Create("prop_dynamic")
		fixLeap2:SetPos(Vector(-8477, 476, 961))
		fixLeap2:SetAngles(Angle(0, 180, 0))
		fixLeap2:SetModel("models/props_wasteland/cargo_container01.mdl")
		fixLeap2:PhysicsInit(SOLID_VPHYSICS)
		fixLeap2:Spawn()
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
		sandAchEarnable = true
		for k, sand in pairs(ents.FindByClass("env_player_surface_trigger")) do
			sand:Fire("AddOutput", "OnSurfaceChangedToTarget triggerhook:RunPassedCode:hook.Run( 'FailSand' ):0:-1")
		end
	end
	
	if game.GetMap() == "d3_c17_10b" then
		for k, trap in pairs(ents.FindByClass("env_beam")) do
			trap:Fire("AddOutput", "OnTouchedByEntity triggerhook:RunPassedCode:hook.Run( 'ResetTrap' ):15:-1")
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
	
	for i, portal in pairs(ents.FindByClass("func_areaportal")) do
		
		hook.Add("Think", "KeepPortalsOpen", function()
			if not portal then return end
			portal:SetKeyValue("StartOpen", 1)
		end)
	end
	SetCheckpointsStageHL2()
	
	if GetConVar("hl2cr_halloween"):GetInt() == 1 then
		SetUpHalloweenMap()
	end
	
end

local playersAmt = 0

hook.Add("Think", "eventThink", function()
	playersAmt = #player.GetAll()
end)

function SetUpHalloweenMap()
	if playersAmt < 4 then return end
	
	if game.GetMap() == "d1_town_02a" then
		local pumpkinBoss = ents.Create("zpn_pumpkin_boss")
		pumpkinBoss:SetPos(Vector(-7565, 537, -3389))
		pumpkinBoss:Spawn()
	end
end

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
			Achievement(v, "Rave_Ball", "HL2_Ach_List")	
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

hook.Add("FixBarney", "TeleportBarney", function()
	for k, barneyNPC in pairs(ents.FindByClass("npc_barney")) do
		barneyNPC:SetPos(Vector(-2867, 6474, 532))
	end
end)

hook.Add("ResetTrap", "ResetLaserTrap", function()
	
	for k, beam in pairs(ents.FindByClass("env_beam")) do
		beam:Fire("TurnOn")
	end
	
	for k, turret in pairs(ents.FindByClass("npc_turret_ceiling")) do
		turret:Fire("Disable")
	end
	
	for k, button in pairs(ents.FindByName("s_room_panelswitch")) do
		button:Fire("Unlock")
	end
	
	for k, doors in pairs(ents.FindByName("s_room_doors")) do
		doors:Fire("Open")
	end
end)

hook.Add("FailSand", "FailureSandAch", function()	
	if sandAchEarnable and not surpassSand then 
		for k, v in pairs(player.GetAll()) do
			v:ChatPrint("Keep off the Sand! Failed")
		end
	end
	sandAchEarnable = false
end)


hook.Add("GiveGravgun", "GrantGravgun", function()
	for k, v in pairs(player.GetAll()) do
		v:Give("weapon_physcannon")
		Achievement(v, "ZeroPoint_Energy", "HL2_Ach_List")
		v:ChatPrint("Gravity gun is now enabled")
	end
end)

hook.Add("EndHL2", "FinishedHL2", function()
	for k, v in pairs(player.GetAll()) do
		Achievement(v, "Finish_HL2", "HL2_Ach_List")
	end
	
	EndHL2Game()
end)

hook.Add("GiveWhatCat", "GrantCatAch", function()
	for k, v in pairs(player.GetAll()) do
		Achievement(v, "What_Cat", "HL2_Ach_List")
	end
end)

hook.Add("GiveSubmissive", "GrantSubmissiveAch", function()
	if noSubmissive then return end
	noDefiant = true
	for k, v in pairs(player.GetAll()) do
		Achievement(v, "Submissive", "HL2_Ach_List")
	end
end)

hook.Add("GiveDefiant", "GrantDefiantAch", function()
	if noDefiant and not noSubmissive then return end
	noSubmissive = true
	for k, v in pairs(player.GetAll()) do
		Achievement(v, "Defiant", "HL2_Ach_List")
	end
end)

hook.Add("GiveSinger", "GrantSingerAch", function()
	local activator, caller = ACTIVATOR, CALLER
	
	Achievement(activator, "Vorticough", "HL2_Ach_List")
end)

hook.Add("GravGunOnPickedUp", "PastPickup", function(ply, ent)
	if ent:GetModel() == "models/props_lab/hevplate.mdl" then
		Achievement(ply, "Blast_from_the_Past", "HL2_Ach_List")
	end
end)

function SetCheckpointsStageHL2()
	
	--Remove the old checkpoints and changelevels
	for k, oldCheck in pairs(ents.FindByClass("trigger_checkpoint")) do
		oldCheck:Remove()
	end
	
	for k, oldChange in pairs(ents.FindByClass("trigger_changelevel")) do
		oldChange:Remove()
	end
	
	if game.GetMap() == "d1_trainstation_01" then
		TRIGGER_CHANGELEVEL = {
			Vector(-3045, -185, -43), Vector(-3181, -199, 59)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(-5513, -1985, -18), Vector(-5163, -1933, 142),
			Vector(-4335, -605, -30), Vector(-4092, -430, 130),
			Vector(-3475, -444, -23), Vector(-3600, -320, 81),
			Vector(-3275, -76, -25), Vector(-3512, -6, 71),
		}
		
		TRIGGER_SPAWNPOINT = {
			Vector(-5329, -2090, 3), Vector(-4217, -513, -21),
			Vector(-3530, -338, -25), Vector(-3392, -46, -23)
		}
	elseif game.GetMap() == "d1_trainstation_02" then
		TRIGGER_CHANGELEVEL = {
			Vector(-5295, -4593, 1), Vector(-5357, -4506, 125)
		}

	elseif game.GetMap() == "d1_trainstation_03" then
		TRIGGER_CHANGELEVEL = {
			Vector(-5205, -4870, 578), Vector(-5262, -4742, 688)
		}
		TRIGGER_CHECKPOINT = {
			Vector( -4558, -4653, 386 ), Vector( -4448, -4588, 494 ), 
			Vector( -5002, -4710, 522 ), Vector( -4899, -4821, 630 ), 		
		}
		TRIGGER_SPAWNPOINT = {
			Vector(-4742, -4614, 399), Vector(-4964, -4824, 518)
		}
		
	elseif game.GetMap() == "d1_trainstation_04" then
		TRIGGER_CHANGELEVEL = {
			Vector(-8006, -4143, -242),	Vector(-7963, -4100, -154)
		}
		TRIGGER_CHECKPOINT = {
			Vector(-6861, -4255, 543), Vector(-7102, -4104, 670),
			Vector( -7904, -4158, -251 ), Vector( -7807, -4098, -128 ),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(-7031, -4004, 584),	Vector(-7864, -4125, -242)
		}
		
	elseif game.GetMap() == "d1_trainstation_05" then
		TRIGGER_CHANGELEVEL = {
			Vector(-10512, -3676, 384),	Vector(-10671, -3549, 460)
		}
		TRIGGER_CHECKPOINT = {
			 Vector(-6526, -1120, 17), Vector(-6421, -1203, 119),
			 Vector(-7073, -1325, 14), Vector(-7252, -1457, 116),
			 Vector(-10272, -4752, 321), Vector(-10427, -4703, 427),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(-6534, -1458, 64), Vector(-7170, -1389, 64),
			Vector(-10235, -4719, 329)
		}	
	elseif game.GetMap() == "d1_trainstation_06" then
		TRIGGER_CHANGELEVEL = {
			Vector(-8690, -559, -319), Vector(-8651, -528, -367)
		}
	elseif game.GetMap() == "d1_canals_01" then
		TRIGGER_CHANGELEVEL = {
			Vector(693, 2874, -83), Vector(740, 2919, -12)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(381, -3925, 258), Vector(137, -3712, 387),
			Vector(707, 2727, -87), Vector(758, 2756, -0),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(65, -3397, 262),		Vector(512, 2882, -31)
		}
		
	elseif game.GetMap() == "d1_canals_01a" then
		TRIGGER_CHANGELEVEL = {
			Vector(-5574, 9291, 13), Vector(-5769, 9147, 128)
		}
		
		TRIGGER_CHECKPOINT = {
			 Vector(-2931, 5371, -56), Vector(-3012, 5216, 112)
		}
		TRIGGER_SPAWNPOINT = {
			Vector(-3200, 5180, -78)
		}
	elseif game.GetMap() == "d1_canals_02" then
		TRIGGER_CHANGELEVEL = {
			Vector(-495, 1531, -820),Vector(-505, 1593, -738)
		}
	elseif game.GetMap() == "d1_canals_03" then
		TRIGGER_CHANGELEVEL = {
			Vector(-3406, -124, -1062),	Vector(-3532, -44, -966)
		}
		TRIGGER_CHECKPOINT = {
			 Vector(-1044, -34, -1023), Vector(-1006, -110, -892),
			 Vector(-2180, -885, -1028), Vector(-2108, -829, -1076),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(-881, 16, -1032),	Vector(-2073, -871, -1167)
		}		
	
	elseif game.GetMap() == "d1_canals_05" then
		TRIGGER_CHANGELEVEL = {
			Vector(-4395, -2548, -464),	Vector(-4711, -2072, -327)
		}
		TRIGGER_CHECKPOINT = {
			 Vector(4281, 1474, -453), 	Vector(4114, 1549, -294),
			 Vector(6745, 1598, -446), 	Vector(6775, 1534, -337),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(4187, 1559, -448), 	Vector(7261, 1608, -383)
		}
	elseif game.GetMap() == "d1_canals_06" then
		TRIGGER_CHANGELEVEL = {
			Vector(-1488, -3617, -458),	Vector(-897, -2397, -155)
		}
	elseif game.GetMap() == "d1_canals_07" then
		TRIGGER_CHANGELEVEL = {
			Vector(-8477, -4543, -982),	Vector(-7496, -3840, -746)
		}
		TRIGGER_CHECKPOINT = {
			 Vector(7361, 1410, -251), 	Vector(7319, 1358, -142)
		}
		TRIGGER_SPAWNPOINT = {
			Vector(7356, 1849, -319)
		}

	elseif game.GetMap() == "d1_canals_08" then
		TRIGGER_CHANGELEVEL = {
			Vector(-8847, 8646, -571),	Vector(-9196, 9544, -321)
		}
		TRIGGER_CHECKPOINT = {
			 Vector(-777, -388, -575), 	Vector(-675, -272, -457),
			 Vector(-2440, -4593, -445), 	Vector(-2755, -3590, -605)
		}
		TRIGGER_SPAWNPOINT = {
			Vector(-783, -577, -540), 	Vector(-3391, -4081, -549)
		}	
	elseif game.GetMap() == "d1_canals_09" then
		TRIGGER_CHANGELEVEL = {
			Vector(-1784, -7980, -504),	Vector(-1426, -7087, -139)
		}
	elseif game.GetMap() == "d1_canals_10" then
		TRIGGER_CHANGELEVEL = {
			Vector(-13583, 810, -333),	Vector(-13932, 113, -25)
		}
	elseif game.GetMap() == "d1_canals_11" then
		TRIGGER_CHANGELEVEL = {
			Vector(-11776, -1154, -958),	Vector(-11262, -745, -711)
		}
		TRIGGER_CHECKPOINT = {
			 Vector(6228, 5310, -889), 	Vector(6276, 5247, -777),
			 Vector(5117, 5052, -945), 	Vector(4830, 4725, -764),
			 Vector(2349, -7427, -999), 	Vector(2066, -8069, -760),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(6329, 5405, -893), 	Vector(5348, 4912, -939),
			Vector(1961, -7257, -863)
		}
	elseif game.GetMap() == "d1_canals_12" then
		TRIGGER_CHANGELEVEL = {
			Vector(2625, -7848, 93),	Vector(2238, -8472, 419)
		}
	elseif game.GetMap() == "d1_canals_13" then
		TRIGGER_CHANGELEVEL = {
			Vector(-769, -3798, -390),	Vector(-509, -4172, -171)
		}
	elseif game.GetMap() == "d1_eli_01" then
		TRIGGER_CHANGELEVEL = {
			Vector(-471, 1091, -2703),	Vector(-672, 904, -2492)
		}
		TRIGGER_CHECKPOINT = {
			 Vector(15, 2847, -1271), 	Vector(-110, 2837, -1180),
			 Vector(397, 1716, -1256), 	Vector(510, 1669, -1175),
			 Vector(508, 1770, -2726), 	Vector(383, 1881, -2603),
			 Vector(19, 2075, -2727), 	Vector(-79, 2181, -2606),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(-107, 2747, -1270), Vector(455, 1666, -1253),
			Vector(434, 1949, -2671), Vector(-329, 2132, -2671)
		}
		
	elseif game.GetMap() == "d1_eli_02" then
		TRIGGER_CHANGELEVEL = {
			Vector(-3559, 4081, -1664),	Vector(-3412, 4015, -1529)
		}
		
		TRIGGER_CHECKPOINT = {
			 Vector(-677, 864, -2676), Vector(-519, 779, -2566),
			 Vector(-525, 1186, -2681), Vector(-681, 1320, -2573),
			 Vector(-1905, 2007, -2726), Vector(-2056, 1851, -2592),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(-604, 639, -2623), Vector(-722, 1469, -2633),
			Vector(-2331, 2092, -2671)
		}	
	elseif game.GetMap() == "d1_town_01" then
		TRIGGER_CHANGELEVEL = {
			Vector(231, 317, -3319),	Vector(144, 225, -3211)
		}
	elseif game.GetMap() == "d1_town_01a" then
		TRIGGER_CHANGELEVEL = {
			Vector(-522, 658, -3429),	Vector(-679, 760, -3300)
		}
	elseif game.GetMap() == "d1_town_02" and not file.Exists("hl2cr_data/d1_town_02.txt", "DATA") then
		TRIGGER_CHANGELEVEL = {
			Vector(-3575, -515, -3585),	Vector(-3710, -612, -3431)
		}
	elseif game.GetMap() == "d1_town_02" and file.Exists("hl2cr_data/d1_town_02.txt", "DATA") then
		TRIGGER_CHANGELEVEL = {
			Vector(-5399, 1803, -3233),	Vector(-5026, 2262, -3033)
		}
		TRIGGER_CHECKPOINT = {
			 Vector(-4522, 869, -3050), Vector(-4647, 957, -2914),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(-4712, 586, -3199)
		}
	elseif game.GetMap() == "d1_town_03" then
		TRIGGER_CHANGELEVEL = {
			Vector(-3719, -53, -3442),	Vector(-3796, 25, -3332)
		}
	elseif game.GetMap() == "d1_town_02a" then
		TRIGGER_CHANGELEVEL = {
			Vector(-6634, -612, -3255),	Vector(-6537, -759, -3100)
		}
		TRIGGER_CHECKPOINT = {
			 Vector(-7539, -287, -3404), Vector(-7461, -150, -3279),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(-7412, -370, -3338)
		}
	elseif game.GetMap() == "d1_town_04" then
		TRIGGER_CHANGELEVEL = {
			Vector(-2388, 1269, -4856),	Vector(-2556, 1037, -4743)
		}
	elseif game.GetMap() == "d1_town_05" then
		TRIGGER_CHANGELEVEL = {
			Vector(-1648, 10919, 912),	Vector(-1714, 10972, 1011)
		}
		TRIGGER_CHECKPOINT = {
			 Vector(-1078, 10319, 901), Vector(-1156, 10377, 1007),
			 Vector(1714, 10868, 910), Vector(-1714, 10972, 1011),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(-1227, 10663, 930), Vector(-1699, 10887, 909)
		}
	elseif game.GetMap() == "d2_coast_01" then
		TRIGGER_CHANGELEVEL = {
			Vector(-11594, 4201, 1547),	Vector(-12089, 4603, 1701)
		}
	elseif game.GetMap() == "d2_coast_03" then
		TRIGGER_CHANGELEVEL = {
			Vector(6386, 13211, 42),	Vector(7234, 13600, 244)
		}
		TRIGGER_CHECKPOINT = {
			 Vector(9007, 4597, 259), Vector(8782, 4161, 375)
		}
		TRIGGER_SPAWNPOINT = {
			Vector(8659, 4337, 266)
		}
	elseif game.GetMap() == "d2_coast_04" then
		TRIGGER_CHANGELEVEL = {
			Vector(-3375, 10248, 1798),	Vector(-3987, 10697, 1968)	
		}
		TRIGGER_CHECKPOINT = {
			 Vector(6207, -4223, 385), Vector(5894, -3976, 610)
		}
		TRIGGER_SPAWNPOINT = {
			Vector(6036, -4081, 409)
		}
	elseif game.GetMap() == "d2_coast_05" then
		TRIGGER_CHANGELEVEL = {
			Vector(1495, 5429, 1617),	Vector(2334, 5373, 1353)
		}
		TRIGGER_CHECKPOINT = {
			 Vector(-4582, -1183, 1089), Vector(-4505, -1262, 1234)
		}
		TRIGGER_SPAWNPOINT = {
			Vector(-4565, -1091, 1119)
		}
	elseif game.GetMap() == "d2_coast_07" and not file.Exists("hl2cr_data/d2_coast_07.txt", "DATA") then
		TRIGGER_CHANGELEVEL = {
			Vector(3356, 5183, 1542),	Vector(3297, 5140, 1661)
		}
	elseif game.GetMap() == "d2_coast_08" then
		TRIGGER_CHANGELEVEL = {
			Vector(3074, 1598, 1537),	Vector(3186, 1787, 1663)
		}
		TRIGGER_CHECKPOINT = {
			 Vector(3061, -6922, 1921), Vector(2832, -6994, 2037),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(2939, -6995, 1935)
		}
	elseif game.GetMap() == "d2_coast_07" and file.Exists("hl2cr_data/d2_coast_07.txt", "DATA") then
		TRIGGER_CHANGELEVEL = {
			Vector(9533, -9202, 2049),	Vector(8963, -9376, 2213)
		}
	
	elseif game.GetMap() == "d2_coast_09" then
		TRIGGER_CHANGELEVEL = {
			Vector(10931, -1079, -190),		Vector(10577, -1439, -6)
		}
		TRIGGER_CHECKPOINT = {
			 Vector(10870, 8391, -185), Vector(11160, 8727, -45),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(10968, 8648, -163)
		}
	elseif game.GetMap() == "d2_coast_10" then
		TRIGGER_CHANGELEVEL = {
			Vector(5714, 2500, 513),	Vector(5625, 2293, 661)
		}
		TRIGGER_CHECKPOINT = {
			Vector(4740, -131, 918),	Vector(4957, -314, 1066),
			Vector(8130, 1905, 962),	Vector(8287, 1781, 1079)
		}
		TRIGGER_SPAWNPOINT = {
			Vector(4864, -432, 931), Vector(8222, 1840, 981)
		}
		
	elseif game.GetMap() == "d2_coast_11" then
		TRIGGER_CHANGELEVEL = {
			Vector(-2891, 13059, 339),	Vector(-3124, 13516, 682)
		}
		TRIGGER_CHECKPOINT = {
			 Vector(4548, 6434, 580), Vector(4145, 6676, 818),
			 Vector(5038, 10047, 172), Vector(4856, 9808, 314),
			 Vector(432, 11717, 431), Vector(718, 11597, 620),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(4406, 6555, 655), Vector(4967, 9917, 233),
			Vector(315, 11606, 436),
		}
	elseif game.GetMap() == "d2_coast_12" then
		TRIGGER_CHANGELEVEL = {
			Vector(9241, 8491, 2080),	Vector(9330, 8594, 2240)
		}
		TRIGGER_CHECKPOINT = {
			 Vector(2236, -317, 672), Vector(2055, -188, 815),
			 Vector(8521, 7965, 1041), Vector(8680, 7835, 1247),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(2086, -77, 694), Vector(8775, 8241, 988)
		}
	elseif game.GetMap() == "d2_prison_01" then
		TRIGGER_CHANGELEVEL = {
			Vector(692, -1587, 1614),	Vector(561, -1452, 1738)
		}
		TRIGGER_CHECKPOINT = {
			 Vector(1156, -1410, 1602), Vector(1000, -1582, 1777),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(846, -1497, 1621)
		}
	elseif game.GetMap() == "d2_prison_02" then
		TRIGGER_CHANGELEVEL = {
			Vector(-2791, 1157, 646),	Vector(-2666, 1294, 791)
		}
	elseif game.GetMap() == "d2_prison_03" then
		TRIGGER_CHANGELEVEL = {
			Vector(-3394, 6140, 4),	Vector(-3317, 5963, 155)
		}
		TRIGGER_CHECKPOINT = {
			 Vector(-3395, 3390, 4), Vector(-3574, 3325, 191),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(-3515, 3524, 64)
		}
	elseif game.GetMap() == "d2_prison_04" then
		TRIGGER_CHANGELEVEL = {
			Vector(-1437, 3029, 386),	Vector(-1249, 2841, 541)
		}
	elseif game.GetMap() == "d2_prison_05" then
		TRIGGER_CHANGELEVEL = {
			Vector(-4054, -1079, 403),	Vector(-4305, -978, 539)
		}
		TRIGGER_CHECKPOINT = {
			 Vector(-3478, -468, 511), Vector(-3640, -665, 858),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(-3797, -557, 523)
		}
		
	elseif game.GetMap() == "d2_prison_06" then
		TRIGGER_CHANGELEVEL = {
			Vector(-1, -2683, -235),	Vector(155, -2410, -118)
		}
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
		TRIGGER_CHANGELEVEL = {
			Vector(4628, -4241, -695),	Vector(4432, -4428, -571)
		}
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
		TRIGGER_CHANGELEVEL = {
			Vector(-862, -1091, 919),	Vector(-958, -959, 1069)
		}
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
		TRIGGER_CHANGELEVEL = {
			Vector(-6602, -918, -35),	Vector(-6782, -745, -157)
		}
		TRIGGER_CHECKPOINT = {
			 Vector(-6993, -1223, 6), Vector(-6923, -1619, 98),
			 Vector(-6354, -1019, 3), Vector(-6564, -743, 147),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(-6841, -1384, 13), Vector(-6476, -918, 11)
		}
		
	elseif game.GetMap() == "d3_c17_02" then
		TRIGGER_CHANGELEVEL = {
			Vector(-5143, -4472, 4),	Vector(-5208, -4519, 124)
		}
		TRIGGER_CHECKPOINT = {
			 Vector(-5586, -5702, 0), Vector(-5478, -5565, 150),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(-5449, -5753, 22)
		}
		
	elseif game.GetMap() == "d3_c17_03" then
		TRIGGER_CHANGELEVEL = {
			Vector(-1216, -3521, 51),	Vector(-1091, -3576, 248)
		}	
	elseif game.GetMap() == "d3_c17_04" then
		TRIGGER_CHANGELEVEL = {
			Vector(179, -5875, 129),	Vector(62, -5819, 244)
		}	
	elseif game.GetMap() == "d3_c17_05" then
		TRIGGER_CHANGELEVEL = {
			Vector(2785, -3333, -123),	Vector(2567, -3446, -11)
		}	
	elseif game.GetMap() == "d3_c17_06a" then
		TRIGGER_CHANGELEVEL = {
			Vector(2112, 2951, -130),	Vector(2170, 3070, 52)
		}
		TRIGGER_CHECKPOINT = {
			 Vector(3002, 2404, -310), Vector(2882, 2506, -169),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(2751, 2763, -301)
		}
	elseif game.GetMap() == "d3_c17_06b" then
		TRIGGER_CHANGELEVEL = {
			Vector(5281, 1773, 260),	Vector(5370, 1680, 373)
		}
	elseif game.GetMap() == "d3_c17_07" then
		TRIGGER_CHANGELEVEL = {
			Vector(10205, 2848, -478),	Vector(10115, 2924, -319)
		}
		TRIGGER_CHECKPOINT = {
			 Vector(5520, 1383, 0), Vector(5525, 1432, 109),
			 Vector(7292, 1282, 3), Vector(7313, 1788, 125),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(6585, 1531, 19), Vector(7840, 1531, 6)
		}
		
	elseif game.GetMap() == "d3_c17_08" then
		TRIGGER_CHANGELEVEL = {
			Vector(2296, -487, 496),	Vector(2502, -363, 676)
		}
		TRIGGER_CHECKPOINT = {
			Vector(1310, -754, -320), Vector(1220, -682, -225),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(1473, -596, -377)
		}
	elseif game.GetMap() == "d3_c17_09" then
		TRIGGER_CHANGELEVEL = {
			Vector(9296, 7149, 1),	Vector(9080, 7061, 188)
		}
	elseif game.GetMap() == "d3_c17_10a" then
		TRIGGER_CHANGELEVEL = {
			Vector(493, 4973, 259),	Vector(308, 4803, 429)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(-2625, 6533, 514),	Vector(-2785, 6418, 604)
		}
		
		TRIGGER_SPAWNPOINT = {
			Vector(-3007, 6475, 528)
		}

	elseif game.GetMap() == "d3_c17_10b" then
		TRIGGER_CHANGELEVEL = {
			Vector(2658, 1246, 833),	Vector(2720, 1182, 999)
		}
		TRIGGER_CHECKPOINT = {
			Vector(2836, -956, 276), Vector(2512, -858, 472),
			Vector(2718, 1083, 263), Vector(2668, 1004, 362)
		}
		TRIGGER_SPAWNPOINT = {
			Vector(2424, -943, 320), Vector(2802, 1015, 320)
		}
	elseif game.GetMap() == "d3_c17_11" then
		TRIGGER_CHANGELEVEL = {
			Vector(1254, 3384, 965),	Vector(1251, 3329, 1088)
		}
	elseif game.GetMap() == "d3_c17_12" then
		TRIGGER_CHANGELEVEL = {
			Vector(-2686, 9105, -124),	Vector(-2572, 9255, -8)
		}
	elseif game.GetMap() == "d3_c17_12b" then
		TRIGGER_CHANGELEVEL = {
			Vector(-4363, 747, -28),	Vector(-4517, 866, 85)
		}
		TRIGGER_CHECKPOINT = {
			Vector(-8078, -1230, -235),  Vector(-7594, -605, -60)
		}
		TRIGGER_SPAWNPOINT = {
			Vector(-7458, -906, -236)
		}
	elseif game.GetMap() == "d3_c17_13" then
		TRIGGER_CHANGELEVEL = {
			Vector(8327, 1835, -427),	Vector(8460, 1983, -276)
		}
		TRIGGER_CHECKPOINT = {
			Vector(5009, 255, 258), Vector(5207, 338, 419),
			Vector(8445, 963, -196), Vector(8321, 1086, -120),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(5144, 450, 14),	Vector(8379, 1044, -353)
		}
	elseif game.GetMap() == "d3_citadel_01" then
		TRIGGER_CHANGELEVEL = {
			Vector(11326, 5981, -1774),	Vector(11091, 5793, -1537)
		}
		TRIGGER_CHECKPOINT = {
			Vector(10545, 4302, -1774), Vector(10484, 4156, -1603),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(10201, 4225, -1779)
		}
	elseif game.GetMap() == "d3_citadel_03" then
		TRIGGER_CHANGELEVEL = {
			Vector(692, -258, 2369),	Vector(454, -383, 2494)
		}
	elseif game.GetMap() == "d3_citadel_04" then
		TRIGGER_CHANGELEVEL = {
			Vector(-1154, -7748, 6022),	Vector(-1271, -8556, 6172)
		}
		TRIGGER_CHECKPOINT = {
			Vector(435, 640, 2793), Vector(68, 974, 3087),
			Vector(459, 639, 4123), Vector(74, 1016, 4600),
			Vector(445, 252, 6403), Vector(72, 31, 6655),
		}
		TRIGGER_SPAWNPOINT = {
			Vector(264, 837, 2853), Vector(240, 825, 4186),
			Vector(236, -245, 6422)
		}	
	elseif game.GetMap() == "d3_citadel_05" then
		TRIGGER_CHANGELEVEL = {
			Vector(14307, -9965, 8750),	Vector(14396, -9809, 9200)
		}
	elseif game.GetMap() == "d3_breen_01" then
		TRIGGER_CHANGELEVEL = {
			Vector(14000, 14944, 14956),	Vector(14096, 14891, 15094)
		}
		TRIGGER_CHECKPOINT = {
			Vector(-2029, 61, 1377), Vector(-1906, -61, 1241),
			Vector(-769, 123, -250), Vector(-672, -130, -54),
			Vector(-762, -470, 1285), Vector(-519, -276, 1479)
		}
		TRIGGER_SPAWNPOINT = {
			Vector(-1803, -0, 1363),	Vector(-649, 16, -244), 
			Vector(-692, 1, 1311)
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
