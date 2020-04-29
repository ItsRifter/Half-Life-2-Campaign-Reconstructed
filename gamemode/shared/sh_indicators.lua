if SERVER then
	
	hook.Add("OnNPCKilled", "NPCDeathIndicator", function(npc, attacker, inflictor)
		local giveXP
		local giveCoins
		local bonusXP = 0
		local bonusCoins = 0

		if npc:GetClass() == "npc_antlionguard" then
			bonusXP = 75
			bonusCoins = 50
		end
		if npc:GetClass() != "npc_antlion" then
			giveXP = math.Rand(1 + bonusXP, (25 + bonusXP) * GetConVar("hl2c_difficulty"):GetInt())
			giveCoins = math.Rand(1 + bonusCoins, (15 + bonusCoins) * GetConVar("hl2c_difficulty"):GetInt())
		else
			giveXP = 0
			giveCoins = 0
		end
		local npcPos = npc:GetPos()
		
		if attacker:IsPlayer() then
			AddXP(attacker, giveXP)
			Spawn(giveXP, giveCoins, npc:GetPos(), npc, attacker)
		end	
	end)

	function Spawn(xpAmt, coinAmt, pos, target, reciever)
		
		net.Start("IndicSpawn")
		
		net.WriteInt(xpAmt, 16)
		
		net.WriteInt(coinAmt, 16)
		
		net.WriteVector(pos)
		
		net.Send(reciever)
	end
end
