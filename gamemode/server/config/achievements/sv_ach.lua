Lobby_Ach_List_Title = {
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

Misc_Ach_List_Title = {
	["Survival_Lost"] = "A Predictable Failure",
}

Misc_Ach_List_Title = {
	["Survival_Lost"] = "Fail a map on survival with 4 or more players",
}

Misc_Ach_List_Mat = {
	["Survival_Lost"] = "vgui/achievements/hl2_find_allgmen.png",
}


Misc_Ach_List = {
	[1] = "A Predictable Failure",
}


function Announce(ply, achTitle, achImage)
	net.Start("Achievement_Earned")
		net.WriteString(achTitle)
		net.WriteString(achImage)
	net.Send(ply)
end

net.Receive("Achievement", function(len, ply)
	local achName = net.ReadString()
	local list = net.ReadString()
	local sendTable = {}
	
	if list == "Lobby_Ach_List" then
		sendTable = Lobby_Ach_List_Titles
		Announce(ply, Lobby_Ach_List_Title[achName], Lobby_Ach_List_Mat[achName])
		
		for k, v in pairs(player.GetAll()) do
			v:ChatPrint(ply:Nick() ..  " has earned the achievement: " .. Lobby_Ach_List_Title[achName])
		end
		
	elseif list == "HL2_Ach_List" then
		sendTable = HL2_Ach_List_Title
		UpdateAchievements(ply)
		Announce(ply, HL2_Ach_List_Title[achName], HL2_Ach_List_Mat[achName])
		
		for k, v in pairs(player.GetAll()) do
			v:ChatPrint(ply:Nick() ..  " has earned the achievement: " .. HL2_Ach_List_Title[achName])
		end
		
	elseif list == "Misc_Ach_List" then
		sendTable = Misc_Ach_List_Title
		UpdateAchievements(ply)
		Announce(ply, Misc_Ach_List_Title[achName], Misc_Ach_List_Mat[achName])
		
		for k, v in pairs(player.GetAll()) do
			v:ChatPrint(ply:Nick() ..  " has earned the achievement: " .. Misc_Ach_List_Title[achName])
		end
		
	end
end)
