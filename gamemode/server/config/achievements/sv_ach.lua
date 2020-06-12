AchievementLists = {
	Lobby_Ach_List = {
		First_Time = {name = "First Time", desc = "Play the gamemode for the first time", mat = "vgui/achievements/hl2_beat_cemetery.png", isRare = false, clientTriggerable = true},
		Test = {name = "Dumb Secret", desc = "You get this one, but with no XP!", mat = "entities/npc_kleiner.png", isRare = true},
		Lost_Cause = {name = "Lost Cause", desc = "Find what remains of Leiftiger's HL2C server", mat = "vgui/achievements/hl2_beat_cemetery.png", isRare = false, clientTriggerable = true}
	},

	HL2_Ach_List = {
		Baby = {name = "A Red Letter Baby", desc = "Bring the baby doll to Dr.Kleiner", mat = "vgui/achievements/hl2_beat_game.png", isRare = false},
		Crowbar = {name = "Trusty Hardware", desc = "Acquire the crowbar", mat = "vgui/achievements/hl2_get_crowbar.png", isRare = false},
		Gravgun = {name = "Zero-Point Energy", desc = "Acquire the Gravity gun in Black Mesa East", mat = "vgui/achievements/hl2_get_gravitygun.png", isRare = false},
		RavenBall = {name = "Rave Ball", desc = "Carry dog's ball through Ravenholm into the mines", mat = "vgui/achievements/hl2_get_gravitygun.png", isRare = false},
		Sand = {name = "Keep off the sand", desc = "Cross the antlion beach in d2_coast_11 without touching the sand", mat = "vgui/achievements/hl2_beat_donttouchsand.png", isRare = false}
	},

	Misc_Ach_List = {
		Survival_Lost = {name = "A Predictable Failure", desc = "Fail a map on survival with 4 or more players", mat = "vgui/achievements/hl2_find_allgmen.png", isRare = false},
		Pet_Zomb_Finish = {name = "Blast that little...", desc = "Complete the Zombie evolution tree", mat = "vgui/achievements/hl2_beat_toxictunnel.png", isRare = false}
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
	if ply.hl2cPersistent.Achievements[name] then return end

	-- Give achievement to player
	ply.hl2cPersistent.Achievements[name] = true

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
	AddXP(ply, amt)
	ply:ChatPrint(string.format("You got %s XP", amt))
end

net.Receive("Achievement", function(len, ply)
	local name = net.ReadString()
	local listName = net.ReadString()
	local amt = 0
	Achievement(ply, name, listName, amt, true)
end)


