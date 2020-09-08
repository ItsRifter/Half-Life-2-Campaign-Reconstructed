ENT.Base = "base_brush"
ENT.Type = "brush"

function ENT:Initialize()

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
		if game.GetMap() != "d1_trainstation_01" or game.GetMap() != "d1_trainstation_02" or game.GetMap() != "d1_trainstation_03" or
		game.GetMap() != "d1_trainstation_04" or game.GetMap() != "d1_trainstation_05" then
			giveRewards(ent)
			if not ent.hasDiedOnce and not (game.GetMap() == "d1_trainstation_01" or game.GetMap() == "d1_trainstation_02" or game.GetMap() == "d1_trainstation_03" or game.GetMap() == "d1_trainstation_04" or game.GetMap() == "d1_trainstation_05") then
				bonusCoins = 25 * GetConVar("hl2cr_difficulty"):GetInt()
				bonusXP = 50 * GetConVar("hl2cr_difficulty"):GetInt()
				AddXP(ent, bonusXP)
				AddCoins(ent, bonusCoins)
			elseif not ent.crowbarOnly and not (game.GetMap() == "d1_trainstation_01" or game.GetMap() == "d1_trainstation_02" or game.GetMap() == "d1_trainstation_03" or game.GetMap() == "d1_trainstation_04" or game.GetMap() == "d1_trainstation_05") then
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

function ENT:Think()
	
	playerCount = #player.GetAll()
	local addOne = 0
	local subOne = 0
	if playerCount > 0 and playerCount <= 5 then
		addOne = 1
	end
	if timer.Exists("MapTimer") then
		if GetConVar("hl2cr_survivalmode"):GetInt() == 1 then
			subOne = team.NumPlayers(TEAM_DEAD)
		end
	end
	
	if team.NumPlayers(TEAM_COMPLETED_MAP) >= team.NumPlayers(TEAM_ALIVE) + addOne - subOne and not (game.GetMap() == "d1_eli_01" or game.GetMap() == "d1_town_05" or game.GetMap() == "d3_citadel_01" or game.GetMap() == "d3_citadel_05" or game.GetMap() == "d3_breen_01") then
		for k, p in pairs(player.GetAll()) do
			if not displayOnce then
				p:ChatPrint("Enough players have completed, changing map in 20 seconds")
				displayOnce = true
				net.Start("DisplayMapTimer")
				net.Broadcast()
				timer.Create("MapTimer", 20, 0, function() hook.Call("OnChangeLevel") timer.Remove("MapTimer") end)
			end
		end
	elseif team.NumPlayers(TEAM_COMPLETED_MAP) == 1 and (game.GetMap() == "d1_eli_01" or game.GetMap() == "d1_town_05" or game.GetMap() == "d3_citadel_01" or game.GetMap() == "d3_citadel_05" or game.GetMap() == "d3_breen_01") then
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

function EndHL2Game()
	for k, p in pairs(player.GetAll()) do
		if not displayOnce then
			p:ChatPrint("Congratulations on finishing Half-Life 2!, returning to lobby in 35 seconds")
			displayOnce = true
			game.SetGlobalState("super_phys_gun", 0)
			net.Start("DisplayMapTimer")
			net.Broadcast()
			timer.Create("MapTimer", 35, 0, function() hook.Call("OnChangeLevel") timer.Remove("MapTimer") end)
		end
	end
end
