local playerCount = 0
local loyalPlayers = 0
local chance = {}

hook.Add("Think", "loyalThink", function()
	playerCount = #player.GetAll()
end)

function beginLoyal()

	
	if playerCount > 4 and playerCount <= 8 then
		loyalPlayers = 2
	else
		loyalPlayers = 0
	end
	
	--Assign the chance table to each player
	for k, v in pairs(player.GetAll()) do
		if loyalPlayers != 0 then
			local chosen = math.random(playerCount)
			chance[k] = v
		end
	end
	
	--For how many can become loyal, loop through each player and see if they
	--gain the chance to become loyal
	for k = 0, loyalPlayers do
		for i, p in pairs(player.GetAll()) do
			if p == table.Random(chance) then
				p:ChatPrint("You have been selected to join the combine: !loyal")
				p.canBecomeLoyal = true
			end
		end
	end
end

--Once the loyal is over, set each loyal player back to normal
function endLoyal()
	for k, v in pairs(player.GetAll()) do
		if v:Team() == TEAM_LOYAL then
			v:SetTeam(TEAM_ALIVE)
			v:SetModel(v.oldModel)
			v.loyal = false
			v:Spawn()
			if v.totalXPLoyal then
				v.hl2cPersistent.XP = v.hl2cPersistent.XP + v.totalXPLoyal
				v:ChatPrint("Your contribution to the combine has been met with gratitude")
				v:ChatPrint(v.totalXPLoyal.. " Total XP")
			else
				v:ChatPrint("The combine has shown disappointment in your efforts")
			end
		end
	end
end