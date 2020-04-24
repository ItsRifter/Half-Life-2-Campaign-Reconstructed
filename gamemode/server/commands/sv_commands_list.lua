hook.Add("PlayerSay", "Commands", function(ply, text)
	if (string.lower(text) == "!ach" or string.lower(text) == "!achievement" ) then
		net.Start("Open_Ach_Menu")
		net.Send(ply)
		return ""
	end
	
	if string.lower(text) == "!allowsuicide" then
		if ply:IsAdmin() then
			if GetConVar("hl2c_allowsuicide"):GetInt() == 0 then
				ply:ChatPrint("Suicide Enabled")
				GetConVar("hl2c_allowsuicide"):SetInt(1)
			else 
				ply:ChatPrint("Suicide Disabled")
				GetConVar("hl2c_allowsuicide"):SetInt(0)
			end
		else
		ply:ChatPrint("You do not have access to this command!")
		net.Start("Failed_Command")
		net.Send(ply)
		end
		return ""
	end
end)
