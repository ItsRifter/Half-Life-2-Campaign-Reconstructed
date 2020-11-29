function SetupLobbyMap()
	--Create the lua entity
	MapLua = ents.Create("lua_run")
	MapLua:SetName("triggerhook")
	MapLua:Spawn()
		
	for k, door in pairs(ents.FindByName("hl2_door")) do
		door:Fire("Open")
	end	
	
	for k, door2 in pairs(ents.FindByName("hl2_ep1_door")) do
		door2:Fire("Open")
	end
	
	for k, door3 in pairs(ents.FindByName("hl2_ep2_door")) do
		door3:Fire("Open")
	end
	
	game.SetGlobalState("super_phys_gun", 0)
	game.SetGlobalState("antlion_allied", 0)
	game.SetGlobalState("ep2_alyx_injured", 0)
	game.SetGlobalState("friendly_encounter", 0)
	
	GetConVar("hl2cr_doublehp"):SetInt(0)
	--GetConVar("hl2cr_specials"):SetInt(0)
	
	--Lost cause achievement trigger
	for a, LCAch in pairs(ents.FindByName("trigger_achievement_lostcause")) do
		LCAch:Fire("AddOutput", "OnTrigger triggerhook:RunPassedCode:hook.Run( 'GiveLostCause' ):0:-1" )
	end
	
	if game.GetMap() == "hl2cr_lobby" then
		if file.Exists("hl2cr_data/d1_town_02", "DATA") then
			file.Delete("hl2cr_data/d1_town_02.txt")
		elseif file.Exists("hl2cr_data/d2_coast_07", "DATA") then
			file.Delete("hl2cr_data/d2_coast_07.txt")
		end
	end
	
	local specialChance = 0
	local NPCKind = 0
	if GetConVar("hl2cr_specials"):GetInt() == 1 then
		for k, npc in pairs(ents.FindByClass("npc_combine_*")) do
			specialChance = math.random(1, 65)
			if specialChance <= (12 * GetConVar("hl2cr_difficulty"):GetInt()) then
				NPCKind = math.random(5, 5)
				local newNPC = nil
				if NPCKind == 1 then
					newNPC = ents.Create("npc_combine_assassin")
				elseif NPCKind == 2 then
					newNPC = ents.Create("npc_combine_support")
				elseif NPCKind == 3 then
					newNPC = ents.Create("npc_combine_medic")
				elseif NPCKind == 4 then
					newNPC = ents.Create("npc_combine_veteran")
				elseif NPCKind == 5 then
					newNPC = ents.Create("npc_combine_grenadier")
				end
				
				local NPCPos = npc:GetPos()
				newNPC:SetPos(npc:GetPos())
				newNPC:Spawn()
				npc:Remove()
			end
		end
	end
end

hook.Add("GiveLostCause", "GrantLobbyAch", function()
	local activator, caller = ACTIVATOR, CALLER
	
	Achievement(activator, "Lost_Cause", "Lobby_Ach_List")
end)