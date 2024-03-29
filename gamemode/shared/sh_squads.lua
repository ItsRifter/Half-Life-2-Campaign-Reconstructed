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
		end

		owner.hl2cPersistent.SquadLeader = true
		owner:ChatPrint("Squad Created")
		return squad
	end

	--Resume Squad
	function HL2CR_Squad:ResumeSquad(name, owner)
		self:NewSquad(name, owner)
		return
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
					member.hl2cPersistent.SquadLeader = false
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
		if plySquad == self then
			ply:ChatPrint("You are already in this squad")
			return false
		end

		-- Check if player is already in a squad
		if plySquad then
			ply:ChatPrint("You are already in another squad")
			return false
		end

		table.insert(self.Members, ply)
		table.Inherit(ply.hl2cPersistent.SquadMembers, self.Members)
		-- Send data to everyone but the new member (Update their member lists)
		for _, member in ipairs(self.Members) do
			self:SendSquadStart(member)

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
		table.RemoveByValue(ply.hl2cPersistent.SquadMembers, ply)
		ply:ChatPrint("You have left the squad")

		-- Remove any client side UI and other stuff
		self:SendSquadEnd(ply)

		-- Send data to everyone but the removed member (Update their member lists)
		for _, member in ipairs(self.Members) do
			self:SendSquadStart(member)
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
		self:StartTimer()
		return
	end
	
	function HL2CR_Squad:GiveXP()
		self.XP = math.Round(self.XP / table.Count(self.Members))
		for _, member in ipairs(self.Members) do
			AddXP(member, self.XP)
			member:ChatPrint("You gained " .. self.XP .. "XP as a share")
			self.XP = 0	
			self:SendSquadXP(member)
		end
		
		return
	end
	
	-- Start Squad timer 
	function HL2CR_Squad:StartTimer()
		if not timer.Exists("Squad_XPTimer") then
			timer.Create("Squad_XPTimer", 60, 1, function() 
				self:GiveXP()
			end)
			
		end
	
		
		
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

	-- This will init the UI and send member list and other stuff to a ply/client.
	-- Doesn't check if ply is actually member of the suqad.
	function HL2CR_Squad:SendSquadStart(ply)
		net.Start("Squad_Start")
		net.WriteString(self.Name)
		net.WriteInt(self.XP, 24)
		net.WriteUInt(#self.Members, 8)
		for _, member in ipairs(self.Members) do
			net.WriteEntity(member)
		end
		net.Send(ply)
	end

	-- This will send the squad's XP to a client.
	-- Doesn't check if ply is actually member of the squad.
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
	-- This will open and or redo the window content.
	function HL2CR_ClientSquad:StartOrUpdate(squad)
		
		-- Delete anything that was here before
		self:End()

		-- Frame
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

		-- Panel
		self.SquadPanel = vgui.Create("DPanel", self.SquadFrame)
		self.SquadPanel:SetBackgroundColor(self.BackgroundColor)
		self.SquadPanel:Dock(FILL)

		self.squadGrid = vgui.Create("DGrid", self.SquadPanel)
		self.squadGrid:SetColWide(160)
		self.squadGrid:SetRowHeight(self.SquadPanel:GetTall())
		self.squadGrid:SetPos(0, 75)
		-- Squad name
		self.SquadTeamNameLabel = vgui.Create("DLabel", self.SquadPanel)
		self.SquadTeamNameLabel:SetText(squad.Name)
		self.SquadTeamNameLabel:SetPos(0, 15)
		self.SquadTeamNameLabel:SetFont("Squad_TeamName")
		self.SquadTeamNameLabel:SetTextColor(Color(255, 255, 255))
		self.SquadTeamNameLabel:SizeToContents()

		-- XP text
		self.SquadXPLabel = vgui.Create("DLabel", self.SquadPanel)
		self.SquadXPLabel:SetPos(0, 50)
		self.SquadXPLabel:SetFont("Squad_TeamMembers")
		self.SquadXPLabel:SetTextColor(Color(255, 255, 255))
		self.SquadXPLabel:SizeToContents()
		self:UpdateXP(squad.XP)

		-- Member entries
		for i, member in ipairs(squad.Members) do
			local memberText = vgui.Create("DLabel")
			memberText:SetPos((i-1) * 85, 75) -- TODO: Use the layouter instead of hardcoding UI positions
			memberText:SetText(member:Nick() .. "\n" .. "more stuff here")
			memberText:SetFont("Squad_TeamMembers")
			memberText:SizeToContents()
			if i == 1 then
				-- Make the leader/owner a different color
				memberText:SetTextColor(Color(255, 255, 255))
			end
			self.SquadPanel:Add(memberText)
			self.squadGrid:AddItem(memberText)
		end
	end

	function HL2CR_ClientSquad:UpdateXP(XP)
		self.SquadXPLabel:SetText(string.format("Total XP: %d", XP))
		self.SquadXPLabel:SizeToContents()
	end

	function HL2CR_ClientSquad:End()
		if self.SquadFrame and IsValid(self.SquadFrame) then
			self.SquadFrame:Close()
		end
	end

	net.Receive(
		"Squad_Start",
		function(len)
			local squad = {}
			squad.Name = net.ReadString()
			squad.XP = net.ReadInt(24)
			local memberCount = net.ReadUInt(8)
			squad.Members = {}
			for i = 1, memberCount, 1 do
				squad.Members[i] = net.ReadEntity()
			end
			HL2CR_ClientSquad:StartOrUpdate(squad)
		end
	)

	net.Receive(
		"Squad_Update_XP",
		function(len)
			local XP = net.ReadInt(24)
			HL2CR_ClientSquad:UpdateXP(XP)
		end
	)

	net.Receive(
		"Squad_End",
		function(len)
			HL2CR_ClientSquad:End()
		end
	)
end
