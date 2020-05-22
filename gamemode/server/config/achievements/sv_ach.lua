Lobby_Ach_List = {
	First_Time = {name = "First Time", desc = "Play the gamemode for the first time", mat = "vgui/achievements/hl2_beat_cemetery.png", isRare = false},
	Test = {name = "Dumb Secret", desc = "You get this one, but with no XP!", mat = "entities/npc_kleiner.png", isRare = true}
}

HL2_Ach_List = {
	Baby = {name = "A Red Letter Baby", desc = "Bring the baby doll to Dr.Kleiner", mat = "vgui/achievements/hl2_beat_game.png", isRare = false},
	Crowbar = {name = "Trusty Hardware", desc = "Acquire the crowbar", mat = "vgui/achievements/hl2_get_crowbar.png", isRare = false},
	Gravgun = {name = "Zero-Point Energy", desc = "Acquire the Gravity gun in Black Mesa East", mat = "vgui/achievements/hl2_get_gravitygun.png", isRare = false},
	RavenBall = {name = "Rave Ball", desc = "Carry dog's ball through Ravenholm into the mines", mat = "vgui/achievements/hl2_get_gravitygun.png", isRare = false},
	Sand = {name = "Keep off the sand", desc = "Cross the antlion beach in d2_coast_11 without touching the sand", mat = "vgui/achievements/hl2_beat_donttouchsand.png", isRare = false}
}

Misc_Ach_List = {
	Survival_Lost = {name = "A Predictable Failure", desc = "Fail a map on survival with 4 or more players", mat = "vgui/achievements/hl2_find_allgmen.png", isRare = false},
	Pet_Zomb_Finish = {name = "Blast that little...", desc = "Complete the Zombie evolution tree", mat = "vgui/achievements/hl2_beat_toxictunnel.png", isRare = false}
}

function Achievement(ply, name, list, amt)
	
	if list == "Lobby_Ach_List" and not string.find(ply.hl2cPersistent.Achievements, Lobby_Ach_List[name].name, 1, true) then
		ply.hl2cPersistent.Achievements = ply.hl2cPersistent.Achievements .. " " .. Lobby_Ach_List[name].name
		ply:SetNWString("Ach", ply.hl2cPersistent.Achievements)
		net.Start("Achievement_Earned")
			net.WriteString(Lobby_Ach_List[name].name)
			net.WriteString(Lobby_Ach_List[name].mat)
			net.WriteBool(Lobby_Ach_List[name].isRare)
		net.Send(ply)
		for k, v in pairs(player.GetAll()) do
			if not Lobby_Ach_List[name].isRare then
				v:ChatPrint(ply:Nick() ..  " has earned the achievement: " .. Lobby_Ach_List[name].name)
			else
				v:ChatPrint("Congratulations to " .. ply:Nick() .. " as they earned a rare achievement!: " .. Lobby_Ach_List[name].name)
			end
		end
		AddXP(ply, amt)
		ply:ChatPrint(amt .. "XP")
		
	elseif list == "HL2_Ach_List" and not string.find(ply.hl2cPersistent.Achievements, HL2_Ach_List[name].name, 1, true) then
		achTable = HL2_Ach_List[name]
		ply.hl2cPersistent.Achievements = ply.hl2cPersistent.Achievements  .. " " .. HL2_Ach_List[name].name
		ply:SetNWString("Ach", ply.hl2cPersistent.Achievements)
		net.Start("Achievement_Earned")
			net.WriteString(HL2_Ach_List[name].name)
			net.WriteString(HL2_Ach_List[name].mat)
			net.WriteBool(HL2_Ach_List[name].isRare)
		net.Send(ply)
		for k, v in pairs(player.GetAll()) do
			if not HL2_Ach_List[name].isRare then
				v:ChatPrint(ply:Nick() ..  " has earned the achievement: " .. HL2_Ach_List[name].name)
			else
				v:ChatPrint("Congratulations to " .. ply:Nick() .. " as they earned a rare achievement!: " .. HL2_Ach_List[name].name)
			end
		end
		AddXP(ply, amt)
		ply:ChatPrint(amt .. "XP")
		
	elseif list == "Misc_Ach_List" and not string.find(ply.hl2cPersistent.Achievements, Misc_Ach_List[name].name, 1, true) then
		achTable = HL2_Ach_List_Name[name]
		ply.hl2cPersistent.Achievements = ply.hl2cPersistent.Achievements .. " " .. Misc_Ach_List[name].name
		ply:SetNWString("Ach", ply.hl2cPersistent.Achievements)
		net.Start("Achievement_Earned")
			net.WriteString(Misc_Ach_List[name].name)
			net.WriteString(Misc_Ach_List[name].mat)
			net.WriteBool(Misc_Rare_Ach[name].isRare)
		net.Send(ply)
		for k, v in pairs(player.GetAll()) do
			if not Misc_Ach_List[name].isRare then
				v:ChatPrint(ply:Nick() ..  " has earned the achievement: " .. Misc_Ach_List[name].name)
			else
				v:ChatPrint("Congratulations to " .. ply:Nick() .. " as they earned a rare achievement!: " .. Misc_Ach_List[name].name)
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


