function BeginHL2()
	RunConsoleCommand("ChangeLevel", "d1_trainstation_01")
	playingHL2 = true
end

function BeginHL2EP1()
	RunConsoleCommand("ChangeLevel", "ep1_citadel_00")
end

function BeginHL2EP2()
	RunConsoleCommand("ChangeLevel", "ep2_outlands_01")
end

function BeginCoop01()
	RunConsoleCommand("ChangeLevel", "level01_entryway_of_doom")
end