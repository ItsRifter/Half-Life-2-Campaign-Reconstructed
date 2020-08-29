surface.CreateFont("Scoreboard_Title4K_font", {
	font = "Roboto",
	size = 68,
})

surface.CreateFont("Scoreboard_Title_font", {
	font = "Roboto",
	size = 34,
})


surface.CreateFont("Scoreboard_Board_font", {
	font = "Arial",
	extended = true,
	size = 20,
})

surface.CreateFont("Scoreboard_Stats_font", {
	font = "Arial",
	size = 24,
})

surface.CreateFont("Scoreboard_Stats_4K_XP_font", {
	font = "Arial",
	size = 36,
})

surface.CreateFont("Scoreboard_Stats_XP_font", {
	font = "Arial",
	size = 26,
})

if game.GetMap() != "hl2c_lobby_remake" then
	timer.Create("LobbyReturnAutoClient", 3600, 0, function()
	RunConsoleCommand("changelevel", "hl2c_lobby_remake")
	end)
end


function ToggleBoard(toggle)
	if toggle then
		
		Board = vgui.Create("DFrame")
		Board:SetTitle("")
		Board:SetSize(ScrW() / 2 + 50, ScrH() / 2 + 50)
		Board:SetDraggable(false)
		Board:ShowCloseButton(false)
		Board:SetPos(ScrW() / 2 * .5, ScrH() / 2 * 0.1)
		Board:SetVisible(true)
		Board.Paint = function(self, w, h)
			surface.SetDrawColor(0, 0, 0, 0)
			surface.DrawRect(0,0, w, h)
			draw.RoundedBox(128, 0, 0, w, h, Color(205, 150, 45, 155))
			if (ScrW() == 3840 and ScrH() == 2160) then
				draw.SimpleText("Half-Life 2: Campaign - Revisited", "Scoreboard_Title4K_font", 950, 65, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			else
				draw.SimpleText("Half-Life 2: Campaign - Revisited", "Scoreboard_Title_font", 425, 65, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
		end
		Board:SizeToContents()
		
		local yPos = Board:GetTall() * .18
		
		local BoardNameLabel = vgui.Create("DLabel", Board)
		BoardNameLabel:SetFont("Scoreboard_Board_font")
		BoardNameLabel:SetText("Username")
		BoardNameLabel:SetSize(75, 25)
		if (ScrW() == 3840 and ScrH() == 2160) then
			BoardNameLabel:SetPos(ScrW() / 6 - 525, 175)
		else
			BoardNameLabel:SetPos(ScrW() / 2 - 855, 85)
		end
		
		local BoardTeamLabel = vgui.Create("DLabel", Board)
		BoardTeamLabel:SetFont("Scoreboard_Board_font")
		BoardTeamLabel:SetText("Team")
		if (ScrW() == 3840 and ScrH() == 2160) then
			BoardTeamLabel:SetPos(Board:GetWide() / 5 + 140, 175)
		else
			BoardTeamLabel:SetPos(Board:GetWide() / 2 + 25, 85)
		end
		
		local BoardLevelLabel = vgui.Create("DLabel", Board)
		BoardLevelLabel:SetFont("Scoreboard_Board_font")
		BoardLevelLabel:SetText("Level")
		if (ScrW() == 3840 and ScrH() == 2160) then
			BoardLevelLabel:SetPos(Board:GetWide() / 5 - 60, 175)
		else
			BoardLevelLabel:SetPos(Board:GetWide() / 2 - 170, 85)
		end
		
		local BoardPingLabel = vgui.Create("DLabel", Board)
		BoardPingLabel:SetFont("Scoreboard_Board_font")
		BoardPingLabel:SetText("Ping")
		if (ScrW() == 3840 and ScrH() == 2160) then
			BoardPingLabel:SetPos(Board:GetWide() / 5 + 340, 175)
		else
			BoardPingLabel:SetPos(Board:GetWide() / 2 + 225, 85)
		end
		
		local BoardRankLabel = vgui.Create("DLabel", Board)
		BoardRankLabel:SetFont("Scoreboard_Board_font")
		BoardRankLabel:SetText("Rank")
		if (ScrW() == 3840 and ScrH() == 2160) then
			BoardRankLabel:SetPos(Board:GetWide() / 5 + 540, 175)
		else
			BoardRankLabel:SetPos(Board:GetWide() / 2 + 375, 85)
		end
		
		
		for k, v in pairs( player.GetAll() ) do
			
			local playerName = v:Nick()
			local playerPing = v:Ping()
			local playerLevel = v:GetNWInt("Level", 1)
			local playerXP = LocalPlayer():GetNWInt("XP", 0)
			local playerMaxXP = LocalPlayer():GetNWInt("MaxXP", 500)
			local playerTeam = v:Team()
			local playerRank = v:GetUserGroup()
			
			local playerNamePanel = vgui.Create("DPanel", Board)
			playerNamePanel:SetPos(0, yPos)
			playerNamePanel:SetSize(Board:GetWide() + 50, Board:GetTall() * .05)
			playerNamePanel.Paint = function(self, w, h)
				if IsValid(v) then
					surface.SetDrawColor(0, 0, 0, 200)
					surface.DrawRect(0, 0, w, h)
					draw.SimpleText(playerName, "Scoreboard_Stats_font", 155, h / 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end
			end
			
			local playerStatusPanel = vgui.Create("DPanel", Board)
			playerStatusPanel:SetPos(0, yPos)
			playerStatusPanel:SetSize(Board:GetWide() + 50, Board:GetTall() * .05)
			playerStatusPanel.Paint = function(self, w, h)
				if IsValid(v) then
					draw.SimpleText(playerLevel, "Scoreboard_Stats_font", 350, h / 2, Color(40, 255, 25, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end
			end
			
			local playerTeamPanel = vgui.Create("DPanel", Board)
			playerTeamPanel:SetPos(0, yPos)
			playerTeamPanel:SetSize(Board:GetWide() + 50, Board:GetTall() * .05)
			playerTeamPanel.Paint = function(self, w, h)
				if IsValid(v) then
					if playerTeam == 1 then
						draw.SimpleText("Alive", "Scoreboard_Stats_font", 555, h / 2, Color(40, 255, 25, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					elseif playerTeam == 2 then
						draw.SimpleText("Completed", "Scoreboard_Stats_font", 555, h / 2, Color(255, 255, 40, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					else
						draw.SimpleText("Terminated", "Scoreboard_Stats_font", 555, h / 2, Color(255, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					end
				end
			end
			
			local playerPingPanel = vgui.Create("DPanel", Board)
			playerPingPanel:SetPos(0, yPos)
			playerPingPanel:SetSize(Board:GetWide() + 50, Board:GetTall() * .05)
			playerPingPanel.Paint = function(self, w, h)
				if IsValid(v) then
					if v:IsBot() then
						draw.SimpleText("BOT", "Scoreboard_Stats_font", 750, h / 2, Color(255, 255, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)	
					elseif v:Ping() > 1 and v:Ping() < 100 then
						draw.SimpleText(playerPing, "Scoreboard_Stats_font", 750, h / 2, Color(40, 255, 25, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					elseif v:Ping() > 100 and v:Ping() < 200 then
						draw.SimpleText(playerPing, "Scoreboard_Stats_font", 750, h / 2, Color(255, 255, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					else
						draw.SimpleText(playerPing, "Scoreboard_Stats_font", 750, h / 2, Color(200, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					end
				end
			end
			
			local playerRankPanel = vgui.Create("DPanel", Board)
			playerRankPanel:SetPos(0, yPos)
			playerRankPanel:SetSize(Board:GetWide() + 50, Board:GetTall() * .05)
			playerRankPanel.Paint = function(self, w, h)
				if IsValid(v) then
					if (ScrW() == 3840 and ScrH() == 2160) then
						draw.SimpleText(playerRank, "Scoreboard_Stats_font", 950, h / 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					else
						draw.SimpleText(playerRank, "Scoreboard_Stats_font", Board:GetWide() / 2 + 395, h / 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					end
				end
			end
			
			yPos = yPos + playerStatusPanel:GetTall() * 1.2

			local playerXPLabel = vgui.Create("DLabel", Board)
			playerXPLabel:SetText("XP: " .. playerXP .. " / " .. playerMaxXP)
			playerXPLabel:SetSize(185, 25)
			if IsValid(v) then
				if ScrW() == 3840 and ScrH() == 2160 then
					playerXPLabel:SetPos(Board:GetWide() / 2 - 100, Board:GetTall() / 2 + 490)
					playerXPLabel:SetFont("Scoreboard_Stats_4K_XP_font")
				else
					playerXPLabel:SetPos(Board:GetWide() / 2 - 100, Board:GetTall() / 4 + 390)
					playerXPLabel:SetFont("Scoreboard_Stats_XP_font")
				end
				playerXPLabel:SizeToContents()
			end
		end
		
		local boardTimer
		
		if game.GetMap() != "hl2c_lobby_remake" then
			boardTimer = math.Round(timer.TimeLeft("LobbyReturnAutoClient"), 0)
		elseif game.GetMap() == "hl2c_lobby_remake" then
			boardTimer = "INF"
		end
		
		local timeLeftLabel = vgui.Create("DLabel", Board)
		timeLeftLabel:SetText("Time left: " .. boardTimer)
		if ScrW() == 3840 and ScrH() == 2160 then
			timeLeftLabel:SetPos(Board:GetWide() / 2 - 100, Board:GetTall() / 2 + 430)
			timeLeftLabel:SetFont("Scoreboard_Stats_4K_XP_font")
		else
			timeLeftLabel:SetPos(Board:GetWide() / 2 - 100, Board:GetTall() / 4 + 330)
			timeLeftLabel:SetFont("Scoreboard_Stats_XP_font")
		end
		timeLeftLabel:SizeToContents()
	else
		Board:SetVisible(false)
	end
end

hook.Add("ScoreboardShow", "OpenHL2CScoreBoard", function()
	ToggleBoard(true)
	return false
end)


hook.Add("ScoreboardHide", "CloseHL2CScoreBoard", function()
	ToggleBoard(false)
end)