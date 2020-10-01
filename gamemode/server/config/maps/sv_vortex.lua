function placeVortex()

	if game.GetMap() == "d1_trainstation_05" then
		VORTEX_POSITION = Vector(-10969, -5326, 384)
	elseif game.GetMap() == "d1_trainstation_06" then
		VORTEX_POSITION = Vector(-6583, -1442, 0)
	elseif game.GetMap() == "d1_canals_01" then
		VORTEX_POSITION = Vector(882, -1523, -143)
	elseif game.GetMap() == "d1_canals_02" then
		VORTEX_POSITION = Vector(124, 1744, -575)
	elseif game.GetMap() == "d1_canals_05" then
		VORTEX_POSITION = Vector(-29, -1280, -111)
	elseif game.GetMap() == "d1_canals_07" then
		VORTEX_POSITION = Vector(4222, -7058, -724)
	elseif game.GetMap() == "d1_canals_08" then
		VORTEX_POSITION = Vector(1840, -380, -485)
	elseif game.GetMap() == "d1_canals_09" then
		VORTEX_POSITION = Vector(1540, 8815, -257)
	elseif game.GetMap() == "d1_eli_01" then
		VORTEX_POSITION = Vector(380, 2067, -2476)
	elseif game.GetMap() == "d1_eli_02" then
		VORTEX_POSITION = Vector(-404, 361, -2255)
	elseif game.GetMap() == "d1_town_02" and not file.Exists("hl2cr_data/d1_town_02.txt", "DATA") then
		VORTEX_POSITION = Vector(-1982, -270, -2942)
	elseif game.GetMap() == "d1_town_03" then
		VORTEX_POSITION = Vector(-2223, -2047, -2983)
	elseif game.GetMap() == "d1_town_02a" then
		VORTEX_POSITION = Vector(-6930, 415, -2847)
	elseif game.GetMap() == "d1_town_04" then
		VORTEX_POSITION = Vector(-141, -897, -4767)
	elseif game.GetMap() == "d1_town_05" then
		VORTEX_POSITION = Vector(-1311, 9039, 1248)
	elseif game.GetMap() == "d2_coast_01" then
		VORTEX_POSITION = Vector(-12909, 656, 1784)
	elseif game.GetMap() == "d2_coast_04" then
		VORTEX_POSITION = Vector(6035, -6065, 576)
	elseif game.GetMap() == "d2_coast_08" then
		VORTEX_POSITION = Vector(2955, -5609, 1981)
	elseif game.GetMap() == "d2_coast_11" then
		VORTEX_POSITION = Vector(4678, 8309, 658)
	elseif game.GetMap() == "d2_prison_07" then
		VORTEX_POSITION = Vector(3530, -4339, -351)
	elseif game.GetMap() == "d3_c17_03" then
		VORTEX_POSITION = Vector(-1382, -2523, 200)
	elseif game.GetMap() == "d3_c17_07" then
		VORTEX_POSITION = Vector(6350, 1533, 314)
	elseif game.GetMap() == "d3_c17_12b" then
		VORTEX_POSITION = Vector(-6134, 332, 231)
	elseif game.GetMap() == "d3_c17_13" then
		VORTEX_POSITION = Vector(6815, 2729, 256)
	end
	
	if game.GetMap() == "ep1_citadel_01" then
		VORTEX_POSITION = Vector(-4209, 6942, 2584)
	elseif game.GetMap() == "ep1_citadel_02" then
		VORTEX_POSITION = Vector(-945, -823, 849)
	elseif game.GetMap() == "ep1_c17_01" then
		VORTEX_POSITION = Vector(2723, 281, 192)
	elseif game.GetMap() == "ep1_c17_02" then
		VORTEX_POSITION = Vector(-613, 609, 321)
	elseif game.GetMap() == "ep1_c17_02b" then
		VORTEX_POSITION = Vector(636, 3076, 394)
	elseif game.GetMap() == "ep1_c17_06" then
		VORTEX_POSITION = Vector(12096, 8537, -671)
	end
	
	if game.GetMap() == "ep2_outland_01" then
		VORTEX_POSITION = Vector(-5837, 3783, 45)
	elseif game.GetMap() == "ep2_outland_01a" then
		VORTEX_POSITION = Vector(-11134, -7896, 1396)
	elseif game.GetMap() == "ep2_outland_04" then
		VORTEX_POSITION = Vector(6187, 633, -2369)
	elseif game.GetMap() == "ep2_outland_05" then
		VORTEX_POSITION = Vector(110, 3932, 234)
	elseif game.GetMap() == "ep2_outland_06" then
		VORTEX_POSITION = Vector(3357, 4041, 254)
	elseif game.GetMap() == "ep2_outland_07" then
		VORTEX_POSITION = Vector(-10018, -9600, 660)
	elseif game.GetMap() == "ep2_outland_10" then
		VORTEX_POSITION = Vector(1509, -2401, 536)
	elseif game.GetMap() == "ep2_outland_12a" then
		VORTEX_POSITION = Vector(144, -1864, -1111)
	end
	
	if VORTEX_POSITION then
		Vortex = ents.Create("prop_dynamic")
		Vortex:SetModel("models/effects/combineball.mdl")
		Vortex:SetName("vortex")
	
		vortTrigger = ents.Create("trigger_vortex")
	
		Vortex:SetPos(VORTEX_POSITION)
		Vortex:Spawn()
		vortTrigger:SetPos(Vortex:GetPos())
		vortTrigger:Spawn()
	end
	
end


hook.Add("InitPostEntity", "SetUpVortex", placeVortex)
hook.Add("PostCleanupMap", "SetUpVortex", placeVortex)