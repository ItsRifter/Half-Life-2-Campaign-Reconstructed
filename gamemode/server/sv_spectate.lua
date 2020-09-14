local alive = team.GetPlayers(TEAM_ALIVE)
isSpec = false
local specEnt = 1
function SpectateMode(ply)
	isSpec = true
	ply:SetNoTarget(true)
	if ply:IsValid() then
		ply:StripWeapons()
		ply:Spectate(5)
	end
end

function DisableSpec(ply)
	ply:UnSpectate()
	ply.isSpec = false
end

hook.Add("KeyPress", "SpecKey", function(ply, key)
	if ply:KeyPressed(IN_ATTACK) then
		specEnt = specEnt + 1
		if specEnt > #alive then
			specEnt = 1
		end
		ply:SpectateEntity(alive[specEnt])
	elseif ply:KeyPressed(IN_ATTACK2) then
		specEnt = specEnt - 1
		if specEnt < 0 then
			specEnt = #team.GetPlayers(TEAM_ALIVE) 
		end
		ply:SpectateEntity(alive[specEnt])
	end
end)
