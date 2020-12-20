local lobbyVotes = 0
local restoreVotes = 0
local restartVotes = 0 
oldModel = ""
local playerFound = false
local diffVar = ""
local timer = 3600 + CurTime()
local petbringTime = 0
local petSpawntime = 0

local DISABLED_MAPS = {
	["hl2cr_lobby_festive"] = true,
}

hook.Add("Think", "LobbyTimer", function()
	if not DISABLED_MAPS[game.GetMap()] then
		if timer <= CurTime() then
			RunConsoleCommand("changelevel", "hl2cr_lobby_festive")
		end
	end
end)

hook.Add("PlayerSay", "Commands", function(ply, text)
	--Worthless secret for worthless achievement hunter
	if (string.lower(text) == "!gimmeasecret") then
		Achievement(ply, "Worthless_Secret", "Lobby_Ach_List")
		return ""
	end
	
	if (string.lower(text) == "!cp") then
		--If the player can use !cp command, teleport them to the checkpoint
		if ply.CPTP and not ply:InVehicle() then
			for k, sp in pairs(ents.FindByClass("info_player_start")) do
				ply:SetPos(sp:GetPos())
				ply.CPTP = false
			end
		elseif ply:InVehicle() then
			ply:ChatPrint("Exit the vehicle before using this command")
		else
			ply:ChatPrint("You can't use this command yet")
		end
		return ""
	end
	
	--Views the achievements the player has
	if (string.lower(text) == "!ach" or string.lower(text) == "!achievement" ) then
		net.Start("Open_Ach_Menu")
			net.WriteTable(ply.hl2cPersistent.Achievements)
			net.WriteTable(ply.hl2cPersistent.Vortexes)
			net.WriteTable(ply.hl2cPersistent.Lambdas)
			net.WriteTable(ply.hl2cPersistent.Vortexes.EP1)
			net.WriteTable(ply.hl2cPersistent.Vortexes.EP2)
		net.Send(ply)
		return ""
	end
	
	--Views the achievements the player has
	if (string.find(string.lower(text), "!ach ")) then
		local target = ""
		target = string.lower(string.sub(text, 6))
		for k, v in pairs(player.GetAll()) do
			if string.match(string.lower(v:Nick()), tostring(target)) then
				target = v
			end
		end
		net.Start("Open_Ach_Menu")
			net.WriteTable(target.hl2cPersistent.Achievements)
			net.WriteTable(target.hl2cPersistent.Vortexes)
			net.WriteTable(target.hl2cPersistent.Lambdas)
			net.WriteTable(ply.hl2cPersistent.Vortexes.EP1)
			net.WriteTable(ply.hl2cPersistent.Vortexes.EP2)
		net.Send(ply)
		return ""
	end
	
	--When enabled, let the player enable one true freeman for them
	if (string.lower(text) == "!otf") then
		if ply.EnableOTF and not ply.hl2cPersistent.OTF then
			net.Start("ShowOTF")
			net.Send(ply)
		elseif ply.hl2cPersistent.OTF then
			ply:ChatPrint("You are attempting the 'One true Freeman' right now, stay strong!")
		else
			ply:ChatPrint("You cannot attempt 'One true Freeman' at this time")
		end
		return ""
	end
	
	
	--Squads
	if string.lower(text) == "!squadcreate" or string.lower(text) == "!createsquad" then
		HL2CR_Squad:NewSquad(ply:Nick(), ply)
		
		return ""
	end
	
	if string.lower(text) == "!squadleave" or string.lower(text) == "!leavesquad" then
		
		return ""
	end
	
	if string.lower(text) == "!squadjoin" or string.lower(text) == "!joinsquad" then
		ply:ChatPrint("You need to specify a player name for the squad you're joining!")
		return ""
	end
	
	if string.find(string.lower(text), "!squadjoin ") or string.find(string.lower(text), "!joinsquad ") then
		
		return ""
	end
	
	if (string.lower(text) == "!squaddisband" or string.lower(text) == "!disbandsquad") then
		HL2CR_Squad:Disband(ply:Nick())
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
		if ply.hl2cPersistent.Level >= 10 or ply.hl2cPersistent.Prestige > 0 and ply:Alive() and ply:Team() == TEAM_ALIVE then
			if not ply.petAlive and petSpawntime < CurTime() then
				spawnPet(ply)
				petSpawntime = CurTime() + 5
			elseif ply:Team() != TEAM_ALIVE then
				ply:ChatPrint("You can't spawn your pet right now///")
			elseif petSpawntime > CurTime() then
				ply:ChatPrint("Slow down! you can't respawn your pet that fast")
			elseif not ply:Alive() then
				ply:ChatPrint("You can't bring your pet while dead!")
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
			net.WriteInt(GetConVar("hl2cr_specials"):GetInt(), 8)
			net.WriteInt(GetConVar("hl2cr_doublehp"):GetInt(), 8)
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
		
		if GetDuelAccepted(ply) then
			ply:ChatPrint("You can't bring your pet in a duel!")
			return ""
		end
		
		if ply:Team() == TEAM_COMPLETED_MAP then
			ply:ChatPrint("You can't bring your pet when you have finished the map")
			return ""
		end
		
		if not ply:Alive() then
			ply:ChatPrint("You can't bring your pet while dead!")
			return ""
		end
		
		if duel then
			ply:ChatPrint("You can't bring your pet while in a duel!")
			return ""
		end
		
		if ply.BringPet then -- This is a global variable shared between all players, i doubt it does what it is supposed to do!
			ply.pet:GotoOwner(ply:GetPos())
			ply.pet:SetPos(ply:GetPos())
			ply.pet:SetAngles(ply:GetAngles())
			beginPetBringTimer(ply)
			return ""
		end
	return ""
	end
	if (string.lower(text) == "!removepet" or string.lower(text) == "!petremove") then
		if not ply.pet or not ply.pet:IsValid() then
			ply:ChatPrint("Your pet doesn't exist!")
			return ""		
		end
		
		if GetDuelAccepted(ply) then
			ply:ChatPrint("You can't bring your pet in a duel!")
			return ""
		end

		if ply.pet:Health() == ply.pet:GetMaxHealth() then
			net.Start("ClosePets")
			net.Send(ply)
			ply.petAlive = false
			ply:SetNWBool("PetActive", false)
			ply.pet:Remove()
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

		AddCoins(duelUnaccepted.challenger, -duelUnaccepted.bet)
		AddCoins(duelUnaccepted.challengee, -duelUnaccepted.bet)

		duelUnaccepted.accepted = true

		PetDuelBegin(duelUnaccepted.challenger, duelUnaccepted.challengee, bet)
		if not ply.pet then
			ply:ConCommand("hl2cr_petsummon")
		end
		return ""
	end
	
	if (string.lower(text) == "!petduel" or string.lower(text) == "!duelpet") then
		net.Start("PetDuel")
			net.WriteInt(ply.hl2cPersistent.Coins, 64)
		net.Send(ply)
		return ""
	end

	if (string.lower(text) == "!pet") then
			if ply.hl2cPersistent.Level >= 10 or ply.hl2cPersistent.Prestige > 0 then
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
	
	if (string.lower(text) == "!restore") then
		if game.GetMap() == "hl2cr_lobby_festive" and file.Exists("hl2cr_data/maprecovery.txt", "DATA") then
			if not ply.hasVotedRestore then
				restoreVotes = restoreVotes + 1
				ply:SetNWInt("PlayerVotesRestore", restoreVotes)
				ply.hasVotedRestore = true
				for k, v in pairs(player.GetAll()) do
					v:ChatPrint(ply:Nick() .. " Has voted to restore the original map: " .. restoreVotes .. "/" .. VOTE_REQUIRED["neededVoteRestore"] )
				end
				if restoreVotes == VOTE_REQUIRED["neededVoteRestore"] then
					local mapToRead = file.Read("hl2cr_data/maprecovery.txt", "DATA")
					RunConsoleCommand("changelevel", mapToRead)
				end
			else
				ply:ChatPrint("You already voted to restore the original map!")
			end
		else
			ply:ChatPrint("You can't use this command!")
		end
		return ""
	end
	if (string.lower(text) == "!lobby") then
		if not DISABLED_MAPS[game.GetMap()] then
			if not ply.hasVotedLobby then
				lobbyVotes = lobbyVotes + 1
				ply:SetNWInt("PlayerVotesLobby", lobbyVotes)
				ply.hasVotedLobby = true
				for k, v in pairs(player.GetAll()) do
					v:ChatPrint(ply:Nick() .. " Has voted to return to the lobby: " .. lobbyVotes .. "/" .. VOTE_REQUIRED["neededVotes"] )
				end
				if lobbyVotes == VOTE_REQUIRED["neededVotes"] then
					game.SetGlobalState("super_phys_gun", 0)
					file.Delete("hl2cr_data/maprecovery.txt")
					RunConsoleCommand("changelevel", "hl2cr_lobby_festive")
				end
			else
				ply:ChatPrint("You already voted to return to the lobby!")
			end
		else
			ply:ChatPrint("You can't use this command on this map!")
		end
	return ""
	end
	if (string.lower(text) == "!restart" or string.lower(text) == "!vrm") then
		if game.GetMap() != "hl2cr_lobby_festive" then
			if not ply.hasVotedRestart then
				restartVotes = restartVotes + 1
				ply.hasVotedRestart = true
				for k, v in pairs(player.GetAll()) do
					v:ChatPrint(ply:Nick() .. " has voted to return to restart the map: " .. restartVotes .. "/" .. VOTE_REQUIRED["neededVotesRestart"])
				end
				if restartVotes >= VOTE_REQUIRED["neededVotesRestart"] then
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
		if DISABLED_MAPS[game.GetMap()] then
			ply:ChatPrint("Time is infinite on this map")
		else
			ply:ChatPrint(string.NiceTime(timer - CurTime()) .. " left before returning to lobby")
		end
		return ""
	end
	
	if (string.lower(text) == "!seats") then
		if (ply:InVehicle() and ply:GetVehicle():GetClass() == "prop_vehicle_jeep") and not ply.hasSeat then
			local vehicle = ply:GetVehicle()
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
		elseif ply:InVehicle() and ply:GetVehicle():GetClass() != "prop_vehicle_jeep" then
			ply:ChatPrint("You can only use this command on a jeep")
		else
			ply:ChatPrint("You can't use this command while not in a vehicle!")
		end
	return ""
	end
	
	if (string.lower(text) == "!prestige") then
		if ply.hl2cPersistent.Level < ply.hl2cPersistent.LevelCap then
			ply:ChatPrint("You aren't ready to prestige yet")
		else
			net.Start("Prestige")
			net.Send(ply)
		end
		return ""
	end
	
end)

function beginPetBringTimer(ply)
	ply.petbringTime = 7 + CurTime()
	if not ply then return end
	hook.Add("Think", "petTimer", function()
		if not ply or not ply.petbringTime then return end
		if ply.petbringTime <= CurTime() and ply:IsValid() then
			ply.BringPet = true
		end
	end)
end

local function showTimerPet(ply)
	ply:ChatPrint("You need to wait " .. math.Round(ply.petbringTime - CurTime()) .. " before bringing again")
	if ply.petbringTime <= CurTime() then
		ply.BringPet = true
	end
end

function AddBonusCoins(ply, bonusAmt)
	if ply.hl2cPersistent.Coins < 0 then
		ply.hl2cPersistent.Coins = 0 + bonusAmt
	end
	ply.hl2cPersistent.Coins = ply.hl2cPersistent.Coins + bonusAmt
	ply:SetNWInt("Coins", math.Round(ply.hl2cPersistent.Coins))
	ply:ChatPrint("BONUS COINS: " .. bonusAmt)
end

function AddBonusCoins(ply, bonusAmt)
	if ply.hl2cPersistent.Coins < 0 then
		ply.hl2cPersistent.Coins = 0 + bonusAmt
	end
	ply.hl2cPersistent.Coins = ply.hl2cPersistent.Coins + bonusAmt
	ply:SetNWInt("Coins", math.Round(ply.hl2cPersistent.Coins))
	ply:ChatPrint("BONUS COINS: " .. bonusAmt)
end

function AddCoins(ply, amount)
	if ply.hl2cPersistent.Coins < 0 then
		ply.hl2cPersistent.Coins = 0 + amount
	end
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
				if string.find(string.lower(v:Nick()), string.lower(tostring(target))) then
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

concommand.Add("hl2cr_getachlist", function(ply, cmd, args, argStr)
	local list = string.sub(args[1], 0)
	
	if ply:IsAdmin() then
		local AchLists = AchievementLists
		local getList = AchLists[list]
		for k, ach in pairs(getList) do
			ply:PrintMessage(HUD_PRINTCONSOLE, tostring(ach.name))
		end
	else
		ply:PrintMessage(HUD_PRINTCONSOLE, "You do not have access to this command")
	end

end)
concommand.Add("hl2cr_giveach", function(ply, cmd, args, argStr)
	local ach = string.sub(args[2], 0)
	local list = string.sub(args[3], 0)

	if ply:IsAdmin() then
		for k, v in pairs(player.GetAll()) do
			if v != ply and target != "" then
				if string.match(string.lower(v:Nick()), string.lower(args[1])) then
					target = v
				end
			else
				target = ply
			end
		end
		local achievementList = AchievementLists[list]
		if not achievementList then ply:ChatPrint("Invalid List") return end

		local achievement = achievementList[ach]
		if not achievement then ply:ChatPrint("Invalid Achievement") return end
		
		if target and achievement and achievementList then
			Achievement(target, ach, list)
			target:ChatPrint("You have been given the " .. ach .. " achievement by an admin")
		end
	else
		ply:PrintMessage(HUD_PRINTCONSOLE, "You do not have access to this command")
	end
end)

--Incase important npcs break
concommand.Add("hl2cr_bringnpc", function(ply, cmd, args, argStr)
	local npc = tostring(args[1])
	if ply:IsAdmin() then
		if npc == "alyx" then
			for k, bring in pairs(ents.FindByClass("npc_alyx")) do
				bring:SetPos(ply:GetPos())
			end
		elseif npc == "barney" then
			for k, bring in pairs(ents.FindByClass("npc_barney")) do
				bring:SetPos(ply:GetPos())
			end
		elseif npc == "dog" then
			for k, bring in pairs(ents.FindByClass("npc_dog")) do
				bring:SetPos(ply:GetPos())
			end
		end
	else
		ply:PrintMessage(HUD_PRINTCONSOLE, "You do not have access to this command")
	end

end)
--Meant for dev reasons with bots, but can be used on people for fun
concommand.Add("hl2cr_forcesay", function(ply, cmd, args, argStr)
	local message = args[1]
	local target = nil
	if not args[2] then
		target = ply
	end
	if ply:IsAdmin() then
		for k, v in pairs(player.GetAll()) do
			if string.find(string.lower(v:Nick()), string.lower(args[2])) then
				target = v
			end
		end
		
		if args[2] then
			target:Say(message, false)
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
		
	if target == "" then
		target = ply
	end
		if target and int then
			if target.hl2cPersistent.Level >= target.hl2cPersistent.LevelCap then ply:ChatPrint("The target exceeds the level cap") return end
			AddXP(target, int)
			target:ChatPrint("You have been given " .. int .. "xp by an admin")
		else
			ply:PrintMessage(HUD_PRINTCONSOLE, "Invalid Value")
		end
	else
		ply:PrintMessage(HUD_PRINTCONSOLE, "You do not have access to this command")
	end
end)

concommand.Add("hl2cr_getxp", function(ply, cmd, args)
	local target = ""
	
	if args[1] then
		target = string.sub(args[1], 0)
	end
	
	if ply:IsAdmin() then
		for k, v in pairs(player.GetAll()) do
			if string.match(string.lower(v:Nick()), tostring(target)) then
				target = v
			end
		end
		
		if target == "" then
			target = ply
		end
		
		ply:ChatPrint(target:Nick() ..  "'s XP: " .. target.hl2cPersistent.XP .. "/" .. target.hl2cPersistent.MaxXP)
	else
		ply:ChatPrint("You don't have access to this command")
	end
end)

concommand.Add("hl2cr_cp", function(ply, cmd, args)
	if ply:IsAdmin() then
	
		for k, v in pairs(ents.FindByName("lambdaCheckpoint")) do
			v:Remove()
		end
		
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
		
		if target == "" then
			target = ply
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

concommand.Add("hl2cr_setprestige", function(ply, cmd, args, argStr)
	local prestige = tonumber(args[1])
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
		
		if target == "" then
			target = ply
		end
	
		if prestige != nil then
			target.hl2cPersistent.Prestige = prestige
			target:SetNWInt("Prestige", target.hl2cPersistent.Prestige)
			if prestige != 0 then
				target.hl2cPersistent.LevelCap = (prestige + 2) * 10
			else
				target.hl2cPersistent.LevelCap = 20
			end
			target:ChatPrint("Your prestige has changed to " .. prestige .. " by an admin") 
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
		
		if target == "" then
			target = ply
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
		
		if target == "" then
			target = ply
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
	if tonumber(level) >= 10 or ply.hl2cPersistent.Prestige > 0 and ply:Alive() and ply:Team() == TEAM_ALIVE then
		if not ply.petAlive and ply.petSpawntime <= CurTime() then
			spawnPet(ply)
			ply:SetNWString("PetOwnerName", ply:Nick())
			ply.petSpawntime = CurTime() + 5
		elseif ply:Team() != TEAM_ALIVE then
			ply:ChatPrint("You can't spawn your pet while you have completed the map")
		elseif ply.petSpawntime > CurTime() then
			ply:ChatPrint("Slow down! you can't respawn your pet that fast")
		elseif not ply:Alive() then
			ply:ChatPrint("You can't summon your pet while dead!")
		else
			ply:ChatPrint("You can only summon your pet once every life!")
		end
	elseif tonumber(level) < 10 then
		ply:ChatPrint("You don't have access to pets")
	end
end)

concommand.Add("hl2cr_getcoins", function(ply, cmd, args)
	local target = ""
	
	if args[1] then
		target = string.sub(args[1], 0)
	end
	
	if ply:IsAdmin() then
		for k, v in pairs(player.GetAll()) do
			if string.match(string.lower(v:Nick()), tostring(target)) then
				target = v
			end
		end
		
		if target == "" then
			target = ply
		end
		
		ply:ChatPrint(target:Nick() .. "'s Coins: " .. target.hl2cPersistent.Coins)
	else
		ply:ChatPrint("You don't have access to this command")
	end
end)

concommand.Add("hl2cr_getarmour", function(ply, cmd, args)
	local target = ""
	
	if args[1] then
		target = string.sub(args[1], 0)
	end
	
	if ply:IsAdmin() then
		for k, v in pairs(player.GetAll()) do
			if string.match(string.lower(v:Nick()), tostring(target)) then
				target = v
			end
		end
		
		if target == "" then
			target = ply
		end
		
		ply:ChatPrint(target:Nick() .. "'s Armour: " .. target.hl2cPersistent.Armour)
	else
		ply:ChatPrint("You don't have access to this command")
	end
end)

concommand.Add("hl2cr_setarmour", function(ply, cmd, args)
	local armour = tonumber(args[1])
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
		
		if target == "" then
			target = ply
		end
		
		if armour >= 0 then
			target:ChatPrint("An admin set your armour to " .. armour)
			target.hl2cPersistent.Armour = armour
			target:SetNWInt("Armour", target.hl2cPersistent.Armour)
		end
	else
		ply:ChatPrint("You don't have access to this command")
	end
end)

concommand.Add("hl2cr_otf", function(ply, cmd, args)
	local target = ""
	
	if args[1] then
		target = string.sub(args[1], 0)
	end
	
	if ply:IsAdmin() then
		for k, v in pairs(player.GetAll()) do
			if string.match(string.lower(v:Nick()), tostring(target)) then
				target = v
			end
		end
		
		if target == "" then
			target = ply
		end
		
		if target.hl2cPersistent.OTF then
			ply:ChatPrint("OTF Already enabled")
		else
			target.hl2cPersistent.OTF = true
			target:ChatPrint("An admin just enabled OTF for you")
		end
	else
		ply:ChatPrint("You don't have access to this command")
	end
end)

concommand.Add("hl2cr_petbring", function(ply, cmd, args)
	if not ply.pet:IsValid() then
		ply:ChatPrint("Your pet doesn't exist!")
		return
	end
	
	if GetDuelAccepted(ply) then
		ply:ChatPrint("You can't bring your pet in a duel!")
		return
	end
	
	if ply:Team() == TEAM_COMPLETED_MAP then
		ply:ChatPrint("You can't bring your pet when you have finished the map")
		return
	end
	
	if not ply:Alive() then
		ply:ChatPrint("You can't bring your pet while dead!")
		return
	end
	
	
	if ply.BringPet then
		ply.pet:GotoOwner(ply:GetPos())
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
		return		
	end
	
	if GetDuelAccepted(ply) then
		ply:ChatPrint("You can't bring your pet in a duel!")
		return
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
	local target = nil
	if args[2] then
		target = string.sub(args[2], 0)	
	end
	if ply:IsAdmin() then
		for k, v in pairs(player.GetAll()) do
			if string.match(string.lower(v:Nick()), tostring(target)) then
				target = v
			end
		end
		
		if target == "" then
			target = ply
		end
		
		if target and petPoints then
			target.hl2cPersistent.PetPoints = target.hl2cPersistent.PetPoints + petPoints
			target:SetNWInt("PetSkillPoints", target.hl2cPersistent.PetPoints)
			target:ChatPrint("Your pet skill points has been added by " .. petPoints .. " by an admin")
		end
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

concommand.Add("hl2cr_resetslots", function(ply, cmd, args)
	local target = ""
	if args[1] then
		target = string.sub(args[1], 0)
	end
	
	if ply:IsAdmin() then
		for k, v in pairs(player.GetAll()) do
			if string.match(string.lower(v:Nick()), tostring(target)) then
				target = v
			end
		end
		
		if target == "" then
			target = ply
		end
		
		if target then
			for k, item in pairs(GAMEMODE.ArmourItem) do
				if target.hl2cPersistent.Helmet and target.hl2cPersistent.Helmet == GAMEMODE.ArmourItem[k].Name then
					AddCoins(target, GAMEMODE.ArmourItem[k].Cost)
					target.hl2cPersistent.Helmet = ""
				end
				
				if target.hl2cPersistent.Suit and target.hl2cPersistent.Suit == GAMEMODE.ArmourItem[k].Name then
					AddCoins(target, GAMEMODE.ArmourItem[k].Cost)
					target.hl2cPersistent.Suit = ""
				end
				
				if target.hl2cPersistent.Arm and target.hl2cPersistent.Arm == GAMEMODE.ArmourItem[k].Name then
					AddCoins(target, GAMEMODE.ArmourItem[k].Cost)
					target.hl2cPersistent.Arm = ""
				end
				
				if target.hl2cPersistent.Hands and target.hl2cPersistent.Hands == GAMEMODE.ArmourItem[k].Name then
					AddCoins(target, GAMEMODE.ArmourItem[k].Cost)
					target.hl2cPersistent.Hands = ""
				end
				
				if target.hl2cPersistent.Boot and target.hl2cPersistent.Boot == GAMEMODE.ArmourItem[k].Name then
					AddCoins(target, GAMEMODE.ArmourItem[k].Cost)
					target.hl2cPersistent.Boot = ""
				end
			end
			
			target.hl2cPersistent.Armour = 0
			
			target:SetNWInt("Armour", target.hl2cPersistent.Armour)

			target:SetNWString("HelmetSlot", "")
			target:SetNWString("SuitSlot", "")
			target:SetNWString("ArmSlot", "")
			target:SetNWString("HandSlot", "")
			target:SetNWString("BootSlot", "")
			
			target:ChatPrint("Your armor points and slots have been reset by an admin, you have been refunded")
		end
	else
		ply:PrintMessage(HUD_PRINTCONSOLE, "You do not have access to this command")
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

concommand.Add("hl2cr_rollmission", function(ply, cmd, args)
	if ply:IsAdmin() then
		MISSIONS:StartNextRoll()
	else
		ply:ChatPrint("You don't have access to this command")
	end
end)

concommand.Add("hl2cr_resetvotes", function(ply, cmd, args)
	if ply:IsAdmin() then
		net.Start("ResetVotes")
		net.Broadcast()
	else
		ply:ChatPrint("You don't have access to this command")
	end
end)