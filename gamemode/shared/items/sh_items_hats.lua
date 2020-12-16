AddCSLuaFile() -- Add itself to files to be sent to the clients, as this file is shared

if SERVER then
	function wearHat(ply, hat)
		if hat == "no_hat" then
			ply:ConCommand("pac_clear_parts")
			return
		elseif hat == "baby_head" then
			ply:ConCommand(string.format("pac_load_url %q", "https://www.dropbox.com/s/a2lazif91o2rxmo/hl2cr_baby.txt?dl=0"))
		end
	end
end
