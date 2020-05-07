function SpectateMode(ply)
	local alive = team.GetPlayers(TEAM_ALIVE)
	ply:SetNoTarget( true )
	if ply:IsValid() and ply:Team() == TEAM_DEAD or ply:Team() == TEAM_COMPLETED_MAP then
		if #alive <= 0 then
		ply:SpectateEntity(ents.FindByClass("info_player_*")[1])
		ply:GetViewEntity():GetPos()
		return end
	end
	
	if ply:KeyPressed(IN_ATTACK) then
		if not ply.SpecID then
			ply.SpecID = 1
		end
		
		ply.SpecID = ply.SpecID + 1
		
		if ply.SpecID > #alive then
			ply.SpecID = 1
		end
		
		ply:SpectateEntity(alive(ply.SpecID))
		ply:SetPos(alive(ply.SpecID):GetPos())
		
	elseif ply:KeyPressed(IN_ATTACK2) then
		if not ply.SpecID then
			ply.SpecID = 1
		end
		
		ply.SpecID = ply.SpecID + 1
		
		if ply.SpecID <= 0 then
			ply.SpecID = #alive
		end
		
		ply:SpectateEntity(alive(ply.SpecID))
		ply:SetPos(alive(ply.SpecID):GetPos())
		--net.Start( "Spectating" )
		--	net.WriteEntity( Aliveplayers[ply.SpecID] )
		--net.Send(ply)
	end
	
	ply:GetViewEntity():GetPos()
end
