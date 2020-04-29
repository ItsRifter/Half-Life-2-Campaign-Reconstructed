ENT.Base = "base_brush"
ENT.Type = "brush"

NEXT_MAP_PERCENT = 100
local createTrigger = true
if game.GetMap() == "hl2c_lobby_remake" then
	createTrigger = false
	
elseif game.GetMap() == "d1_trainstation_01" then
	ENT.PointA = Vector(-3045, -185, -43)
	ENT.PointB = Vector(-3181, -199, 59)
elseif game.GetMap() == "d1_trainstation_02" then
	ENT.PointA = Vector(-5308, -4583, 64)
	ENT.PointB = Vector(-5357, -4506, 125)
elseif game.GetMap() == "d1_trainstation_03" then
	ENT.PointA = Vector(-5179, -4855, 640)
	ENT.PointB = Vector(-5256, -4810, 675)
elseif game.GetMap() == "d1_trainstation_04" then
	ENT.PointA = Vector(-8006, -4143, -242)
	ENT.PointB = Vector(-7963, -4100, -154)
elseif game.GetMap() == "d1_trainstation_05" then
	ENT.PointA = Vector(-10512, -3676, 384)
	ENT.PointB = Vector(-10671, -3549, 460)
elseif game.GetMap() == "d1_trainstation_06" then
	ENT.PointA = Vector(-8690, -559, -319)
	ENT.PointB = Vector(-8651, -528, -272)
elseif game.GetMap() == "d1_canals_01" then
	ENT.PointA = Vector(693, 2874, -83)
	ENT.PointB = Vector(740, 2919, -12)
elseif game.GetMap() == "d1_canals_01a" then
	ENT.PointA = Vector(-5574, 9291, 13)
	ENT.PointB = Vector(-5769, 9147, 128)
elseif game.GetMap() == "d1_canals_02" then
	ENT.PointA = Vector(-495, 1531, -820)
	ENT.PointB = Vector(-505, 1593, -738)
elseif game.GetMap() == "d1_canals_03" then
	ENT.PointA = Vector(-3406, -124, -1062)
	ENT.PointB = Vector(-3532, -44, -966)
elseif game.GetMap() == "d1_canals_05" then
	ENT.PointA = Vector(-4395, -2548, -464)
	ENT.PointB = Vector(-4711, -2072, -327)
elseif game.GetMap() == "d1_canals_06" then
	ENT.PointA = Vector(-1488, -3617, -458)
	ENT.PointB = Vector(-897, -2397, -155)
elseif game.GetMap() == "d1_canals_07" then
	ENT.PointA = Vector(-8477, -4543, -982)
	ENT.PointB = Vector(-7496, -3840, -746)
elseif game.GetMap() == "d1_canals_08" then
	ENT.PointA = Vector(-8847, 8646, -571)
	ENT.PointB = Vector(-9196, 9544, -321)
elseif game.GetMap() == "d1_canals_09" then
	ENT.PointA = Vector(-1784, -7980, -504)
	ENT.PointB = Vector(-1426, -7087, -139)
elseif game.GetMap() == "d1_canals_10" then
	ENT.PointA = Vector(-13583, 810, -333)
	ENT.PointB = Vector(-13932, 113, -25)
elseif game.GetMap() == "d1_canals_11" then
	ENT.PointA = Vector(-11776, -1154, -958)
	ENT.PointB = Vector(-11262, -745, -711)
elseif game.GetMap() == "d1_canals_12" then
	ENT.PointA = Vector(2625, -7848, 93)
	ENT.PointB = Vector(2238, -8472, 419)
elseif game.GetMap() == "d1_canals_13" then
	ENT.PointA = Vector(-769, -3798, -390)
	ENT.PointB = Vector(-509, -4172, -171)
elseif game.GetMap() == "d1_eli_01" then
	ENT.PointA = Vector(-471, 1091, -2703)
	ENT.PointB = Vector(-672, 904, -2492)
elseif game.GetMap() == "d1_eli_02" then
	ENT.PointA = Vector(-3559, 4081, -1664)
	ENT.PointB = Vector(-3412, 4015, -1529)
elseif game.GetMap() == "d1_town_01" then
	ENT.PointA = Vector(231, 317, -3319)
	ENT.PointB = Vector(144, 225, -3211)
elseif game.GetMap() == "d1_town_01a" then
	ENT.PointA = Vector(-522, 658, -3429)
	ENT.PointB = Vector(-679, 760, -3300)
elseif game.GetMap() == "d1_town_02" and not file.Exists("hl2c_data/d1_town_02.txt", "DATA") then
	ENT.PointA = Vector(-3575, -515, -3585)
	ENT.PointB = Vector(-3710, -612, -3431)
elseif game.GetMap() == "d1_town_02" and file.Exists("hl2c_data/d1_town_02.txt", "DATA") then
	ENT.PointA = Vector(-5399, 1803, -3233)
	ENT.PointB = Vector(-5026, 2262, -3033)
elseif game.GetMap() == "d1_town_03" then
	ENT.PointA = Vector(-3719, -53, -3442)
	ENT.PointB = Vector(-3796, 25, -3332)
elseif game.GetMap() == "d1_town_02a" then
	ENT.PointA = Vector(-6634, -612, -3255)
	ENT.PointB = Vector(-6537, -759, -3100)
elseif game.GetMap() == "d1_town_04" then
	ENT.PointA = Vector(-2388, 1269, -4856)
	ENT.PointB = Vector(-2556, 1037, -4743)
elseif game.GetMap() == "d1_town_05" then
	ENT.PointA = Vector(-1648, 10919, 912)
	ENT.PointB = Vector(-1714, 10972, 1011)
elseif game.GetMap() == "d2_coast_01" then
	ENT.PointA = Vector(-11594, 4201, 1547)
	ENT.PointB = Vector(-12089, 4603, 1701)
	
end

function ENT:Initialize()
	if createTrigger then
		self:SetCollisionBounds(self.PointA, self.PointB)
		self:SetSolid(SOLID_BBOX)
	end
end

function ENT:StartTouch(ent)
	if ent and ent:IsValid() and ent:IsPlayer() and ent:Team() == TEAM_ALIVE then
		ent:SetTeam(TEAM_COMPLETED_MAP)
		
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

function ENT:Think()
	
	playerCount = team.NumPlayers(TEAM_ALIVE) + team.NumPlayers(TEAM_COMPLETED_MAP)
	
	if playerCount > 0 and team.NumPlayers(TEAM_COMPLETED_MAP) >= team.NumPlayers(TEAM_ALIVE) then
		for k, p in pairs(player.GetAll()) do
			if not displayOnce then
				p:ChatPrint("Enough players have completed, changing map in 20 seconds")
				displayOnce = true
				net.Start("DisplayMapTimer")
				net.Broadcast()
				timer.Simple(20, function() hook.Call("OnChangeLevel") end)
			end
		end
	end
end

