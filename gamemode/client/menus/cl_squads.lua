surface.CreateFont("Squad_TeamName", {
	font = "Arial",
	size = 22,
})

local XPTotal = 0

function StartSquad(leaderName, teamName)
	
	squadFrame = vgui.Create("DFrame")
	squadFrame:SetVisible(true)
	squadFrame:ShowCloseButton(false)
	squadFrame:SetTitle("")
	squadFrame:SetSize(250, 650)
	squadFrame:SetPos(0, ScrH() / 2 - 200)
	
	local squadPanel = vgui.Create("DPanel", squadFrame)
	squadPanel:SetBackgroundColor(Color(158, 158, 158))
	squadPanel:Dock(FILL)
	
	
	local squadTeamNameLabel = vgui.Create("DLabel", squadPanel)
	squadTeamNameLabel:SetText(leaderName .. "'s Team:\n" .. teamName)
	squadTeamNameLabel:SetPos(0, 15)
	squadTeamNameLabel:SetFont("Squad_TeamName")
	squadTeamNameLabel:SetTextColor(Color( 0, 0, 0))
	squadTeamNameLabel:SizeToContents()
	
	local squadTeamLeaderMember = vgui.Create("DLabel", squadPanel)
	squadTeamLeaderMember:SetPos(0, 75)
	squadTeamLeaderMember:SetText(leaderName .. ":\n" .. XPTotal .. "XP")
	squadTeamLeaderMember:SetFont("Squad_TeamName")
	squadTeamLeaderMember:SetTextColor(Color( 0, 0, 0))
	squadTeamLeaderMember:SizeToContents()
	

	
	squadPanel.Think = function()

		squadTeamLeaderMember:SetText(leaderName .. ":\n" .. XPTotal .. "XP")
	
		for k, v in pairs(player.GetAll()) do
			if v != LocalPlayer() and (v:GetNWBool("InTeam") and v:GetNWString("Team") == teamName) then
				local yPos = 35 * v
				
				local squadTeamMember = vgui.Create("DLabel", squadPanel)
				squadTeamMember:SetPos(0, 75 + yPos)
				squadTeamMember:SetText(v:Nick() .. ":\n" .. math.Round(LocalPlayer():GetNWInt("TotalSquadXP"), 0) .. "XP")
				squadTeamMember:SetFont("Squad_TeamName")
				squadTeamMember:SetTextColor(Color( 0, 0, 0))
				squadTeamMember:SizeToContents()
			end
		end
		
		if XPTotal != 0 and not timer.Exists("SquadTimer") then
			print("Timer Created")
			timer.Create("SquadTimer", 5, 0, function()
				
				
				print("Timer Expired")
				XPTotal = 0
				squadTeamLeaderMember:SetText(leaderName .. ":\n" .. 0 .. "XP")
				timer.Remove("SquadTimer")
			end)
		end	
	end
end

function EndSquad()
	squadFrame:Close()
end

net.Receive("Squad_Created", function()
	local leaderName = net.ReadString()
	local teamName = net.ReadString()
	StartSquad(leaderName, teamName)
end)

net.Receive("Squad_XPUpdate", function()
	XPTotal = XPTotal + net.ReadInt(32)
end)

net.Receive("Squad_Disband", function()
	EndSquad()
end)
