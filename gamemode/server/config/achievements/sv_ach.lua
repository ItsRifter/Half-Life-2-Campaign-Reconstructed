Lobby_Ach_List_Name = {
	["First_Time"] = "Rise and Shine",
	["Test"] = "Shitter",
}

Lobby_Ach_List_Desc = {
	["First_Time"] = "Play the gamemode for the first time",
	["Test"] = "How did you find this?",
}

Lobby_Ach_List_Mat = {
	["First_Time"] = "vgui/achievements/hl2_beat_cemetery.png",
	["Test"] = "entities/npc_kleiner.png",
}

Lobby_Ach_List = {
	[1] = "First_Time",
	[2] = "Test",
}

HL2_Ach_List_Name = {
	["Baby"] = "A Red Letter Baby",
	["Crowbar"] = "Trusty Hardware",
	["Gravgun"] = "Zero-Point Energy",
	["RavenBall"] = "RaveBall",
	["Sand"] = "Keep off the sand",
}

HL2_Ach_List_Desc = {
	["Baby"] = "Bring the doll from the playground to Dr.Kleiner",
	["Crowbar"] = "Acquire the crowbar",
	["Gravgun"] = "Acquire the Gravity gun in black mesa",
	["RavenBall"] = "Carry dog's ball through Ravenholm (Don't worry about water)",
	["Sand"] = "Cross the antlion beach in d2_coast_11 without touching the sand",
}

HL2_Ach_List_Mat = {
	["Baby"] = "vgui/achievements/hl2_beat_game.png",
	["Crowbar"] = "vgui/achievements/hl2_get_crowbar.png",
	["Gravgun"] = "vgui/achievements/hl2_get_gravitygun.png",
	["RavenBall"] = "vgui/achievements/hl2_get_gravitygun.png",
	["Sand"] = "vgui/achievements/hl2_beat_donttouchsand.png",
}

HL2_Ach_List = {
	[1] = "Baby",
	[2] = "Crowbar",
	[3] = "Gravgun",
	[4] = "RavenBall",
	[5] = "Sand",
}


Misc_Ach_List = {
	[1] = "Survival_Lost",
}

Misc_Ach_List_Name = {
	["Survival_Lost"] = "A Predictable Failure",
}

Misc_Ach_List_Desc = {
	["Survival_Lost"] = "Fail a map on survival with 4 or more players",
}

Misc_Ach_List_Mat = {
	["Survival_Lost"] = "vgui/achievements/hl2_find_allgmen.png",
}

function Achievement(ply, name, list, amt)
	
	if list == "Lobby_Ach_List" and not string.find(ply.hl2cPersistent.Achievements, Lobby_Ach_List_Name[name], 1, true) then
		ply.hl2cPersistent.Achievements = ply.hl2cPersistent.Achievements .. " " .. Lobby_Ach_List_Name[name]
		ply:SetNWString("Ach", ply.hl2cPersistent.Achievements)
		net.Start("Achievement_Earned")
			net.WriteString(Lobby_Ach_List_Name[name])
			net.WriteString(Lobby_Ach_List_Mat[name])
		net.Send(ply)
		for k, v in pairs(player.GetAll()) do
			v:ChatPrint(ply:Nick() ..  " has earned the achievement: " ..  Lobby_Ach_List_Name[name])
		end
		AddXP(ply, amt)
		ply:ChatPrint(amt .. "XP")
		
	elseif list == "HL2_Ach_List" and not string.find(ply.hl2cPersistent.Achievements, HL2_Ach_List_Name[name], 1, true) then
		achTable = HL2_Ach_List_Name[name]
		ply.hl2cPersistent.Achievements = ply.hl2cPersistent.Achievements  .. " " .. HL2_Ach_List_Name[name]
		ply:SetNWString("Ach", ply.hl2cPersistent.Achievements)
		net.Start("Achievement_Earned")
			net.WriteString(HL2_Ach_List_Name[name])
			net.WriteString(HL2_Ach_List_Mat[name])
		net.Send(ply)
		for k, v in pairs(player.GetAll()) do
			v:ChatPrint(ply:Nick() ..  " has earned the achievement: " .. HL2_Ach_List_Name[name])
		end
		AddXP(ply, amt)
		ply:ChatPrint(amt .. "XP")
		
	elseif list == "Misc_Ach_List" and not string.find(ply.hl2cPersistent.Achievements, Misc_Ach_List_Name[name], 1, true) then
		achTable = HL2_Ach_List_Name[name]
		ply.hl2cPersistent.Achievements = ply.hl2cPersistent.Achievements .. " " .. Misc_Ach_List_Name[name]
		ply:SetNWString("Ach", ply.hl2cPersistent.Achievements)
		net.Start("Achievement_Earned")
			net.WriteString(Misc_Ach_List_Name[name])
			net.WriteString(Misc_Ach_List_Mat[name])
		net.Send(ply)
		for k, v in pairs(player.GetAll()) do
			v:ChatPrint(ply:Nick() ..  " has earned the achievement: " .. Misc_Ach_List_Name[name])
		end
		AddXP(ply, amt)
		ply:ChatPrint(amt .. "XP")
	end
end


net.Receive("Achievement", function(len, ply)
	local name = net.ReadString()
	local listName = net.ReadString()
	Achievement(ply, name, listName)
end)


