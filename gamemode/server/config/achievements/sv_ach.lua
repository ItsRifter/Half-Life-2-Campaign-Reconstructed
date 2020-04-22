function Announce(ply, achTitle, achImage)
	net.Start("Achievement_Earned")
		net.WriteString(ply:Nick())
		net.WriteString(achTitle)
		net.WriteString(achImage)
	net.Send(ply)
end

net.Receive("Achievement", function(len, ply)
	local achName = net.ReadString()
	
	if achName == "Rise and Shine" then
		Announce(ply, "Rise and Shine", "entities/npc_gman.png")
	end
	
	for k, v in pairs(player.GetAll()) do
		v:ChatPrint(ply:Nick() ..  " has earned the achievement: " .. achName)
	end
end)
