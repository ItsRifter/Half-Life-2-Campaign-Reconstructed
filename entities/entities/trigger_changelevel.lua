ENT.Base = "base_brush"
ENT.Type = "brush"

local series = nil

if string.match(game.GetMap(), "d1_") or string.match(game.GetMap(), "d2_") 
or string.match(game.GetMap(), "d3_") then
	series = "hl2"
elseif string.match(game.GetMap(), "ep1_") then
	series = "ep1"
end

function ENT:Initialize()
	displayOnce = false
	if not TRIGGER_CHANGELEVEL then
		return
	end

	--Set width, length and height of the changelevel
	local w = TRIGGER_CHANGELEVEL[2].x - TRIGGER_CHANGELEVEL[1].x
	local l = TRIGGER_CHANGELEVEL[2].y - TRIGGER_CHANGELEVEL[1].y
	local h = TRIGGER_CHANGELEVEL[2].z - TRIGGER_CHANGELEVEL[1].z
	local minPos = Vector(-1 - ( w / 2 ), -1 - ( l / 2 ), -1 - ( h / 2 ))
	local maxPos = Vector(w / 2, l / 2, h / 2)

	self:DrawShadow(false)
	self:SetCollisionBounds(minPos, maxPos)
	self:SetSolid(SOLID_BBOX)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetMoveType(0)
	self:SetTrigger(true)
	
end
local MAPS_TRAINSTATION = {
	["d1_trainstation_01"] = true,
	["d1_trainstation_02"] = true,
	["d1_trainstation_03"] = true,
	["d1_trainstation_04"] = true,
	["d1_trainstation_05"] = true
}
function ENT:StartTouch(ent)
	if ent and ent:IsValid() and ent:GetModel() == "models/props_c17/doll01.mdl" then
		ent:Remove()
		if game.GetMap() == "d1_trainstation_02" then
			UpdateBaby()
		elseif game.GetMap() == "d1_trainstation_03" then
			UpdateBaby()
		elseif game.GetMap() == "d1_trainstation_04" then
			UpdateBaby()
		end
	end

	if ent and ent:IsValid() and ent:GetModel() == "models/roller.mdl" then
		ent:Remove()
		if game.GetMap() == "d1_eli_02" then
			UpdateBall()
		elseif game.GetMap() == "d1_town_01" then
			UpdateBall()
		elseif game.GetMap() == "d1_town_01a" then
			UpdateBall()
		elseif game.GetMap() == "d1_town_02" and not file.Exists("hl2cr_data/d1_town_02.txt", "DATA") then
			UpdateBall()
		elseif game.GetMap() == "d1_town_03" then
			UpdateBall()
		elseif game.GetMap() == "d1_town_02" and file.Exists("hl2cr_data/d1_town_02.txt", "DATA") then
			UpdateBall()
		elseif game.GetMap() == "d1_town_02a" then
			UpdateBall()
		elseif game.GetMap() == "d1_town_04" then
			file.Delete("hl2cr_data/RavenBall8.txt")
			UpdateBall()
		end
	end

	local bonusXP = 0
	local bonusCoins = 0

	if ent and ent:IsValid() and ent:IsPlayer() and ent:Team() == TEAM_ALIVE then
		ent:SetTeam(TEAM_COMPLETED_MAP)
		SpectateMode(ent)
		ent:SetObserverMode(OBS_MODE_CHASE)
		if not MAPS_TRAINSTATION[game.GetMap()] then
			giveRewards(ent)
			if not ent.hasDiedOnce then
				bonusCoins = 25 * GetConVar("hl2cr_difficulty"):GetInt()
				bonusXP = 50 * GetConVar("hl2cr_difficulty"):GetInt()
				AddXP(ent, bonusXP)
				AddCoins(ent, bonusCoins)
			elseif not ent.crowbarOnly then
				bonusCoins = 45 * GetConVar("hl2cr_difficulty"):GetInt()
				bonusXP = 75 * GetConVar("hl2cr_difficulty"):GetInt()
				AddXP(ent, bonusXP)
				AddCoins(ent, bonusCoins)
			end
		end

		if ent:GetVehicle() and ent:GetVehicle():IsValid() then
			ent:GetVehicle():Remove()
		end
		playerCount = team.NumPlayers(TEAM_ALIVE) + team.NumPlayers(TEAM_COMPLETED_MAP)
		ent:SetAvoidPlayers(false)
		for k, p in pairs(player.GetAll()) do
			p:ChatPrint(ent:Nick() .. " has completed the map " .. team.NumPlayers(TEAM_COMPLETED_MAP) .. "/" .. playerCount)
		end
	end
end

local MAPS_ONEPLAYER = {
	["d1_eli_01"] = true,
	["d1_town_05"] = true,
	["d3_citadel_01"] = true,
	["d3_citadel_05"] = true,
	["d3_breen_01"] = true,
}

function ENT:Think()
	playerCount = #player.GetAll()
	local addOne = 0
	local subOne = 0
	if playerCount > 0 and playerCount <= 5 then
		addOne = 1
	end
	if timer.Exists("MapTimer") and GetConVar("hl2cr_survivalmode"):GetInt() == 1 then
		subOne = team.NumPlayers(TEAM_DEAD)
	end
	if playerCount <= 0 then return end
	if team.NumPlayers(TEAM_COMPLETED_MAP) >= team.NumPlayers(TEAM_ALIVE) + addOne - subOne and not MAPS_ONEPLAYER[game.GetMap()] then
		if displayOnce == false then
			displayOnce = true
			net.Start("DisplayMapTimer")
			net.Broadcast()
			timer.Create("MapTimer", 20, 0, function() 
				timer.Remove("MapTimer")
				for k, p in pairs(player.GetAll()) do
					if p.hl2cPersistent.OTF and p:Team() == TEAM_ALIVE then
						p.hl2cPersistent.OTF = false
						p:ChatPrint("You have failed the 'One true freeman' Challenge")
					end
				end
				
				if series == "hl2" then
					ChangeMapHL2()
				elseif series == "ep1" then
					ChangeMapEP1()
				end
				displayOnce = false
			end)
		end
	elseif (team.NumPlayers(TEAM_COMPLETED_MAP) >= 1 and MAPS_ONEPLAYER[game.GetMap()]) then
		if displayOnce == false then
			displayOnce = true
			net.Start("DisplayMapTimer")
			net.Broadcast()
			timer.Create("MapTimer", 20, 0, function() 
				timer.Remove("MapTimer")
				for k, p in pairs(player.GetAll()) do
					if p.hl2cPersistent.OTF and p:Team() == TEAM_ALIVE then
						p.hl2cPersistent.OTF = false
						p:ChatPrint("You have failed the 'One true freeman' Challenge")
					end
				end
				if series == "hl2" then
					ChangeMapHL2()
				elseif series == "ep1" then
					ChangeMapEP1()
				end
				displayOnce = false
			end)
		end
	elseif team.NumPlayers(TEAM_COMPLETED_MAP) >= 1 and game.GetMap() == "ep1_c17_06" then
		EndEP1Game()
	end
end

function EndHL2Game()
	for k, p in pairs(player.GetAll()) do
		if p.hl2cPersistent.OTF then
			Achievement(p, "Crowbar_Only_HL2", "HL2_Ach_List")
			p.hl2cPersistent.OTF = false
		end
		
		if p.hl2cPersistent.HardOTF then
			Achievement(p, "Crowbar_Only_HL2_Hard", "HL2_Ach_List")
			p.hl2cPersistent.HardOTF = false
		end
		
		if not displayOnce then
			p:ChatPrint("Congratulations on finishing Half-Life 2!, returning to lobby in 35 seconds")
			displayOnce = true
			game.SetGlobalState("super_phys_gun", 0)
			net.Start("DisplayMapTimer")
			net.Broadcast()
			timer.Create("MapTimer", 35, 0, function() ChangeMapHL2() timer.Remove("MapTimer") end)
		end
	end
end

function EndEP1Game()
	for k, p in pairs(player.GetAll()) do
		if p.hl2cPersistent.OTF then
			Achievement(p, "Crowbar_Only_EP1", "EP1_Ach_List")
			p.hl2cPersistent.OTF = false
		end
		
		if p.hl2cPersistent.HardOTF then
			Achievement(p, "Crowbar_Only_EP1_Hard", "EP1_Ach_List")
			p.hl2cPersistent.HardOTF = false
		end
		
		if not displayOnce then
			p:ChatPrint("Congratulations on finishing Episode 1!, returning to lobby in 35 seconds")
			displayOnce = true
			net.Start("DisplayMapTimer")
			net.Broadcast()
			timer.Create("MapTimer", 35, 0, function() ChangeMapEP1() timer.Remove("MapTimer") end)
		end
	end
end

function ChangeMapHL2()
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
		if map == HL2[k] then
			if file.Exists("hl2cr_data/d1_town_02.txt", "DATA") and game.GetMap() == "d1_town_03" then
				RunConsoleCommand("changelevel", "d1_town_02")
			elseif game.GetMap() == "d2_coast_08" and file.Exists("hl2cr_data/d2_coast_07.txt", "DATA") then
				RunConsoleCommand("changelevel", "d2_coast_07")
			elseif game.GetMap() == "d1_town_02" and file.Exists("hl2cr_data/d1_town_02.txt", "DATA") then
				RunConsoleCommand("changelevel", "d1_town_02a")
			elseif game.GetMap() == "d2_coast_07" and file.Exists("hl2cr_data/d2_coast_07.txt", "DATA") then
				RunConsoleCommand("changelevel", "d2_coast_09")
			else
				RunConsoleCommand("changelevel", HL2[k+1])
			end
		end
	end
end

function ChangeMapEP1()
	local map = game.GetMap()
	
	local EP1 = {
		--first map is skipped due to map logic
		--"ep1_citadel_00",
		"ep1_citadel_01",
		"ep1_citadel_02",
		"ep1_citadel_02b",
		"ep1_citadel_03",
		"ep1_citadel_04",
		"ep1_c17_00",
		"ep1_c17_00a",
		"ep1_c17_01",
		--"ep1_c17_01a",
		"ep1_c17_02",
		"ep1_c17_02b",
		"ep1_c17_02a",
		--"ep1_c17_05", -Gotta fix somehow
		"ep1_c17_06",
		"hl2c_lobby_remake"
	}
	
	for k = 1, #EP1 do
		if map == EP1[k] then
			RunConsoleCommand("changelevel", EP1[k+1])
		end
	end
end