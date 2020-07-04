function SetupCoopMap()
	
	CHECKPOINTS = CHECKPOINTS or {}
	
	--Create the lua entity
	MapLua = ents.Create("lua_run")
	MapLua:SetName("triggerhook")
	MapLua:Spawn()
	
	for k, v in pairs(ents.FindByClass("trigger_weapon_strip")) do
		v:Remove()
	end
	
	--This map maker doesn't either know english or is rather young when he made this
	if game.GetMap() == "level01_entryway_of_doom" then
		for k, b in pairs(ents.FindByName("bouton10")) do
			b:Fire("AddOutput", "OnPressed triggerhook:RunPassedCode:hook.Run( 'NextMap' ):0:-1")
		end
	end
	
	if game.GetMap() == "level02_tricks_and_traps" then
		for k, b in pairs(ents.FindByName("make_antg1")) do
			b:Fire("Spawn")
		end
		timer.Simple(2, function()
			for k, a in pairs(ents.FindByName("antg2")) do
				a:Fire("AddOutput", "OnDeath triggerhook:RunPassedCode:hook.Run( 'NextMap' ):0:-1")
			end
		end)
	end
	
	if game.GetMap() == "level03_underground" then
		for k, b in pairs(ents.FindByName("make_antg1")) do
			b:Fire("Spawn")
		end
		timer.Simple(2, function()
			for k, a in pairs(ents.FindByName("antg1")) do
				a:Fire("AddOutput", "OnDeath triggerhook:RunPassedCode:hook.Run( 'NextMap' ):0:-1")
			end
		end)
	end
	
	if game.GetMap() == "level04_across_the_darkness" then
		for k, b in pairs(ents.FindByName("bouton6")) do
			b:Fire("AddOutput", "OnPressed triggerhook:RunPassedCode:hook.Run( 'NextMap' ):0:-1")
		end
	end
end

hook.Add( "NextMap", "ChangeMap", function()
	
	for k, v in pairs(player.GetAll()) do
		giveRewards(v)
	end
	
	net.Start("DisplayMapTimer")
	net.Broadcast()
	timer.Create("MapTimer", 20, 0, function() hook.Call("OnChangeLevel") timer.Remove("MapTimer") end)
	
end)

hook.Add("OnChangeLevel", "NextCoop01Map", function()
	local map = game.GetMap()
	
	local Coop01 = {
		"level01_entryway_of_doom",
		"level02_tricks_and_traps",
		"level03_underground",
		"level04_across_the_darkness",
		"level05_diehard",
		"level06_base",
		"level07_scary_house",
	}
	
	for k = 1, #Coop01 do
		if (map == Coop01[k])then
			RunConsoleCommand("changelevel", Coop01[k+1])
		end
	end
end)

hook.Add("InitPostEntity", "SetupMapLua", SetupCoopMap)
hook.Add("PostCleanupMap", "SetupMapLua", SetupCoopMap)