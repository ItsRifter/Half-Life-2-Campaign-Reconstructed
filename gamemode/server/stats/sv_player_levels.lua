function XPManagement(ply)
	local CurrentXP = 0
	local MaxXP = 10
	local CurrentLevel = 1
	Leveler = ply:Nick()
	print(Leveler .. " XP " .. CurrentXP .. "")
	AddXP(ply)
end

function AddXP(ply)
	CurrentXP = CurrentXP + 10
	if CurrentXP >= MaxXP then
		print("LEVEL UP")
		MaxXP = MaxXP * 2
		print("Max xp is now " .. MaxXP)
		CurrentLevel = CurrentLevel + 1
		for k, v in pairs( player.GetAll()) do
			v:ChatPrint(Leveler .. " has leveled up to " .. CurrentLevel)
		end
	end
end