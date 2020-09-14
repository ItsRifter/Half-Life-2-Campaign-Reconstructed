function SetupLobbyMap()
	--Create the lua entity
	MapLua = ents.Create("lua_run")
	MapLua:SetName("triggerhook")
	MapLua:Spawn()
		
	for k, door in pairs(ents.FindByName("hl2_door")) do
		door:Fire("Open")
	end
	
	game.SetGlobalState("super_phys_gun", 0)
	
	--Lost cause achievement trigger
	for a, LCAch in pairs(ents.FindByName("trigger_achievement_lostcause")) do
		LCAch:Fire("AddOutput", "OnTrigger triggerhook:RunPassedCode:hook.Run( 'GiveLostCause' ):0:-1" )
	end
	
	if game.GetMap() == "hl2c_lobby_remake" then
		if file.Exists("hl2cr_data/d1_town_02", "DATA") then
			file.Delete("hl2cr_data/d1_town_02.txt")
		elseif file.Exists("hl2cr_data/d2_coast_07", "DATA") then
			file.Delete("hl2cr_data/d2_coast_07.txt")
		end
	end
end

hook.Add("GiveLostCause", "GrantLobbyAch", function()
	local activator, caller = ACTIVATOR, CALLER
	
	Achievement(activator, "Lost_Cause", "Lobby_Ach_List", 500)
end)