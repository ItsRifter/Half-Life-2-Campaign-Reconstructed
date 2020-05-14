Lobby_Ach_List_Name = {
	["First_Time"] = "Rise and Shine",
	["Test"] = "Take your stupid achievement",
}

Lobby_Ach_List_Desc = {
	["First_Time"] = "Play the gamemode for the first time",
	["Test"] = "You get this one, but with no xp!",
}

Lobby_Ach_List_Mat = {
	["First_Time"] = "vgui/achievements/hl2_beat_cemetery.png",
	["Test"] = "entities/npc_kleiner.png",
}

Lobby_Ach_List = {
	[1] = "First_Time",
	[2] = "Test",
}

Lobby_Rare_Ach_List = {
	["First_Time"] = false,
	["Test"] = true,
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

HL2_Rare_Ach_List = {
	[1] = false,
	[2] = false,
	[3] = false,
	[4] = false,
	[5] = false,
}

Misc_Ach_List = {
	[1] = "Survival_Lost",
	[2] = "Pet_Zomb_Finish",
}

Misc_Rare_Ach_List = {
	[1] = false,
	[2] = false,
}

Misc_Ach_List_Name = {
	["Survival_Lost"] = "A Predictable Failure",
	["Pet_Zomb_Finish"] = "Blast that little...",
}

Misc_Ach_List_Desc = {
	["Survival_Lost"] = "Fail a map on survival with 4 or more players",
	["Pet_Zomb_Finish"] = "Complete the Zombie evolution tree",
}

Misc_Ach_List_Mat = {
	["Survival_Lost"] = "vgui/achievements/hl2_find_allgmen.png",
	["Pet_Zomb_Finish"] = "vgui/achievements/hl2_beat_toxictunnel.png",
}

function Achievement(ply, name, list, amt)
	
	if list == "Lobby_Ach_List" and not string.find(ply.hl2cPersistent.Achievements, Lobby_Ach_List_Name[name], 1, true) then
		ply.hl2cPersistent.Achievements = ply.hl2cPersistent.Achievements .. " " .. Lobby_Ach_List_Name[name]
		ply:SetNWString("Ach", ply.hl2cPersistent.Achievements)
		net.Start("Achievement_Earned")
			net.WriteString(Lobby_Ach_List_Name[name])
			net.WriteString(Lobby_Ach_List_Mat[name])
			net.WriteBool(Lobby_Rare_Ach_List[name])
		net.Send(ply)
		for k, v in pairs(player.GetAll()) do
			if not Lobby_Rare_Ach_List[name] then
				v:ChatPrint(ply:Nick() ..  " has earned the achievement: " .. Lobby_Ach_List_Name[name])
			else
				v:ChatPrint("Congratulations to " .. ply:Nick() .. " as they earned a rare achievement!: " .. Lobby_Ach_List_Name[name])
			end
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
			net.WriteBool(HL2_Rare_Ach_List[name])
		net.Send(ply)
		for k, v in pairs(player.GetAll()) do
			if not HL2_Rare_Ach_List[name] then
				v:ChatPrint(ply:Nick() ..  " has earned the achievement: " .. HL2_Ach_List_Name[name])
			else
				v:ChatPrint("Congratulations to " .. ply:Nick() .. " as they earned a rare achievement!: " .. HL2_Ach_List_Name[name])
			end
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
			net.WriteBool(Misc_Rare_Ach_List[name])
		net.Send(ply)
		for k, v in pairs(player.GetAll()) do
			if not Misc_Rare_Ach_List[name] then
				v:ChatPrint(ply:Nick() ..  " has earned the achievement: " .. Misc_Ach_List_Name[name])
			else
				v:ChatPrint("Congratulations to " .. ply:Nick() .. " as they earned a rare achievement!: " .. Misc_Ach_List_Name[name])
			end
		end
		AddXP(ply, amt)
		ply:ChatPrint(amt .. "XP")
	end
end


net.Receive("Achievement", function(len, ply)
	local name = net.ReadString()
	local listName = net.ReadString()
	local amt = 0
	Achievement(ply, name, listName, amt)
end)


