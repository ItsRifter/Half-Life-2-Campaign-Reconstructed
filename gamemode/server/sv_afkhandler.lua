--Afk Kicker by Salamafet, fitted for hl2cr
AFK_WARN_TIME = 300

AFK_TIME = 900

hook.Add("PlayerInitialSpawn", "MakeAFKVar", function(ply)
	ply.NextAFK = CurTime() + AFK_TIME
end)

hook.Add("Think", "HandleAFKPlayers", function()
	for _, ply in pairs (player.GetAll()) do
		if ( ply:IsConnected() and ply:IsFullyAuthenticated() ) then
			if (!ply.NextAFK) then
				ply.NextAFK = CurTime() + AFK_TIME
			end
		
			local afktime = ply.NextAFK
			if (CurTime() >= afktime - AFK_WARN_TIME) and (!ply.Warning) then
				ply:ChatPrint("Warning! You are now AFK!")
				ply:ChatPrint("You will be disconnected in 10 minutes if you remain inactive.")
				ply:EmitSound("HL1/fvox/buzz.wav", 100, 100)
				
				ply.Warning = true
			elseif (CurTime() >= afktime) and (ply.Warning) then
				ply.Warning = nil
				ply.NextAFK = nil
				ply:Kick("\nKicked for being AFK")
			end
		end
	end
end)

hook.Add("KeyPress", "PlayerMoved", function(ply, key)
	ply.NextAFK = CurTime() + AFK_TIME
	if ply.Warning == true then
		ply.Warning = false
		ply:ChatPrint("You are no longer AFK!")
	end
end)