HasVortex = false

function placeVortex()
	
	
	
	if game.GetMap() == "d1_trainstation_05" then
		VORTEX_POSITION = Vector(-10969, -5326, 384)
	elseif game.GetMap() == "d1_trainstation_06" then
		VORTEX_POSITION = Vector(-6583, -1442, 0)
	elseif game.GetMap() == "d1_canals_01" then
		VORTEX_POSITION = Vector(882, -1523, -143)
	elseif game.GetMap() == "d1_canals_02" then
		VORTEX_POSITION = Vector(124, 1744, -575)
	elseif game.GetMap() == "d1_eli_01" then
		VORTEX_POSITION = Vector(380, 2067, -2476)
	elseif game.GetMap() == "d1_eli_02" then
		VORTEX_POSITION = Vector(-404, 361, -2255)
	elseif game.GetMap() == "d1_town_02" then
		VORTEX_POSITION = Vector(-1984, -271, -2943)
	end
	
	Vortex = ents.Create("prop_dynamic")
	Vortex:SetModel("models/effects/combineball.mdl")
	Vortex:SetName("vortex")
	
	vortTrigger = ents.Create("trigger_vortex")
	
	
	if VORTEX_POSITION then
		Vortex:SetPos(VORTEX_POSITION)
		Vortex:Spawn()
		vortTrigger:SetPos(Vortex:GetPos())
		vortTrigger:Spawn()
	end
	

	
	
	
end


hook.Add("InitPostEntity", "SetUpVortex", placeVortex)
hook.Add("PostCleanupMap", "SetUpVortex", placeVortex)