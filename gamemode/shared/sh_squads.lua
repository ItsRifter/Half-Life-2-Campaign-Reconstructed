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
		if self:GetPlayerSquad(owner) then return end

		-- Add to list and use name as key
		self.Squads[name] = squad

		for _, member in ipairs(squad.Members) do
			net.Start("Squad_Created")
				net.WriteEntity(owner)
			net.Send(owner)
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

	-- Returns true if the owner of the squad is the given player, false otherwise.
	function HL2CR_Squad:IsOwner(ply)
		return self.Members[1] == ply
	end

	-- Disband squad
	function HL2CR_Squad:Disband(name, ply)
		if not self:IsOwner(ply) then
			ply:ChatPrint("You aren't leading any squads")
			return
		end
		
		net.Start("Squad_Disband")
		net.Send(ply)
		
		if self.Members then
			for _, member in ipairs(self.Members) do
				member:ChatPrint("Your squad leader has disbanded/left")
				net.Start("Squad_Leave_Disband")
				net.Send(member)
			end
		end

		-- Delete from list
		self.Squads[name] = nil
		ply:ChatPrint("Squad Disbanded")
		return
	end

	-- Add member to squad.
	-- If the ply is already member of another squad, this will return false.
	function HL2CR_Squad:AddMember(ply, leader)
		-- Check if player is already in a squad
		if self:GetPlayerSquad(ply) then return false end
		table.insert(self.Members, ply)
		-- Send data to everyone but the new member (Update their member lists)
		for _, member in ipairs(self.Members) do
			net.Start("Squad_NewMember")
				net.WriteEntity(ply)
			net.Send(member)
			
			if ply != member then
				member:ChatPrint(ply:Nick() .. " has joined your squad")
			end
		end
		
		net.Start("Squad_Joined")
			net.WriteEntity(ply)
			net.WriteEntity(leader)
		net.Send(ply)

		-- TODO: Send a special network command to that single member that we just added

		return true
	end

	-- Prints the state of the squad to the given player.
	function HL2CR_Squad:PrintState(ply)
		for name, squad in pairs(self.Squads) do
			if squad == self then
				ply:ChatPrint(string.format("Squad Leader: %s", name))
				ply:ChatPrint(string.format("XP: %d", self.XP))
				ply:ChatPrint("Members:")
				for i, member in ipairs(self.Members) do
					ply:ChatPrint(string.format("  %d: %s", i, member:Nick()))
				end
				return
			end
		end

		ply:ChatPrint("Squad not found in list! It's probably disbanded, but still referenced somewhere")
		return
	end

	-- Remove member
	function HL2CR_Squad:RemoveMember(ply)
		-- Add that member to list
		local removedPly = table.RemoveByValue(self.Members, ply)
		if removedPly then
			net.Start("Squad_Left")
			net.Send(ply)
			-- Send data to everyone but the removed member (Update their member lists)
			for _, member in ipairs(self.Members) do
				net.Start("Squad_Left_Member")
					net.WriteEntity(ply)
				net.Send(member)
				member:ChatPrint(ply:Nick() .. " has left your squad")
			end
		end
		ply:ChatPrint("You have left the squad")
		return
	end

	-- Add XP to squad
	function HL2CR_Squad:AddXP(xp, leader)
		self.XP = self.XP + xp

		for _, member in ipairs(self.Members) do
			net.Start("Squad_XPUpdate")
				net.WriteInt(self.XP, 16)
			net.Send(leader)
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

	function StartSquad(leader, ply)
		
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
		squadTeamNameLabel:SetText(leader:Nick() .. "'s Team")
		squadTeamNameLabel:SetPos(0, 15)
		squadTeamNameLabel:SetFont("Squad_TeamName")
		squadTeamNameLabel:SetTextColor(Color(255, 255, 255))
		squadTeamNameLabel:SizeToContents()
		
		squadTeamLeaderMember = vgui.Create("DLabel", squadPanel)
		squadTeamLeaderMember:SetPos(0, 75)
		squadTeamLeaderMember:SetText(leader:Nick() .. ":\n" .. XPTotal .. "XP")
		squadTeamLeaderMember:SetFont("Squad_TeamMembers")
		squadTeamLeaderMember:SetTextColor(Color(255, 255, 255))
		squadTeamLeaderMember:SizeToContents()
	
		squadTeamMember = vgui.Create("DLabel", squadPanel)
		squadTeamMember:SetText("")
		squadTeamMember:SizeToContents()
		squadTeamLeaderMember:SetText(leader:Nick() .. ":\n" .. XPTotal .. "XP")
		UpdateSquad(leader, true)
	end

	function UpdateSquad(newMember, joined)
		if joined == true then
			table.insert(memberNames, newMember)
			print("Joined")
			PrintTable(memberNames)
		elseif joined == false then
			table.RemoveByValue(memberNames, newMember)
			memberText:Remove()
			print("Left")
			PrintTable(memberNames)
		end
		for k, m in pairs(memberNames) do
			memberText = vgui.Create("DLabel")
			memberText:SetPos(85 * (k+1), 75)
			memberText:SetText(m:Nick() .. ":\n" .. XPTotal .. "XP")
			memberText:SetFont("Squad_TeamMembers")
			memberText:SizeToContents()
			squadPanel:Add(memberText)
		end
	end

	function endSquad()
		squadFrame:Close()
	end

	net.Receive("Squad_Created", function(len, ply)
		local leader = net.ReadEntity()
		StartSquad(leader)
	end)

	net.Receive("Squad_Joined", function()
		local ply = net.ReadEntity()
		local leader = net.ReadEntity()
		StartSquad(leader, ply)
		
	end)

	net.Receive("Squad_NewMember", function()
		local newMember = net.ReadEntity()
		UpdateSquad(newMember, true)
	end)

	net.Receive("Squad_Left_Member", function(len, ply)
		local leaver = net.ReadEntity()
		UpdateSquad(leaver, false)
	end)
	net.Receive("Squad_Left", function(len, ply)
		endSquad()
	end)

	net.Receive("Squad_XPUpdate", function(len, ply)
		XPTotal = XPTotal + net.ReadInt(16)
		
	end)

	net.Receive("Squad_Disband", function(len, ply)
		endSquad()
	end)

	net.Receive("Squad_Leave_Disband", function(len, ply)
		endSquad()
	end)
end
