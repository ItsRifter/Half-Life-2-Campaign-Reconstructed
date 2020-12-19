AddCSLuaFile()
--Thanks D3

-- Squad class that contains a list of squads
HL2CR_Squad = HL2CR_Squad or {Squads = {}}

if SERVER then
	-- Create a new squad and add it to the squad list.
	-- This will return nothing if the player is already in a squad.
	function HL2CR_Squad:NewSquad(name, owner)
		local squad = {
			Members = {owner}, -- The first member is the owner
			XP = 0
		}

		-- Check if player is already in a squad
		if self.GetPlayerSquad(ply) then return end

		-- Add to list and use name as key
		self.Squads[name] = squad

		for _, member in ipairs(squad.Members) do
			-- TODO: Add network stuff to send info to all clients that have something to do with this squad (for now that's just the owner)
		end

		-- Add methods to all instances of HL2CR_Squads. No need to care about this, just leave it as it is
		setmetatable(squad, self)
		self.__index = self

		owner:ChatPrint("Squad Created")
		return squad
	end

	-- Searches through all squads and returns the squad the given player is in. Or nil if ply isn't in any squad.
	function HL2CR_Squad:GetPlayerSquad(ply)
		for _, squad in pairs(self.Squads) do
			for _, member in ipairs(squad.Members) do
				if member == ply then
					-- Found
					return squad
				end
			end
		end

		-- Nothing found
		return
	end

	-- Disband squad
	function HL2CR_Squad:Disband(name)
		if self.Members then
			for _, member in ipairs(self.Members) do
				-- TODO: Add network stuff to send info to all clients that have something to do with this squad
			end
		end

		-- Delete from list
		self.Squads[name] = nil
		return
	end

	-- Add member to squad.
	-- If the ply is already member of another squad, this will return false.
	function HL2CR_Squad:AddMember(ply)
		-- Check if player is already in a squad
		if self.GetPlayerSquad(ply) then return false end

		-- Send data to everyone but the new member (Update their member lists)
		for _, member in ipairs(self.Members) do
			-- TODO: Add network stuff to send info to all clients that have something to do with this squad
		end

		-- TODO: Send a special network command to that single member that we just added

		-- Add that member to list
		table.insert(self.Members, ply)

		return true
	end

	-- Remove member
	function HL2CR_Squad:RemoveMember(ply)
		-- Add that member to list
		local removedPly = table.RemoveByValue(self.Members, ply)
		if removedPly then
			-- TODO: Send a special network command to that single member that we just added
			-- removedPly is the removed member

			-- Send data to everyone but the removed member (Update their member lists)
			for _, member in ipairs(self.Members) do
				-- TODO: Add network stuff to send info to all clients that have something to do with this squad
			end
		end

		return
	end

	-- Add XP to squad
	function HL2CR_Squad:AddXP(xp)
		self.XP = self.XP + xp

		for _, member in ipairs(self.Members) do
			-- TODO: Add network stuff to send info to all clients that have something to do with this squad
		end

		return
	end
end

if CLIENT then
	surface.CreateFont("Squad_TeamName", {
	font = "Arial",
	size = 28,
	})
	surface.CreateFont("Squad_TeamMembers", {
		font = "Arial",
		size = 24,
	})

	local XPTotal = 0
	local memberNames = {}

	function StartSquad(plyLeader, newMember)
		
		HL2CRSQUADS = Color(255, 166, 0, 75)
		
		squadFrame = vgui.Create("DFrame")
		squadFrame:SetVisible(true)
		squadFrame:ShowCloseButton(false)
		squadFrame:SetTitle("")
		squadFrame:SetDraggable(true)
		squadFrame:SetSize(650, 250)
		squadFrame:SetPos(ScrW() * 0.73, ScrH() * 0.65)
		squadFrame.Paint = function()
			draw.RoundedBox( 8, 0, 0, 0, 0, Color( 0, 0, 0, 150 ) )
		end

		squadPanel = vgui.Create("DPanel", squadFrame)
		squadPanel:SetBackgroundColor(HL2CRSQUADS)
		squadPanel:Dock(FILL)
		
		squadTeamNameLabel = vgui.Create("DLabel", squadPanel)
		squadTeamNameLabel:SetText(plyLeader:Nick() .. "'s Team")
		squadTeamNameLabel:SetPos(0, 15)
		squadTeamNameLabel:SetFont("Squad_TeamName")
		squadTeamNameLabel:SetTextColor(Color(255, 255, 255))
		squadTeamNameLabel:SizeToContents()
		
		squadTeamLeaderMember = vgui.Create("DLabel", squadPanel)
		squadTeamLeaderMember:SetPos(0, 75)
		squadTeamLeaderMember:SetText(plyLeader:Nick() .. ":\n" .. XPTotal .. "XP")
		squadTeamLeaderMember:SetFont("Squad_TeamMembers")
		squadTeamLeaderMember:SetTextColor(Color(255, 255, 255))
		squadTeamLeaderMember:SizeToContents()
	
		squadTeamMember = vgui.Create("DLabel", squadPanel)
		squadTeamMember:SetText("")
		squadTeamMember:SizeToContents()
		squadTeamLeaderMember:SetText(plyLeader:Nick() .. ":\n" .. XPTotal .. "XP")
		for k, m in pairs(memberNames) do
			local memberText = squadPanel:Add("DLabel")
			memberText:SetPos(25 * k, 75)
			memberText:SetText(m:Nick())
			memberText:SetFont("Squad_TeamMembers")
		end
	end

	function endSquad()
		squadFrame:Close()
		LocalPlayer():ChatPrint("Your squad leader has left")
	end

	net.Receive("Squad_Created", function(len, ply)
		local leader = net.ReadEntity()
		StartSquad(leader)
	end)

	net.Receive("Squad_Joined", function()
		local ply = net.ReadEntity()
		local teamToJoin = net.ReadEntity()
		table.insert(memberNames, ply)
		StartSquad(teamToJoin, ply)
		
	end)

	net.Receive("Squad_NewMember", function()
		local leader = net.ReadEntity()
		local newPly = net.ReadEntity()
		table.insert(memberNames, newPly)
		StartSquad(leader, newPly)
	end)

	net.Receive("Squad_Left", function()
		local leavingPlayer = net.ReadEntity()
		squadFrame:Close()
		table.RemoveByValue(memberNames, leavingPlayer)
	end)

	net.Receive("Squad_XPUpdate", function(len, ply)
		SquadXPTotal = SquadXPTotal + net.ReadInt(32)
		
	end)

	net.Receive("Squad_Disband", function(len, ply)
		endSquad()
	end)

	net.Receive("Squad_Leave_Disband", function(len, ply)
		endSquad()
	end)
end