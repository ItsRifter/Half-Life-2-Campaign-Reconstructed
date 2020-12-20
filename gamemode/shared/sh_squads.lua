AddCSLuaFile()
--Thanks D3

if SERVER then
	-- Squad class that contains a list of squads
	HL2CR_Squad = HL2CR_Squad or {Squads = {}}

	--------------------------------------
	--			Static methods			--
	--------------------------------------

	-- Create a new squad and add it to the squad list.
	-- This will return nothing if the player is already in a squad.
	function HL2CR_Squad:NewSquad(name, owner)
		local squad = {
			Name = name,
			Members = {owner}, -- The first member is the owner
			XP = 0
		}

		-- Add methods to all instances of HL2CR_Squads. No need to care about this, just leave it as it is
		setmetatable(squad, self)
		self.__index = self

		-- Check if player is already in a squad
		if self:GetPlayerSquad(owner) then
			owner:ChatPrint("You are already in a squad")
			return
		end

		-- Add to list and use name as key
		self.Squads[name] = squad

		-- This will be only the owner, duh
		for _, member in ipairs(squad.Members) do
			squad:SendSquadStart(member)
			squad:SendSquadData(member)
		end

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

	--------------------------------------
	--				Methods				--
	--------------------------------------

	-- Returns true if the owner of the squad is the given player, false otherwise.
	function HL2CR_Squad:IsOwner(ply)
		return self.Members[1] == ply
	end

	-- Disband squad.
	function HL2CR_Squad:Disband()
		-- Tell all members that the squad is gone
		if self.Members then
			for _, member in ipairs(self.Members) do
				if self:IsOwner(member) then
					member:ChatPrint("Squad Disbanded")
				else
					member:ChatPrint("Your squad leader has disbanded the squad")
				end
				self:SendSquadEnd(member)
			end
		end

		-- Delete from squads list
		self.Squads[self.Name] = nil

		return true
	end

	-- Add member to squad.
	-- Will return false on fail.
	function HL2CR_Squad:AddMember(ply)
		local plySquad = self:GetPlayerSquad(ply)

		-- Check if player is already in this squad
		if plySquad == squad then
			member:ChatPrint("You are already in this squad")
			return false
		end

		-- Check if player is already in a squad
		if plySquad then
			member:ChatPrint("You are already in another squad")
			return false
		end

		table.insert(self.Members, ply)

		-- Init squad on the new members client side.
		-- The member list will be updated for all members at once.
		self:SendSquadStart(ply)

		-- Send data to everyone but the new member (Update their member lists)
		for _, member in ipairs(self.Members) do
			self:SendSquadData(member)

			if ply ~= member then
				member:ChatPrint(string.format("%s has joined your squad", ply:Nick()))
			end
		end

		return true
	end

	-- Remove member
	function HL2CR_Squad:RemoveMember(ply) -- TODO: Make sure that ply that left the server are removed from any squad
		-- Check if the player is member of this squad
		if self:GetPlayerSquad(ply) ~= self then
			return false
		end

		-- Remove the member from the list
		table.RemoveByValue(self.Members, ply)

		ply:ChatPrint("You have left the squad")

		-- Remove any client side UI and other stuff
		self:SendSquadEnd(ply)

		-- Send data to everyone but the removed member (Update their member lists)
		for _, member in ipairs(self.Members) do
			self:SendSquadData(member)
			member:ChatPrint(string.format("%s has left your squad", ply:Nick()))
		end

		-- If there are no members left, disband the squad
		if #self.Members == 0 then
			self:Disband()
		end

		return true
	end

	-- Add XP to squad
	function HL2CR_Squad:AddXP(addXP)
		self.XP = self.XP + addXP

		for _, member in ipairs(self.Members) do
			self:SendSquadXP(member)
		end

		return
	end

	-- Prints the state of the squad to the given player.
	function HL2CR_Squad:PrintState(ply)
		for name, squad in pairs(self.Squads) do
			if squad == self then
				ply:ChatPrint(string.format("Squad name: %s", name))
				ply:ChatPrint(string.format("XP: %d", self.XP))
				ply:ChatPrint("Members:")
				for i, member in ipairs(self.Members) do
					if i == 1 then
						ply:ChatPrint(string.format("  LEADER: %d: %s", i, member:Nick()))
					else
						ply:ChatPrint(string.format("  %d: %s", i, member:Nick()))
					end
				end
				return
			end
		end

		ply:ChatPrint("Squad not found in list! It's probably disbanded, but still referenced somewhere")

		return
	end

	--------------------------------------
	--			Networking Stuff		--
	--------------------------------------

	-- Start squad handling on the client side.
	-- This will init the UI, but not fill in any data.
	-- Doesn't check if ply is actually member of the suqad.
	function HL2CR_Squad:SendSquadStart(ply)
		net.Start("Squad_Start")
		net.Send(ply)
	end

	-- Send member list and other stuff to a ply/client.
	-- Doesn't check if ply is actually member of the suqad.
	function HL2CR_Squad:SendSquadData(ply)
		net.Start("Squad_Update_Data")
		net.WriteString(self.Name)
		net.WriteInt(self.XP, 24)
		net.WriteUInt(#self.Members, 8)
		for _, member in ipairs(self.Members) do
			net.WriteEntity(member)
		end
		net.Send(ply)
	end

	-- This will send the squad's XP to a client.
	-- Doesn't check if ply is actually member of the suqad.
	function HL2CR_Squad:SendSquadXP(ply)
		net.Start("Squad_Update_XP")
		net.WriteInt(self.XP, 24)
		net.Send(ply)
	end

	-- Stop squad handling on the client side.
	-- This will remove the UI and reset any data on the client.
	-- Doesn't check if ply is actually member of the suqad.
	function HL2CR_Squad:SendSquadEnd(ply)
		net.Start("Squad_End")
		net.Send(ply)
	end
end

if CLIENT then
	surface.CreateFont(
		"Squad_TeamName",
		{
			font = "Arial",
			size = 28
		}
	)
	surface.CreateFont(
		"Squad_TeamMembers",
		{
			font = "Arial",
			size = 24
		}
	)

	-- Represents the squad a client is in.
	HL2CR_ClientSquad =
		HL2CR_ClientSquad or
		{
			BackgroundColor = Color(255, 166, 0, 75)
		}

	-- Setup the UI for the squad and other stuff.
	function HL2CR_ClientSquad:Start()
		self.SquadFrame = vgui.Create("DFrame")
		self.SquadFrame:SetVisible(true)
		self.SquadFrame:ShowCloseButton(false)
		self.SquadFrame:SetTitle("")
		self.SquadFrame:SetDraggable(true)
		self.SquadFrame:SetSize(650, 250)
		self.SquadFrame:SetPos(ScrW() * 0.73, ScrH() * 0.65)
		self.SquadFrame.Paint = function()
			draw.RoundedBox(8, 0, 0, 0, 0, Color(0, 0, 0, 150))
		end

		self.SquadPanel = vgui.Create("DPanel", self.SquadFrame)
		self.SquadPanel:SetBackgroundColor(self.BackgroundColor)
		self.SquadPanel:Dock(FILL)

		self.SquadTeamNameLabel = vgui.Create("DLabel", self.SquadPanel)
		self.SquadTeamNameLabel:SetText("")
		self.SquadTeamNameLabel:SetPos(0, 15)
		self.SquadTeamNameLabel:SetFont("Squad_TeamName")
		self.SquadTeamNameLabel:SetTextColor(Color(255, 255, 255))
		self.SquadTeamNameLabel:SizeToContents()

		self.SquadXPLabel = vgui.Create("DLabel", self.SquadPanel)
		self.SquadXPLabel:SetText("")
		self.SquadXPLabel:SetPos(0, 50)
		self.SquadXPLabel:SetFont("Squad_TeamMembers")
		self.SquadXPLabel:SetTextColor(Color(255, 255, 255))
		self.SquadXPLabel:SizeToContents()
	end

	-- Update the UI with general squad info and the member list.
	-- This will recreate the member list UI completely.
	function HL2CR_ClientSquad:UpdateData(squad)
		self.SquadTeamNameLabel:SetText(squad.Name)

		self:UpdateXP(squad.XP)

		-- Clean and recreate the member entries
		self.SquadPanel:Clear()
		for i, member in ipairs(squad.Members) do
			local memberText = vgui.Create("DLabel")
			memberText:SetPos(i * 85, 75) -- TODO: Use the layouter instead of hardcoding UI positions
			memberText:SetText(member:Nick() .. "\n" .. "more stuff here")
			memberText:SetFont("Squad_TeamMembers")
			memberText:SizeToContents()
			if i == 1 then
				-- Make the leader/owner a different color
				memberText:SetTextColor(Color(255, 255, 255))
			end
			self.SquadPanel:Add(memberText)
		end
	end

	function HL2CR_ClientSquad:UpdateXP(xp)
		self.SquadXPLabel:SetText(string.format("Total XP: %d", xp))
		self.SquadXPLabel:SizeToContents()
	end

	function HL2CR_ClientSquad:End()
		self.SquadFrame:Close()
	end

	net.Receive(
		"Squad_Start",
		function(len)
			HL2CR_ClientSquad:Start()
		end
	)

	net.Receive(
		"Squad_Update_Data",
		function(len)
			local squad = {}
			squad.Name = net.ReadString()
			squad.XP = net.ReadInt(24)
			local memberCount = net.ReadUInt(8)
			squad.Members = {}
			for i = 1, memberCount, 1 do
				squad.Members[i] = net.ReadEntity()
			end
			HL2CR_ClientSquad:UpdateData(squad)
		end
	)

	net.Receive(
		"Squad_Update_XP",
		function(len)
			local newMember = net.ReadEntity()
			HL2CR_ClientSquad:UpdateXP(xp)
		end
	)

	net.Receive(
		"Squad_End",
		function(len)
			HL2CR_ClientSquad:End()
		end
	)
end
