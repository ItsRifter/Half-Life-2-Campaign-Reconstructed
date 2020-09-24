AddCSLuaFile() -- Add itself to files to be sent to the clients, as this file is shared

if CLIENT then

	local babyURL = "https://www.dropbox.com/s/tmojk6tpzcxbwgd/baby_head.txt?dl=0"
	net.Receive("WearHat", function(len, ply)
		local hat = net.ReadString()
		
		if hat == "no_hat" then
			LocalPlayer():ConCommand("pac_clear_parts")
			return
		elseif hat == "baby_head" then
			LocalPlayer():ConCommand("pac_clear_parts")
			LocalPlayer():ConCommand("pac_load_url https://www.dropbox.com/s/tmojk6tpzcxbwgd/baby_head.txt?dl=0")
			print(babyURL)
		end
	end)
end
