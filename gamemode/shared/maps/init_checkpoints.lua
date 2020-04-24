function GM:InitPostEntity()

	if not game.SinglePlayer() then
		if TRIGGER_CHECKPOINT then
			for _, tcpInfo in pairs(TRIGGER_CHECKPOINT) do
				local tcp = ents.Create("trigger_checkpoint")
				tcp.min = tcpInfo[1]
				tcp.max = tcpInfo[2]
				tcp.pos = tcp.max - ( ( tcp.max - tcp.min ) / 2)
				tcp.skipSpawnpoint = tcpInfo[3]
				tcp.OnTouchRun = tcpInfo[4]

				if tcpInfo[5] ~= nil then
					tcp.CustomSpawn = tcpInfo[5]
				end

				tcp:SetPos(tcp.pos)
				tcp:Spawn()
				table.insert( checkpointPositions, tcp.pos )
			end
		end
	end
end
	
	