hook.Add("PlayerSay", "Commands", function(ply, text)
	if (string.lower(text) == "!ach" or string.lower(text) == "!achievement" ) then
		print("Achievement menu opened")
		AchievementMenu()
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
		end
		return ""
	end
end)