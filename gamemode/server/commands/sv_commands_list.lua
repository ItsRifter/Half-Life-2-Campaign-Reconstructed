local neededVotes = #player.GetAll()
local lobbyVotes = 0
local hasVotedLobby = false
BringPet = true

hook.Add("PlayerSay", "Commands", function(ply, text)
	if (string.lower(text) == "!ach" or string.lower(text) == "!achievement" ) then
		net.Start("Open_Ach_Menu")
			net.WriteTable(ply.hl2cPersistent)
		net.Send(ply)
		return ""
	end
	
	if (string.lower(text) == "!petpanic" or string.lower(text) == "!panicpet") then
		net.Start("PetPanic")
		net.Send(ply)
		return ""
	end
	
	if (string.lower(text) == "!petsummon" or string.lower(text) == "!spawnpet" ) then
		if tonumber(ply.hl2cPersistent.Level) >= 10 then
			if not ply.petAlive then
				spawnPet(ply)
				ply:SetNWString("PetOwnerName", ply:Nick())
			elseif ply.petAlive then
				ply:ChatPrint("Your pet has already been summoned!")
			end
		else
			ply:ChatPrint("You don't have access to pets")
		end
		return ""
	end
	
	
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
		end
		if duel then
			ply:ChatPrint("You can't remove your pet in a duel!")
			return ""
		end

		if ply.pet:Health() == ply.pet:GetMaxHealth() then
			ply.pet:Remove()
			ply.petAlive = false
			net.Start("ClosePets")
			net.Send(ply)
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
		AddCoins(duelUnaccepted.challenger, -duel.bet)
		AddCoins(duelUnaccepted.challengee, -duel.bet)

		duelUnaccepted.accepted = true

		PetDuelBegin(duelUnaccepted.challenger, duelUnaccepted.challengee, bet)
		return ""
	end
	
	if (string.lower(text) == "!petduel" or string.lower(text) == "!duelpet") then
		net.Start("PetDuel")
			net.WriteEntity(ply.pet)
		net.Send(ply)
		return ""
	end

	if (string.lower(text) == "!pet") then
			if tonumber(ply.hl2cPersistent.Level) >= 10 then
				if game.GetMap() == "d1_trainstation_01" or game.GetMap() == "d1_trainstation_02" or game.GetMap() == "d1_trainstation_03" or  game.GetMap() == "d1_trainstation_04" or game.GetMap() == "d1_trainstation_05" then
					ply:ChatPrint("Pets are disabled on this map")
				else
					net.Start("Open_Pet_Menu")
					net.WriteInt(ply:GetNWInt("PetSkills"), 16)
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
			if not ply:IsOnGround() and ply:GetSequence() != 199 and ply:GetSequence() != 122 then
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
			if not hasVotedLobby then
				lobbyVotes = lobbyVotes + 1
				hasVotedLobby = true
				if lobbyVotes == neededVotes then
					RunConsoleCommand("changelevel", "hl2c_lobby_remake")
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
		if ply:InVehicle() and not hasSeat then
			ply.hasSeat = true
			local vehicle = ply:GetVehicle()
			local seat = ents.Create("prop_vehicle_prisoner_pod")
			if vehicle == "prop_vehicle_jeep" then
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
				ply.seat = seat
				ply:ChatPrint("Passenger seat added")
			elseif vehicle:GetVehicle() == "prop_vehicle_airboat" then
				ply:ChatPrint("You can't have a passenger seat on an airboat!")
			end
		elseif ply.hasSeat then
			ply:ChatPrint("You already have a passenger seat!")
		else
			ply:ChatPrint("You can't use this command while not in a vehicle!")
		end
	return ""
	end
end)

net.Receive("SetSuicide", function()
	GetConVar("hl2c_allowsuicide"):SetInt(net.ReadInt(16))
end)

function AddCoins(ply, amount)
	ply.hl2cPersistent.Coins = ply.hl2cPersistent.Coins + amount
	ply:SetNWInt("Coins", math.Round(ply.hl2cPersistent.Coins))
end

net.Receive("AddCoins", function(len, ply, coin)
	local coins = net.ReadInt(32)
	AddCoins(ply, coins)
end)

net.Receive("SurvMode", function(len, ply, survInt)
	local surv = net.ReadInt(8)
	GetConVar("hl2c_survivalmode"):SetInt(surv)
end)

