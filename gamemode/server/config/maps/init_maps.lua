checkpointPositions = {}

local Vehicle = {

	Class = "prop_vehicle_jeep",

	Model =	"models/source_vehicles/van001a_01.mdl",
	
	VC_ExtraSeats = {
		{Pos = Vector(17,-5,17), Ang = Angle(0,0,8), EnterRange = 280, ExitAng = Angle(0,-90,0), Model = "models/props_phx/carseat2.mdl", ModelOffset = Vector(12,0,4), Hide = true, DoorSounds = true, RadioControl = true},
		{Pos = Vector(16,-30,17), Ang = Angle(0,0,8), EnterRange = 280, ExitAng = Angle(0,-90,0), Model = "models/props_phx/carseat2.mdl", ModelOffset = Vector(12,0,4), Hide = true, DoorSounds = false, RadioControl = true},
		{Pos = Vector(-16,-30,17), Ang = Angle(0,0,8), EnterRange = 280, ExitAng = Angle(0,90,0), Model = "models/props_phx/carseat2.mdl", ModelOffset = Vector(12,0,4), Hide = true, DoorSounds = false, RadioControl = true}
	},
	
	KeyValues = {				
		vehiclescript =	"scripts/vehicles/van001a-vehicle_van.txt"
	}
}

list.Set( "Vehicles", "car001a_skin0", Vehicle )


function GM:DoPlayerDeath(ply, attacker, dmgInfo)
	ply:CreateRagdoll()
	ply:SetTeam(TEAM_DEAD)
end

function SetupMap()
	MapLua = ents.Create("lua_run")
	MapLua:SetName("triggerhook")
	MapLua:Spawn()
	
	for k, oldChangeLevel in pairs(ents.FindByClass("trigger_changelevel")) do
		oldChangeLevel:Remove()
	end
	
	local changeLvl = ents.Create("trigger_changelevel")
	changeLvl:Spawn()

	if game.GetMap() == "d1_trainstation_06" then 
		for k, reset in pairs(ents.FindByClass("info_player_start")) do
			reset:SetPos(Vector(-9946, -3660, 384))
		end
	end
	
	if game.GetMap() == "d1_canals_10" then 
		for k, fix in pairs(ents.FindByClass("info_player_start")) do
			fix:SetPos(Vector(11808, -12450, -475))
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
	
	if game.GetMap() == "d1_town_02a" then
		file.Delete("hl2c_data/d1_town_02.txt")
	end
	
	for k, air in pairs(ents.FindByClass("prop_vehicle_airboat")) do
		print(air)
	end
	
	if game.GetMap() == "d1_trainstation_03" then
		for k, pusher in pairs(ents.FindByClass("trigger_push")) do
			print("Begone")
			pusher:Remove()
		end
	end

	local cp = ents.Create("trigger_checkpoint")
	cp:Spawn()
	print(cp)
	
	if game.GetMap() == "d1_eli_02" then
		for k, g in pairs( ents.FindByName( "trigger_Get_physgun" )) do
			g:Fire("AddOutput", "OnTrigger triggerhook:RunPassedCode:hook.Run( 'GiveGravgun' ):0:-1" )
		end
	end
	
	if game.GetMap() == "d1_canals_11" then
		local vehicleTrigger = ents.Create("trigger_multiple")
		vehicleTrigger:Spawn()
	end
	
	for k, c in pairs( ents.FindByClass( "weapon_crowbar" ) ) do
		c:Fire("AddOutput", "OnPlayerPickup triggerhook:RunPassedCode:hook.Run( 'GiveCrowbars' ):0:-1" )
	end
	
	local triggerMultiples = ents.FindByClass("trigger_multiple")
	for k, triggerFail in pairs(triggerMultiples) do
		if triggerFail:GetName() == "fall_trigger" then
			triggerFail:Remove()
		end
	end
	
	if game.GetMap() == "d2_coast_01" then
		van = ents.Create(Vehicle.Class)
		van:SetModel(Vehicle.Model)
		van:SetKeyValue("vehiclescript", Vehicle.KeyValues.vehiclescript)
		van:SetPos(Vector(-7740, -8630, 960))
		van:Spawn()
	elseif game.GetMap() == "d2_coast_03" then
		van = ents.Create(Vehicle.Class)
		van:SetModel(Vehicle.Model)
		van:SetKeyValue("vehiclescript", Vehicle.KeyValues.vehiclescript)
		van:SetPos(Vector(-7076, -13146, 1088))
		van:Spawn()
	end
	
end

hook.Add("InitPostEntity", "SetupMapLua", SetupMap)
hook.Add("PostCleanupMap", "SetupMapLua", SetupMap)

hook.Add("SpawnJeep", "JeepSpawner", function()
	print("Yay")
end)
hook.Add("GiveCrowbars", "GrantCrowbars", function()
	for k, v in pairs(player.GetAll()) do
		v:Give("weapon_crowbar")
	end
end)

hook.Add("GiveGravgun", "GrantGravgun", function()
	for k, v in pairs(player.GetAll()) do
		v:Give("weapon_physcannon")
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
	}

	for k = 1, #HL2 do
        if (map == HL2[k]) then
            RunConsoleCommand("changelevel", HL2[k+1])
			lastMap = HL2[k]
            return
        end
    end
end)

hook.Add("PlayerSpawn", "GiveWeapons", function(ply)
	ply.givenWeapons = {}
end)

hook.Add("Think", "MapWeapons", function()
	for _, p in pairs(player.GetAll()) do
		if !p:Alive() || p:Team() != TEAM_ALIVE then
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
