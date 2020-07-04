BringPet = true
lobbyVotes = 0
hook.Add("PlayerSay", "Commands", function(ply, text)
	
	--Worthless secret for worthless achievement hunter
	if (string.lower(text) == "!gimmeasecret") then
		Achievement(ply, "Worthless_Secret", "Lobby_Ach_List", 0)
		return ""
	end
	
	if (string.lower(text) == "!cp") then
		--If the player can use !cp command, teleport them to the checkpoint
		if ply.CPTP then
			for k, sp in pairs(ents.FindByClass("info_player_start")) do
				ply:SetPos(sp:GetPos())
				ply.CPTP = false
			end
		end
		return ""
	end
	
	--Views the achievements the player has
	if (string.lower(text) == "!ach" or string.lower(text) == "!achievement" ) then
		net.Start("Open_Ach_Menu")
			net.WriteTable(ply.hl2cPersistent.Achievements)
			net.WriteTable(ply.hl2cPersistent.Vortexes)
		net.Send(ply)
		return ""
	end
	
	--if pets don't go as intended, force close it
	if (string.lower(text) == "!petpanic" or string.lower(text) == "!panicpet") then
		net.Start("PetPanic")
		net.Send(ply)
		return ""
	end
	
	--spawns the players pet unless they already exist or have no access to it
	if (string.lower(text) == "!petsummon" or string.lower(text) == "!spawnpet" ) then
		if tonumber(ply.hl2cPersistent.Level) >= 10 then
			if not ply.petAlive then
				spawnPet(ply)
			else
				ply:ChatPrint("Your pet has already been summoned!")
			end
		else
			ply:ChatPrint("You don't have access to pets")
		end
		return ""
	end
	
	--CMD for naming pets
	if string.find(string.lower(text),"!petname ") then
		ply:ChatPrint("You've change your pets name to" .. string.sub(text,9))
		ply.hl2cPersistent.PetName = string.sub(text,9)
		ply:SetNWString("PetName", ply.hl2cPersistent.PetName)
		return ""
	end

	--access the difficulty menu
	if (string.lower(text) == "!diff" or string.lower(text) == "!difficulty" ) then
		net.Start("Open_Diff_Menu")
			net.WriteInt(GetConVar("hl2c_difficulty"):GetInt(), 8)
			net.WriteInt(GetConVar("hl2c_survivalmode"):GetInt(), 8)
		net.Send(ply)
		return ""
	end

	-- Find duel, if one is returned, ply is part of a running duel
	local duel = GetDuelAccepted(ply)
	
	if (string.lower(text) == "!bringpet" or string.lower(text) == "!petbring") then
		if not ply.pet:IsValid() then
			ply:ChatPrint("Your pet doesn't exist!")
			return ""
		end
		if duel then
			ply:ChatPrint("You can't bring your pet while in a duel!")
			return ""
		end
		
		if BringPet then -- This is a global variable shared between all players, i doubt it does what it is supposed to do!
			ply.pet:SetPos(ply:GetPos())
			BringPet = false
			timer.Create("BringCooldown", 7, 0, function()
				BringPet = true
			end)
		else
			ply:ChatPrint("You need to wait " .. math.Round(timer.TimeLeft("BringCooldown")) .. " seconds \nbefore bringing your pet again")
		end
		return ""
	end
	if (string.lower(text) == "!removepet" or string.lower(text) == "!petremove") then
		if not ply.pet:IsValid() then
			ply:ChatPrint("Your pet doesn't exist!")
			return ""		
		elseif duel then
			ply:ChatPrint("You can't remove your pet in a duel!")
			return ""
		end

		if ply.pet:Health() == ply.pet:GetMaxHealth() then
			ply.pet:Remove()
			net.Start("ClosePets")
			net.Send(ply)
			ply.petAlive = false
			ply:SetNWBool("PetActive", false)
		else
			ply:ChatPrint("Your pet needs to be at full health to be removed")
		end
		return ""
	end
	
	if (string.lower(text) == "!declineduel") then
		-- Get unaccepted duel
		local duelUnaccepted = GetDuelByChallengee(ply, false)
		if not duelUnaccepted then
			ply:ChatPrint("Nobody has challenged you")
			return ""
		end

		duelUnaccepted.challenger:ChatPrint(string.format("%s has declined your pet challenge", duelUnaccepted.challengee:Nick()))
		duelUnaccepted.challengee:ChatPrint(string.format("You have declined %s's challenge", duelUnaccepted.challenger:Nick()))
		RemoveDuel(duelUnaccepted.challenger, duelUnaccepted.challengee)
		return ""
	end

	if (string.lower(text) == "!acceptduel") then
		if duel then
			ply:ChatPrint("You are already in a duel with %s!", duel.challenger)
			return ""
		end
		-- Get unaccepted duel
		local duelUnaccepted = GetDuelByChallengee(ply, false)
		if not duelUnaccepted then
			ply:ChatPrint("Nobody has challenged you")
			return ""
		end

		duelUnaccepted.challenger:ChatPrint(string.format("%s has accepted your duel", duelUnaccepted.challengee:Nick()))
		duelUnaccepted.challengee:ChatPrint(string.format("You have accepted %s's challenge", duelUnaccepted.challenger:Nick()))

		-- TODO: Check if both players have enough money to bet
		AddCoins(duelUnaccepted.challenger, -duelUnaccepted.bet)
		AddCoins(duelUnaccepted.challengee, -duelUnaccepted.bet)

		duelUnaccepted.accepted = true

		PetDuelBegin(duelUnaccepted.challenger, duelUnaccepted.challengee, bet)
		return ""
	end
	
	if (string.lower(text) == "!petduel" or string.lower(text) == "!duelpet") then
		net.Start("PetDuel")
		net.Send(ply)
		return ""
	end

	if (string.lower(text) == "!pet") then
			if tonumber(ply.hl2cPersistent.Level) >= 10 then
				if game.GetMap() == "d1_trainstation_01" or game.GetMap() == "d1_trainstation_02" or game.GetMap() == "d1_trainstation_03" or  game.GetMap() == "d1_trainstation_04" or game.GetMap() == "d1_trainstation_05" then
					ply:ChatPrint("Pets are disabled on this map")
				else
					net.Start("Open_Pet_Menu")
						net.WriteInt(ply.hl2cPersistent.PetSkills, 16)
						net.WriteInt(ply.hl2cPersistent.PetPoints, 16)
						net.WriteInt(ply.hl2cPersistent.PetStage, 16)
					net.Send(ply)
				end
			else
				ply:ChatPrint("You need to be at a certain level\nto unlock pets")
			end
		return ""
	end
	
	if (string.lower(text) == "!unstuck") then
	ply:ChatPrint("Checking if you are stuck...")
		timer.Simple(5, function()
			if not ply:IsOnGround() and ply:GetSequence() ~= 199 and ply:GetSequence() ~= 122 then
				ply:ChatPrint("You appear to be stuck, Unstucking...")
				IsStuck(ply)
			else
				ply:ChatPrint("You don't appear to be stuck, if you really are ask an admin or commit suicide")
			end
		end)
		return ""
	end
	if (string.lower(text) == "!lobby") then
		if game.GetMap() != "hl2c_lobby_remake" then
			if not ply.hasVotedLobby then
				lobbyVotes = lobbyVotes + 1
				ply.hasVotedLobby = true
				for k, v in pairs(player.GetAll()) do
					v:ChatPrint(ply:Nick() .. " Has voted to return to the lobby: " .. lobbyVotes .. "/" .. neededVotes)
				end
				if lobbyVotes == neededVotes then
					ply:ChatPrint("Enough players have voted to return the lobby, returning in 10 seconds")
					timer.Simple(10, function()
						RunConsoleCommand("changelevel", "hl2c_lobby_remake")
					end)
				end
			else
				ply:ChatPrint("You already voted to return to the lobby!")
			end
		else
			ply:ChatPrint("You are currently in the lobby!")
		end
	return ""
	end
	
	if (string.lower(text) == "!seats") then
		if ply:InVehicle() and not ply.hasSeat then
			local vehicle = ply:GetVehicle()
			local seat = ents.Create("prop_vehicle_prisoner_pod")
			seat:SetPos(vehicle:LocalToWorld( Vector( 21, -32, 18 ) ))
			seat:SetModel("models/nova/jeep_seat.mdl")
			seat:SetAngles(vehicle:LocalToWorldAngles(Angle(0,-3.5, 0) ))
			seat:Spawn()
			seat:SetOwner(nil)
			seat:SetKeyValue("limitview", "1")
			seat:SetMoveType( MOVETYPE_NONE )
			seat:SetParent( vehicle, -1 );
			seat:SetNoDraw( false )
			vehicle:SetKeyValue("EnablePassengerSeat", 1)
			ply:ChatPrint("Passenger seat added")
			ply.hasSeat = true
		elseif ply.hasSeat then
			ply:ChatPrint("You already have a passenger seat!")
		else
			ply:ChatPrint("You can't use this command while not in a vehicle!")
		end
	return ""
	end
end)

function AddCoins(ply, amount)
	ply.hl2cPersistent.Coins = ply.hl2cPersistent.Coins + amount
	ply:SetNWInt("Coins", math.Round(ply.hl2cPersistent.Coins))
end

function AddEssen(ply, amount)
	ply.hl2cPersistent.Essence = ply.hl2cPersistent.Essence + amount
	ply:SetNWInt("Essence", math.Round(ply.hl2cPersistent.Essence))
end

function AddCryst(ply, amount)
	ply.hl2cPersistent.Cryst = ply.hl2cPersistent.Cryst + amount
	ply:SetNWInt("Cryst", math.Round(ply.hl2cPersistent.Cryst))
end

function SubCoins(ply, amount)
	ply.hl2cPersistent.Coins = ply.hl2cPersistent.Coins - amount
	ply:SetNWInt("Coins", math.Round(ply.hl2cPersistent.Coins))
end

function SubEssen(ply, amount)
	ply.hl2cPersistent.Essence = ply.hl2cPersistent.Essence - amount
	ply:SetNWInt("Essence", math.Round(ply.hl2cPersistent.Essence))
end

function SubCryst(ply, amount)
	ply.hl2cPersistent.Cryst = ply.hl2cPersistent.Cryst - amount
	ply:SetNWInt("Cryst", math.Round(ply.hl2cPersistent.Cryst))
end

net.Receive("SurvMode", function(len, ply, survInt)
	local surv = net.ReadInt(8)
	GetConVar("hl2c_survivalmode"):SetInt(surv)
end)

concommand.Add("hl2cr_givexp", function(ply, cmd, args)
	local int = tonumber(args[1])
	
	if ply:IsAdmin() then
		if int then
			AddXP(ply, int)
			ply:PrintMessage(HUD_PRINTCONSOLE, int)
		elseif not int then
			ply:PrintMessage(HUD_PRINTCONSOLE, "Invalid Value")
		end
	else
		ply:PrintMessage(HUD_PRINTCONSOLE, "You do not have access to this command")
	end
end)

concommand.Add("hl2cr_allowsuicide", function(ply, cmd, args)
	local int = tonumber(args[1])
	if ply:IsAdmin() then
		if int == 1 then
			GetConVar("hl2c_allowsuicide"):SetInt(int)
			ply:PrintMessage(HUD_PRINTCONSOLE, "Suicide enabled")
		elseif int == 0 then
			GetConVar("hl2c_allowsuicide"):SetInt(int)
			ply:PrintMessage(HUD_PRINTCONSOLE, "Suicide disabled")
		else
			ply:PrintMessage(HUD_PRINTCONSOLE, "INVALID VALUE")
		end
	else
		ply:PrintMessage(HUD_PRINTCONSOLE, "You do not have access to this command")
	end
end)

concommand.Add("hl2cr_setmaxxp", function(ply, cmd, args)
	local maxXP = tonumber(args[1])
	if ply:IsAdmin() then
		if maxXP >= 0 then
			ply.hl2cPersistent.MaxXP = maxXP
			ply:SetNWInt("maxXP", math.Round(ply.hl2cPersistent.MaxXP))
		else
			ply:PrintMessage(HUD_PRINTCONSOLE, "Invalid Value")
		end
	else
		ply:PrintMessage(HUD_PRINTCONSOLE, "You do not have access to this command")
	end
end)

concommand.Add("hl2cr_setlevel", function(ply, cmd, args)
	local level = tonumber(args[1])
	if ply:IsAdmin() then
		if level >= 0 then
			ply.hl2cPersistent.Level = level
			ply.hl2cPersistent.XP = 0
			ply:SetNWInt("Level", ply.hl2cPersistent.Level)
		else
			ply:PrintMessage(HUD_PRINTCONSOLE, "Invalid Value")
		end
	else
		ply:PrintMessage(HUD_PRINTCONSOLE, "You do not have access to this command")
	end
end)

concommand.Add("hl2cr_addcoins", function(ply, cmd, args)
	local coins = tonumber(args[1])
	if ply:IsAdmin() then
		if coins >= 0 then
			AddCoins(ply, coins)
		else
			ply:PrintMessage(HUD_PRINTCONSOLE, "Invalid Value")
		end
	else
		ply:PrintMessage(HUD_PRINTCONSOLE, "You do not have access to this command")
	end
end)

concommand.Add("hl2cr_addessence", function(ply, cmd, args)
	local essen = tonumber(args[1])
	if ply:IsAdmin() then
		if essen >= 0 then
			AddEssen(ply, essen)
		else
			ply:PrintMessage(HUD_PRINTCONSOLE, "Invalid Value")
		end
	else
		ply:PrintMessage(HUD_PRINTCONSOLE, "You do not have access to this command")
	end
end)

concommand.Add("hl2cr_addcrystals", function(ply, cmd, args)
	local crystals = tonumber(args[1])
	if ply:IsAdmin() then
		if crystals >= 0 then
			AddCryst(ply, crystals)
		else
			ply:PrintMessage(HUD_PRINTCONSOLE, "Invalid Value")
		end
	else
		ply:PrintMessage(HUD_PRINTCONSOLE, "You do not have access to this command")
	end
end)

concommand.Add("hl2cr_difficulty", function(ply, cmd, args)
	local diff = tonumber(args[1])
	if ply:IsAdmin() then
		if diff >= 1 and diff <= 3 then
			SetDiffMode(diff)
		else
			ply:PrintMessage(HUD_PRINTCONSOLE, "Invalid Value")
		end
	else
		ply:PrintMessage(HUD_PRINTCONSOLE, "You do not have access to this command")
	end
end)

concommand.Add("hl2cr_survival", function(ply, cmd, args)
	local surv = tonumber(args[1])
	if ply:IsAdmin() then
		if surv == 0 or surv == 1 then
			SetSurvMode(surv)
		else
			ply:PrintMessage(HUD_PRINTCONSOLE, "Invalid Value")
		end
	else
		ply:PrintMessage(HUD_PRINTCONSOLE, "You do not have access to this command")
	end
end)

concommand.Add("hl2cr_petsummon", function(ply, cmd, args)
	local level = ply.hl2cPersistent.Level
	if tonumber(level) >= 10 then
		if not ply.petAlive then
			spawnPet(ply)
			ply:SetNWString("PetOwnerName", ply:Nick())
		else
			ply:ChatPrint("You can only summon your pet once every life!")
		end
	elseif tonumber(level) < 10 then
		ply:ChatPrint("You don't have access to pets")
	end
end)

concommand.Add("hl2cr_petpoints", function(ply, cmd, args)
	local petPoints = tonumber(args[1])
	print(tonumber(args[1]))
	if ply:IsAdmin() then
		ply.hl2cPersistent.PetPoints = ply.hl2cPersistent.PetPoints + petPoints
	else
		ply:ChatPrint("You don't have access to this command")
	end
end)

concommand.Add("hl2cr_petlevel", function(ply, cmd, args)
	local newLevel = tonumber(args[1])
	print(tonumber(args[1]))
	if ply:IsAdmin() then
		ply.hl2cPersistent.PetLevel = newLevel
		ply:SetNWInt("PetLevel", ply.hl2cPersistent.PetLevel)
	else
		ply:ChatPrint("You don't have access to this command")
	end
end)

concommand.Add("hl2cr_petstage", function(ply, cmd, args)
	local newStage = tonumber(args[1])
	print(tonumber(args[1]))
	if ply:IsAdmin() then
		ply.hl2cPersistent.PetStage = newStage
		ply:SetNWInt("PetStage", ply.hl2cPersistent.PetStage)
	else
		ply:ChatPrint("You don't have access to this command")
	end
end)

concommand.Add("hl2cr_petresetskills", function(ply, cmd, args)
	if ply:IsAdmin() then
		ply.hl2cPersistent.PetSkills = 0
	else
		ply:ChatPrint("You don't have access to this command")
	end
end)