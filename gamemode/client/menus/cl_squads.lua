surface.CreateFont("Squad_TeamName", {
	font = "Arial",
	size = 22,
})
surface.CreateFont("Squad_TeamMembers", {
	font = "Arial",
	size = 18,
})

local XPTotal = 0
local memberNames = {}

function StartSquad(leaderName, teamName)
	
	TRANSPARENT = Color(0, 0, 0, 175)
	
	squadFrame = vgui.Create("DFrame")
	squadFrame:SetVisible(true)
	squadFrame:ShowCloseButton(false)
	squadFrame:SetTitle("")
	squadFrame:SetSize(650, 250)
	squadFrame:SetPos(-5, ScrH() / 2 - 500)
	squadFrame.Paint = function()
		draw.RoundedBox( 8, 0, 0, 0, 0, Color( 0, 0, 0, 150 ) )
	end

	squadPanel = vgui.Create("DPanel", squadFrame)
	squadPanel:SetBackgroundColor(TRANSPARENT)
	squadPanel:Dock(FILL)
	
	squadTeamNameLabel = vgui.Create("DLabel", squadPanel)
	squadTeamNameLabel:SetText(leaderName .. "'s Team:\n" .. teamName)
	squadTeamNameLabel:SetPos(0, 15)
	squadTeamNameLabel:SetFont("Squad_TeamName")
	squadTeamNameLabel:SetTextColor(Color(255, 255, 255))
	squadTeamNameLabel:SizeToContents()
	
	squadTeamLeaderMember = vgui.Create("DLabel", squadPanel)
	squadTeamLeaderMember:SetPos(0, 75)
	squadTeamLeaderMember:SetText(leaderName .. ":\n" .. XPTotal .. "XP")
	squadTeamLeaderMember:SetFont("Squad_TeamMembers")
	squadTeamLeaderMember:SetTextColor(Color(255, 255, 255))
	squadTeamLeaderMember:SizeToContents()
	
	squadTeamMember = vgui.Create("DLabel", squadPanel)
	squadTeamMember:SetText("")
	squadTeamMember:SizeToContents()
	squadPanel.Think = function()
		squadTeamLeaderMember:SetText(leaderName .. ":\n" .. XPTotal .. "XP")
		for k, v in pairs(memberNames) do
			local xPos = 125 * #memberNames
			local name = table.concat(memberNames, " ", 1)
			squadTeamMember:SetPos(xPos, 75)
			squadTeamMember:SetText(name .. ":\n" .. 0 .. "XP")
			squadTeamMember:SetFont("Squad_TeamMembers")
			squadTeamMember:SetTextColor(Color(255, 255, 255))
			squadTeamMember:SizeToContents()
		end
		if XPTotal != 0 and not timer.Exists("SquadTimer") then
			print("Timer Created")
			timer.Create("SquadTimer", 10, 0, function()
				
				
				print("Timer Expired")
				XPTotal = 0
				squadTeamLeaderMember:SetText(leaderName .. ":\n" .. 0 .. "XP")
				for k, v in pairs(memberNames) do
					squadTeamMember:SetText(v[k] .. ":\n" .. 0 .. "XP")
				end
				timer.Remove("SquadTimer")
			end)
		end	
	end
end

function JoinSquad(leaderName, teamName)
	
	squadPanel.Think = function()
		squadTeamLeaderMember:SetText(leaderName .. ":\n" .. XPTotal .. "XP")
		for k, v in pairs(memberNames) do
			local xPos = 250 * #memberNames
			local name = table.concat(memberNames, " ")
			squadTeamMember:SetPos(xPos, 75)
			squadTeamMember:SetText(name .. ":\n" .. 0 .. "XP")
			squadTeamMember:SetFont("Squad_TeamMembers")
			squadTeamMember:SetTextColor(Color(255, 255, 255))
			squadTeamMember:SizeToContents()
		end
		if XPTotal != 0 and not timer.Exists("SquadTimer") then
			print("Timer Created")
			timer.Create("SquadTimer", 5, 0, function()
				
				
				print("Timer Expired")
				XPTotal = 0
				squadTeamLeaderMember:SetText(leaderName .. ":\n" .. 0 .. "XP")
				for k, v in pairs(memberNames) do
					squadTeamMember:SetText(v[k] .. ":\n" .. 0 .. "XP")
				end
				timer.Remove("SquadTimer")
			end)
		end	
	end
end
function endSquad()
	squadFrame:Close()
end

function leaveSquad()
	squadPanel:Close()
end

net.Receive("Squad_Created", function()
	local leaderName = net.ReadString()
	local teamName = net.ReadString()
	StartSquad(leaderName, teamName)
end)

net.Receive("Squad_Joined", function()
	local username = net.ReadString()
	table.insert(memberNames, username)
	local currentLeaderName = net.ReadString()
	local currentTeamName = net.ReadString()
	StartSquad(currentLeaderName, currentTeamName)
end)

net.Receive("Squad_Left", function()
	local username = net.ReadString()
	table.RemoveByValue(memberNames, username)
end)

net.Receive("Squad_XPUpdate", function()
	XPTotal = XPTotal + net.ReadInt(32)
	if not table.IsEmpty(memberNames) and string.find(table.ToString(memberNames), LocalPlayer():Nick()) then
		print("Yay")
	end
end)

net.Receive("Squad_Disband", function()
	if LocalPlayer():Nick() == net.ReadString() then
		table.Empty(memberNames)
	end
	endSquad()
end)
