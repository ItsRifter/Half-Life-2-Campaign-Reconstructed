function BeginHL2(chapter)
	if chapter == "D1" then
		RunConsoleCommand("ChangeLevel", "d1_trainstation_01")
	elseif chapter == "D2" then
	
	elseif chapter == "D3" then
		RunConsoleCommand("ChangeLevel", "d3_c17_02")
	elseif chapter == "lostcoast" then
		RunConsoleCommand("ChangeLevel", "d2_lostcoast")
	end
	playingHL2 = true
end

function BeginHL2EP1()
	RunConsoleCommand("ChangeLevel", "ep1_citadel_01")
end

function BeginHL2EP2()
	RunConsoleCommand("ChangeLevel", "ep2_outland_01")
end

function BeginCoastline()
	for k, v in pairs(player.GetAll()) do
		v:ChatPrint("Coastline isn't available right now... say thanks to Sponer")
	end

	--RunConsoleCommand("", "")
end

function BeginCustom(mapToLoad)
	RunConsoleCommand("ChangeLevel", mapToLoad)
end