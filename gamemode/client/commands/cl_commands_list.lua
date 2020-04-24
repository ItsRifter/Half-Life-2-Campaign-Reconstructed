concommand.Add("hl2c_givexp", function(ply, cmd, args)
	local int = tonumber(args[1])
	
	if int then
		net.Start("GiveXP")
			net.WriteInt(int, 16)
		net.SendToServer(ply)
	elseif not int then
		print("Invalid Value")
	end
end)

concommand.Add("hl2c_allowsuicide", function(ply, cmd, args)
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

concommand.Add("hl2c_setlevel", function(ply, cmd, args)
	local level = tonumber(args[1])
	if ply:IsAdmin() then
		if level then
			net.Start("SetLevel")
				net.WriteInt(level, 16)
			net.SendToServer(ply)
		elseif not level then
			print("Invalid Value")
		end
	else
		print("You do not have access to this command")
	end
end)