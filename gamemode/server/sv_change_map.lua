function BeginHL2()
	RunConsoleCommand("ChangeLevel", "d1_trainstation_01")
	playingHL2 = true
end

function BeginHL2D2()
	RunConsoleCommand("ChangeLevel", "d2_coast_01")
	playingHL2 = true
end

function BeginHL2D3()
	RunConsoleCommand("ChangeLevel", "d3_c17_02")
	playingHL2 = true
end

function BeginHL2EP1()
	RunConsoleCommand("ChangeLevel", "ep1_citadel_01")
end

function BeginHL2EP2()
	RunConsoleCommand("ChangeLevel", "ep2_outland_01")
end

function BeginCustom(mapToLoad)
	RunConsoleCommand("ChangeLevel", mapToLoad)
end