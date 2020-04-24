function BeginHL2()
	RunConsoleCommand("ChangeLevel", "d1_trainstation_05")
end

function MapChanger()
	
	
	print("Change map please!")
	
	local currentMap = game.GetMap()
	local hl2maps = {	
		"d1_trainstation_01",
		"d1_trainstation_02",
		"d1_trainstation_03",
		"d1_trainstation_04",
		"d1_trainstation_05",
		"d1_trainstation_06",
	}
	
end

function BeginHL2EP1()
	RunConsoleCommand("ChangeLevel", "ep1_citadel_00")
end

function BeginHL2EP2()
	RunConsoleCommand("ChangeLevel", "ep2_outlands_01")
end
