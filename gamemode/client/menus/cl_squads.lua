surface.CreateFont("Squad_TeamName", {
	font = "Arial",
	size = 22,
})

local XPTotal = 0
local members = 0
local memberNames = {}

function StartSquad(leaderName, teamName)
	TRANSPARENT = Color(0, 0, 0, 175)
	squadFrame = vgui.Create("DFrame")
	squadFrame:SetVisible(true)
	squadFrame:ShowCloseButton(false)
	squadFrame:SetTitle("")
	squadFrame:SetSize(550, 250)
	squadFrame:SetPos(0, ScrH() / 2 + 300)
	squadFrame.Paint = function()
		draw.RoundedBox( 8, 0, 0, 0, 0, Color( 0, 0, 0, 150 ) )
	end	
	
	local squadPanel = vgui.Create("DPanel", squadFrame)
	squadPanel:SetBackgroundColor(TRANSPARENT)
	squadPanel:Dock(FILL)
	
	local squadTeamNameLabel = vgui.Create("DLabel", squadPanel)
	squadTeamNameLabel:SetText(leaderName .. "'s Team:\n" .. teamName)
	squadTeamNameLabel:SetPos(0, 15)
	squadTeamNameLabel:SetFont("Squad_TeamName")
	squadTeamNameLabel:SetTextColor(Color(255, 255, 255))
	squadTeamNameLabel:SizeToContents()
	
	local squadTeamLeaderMember = vgui.Create("DLabel", squadPanel)
	squadTeamLeaderMember:SetPos(0, 75)
	squadTeamLeaderMember:SetText(leaderName .. ":\n" .. XPTotal .. "XP")
	squadTeamLeaderMember:SetFont("Squad_TeamName")
	squadTeamLeaderMember:SetTextColor(Color(255, 255, 255))
	squadTeamLeaderMember:SizeToContents()
	
	squadPanel.Think = function()
		squadTeamLeaderMember:SetText(leaderName .. ":\n" .. XPTotal .. "XP")
		for k, v in pairs(memberNames) do
			local xPos = 35 * #v
			local squadTeamMember = vgui.Create("DLabel", squadPanel)
			squadTeamMember:SetPos(50 + xPos, 75)
			squadTeamMember:SetText(memberNames[k] .. ":\n")
			squadTeamMember:SetFont("Squad_TeamName")
			squadTeamMember:SetTextColor(Color(255, 255, 255))
			squadTeamMember:SizeToContents()
			PrintTable(memberNames)
		end
		if XPTotal != 0 and not timer.Exists("SquadTimer") then
			print("Timer Created")
			timer.Create("SquadTimer", 5, 0, function()
				
				
				print("Timer Expired")
				XPTotal = 0
				squadTeamLeaderMember:SetText(leaderName .. ":\n" .. 0 .. "XP")
				for k, v in pairs(memberNames) do
					squadTeamMember:SetText(memberNames[v] .. ":\n" .. 0 .. "XP")
				end
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

net.Receive("Squad_Joined", function()
	local username = net.ReadString()
	members = members + 1
	table.insert(memberNames, username)
	local currentLeaderName = net.ReadString()
	local currentTeamName = net.ReadString()
	StartSquad(currentLeaderName, currentTeamName)
end)

net.Receive("Squad_Left", function()
	local username = net.ReadString()
	members = members - 1
	table.RemoveByValue(memberNames, username)
	EndSquad()
end)

net.Receive("Squad_XPUpdate", function()
	XPTotal = XPTotal + net.ReadInt(32)
end)

net.Receive("Squad_Disband", function()
	table.Empty(memberNames)
	EndSquad()
end)
