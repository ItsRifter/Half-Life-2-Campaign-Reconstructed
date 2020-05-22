concommand.Add("hl2cr_givexp", function(ply, cmd, args)
	local int = tonumber(args[1])
	
	if ply:IsAdmin() then
		if int then
			net.Start("GiveXP")
				net.WriteInt(int, 16)
			net.SendToServer()
			print(int)
		elseif not int then
			print("Invalid Value")
		end
	else
		print("You do not have access to this command")
	end
end)

concommand.Add("hl2cr_allowsuicide", function(ply, cmd, args)
	local int = tonumber(args[1])
	if ply:IsAdmin() then
		if int == 1 then
			net.Start("SetSuicide")
				net.WriteInt(int, 16)
			net.SendToServer()
			print("Suicide enabled")
		elseif int == 0 then
			net.Start("SetSuicide")
				net.WriteInt(int, 16)
			net.SendToServer()
			print("Suicide disabled")
		else
			print("INVALID VALUE")
		end
	else
		print("You do not have access to this command")
	end
end)

concommand.Add("hl2cr_setmaxxp", function(ply, cmd, args)
	local maxXP = tonumber(args[1])
	if ply:IsAdmin() then
		if maxXP then
			net.Start("SetMaxXP")
				net.WriteInt(maxXP, 16)
			net.SendToServer()
		else
			print("Invalid Value")
		end
	else
		print("You do not have access to this command")
	end
end)

concommand.Add("hl2cr_setlevel", function(ply, cmd, args)
	local level = tonumber(args[1])
	if ply:IsAdmin() then
		if level then
			net.Start("SetLevel")
				net.WriteInt(level, 16)
			net.SendToServer()
		else
			print("Invalid Value")
		end
	else
		print("You do not have access to this command")
	end
end)

concommand.Add("hl2cr_addcoins", function(ply, cmd, args)
	local coins = tonumber(args[1])
	if ply:IsAdmin() then
		if coins then
			net.Start("AddCoins")
				net.WriteInt(coins, 32)
			net.SendToServer()
		else
			print("Invalid Value")
		end
	else
		print("You do not have access to this command")
	end
end)

concommand.Add("hl2cr_difficulty", function(ply, cmd, args)
	local diff = tonumber(args[1])
	if ply:IsAdmin() then
		if diff >= 1 and diff <= 3 then
			net.Start("DiffMode")
				net.WriteInt(diff, 8)
			net.SendToServer()
		else
			print("Invalid Value")
		end
	else
		print("You do not have access to this command")
	end
end)

concommand.Add("hl2cr_survival", function(ply, cmd, args)
	local surv = tonumber(args[1])
	if ply:IsAdmin() then
		if surv == 0 or surv == 1 then
			net.Start("SurvMode")
				net.WriteInt(surv, 16)
			net.SendToServer()
		else
			print("Invalid Value")
		end
	else
		print("You do not have access to this command")
	end
end)

concommand.Add("hl2cr_petsummon", function(ply, cmd, args)
	local level = ply:GetNWInt("Level")
	local petEnt = ply:GetNWEntity("PetEntity")
	if tonumber(level) >= 10 then
		net.Start("SpawnPetConCommand")
		net.SendToServer()
	elseif tonumber(level) < 10 then
		LocalPlayer():ChatPrint("You don't have access to pets")
	end
end)