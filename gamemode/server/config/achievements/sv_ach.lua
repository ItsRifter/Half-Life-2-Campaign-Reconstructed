Lobby_Ach_List_Title = {
	["First_Time"] = "Rise and Shine",
	["Test"] = "Shitter",
}

Lobby_Ach_List_Desc = {
	["First_Time"] = "Play the gamemode for the first time",
	["Test"] = "How did you find this?",
}

Lobby_Ach_List_Mat = {
	["First_Time"] = "entities/npc_gman.png",
	["Test"] = "entities/npc_kleiner.png",
}

Lobby_Ach_List = {
	[1] = "First_Time",
	[2] = "Test",
}


function Announce(ply, achTitle, achImage)
	net.Start("Achievement_Earned")
		net.WriteString(achTitle)
		net.WriteString(achImage)
	net.Send(ply)
end

function UpdateProgress(ply, achTitle, achImage)

end

net.Receive("Achievement", function(len, ply)
	local achName = net.ReadString()
	local list = net.ReadString()
	local sendTable = {}
	
	if list == "Lobby_Ach_List" then
		sendTable = Lobby_Ach_List_Title
		UpdateAchievements(ply)
		Announce(ply, Lobby_Ach_List_Title[achName], Lobby_Ach_List_Mat[achName])
	elseif list == "HL2_Ach_List" then
		sendTable = HL2_Ach_List_Title
		UpdateAchievements(ply)
		Announce(ply, HL2_Ach_List_Title[achName], HL2_Ach_List_Mat[achName])
	end
	
	for k, v in pairs(player.GetAll()) do
		v:ChatPrint(ply:Nick() ..  " has earned the achievement: " .. Lobby_Ach_List_Title[achName])
	end
end)
