local lobbyVotes = 0
local restartVotes = 0 
oldModel = ""
local playerFound = false
local inSquad = false

local timer = 3600 + CurTime()
local petbringTime = 0

hook.Add("Think", "LobbyTimer", function()
	if game.GetMap() != "hl2c_lobby_remake" then
		if timer <= CurTime() then
			RunConsoleCommand("changelevel", "hl2c_lobby_remake")
		end
	end
end)

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
			net.WriteTable(ply.hl2cPersistent.Lambdas)
		net.Send(ply)
		return ""
	end
	
	--Squads
	
	--If the player inputs no name for the new squad
	if string.lower(text) == "!squadcreate" or string.lower(text) == "!createsquad" then
		ply:ChatPrint("You need a name for your squad!")
		return ""
	end
	
	--If the player decides to create a squad with a name
	if string.find(string.lower(text), "!squadcreate ") or string.find(string.lower(text), "!createsquad ") then
		local squadNewName = string.sub(text, 13)

		if ply.squads.leader != ply:Nick() and not ply.inSquad then
			
			ply.squads.leader = ply:Nick()
			ply.squads.teamname = squadNewName
			ply:SetNWString("SquadLeader", ply.squads.leader)
			ply:SetNWString("TeamName", ply.squads.teamname)
			
			ply:ChatPrint("You have created a squad with name:" .. squadNewName)
			net.Start("Squad_Created")
				net.WriteString(ply:Nick())
				net.WriteString(squadNewName)
			net.Send(ply)
		elseif ply.squads.leader == ply:Nick() then
			ply:ChatPrint("You already have a squad!")
		elseif ply.inSquad then
			ply:ChatPrint("You can't create a squad while in another")
		end
		return ""
	end
	
	if string.lower(text) == "!squadleave" or string.lower(text) == "!leavesquad" then
		if ply.inSquad and ply.squads.leader != ply:Nick() then
			ply:ChatPrint("You have left " .. ply.squads.leader .. "'s Squad")
			ply.squads.teamname = ""
			ply.squads.leader = ""
			ply:SetNWString("TeamName", ply.squads.teamname)
			ply:SetNWString("SquadLeader", ply.squads.leader)
			ply.inSquad = false
			net.Start("Squad_Left")
				net.WriteString(ply:Nick())
			net.Broadcast()
		elseif ply.squads.leader == ply:Nick() then
			ply:ChatPrint("You can't leave your own squad without disbanding it")
		else
			ply:ChatPrint("You aren't in a squad")
		end
		return ""
	end
	
	if string.lower(text) == "!squadjoin" or string.lower(text) == "!joinsquad" then
		ply:ChatPrint("You need to specify a player name for the squad you're joining!")
		return ""
	end
	
	if string.find(string.lower(text), "!squadjoin ") or string.find(string.lower(text), "!joinsquad ") then
		local targetName = string.sub(text, 12)
			for k, v in pairs(player.GetAll()) do
				if v != ply then
					if string.find(string.lower(v:Nick()), targetName) then
						local leaderName = v:GetNWString("SquadLeader")
						local teamName = v:GetNWString("TeamName")
						playerFound = true
					end
				end
			end
			if not ply.inSquad and (teamName and leaderName) and not string.find(string.lower(ply.squads.leader), string.lower(ply:Nick())) then
				ply.squads.teamname = teamName
				ply.squads.leader = leaderName
				ply.inSquad = true
				net.Start("Squad_Joined")
					net.WriteString(ply:Nick())
					net.WriteString(ply.squads.leader)
					net.WriteString(ply.squads.teamname)
				net.Broadcast()
			elseif ply.inSquad then
				ply:ChatPrint("You are currently in a squad, leave to join another")
			elseif string.find(string.lower(ply.squads.leader), string.lower(ply:Nick())) then
				ply:ChatPrint("You can't join yourself")
			end
		return ""
	end
	
	if (string.lower(text) == "!squaddisband" or string.lower(text) == "!disbandsquad") then
		if ply.squads.leader != "" then
			net.Start("Squad_Disband")
				net.WriteString(ply.squads.leader)
			net.Broadcast()
			ply.squads.leader = ""
			ply.squads.teamname = ""
			ply:SetNWString("SquadLeader", ply.squads.leader)
			ply:SetNWString("TeamName", ply.squads.teamname)
			ply:ChatPrint("You have dismissed your squad")
			ply.inSquad = false
		else
			ply:ChatPrint("You have no squad!")
		end
		return ""
	end
	
	--if pets don't go as intended, force close it
	if (string.lower(text) == "!petpanic" or string.lower(text) == "!panicpet") then
		net.Start("PetPanic")
		net.Send(ply)
		return ""
	end
	--[[
	--Make the pet follow the player
	if (string.lower(text) == "!petfollow") then
		if ply.pet:IsValid() then
			ply:ChatPrint("Your pet is now following you")
			
			
		else
			ply:ChatPrint("Your pet doesn't exist!")
		end
		return ""
	end
	--]]
	--spawns the players pet unless they already exist or have no access to it
	if (string.lower(text) == "!petsummon" or string.lower(text) == "!spawnpet" ) then
		if ply.hl2cPersistent.Level >= 10 then
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
	
	if (string.lower(text) == "!petname") then
		ply:ChatPrint("You can't name your pet like that")
		return ""
	end
	
	--Loyal Combine
	
	if (string.lower(text) == "!loyal") then
		if ply.canBecomeLoyal and not ply.loyal then
			ply.oldModel = ply:GetModel()
			ply:SetModel("models/player/combine_soldier.mdl")
			ply.loyal = true
			ply:SetTeam(TEAM_LOYAL)
			ply:Spawn()
			ply:StripWeapons()
			local weaponsRand = math.random(1, 3)
			local statsRand = math.random(1, 3)
			
			ply:Give("weapon_stunstick")
			if weaponsRand == 1 then
				ply:Give("weapon_smg1")
				ply:GiveAmmo(225, "SMG1", true)
				ply:GiveAmmo(3, "weapon_frag", true)
			elseif weaponsRand == 2 then
				ply:Give("weapon_ar2")
				ply:GiveAmmo(60, "AR2", true)
				ply:GiveAmmo(3, "weapon_frag", true)
			elseif weaponsRand == 3 then
				ply:Give("weapon_shotgun")
				ply:GiveAmmo(30, "Buckshot", true)
				ply:GiveAmmo(3, "weapon_frag", true)
			end
			
			if statsRand == 1 then
				ply:SetMaxHealth(125)
				ply:SetHealth(125)
				ply:SetArmor(35)
			elseif statsRand == 2 then
				ply:SetMaxHealth(150)
				ply:SetHealth(150)
				ply:SetArmor(65)
			elseif statsRand == 3 then
				ply:SetMaxHealth(200)
				ply:SetHealth(200)
				ply:SetArmor(100)
			end
			
			if game.GetMap() == "d2_coast_10" then
				local randSpot = math.random(1, 3)
				if randSpot == 1 then
					ply:SetPos(Vector(6111, 208, 941))
				elseif randSpot == 2 then
					ply:SetPos(Vector(8226, 1486, 1235))
				elseif randSpot == 3 then
					ply:SetPos(Vector(5362, 1026, 1078))
				end
			end
		elseif ply.loyal then
			ply:ChatPrint("You are already a loyal combine!")
		else
			ply:ChatPrint("The combine is not looking for loyal citizens yet")
		end
		return ""
	end
	
	--CMD for naming pets
	if string.find(string.lower(text),"!petname ") then
		ply:ChatPrint("You've changed your pets name to" .. string.sub(text,9))
		ply.hl2cPersistent.PetName = string.sub(text,9)
		ply:SetNWString("PetName", ply.hl2cPersistent.PetName)
		return ""
	end

	--access the difficulty menu
	if (string.lower(text) == "!diff" or string.lower(text) == "!difficulty" ) then
		net.Start("Open_Diff_Menu")
			net.WriteInt(GetConVar("hl2cr_difficulty"):GetInt(), 8)
			net.WriteInt(GetConVar("hl2cr_survivalmode"):GetInt(), 8)
			net.WriteInt(ply:GetNWInt("EasyVotes"), 8)
			net.WriteInt(ply:GetNWInt("MediumVotes"), 8)
			net.WriteInt(ply:GetNWInt("HardVotes"), 8)
			net.WriteInt(ply:GetNWInt("SurvVotes"), 8)
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
		
		if ply.BringPet then -- This is a global variable shared between all players, i doubt it does what it is supposed to do!
			ply.pet:SetPos(ply:GetPos())
			ply.pet:SetAngles(ply:GetAngles())
			beginPetBringTimer(ply)
			return ""
		else
			showTimerPet(ply)
			return ""
		end
	return ""
	end
	if (string.lower(text) == "!removepet" or string.lower(text) == "!petremove") then
		if not ply.pet or not ply.pet:IsValid() then
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
		if not ply:IsOnGround() and ply:GetSequence() != 199 and ply:GetSequence() != 122 then
			ply:ChatPrint("You appear to be stuck, Unstucking...")
			IsStuck(ply)
		else
			ply:ChatPrint("You don't appear to be stuck, if you really are ask an admin or commit suicide")
		end
		return ""
	end
	if (string.lower(text) == "!lobby") then
		if game.GetMap() != "hl2c_lobby_remake" then
			if not ply.hasVotedLobby then
				lobbyVotes = lobbyVotes + 1
				ply:SetNWInt("PlayerVotesLobby", lobbyVotes)
				ply.hasVotedLobby = true
				for k, v in pairs(player.GetAll()) do
					v:ChatPrint(ply:Nick() .. " Has voted to return to the lobby: " .. lobbyVotes .. "/" .. ply:GetNWInt("LobbyVotes") )
				end
				if lobbyVotes == ply:GetNWInt("LobbyVotes") then
					game.SetGlobalState("super_phys_gun", 0)
					ply:ChatPrint("Enough players have voted to return the lobby, returning in 10 seconds")
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
	if (string.lower(text) == "!restart" or string.lower(text) == "!vrm") then
		if game.GetMap() != "hl2c_lobby_remake" then
			if not ply.hasVotedRestart then
				restartVotes = restartVotes + 1
				ply.hasVotedRestart = true
				for k, v in pairs(player.GetAll()) do
					v:ChatPrint(ply:Nick() .. " has voted to return to restart the map: " .. restartVotes .. "/" .. ply:GetNWInt("RestartVotes"))
				end
				if restartVotes >= ply:GetNWInt("RestartVotes") then
					ply:ChatPrint("Enough players have voted to restart the map")
					RunConsoleCommand("changelevel", game.GetMap()) 
				end
			else
				ply:ChatPrint("You already voted to return to restart the map!")
			end
		else
			ply:ChatPrint("Why restart in the lobby?")
		end
	return ""
	end
	
	if (string.lower(text) == "!time") then
		if game.GetMap() == "hl2c_lobby_remake" then
			ply:ChatPrint("Time is infinite while in the lobby")
		else
			ply:ChatPrint(math.Round(3600 - CurTime(), 0) .. " seconds left before returning to lobby")
		end
		return ""
	end
	
	if (string.lower(text) == "!seats") then
		if ply:InVehicle() and not ply.hasSeat then
			local vehicle = ply:GetVehicle()
			if not vehicle:GetClass() == "prop_vehicle_jeep" then return end
			local seat = ents.Create("prop_vehicle_prisoner_pod")
			seat:SetPos(vehicle:LocalToWorld( Vector( 31, -32, 18 ) ))
			seat:SetModel("models/nova/jeep_seat.mdl")
			seat:SetAngles(vehicle:LocalToWorldAngles(Angle(0, -3.5, 0) ))
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

function beginPetBringTimer(ply)
	ply.petbringTime = 7 + CurTime()
	if not ply then return end
	hook.Add("Think", "petTimer", function()
		if ply.petbringTime <= CurTime() and ply:IsValid() then
			ply.BringPet = true
		end
	end)
end

local function showTimerPet(ply)
	ply:ChatPrint("You need to wait " .. math.Round(ply.petbringTime - CurTime()) .. " before bringing again")
end

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

concommand.Add("hl2cr_wipeinv", function(ply, cmd, args, argStr)
	local target = string.sub(args[1], 0)
	if ply:IsAdmin() then
		for k, v in pairs(player.GetAll()) do
			if v != ply and target != "" then
				if string.find(string.lower(v:Nick()), string.lower(target)) then
					target = v
				end
			else
				target = ply
			end
		end
		if target then
			table.Empty(target.hl2cPersistent.Inventory)
			target:ChatPrint("Your inventory has been wiped by an admin")
		end
	else
		ply:PrintMessage(HUD_PRINTCONSOLE, "You do not have access to this command")
	end
end)
concommand.Add("hl2cr_givexp", function(ply, cmd, args, argStr)
	local int = tonumber(args[1])
	local target = ""
	if args[2] then
		target = string.sub(args[2], 0)
	end
	
	if ply:IsAdmin() then
		for k, v in pairs(player.GetAll()) do
			if string.match(string.lower(v:Nick()), tostring(target)) then
				target = v
			end
		end
		
		if target and int then
			AddXP(target, int)
			target:ChatPrint("You have been given " .. int .. "xp by an admin")
		else
			ply:PrintMessage(HUD_PRINTCONSOLE, "Invalid Value")
		end
	else
		ply:PrintMessage(HUD_PRINTCONSOLE, "You do not have access to this command")
	end
end)

concommand.Add("hl2cr_cp", function(ply, cmd, args)
	if ply:IsAdmin() then
		SetUpMap()
	else
		ply:PrintMessage(HUD_PRINTCONSOLE, "You do not have access to this command")
	end
end)

concommand.Add("hl2cr_setsuicide", function(ply, cmd, args)
	local int = tonumber(args[1])
	if ply:IsAdmin() then
		if int == 1 then
			GetConVar("hl2cr_allowsuicide"):SetInt(int)
			ply:PrintMessage(HUD_PRINTCONSOLE, "Suicide enabled")
		elseif int == 0 then
			GetConVar("hl2cr_allowsuicide"):SetInt(int)
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

concommand.Add("hl2cr_setlevel", function(ply, cmd, args, argStr)
	local level = tonumber(args[1])
	local target = ""
	if args[2] then
		target = string.sub(args[2], 0)
	end
	
	if ply:IsAdmin() then
		for k, v in pairs(player.GetAll()) do
			if string.match(string.lower(v:Nick()), tostring(target)) then
				target = v
			end
		end
	
		if level > 0 then
			target.hl2cPersistent.Level = level
			target.hl2cPersistent.XP = 0
			target:SetNWInt("Level", target.hl2cPersistent.Level)
			target:ChatPrint("Your level has changed to " .. level .. " by an admin") 
		else
			ply:PrintMessage(HUD_PRINTCONSOLE, "Invalid Value")
		end
	else
		ply:PrintMessage(HUD_PRINTCONSOLE, "You do not have access to this command")
	end
end)

concommand.Add("hl2cr_addcoins", function(ply, cmd, args)
	local coins = tonumber(args[1])
	local target = ""
	if args[2] then
		target = string.sub(args[2], 0)
	end
	
	if ply:IsAdmin() then
		for k, v in pairs(player.GetAll()) do
			if string.match(string.lower(v:Nick()), tostring(target)) then
				target = v
			end
		end
		
		if coins >= 0 and target then
			AddCoins(target, coins)
			target:ChatPrint("You have been given " .. coins .. " lambda coins by an admin")
		else
			ply:PrintMessage(HUD_PRINTCONSOLE, "Invalid Value")
		end
	else
		ply:PrintMessage(HUD_PRINTCONSOLE, "You do not have access to this command")
	end
end)

concommand.Add("hl2cr_subcoins", function(ply, cmd, args)
	local coins = tonumber(args[1])
	local target = ""
	if args[2] then
		target = string.sub(args[2], 0)
	end
	
	if ply:IsAdmin() then
		for k, v in pairs(player.GetAll()) do
			if string.match(string.lower(v:Nick()), tostring(target)) then
				target = v
			end
		end
		if coins >= 0 and target then
			SubCoins(target, coins)
			target:ChatPrint("Your " .. coins .. " lambda coins were deducted by an admin")
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

concommand.Add("hl2cr_setdiff", function(ply, cmd, args)
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

concommand.Add("hl2cr_petbring", function(ply, cmd, args)
	if not ply.pet:IsValid() then
		ply:ChatPrint("Your pet doesn't exist!")
		return ""
	end
	if duel then
		ply:ChatPrint("You can't bring your pet while in a duel!")
	end
	
	if ply.BringPet then
		ply.pet:SetPos(ply:GetPos())
		ply.pet:SetAngles(ply:GetAngles())
		ply.BringPet = false
		beginPetBringTimer(ply)
	else
		showTimerPet(ply)
	end
end)

concommand.Add("hl2cr_petremove", function(ply, cmd, args)
	if not ply.pet or not ply.pet:IsValid() then
		ply:ChatPrint("Your pet doesn't exist!")		
	elseif duel then
		ply:ChatPrint("You can't remove your pet in a duel!")
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
end)

concommand.Add("hl2cr_petpoints", function(ply, cmd, args)
	local petPoints = tonumber(args[1])
	if ply:IsAdmin() then
		ply.hl2cPersistent.PetPoints = ply.hl2cPersistent.PetPoints + petPoints
	else
		ply:ChatPrint("You don't have access to this command")
	end
end)

concommand.Add("hl2cr_petlevel", function(ply, cmd, args)
	local newLevel = tonumber(args[1])
	if ply:IsAdmin() then
		ply.hl2cPersistent.PetLevel = newLevel
		ply:SetNWInt("PetLevel", ply.hl2cPersistent.PetLevel)
	else
		ply:ChatPrint("You don't have access to this command")
	end
end)

concommand.Add("hl2cr_petstage", function(ply, cmd, args)
	local newStage = tonumber(args[1])
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

concommand.Add("hl2cr_loyal", function(ply, cmd, args)
	if ply:IsAdmin() then
		beginLoyal()
	else
		ply:ChatPrint("You don't have access to this command")
	end
end)

concommand.Add("hl2cr_endloyal", function(ply, cmd, args)
	if ply:IsAdmin() then
		endLoyal()
	else
		ply:ChatPrint("You don't have access to this command")
	end
end)

concommand.Add("hl2cr_fixloyal", function(ply, cmd, args)
	if ply:IsAdmin() then
		if ply.loyal then
			ply:SetModel(oldModel)
			ply:SetTeam(TEAM_ALIVE)
			ply.loyal = false
		else
			ply:ChatPrint("You aren't a loyal combine")
		end
	else
		ply:ChatPrint("You don't have access to this command")
	end
end)