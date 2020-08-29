AchievementLists = {
	Lobby_Ach_List = {
		First_Time = {name = "First Time", mat = "vgui/achievements/hl2_beat_cemetery.png", isRare = false, clientTriggerable = true},
		Worthless_Secret = {name = "Worthless Secret", mat = "entities/npc_kleiner.png", isRare = true},
		Lost_Cause = {name = "Lost Cause", mat = "vgui/achievements/hl2_beat_cemetery.png", isRare = false, clientTriggerable = true}
	},

	HL2_Ach_List = {
		A_Red_Letter_Baby = {name = "A Red Letter Baby", mat = "vgui/achievements/hl2_beat_game.png", isRare = false},
		What_Cat = {name = "What cat", mat = "vgui/achievements/hl2_beat_game.png", isRare = false},
		Trusty_Hardware = {name = "Trusty Hardware", mat = "vgui/achievements/hl2_get_crowbar.png", isRare = false},
		ZeroPoint_Energy = {name = "ZeroPoint Energy", mat = "vgui/achievements/hl2_get_gravitygun.png", isRare = false},
		Rave_Ball = {name = "Rave Ball", desc = "Carry dog's ball through Ravenholm into the mines", mat = "vgui/achievements/hl2_get_gravitygun.png", isRare = false},
		Keep_off_the_sand = {name = "Keep off the sand", mat = "vgui/achievements/hl2_beat_donttouchsand.png", isRare = false},
		Finish_HL2 = {name = "Singularity Collapse", mat = "vgui/achievements/hl2_beat_game.png", isRare = false},
	},

	Misc_Ach_List = {
		Survival_Lost = {name = "A Predictable Failure", mat = "vgui/achievements/hl2_find_allgmen.png", isRare = false},
		Blast_that_little = {name = "Blast that little", mat = "vgui/achievements/hl2_beat_toxictunnel.png", isRare = false, clientTriggerable = true},
		Born_Survivor = {name = "Born Survivor", mat = "vgui/achievements/hl2_followfreeman", isRare = false},
	}
}

SpecialLists = {
	HL2_Lambda = {
		d1_trainstation_05 = {name = "d1_trainstation_05", mat = "vgui/achievements/hl2_find_alllambdas.png"},
		d1_canals_01 = {name = "d1_canals_01", mat = "vgui/achievements/hl2_find_alllambdas.png"},
		d1_canals_01a = {name = "d1_canals_01a", mat = "vgui/achievements/hl2_find_alllambdas.png"},
		d1_canals_02 = {name = "d1_canals_02", mat = "vgui/achievements/hl2_find_alllambdas.png"},
		d1_canals_03 = {name = "d1_canals_03", mat = "vgui/achievements/hl2_find_alllambdas.png"},
		d1_canals_05 = {name = "d1_canals_05", mat = "vgui/achievements/hl2_find_alllambdas.png"},
		d1_canals_06 = {name = "d1_canals_06", mat = "vgui/achievements/hl2_find_alllambdas.png"},
		d1_canals_07 = {name = "d1_canals_07", mat = "vgui/achievements/hl2_find_alllambdas.png"},
		d1_canals_08 = {name = "d1_canals_08", mat = "vgui/achievements/hl2_find_alllambdas.png"},
		d1_canals_09 = {name = "d1_canals_09", mat = "vgui/achievements/hl2_find_alllambdas.png"},
		d1_canals_10 = {name = "d1_canals_10", mat = "vgui/achievements/hl2_find_alllambdas.png"},
		d1_canals_12 = {name = "d1_canals_12", mat = "vgui/achievements/hl2_find_alllambdas.png"},
		d1_eli_01 = {name = "d1_eli_01", mat = "vgui/achievements/hl2_find_alllambdas.png"},
		d1_town_01 = {name = "d1_town_01", mat = "vgui/achievements/hl2_find_alllambdas.png"},
		d1_town_01a = {name = "d1_town_01a", mat = "vgui/achievements/hl2_find_alllambdas.png"},
		d1_town_05 = {name = "d1_town_05", mat = "vgui/achievements/hl2_find_alllambdas.png"},
		d2_coast_01 = {name = "d2_coast_01", mat = "vgui/achievements/hl2_find_alllambdas.png"},
		d2_coast_03 = {name = "d2_coast_03", mat = "vgui/achievements/hl2_find_alllambdas.png"},
		d2_coast_04 = {name = "d2_coast_04", mat = "vgui/achievements/hl2_find_alllambdas.png"},
		d2_coast_05 = {name = "d2_coast_05", mat = "vgui/achievements/hl2_find_alllambdas.png"},
		d2_coast_07 = {name = "d2_coast_07", mat = "vgui/achievements/hl2_find_alllambdas.png"},
	},
	
	HL2_Vortex = {
		d1_trainstation_05 = {name = "d1_trainstation_05", mat = "vgui/achievements/hlx_find_onegman.png"},
		d1_trainstation_06 = {name = "d1_trainstation_06", mat = "vgui/achievements/hlx_find_onegman.png"},
		d1_canals_01 = {name = "d1_canals_01", mat = "vgui/achievements/hlx_find_onegman.png"},
	}
}

function Achievement(ply, name, list, amt, clientTriggered)

	-- Get achievement list, or exit if it doesn't exists
	local achievementList = AchievementLists[list]
	if not achievementList then return end

	-- Get achievement, or exit if it doesn't exists
	local achievement = achievementList[name]
	if not achievement then return end

	-- Only allow the client to trigger achievements that are "clientTriggerable"
	if clientTriggered and not achievement.clientTriggerable then return end

	-- Check if the player already got the achievement
	if table.HasValue(ply.hl2cPersistent.Achievements, name) then return end

	-- Give achievement to player
	table.insert(ply.hl2cPersistent.Achievements, name)

	-- Send space separated achievement list to client
	ply:SetNWString("Ach", table.concat(ply.hl2cPersistent.Achievements, " "))

	-- Trigger "achievement earned" notification on client
	net.Start("Achievement_Earned")
		net.WriteString(achievement.name)
		net.WriteString(achievement.mat)
		net.WriteBool(achievement.isRare)
	net.Send(ply)

	-- Make everyone proud of ply
	for k, v in pairs(player.GetAll()) do
		if achievement.isRare then
			v:ChatPrint(string.format("Congratulations to %s as they earned a rare achievement!: %s", ply:Nick(), achievement.name))
		else
			v:ChatPrint(string.format("%s has earned the achievement: %s", ply:Nick(), achievement.name))
		end
	end

	-- XP stuff
	if amt != 0 then
		AddXP(ply, amt)
		ply:ChatPrint(string.format("You got %s XP", amt))
	end
end

function Special(ply, name, list, amt)
	-- Get special list, or exit if it doesn't exists
	local specialList = SpecialLists[list]
	if not specialList then return end

	-- Get special, or exit if it doesn't exists
	local special = specialList[name]
	if not special then return end
	
	net.Start("Special_Earned")
		net.WriteString(special.name)
		net.WriteString(special.mat)
	net.Send(ply)
	
	if amt != 0 then
		AddXP(ply, amt)
		ply:ChatPrint(string.format("You got %s XP", amt))
	end
end

net.Receive("Achievement", function(len, ply)
	local name = net.ReadString()
	local listName = net.ReadString()
	local amt = 0
	Achievement(ply, name, listName, amt)
end)


