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
	ENT.PointA = Vector(-5295, -4593, 1)
	ENT.PointB = Vector(-5357, -4506, 125)
elseif game.GetMap() == "d1_trainstation_03" then
	ENT.PointA = Vector(-5179, -4855, 567)
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
elseif game.GetMap() == "d2_coast_03" then
	ENT.PointA = Vector(6386, 13211, 42)
	ENT.PointB = Vector(7234, 13600, 244)
elseif game.GetMap() == "d2_coast_04" then
	ENT.PointA = Vector(-3375, 10248, 1798)
	ENT.PointB = Vector(-3987, 10697, 1968)	
elseif game.GetMap() == "d2_coast_05" then
	ENT.PointA = Vector(1495, 5429, 1617)
	ENT.PointB = Vector(2334, 5373, 1353)
elseif game.GetMap() == "d2_coast_07" and not file.Exists("hl2c_data/d2_coast_07.txt", "DATA") then
	ENT.PointA = Vector(3356, 5183, 1542)
	ENT.PointB = Vector(3297, 5140, 1661)
elseif game.GetMap() == "d2_coast_08" and disableField then
	ENT.PointA = Vector(3352, 1550, 1544)
	ENT.PointB = Vector(3306, 1597, 1659)
elseif game.GetMap() == "d2_coast_09" then
	ENT.PointA = Vector(10931, -1079, -190)
	ENT.PointB = Vector(10577, -1439, -6)
elseif game.GetMap() == "d2_coast_10" then
	ENT.PointA = Vector(5714, 2500, 513)
	ENT.PointB = Vector(5625, 2293, 661)
elseif game.GetMap() == "d2_coast_11" then
	ENT.PointA = Vector(-2891, 13059, 339)
	ENT.PointB = Vector(-3124, 13516, 682)
elseif game.GetMap() == "d2_coast_12" then
	ENT.PointA = Vector(9241, 8491, 2080)
	ENT.PointB = Vector(9330, 8594, 2240)
elseif game.GetMap() == "d2_prison_01" then
	ENT.PointA = Vector(692, -1587, 1614)
	ENT.PointB = Vector(561, -1452, 1738)
elseif game.GetMap() == "d2_prison_02" then
	ENT.PointA = Vector(-2791, 1157, 646)
	ENT.PointB = Vector(-2666, 1294, 791)
elseif game.GetMap() == "d2_prison_03" then
	ENT.PointA = Vector(-3394, 6140, 4)
	ENT.PointB = Vector(-3317, 5963, 155)
elseif game.GetMap() == "d2_prison_04" then
	ENT.PointA = Vector(-1437, 3029, 386)
	ENT.PointB = Vector(-1249, 2841, 541)
elseif game.GetMap() == "d2_prison_05" then
	ENT.PointA = Vector(-4054, -1079, 403)
	ENT.PointB = Vector(-4305, -978, 539)
elseif game.GetMap() == "d2_prison_06" then
	ENT.PointA = Vector(-1, -2683, -235)
	ENT.PointB = Vector(155, -2410, -118)
elseif game.GetMap() == "d2_prison_07" then
	ENT.PointA = Vector(4628, -4241, -695)
	ENT.PointB = Vector(4432, -4428, -571)
elseif game.GetMap() == "d2_prison_08" then
	ENT.PointA = Vector(-862, -1091, 919)
	ENT.PointB = Vector(-958, -959, 1069)
elseif game.GetMap() == "d3_c17_01" then
	ENT.PointA = Vector(-6602, -918, -35)
	ENT.PointB = Vector(-6782, -745, -157)
elseif game.GetMap() == "d3_c17_02" then
	ENT.PointA = Vector(-5143, -4472, 4)
	ENT.PointB = Vector(-5208, -4519, 124)
elseif game.GetMap() == "d3_c17_03" then
	ENT.PointA = Vector(-1216, -3521, 51)
	ENT.PointB = Vector(-1091, -3576, 248)
elseif game.GetMap() == "d3_c17_04" then
	ENT.PointA = Vector(179, -5875, 129)
	ENT.PointB = Vector(62, -5819, 244)
elseif game.GetMap() == "d3_c17_05" then
	ENT.PointA = Vector(2785, -3333, -123)
	ENT.PointB = Vector(2567, -3446, -11)
elseif game.GetMap() == "d3_c17_06a" then
	ENT.PointA = Vector(2112, 2951, -130)
	ENT.PointB = Vector(2170, 3070, 52)
elseif game.GetMap() == "d3_c17_06b" then
	ENT.PointA = Vector(2112, 2951, -130)
	ENT.PointB = Vector(5372, 1675, 374)
elseif game.GetMap() == "d3_c17_07" then
	ENT.PointA = Vector(10205, 2848, -478)
	ENT.PointB = Vector(10115, 2924, -319)
elseif game.GetMap() == "d3_c17_08" then
	ENT.PointA = Vector(2296, -487, 496)
	ENT.PointB = Vector(2502, -363, 676)
elseif game.GetMap() == "d3_c17_09" then
	ENT.PointA = Vector(9296, 7149, 1)
	ENT.PointB = Vector(9080, 7061, 188)
elseif game.GetMap() == "d3_c17_10a" then
	ENT.PointA = Vector(493, 4973, 259)
	ENT.PointB = Vector(308, 4803, 429)
elseif game.GetMap() == "d3_c17_10b" then
	ENT.PointA = Vector(2658, 1246, 833)
	ENT.PointB = Vector(2720, 1182, 999)
elseif game.GetMap() == "d3_c17_11" then
	ENT.PointA = Vector(1254, 3384, 965)
	ENT.PointB = Vector(1251, 3329, 1088)
elseif game.GetMap() == "d3_c17_12" then
	ENT.PointA = Vector(-2686, 9105, -124)
	ENT.PointB = Vector(-2572, 9255, -8)
elseif game.GetMap() == "d3_c17_12b" then
	ENT.PointA = Vector(-4363, 747, -28)
	ENT.PointB = Vector(-4517, 866, 85)
elseif game.GetMap() == "d3_c17_13" then
	ENT.PointA = Vector(8327, 1835, -427)
	ENT.PointB = Vector(8460, 1983, -276)
elseif game.GetMap() == "d3_citadel_01" then
	ENT.PointA = Vector(11326, 5981, -1774)
	ENT.PointB = Vector(11091, 5793, -1537)
elseif game.GetMap() == "d3_citadel_03" then
	ENT.PointA = Vector(692, -258, 2369)
	ENT.PointB = Vector(454, -383, 2494)
elseif game.GetMap() == "d3_citadel_04" then
	ENT.PointA = Vector(-1154, -7748, 6022)
	ENT.PointB = Vector(-1271, -8556, 6172)
elseif game.GetMap() == "d3_citadel_05" then
	ENT.PointA = Vector(0, 0, 6022)
	ENT.PointB = Vector(0, 0, 6172)
	
end



function ENT:Initialize()
	if createTrigger then
		self:SetCollisionBounds(self.PointA, self.PointB)
		self:SetSolid(SOLID_BBOX)
	end
end

function ENT:StartTouch(ent)
	if ent and ent:IsValid() and ent:GetModel() == "models/props_c17/doll01.mdl" then
		ent:Remove()
		if game.GetMap() == "d1_trainstation_02" then
			UpdateBaby()
			print("Babies?")
		elseif game.GetMap() == "d1_trainstation_03" then
			UpdateBaby()
		elseif game.GetMap() == "d1_trainstation_04" then
			UpdateBaby()
		end
	end
	
	if ent and ent:IsValid() and ent:GetModel() == "models/roller.mdl" then
		ent:Remove()
		if game.GetMap() == "d1_eli_02" then
			hook.Call("UpdateBall")
		elseif game.GetMap() == "d1_town_01" then
			hook.Call("UpdateBall")
		elseif game.GetMap() == "d1_town_01a" then
			hook.Call("UpdateBall")
		elseif game.GetMap() == "d1_town_02" and not file.Exists("hl2c_data/d1_town_02.txt", "DATA") then
			hook.Call("UpdateBall")
		elseif game.GetMap() == "d1_town_03" then
			hook.Call("UpdateBall")
		elseif game.GetMap() == "d1_town_02" and file.Exists("hl2c_data/d1_town_02.txt", "DATA") then
			hook.Call("UpdateBall")
		elseif game.GetMap() == "d1_town_02a" then
			hook.Call("UpdateBall")
		elseif game.GetMap() == "d1_town_04" then
			file.Delete("hl2c_data/RavenBall8.txt")
			hook.Call("UpdateBall")
		end
	end
		
	local bonusXP = 0
	local bonusCoins = 0
	
	if ent and ent:IsValid() and ent:IsPlayer() and ent:Team() == TEAM_ALIVE then
		ent:SetTeam(TEAM_COMPLETED_MAP)
		giveRewards(ent)
		if not ent.hasDiedOnce and not (game.GetMap() == "d1_trainstation_01" or game.GetMap() == "d1_trainstation_02" or game.GetMap() == "d1_trainstation_03" or game.GetMap() == "d1_trainstation_04" or game.GetMap() == "d1_trainstation_05") then
			bonusCoins = 25 * GetConVar("hl2c_difficulty"):GetInt()
			bonusXP = 50 * GetConVar("hl2c_difficulty"):GetInt()
			AddXP(ent, bonusXP)
			AddCoins(ent, bonusCoins)
		elseif not ent.crowbarOnly and not (game.GetMap() == "d1_trainstation_01" or game.GetMap() == "d1_trainstation_02" or game.GetMap() == "d1_trainstation_03" or game.GetMap() == "d1_trainstation_04" or game.GetMap() == "d1_trainstation_05") then
			bonusCoins = 45 * GetConVar("hl2c_difficulty"):GetInt()
			bonusXP = 75 * GetConVar("hl2c_difficulty"):GetInt()
			AddXP(ent, bonusXP)
			AddCoins(ent, bonusCoins)
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

function ENT:Think()
	
	playerCount = #player.GetAll()
	local addOne = 0
	local subOne = 0
	if playerCount > 0 and playerCount <= 5 then
		addOne = 1
	end
	if timer.Exists("MapTimer") then
		if GetConVar("hl2c_survivalmode"):GetInt() == 1 then
			subOne = team.NumPlayers(TEAM_DEAD)
		end
	end
	
	if team.NumPlayers(TEAM_COMPLETED_MAP) >= team.NumPlayers(TEAM_ALIVE) + addOne - subOne then
		for k, p in pairs(player.GetAll()) do
			if not displayOnce then
				p:ChatPrint("Enough players have completed, changing map in 20 seconds")
				displayOnce = true
				net.Start("DisplayMapTimer")
				net.Broadcast()
				timer.Create("MapTimer", 20, 0, function() hook.Call("OnChangeLevel") timer.Remove("MapTimer") end)
			end
		end
	end
end

