function ToggleBoard(toggle, clientTimer)
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
		BoardLevelLabel:SetText("Level/Prestige")
		if (ScrW() == 3840 and ScrH() == 2160) then
			BoardLevelLabel:SetPos(Board:GetWide() / 5 - 90, 175)
		else
			BoardLevelLabel:SetPos(Board:GetWide() / 2 - 200, 85)
		end
		BoardLevelLabel:SizeToContents()
		
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
			local playerPrestige = v:GetNWInt("Prestige", 0)
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
					draw.SimpleText(playerLevel .. "/" .. playerPrestige, "Scoreboard_Stats_font", 350, h / 2, Color(40, 255, 25, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
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
					elseif playerTeam == 4 then
						draw.SimpleText("Loyal Combine", "Scoreboard_Stats_font", 555, h / 2, Color(0, 225, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
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
					elseif v:Ping() >= 1 and v:Ping() <= 100 then
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
			
			if v ~= LocalPlayer() and not v:IsBot() then
				local playerRankButton = vgui.Create("DImageButton", Board)
				playerRankButton:SetImage("icon16/user.png")
				playerRankButton:SetPos(0, yPos)
				if (ScrW() == 3840 and ScrH() == 2160) then
					playerRankButton:SetSize(45, 45)
				else
					playerRankButton:SetSize(30, 30)
				end
				playerRankButton.DoClick = function()
					v:ShowProfile()
				end
			end
			
			if v ~= LocalPlayer() and not v:IsBot() then
				local playerMuteButton = vgui.Create("DImageButton", Board)
				if (ScrW() == 3840 and ScrH() == 2160) then
					playerMuteButton:SetPos(1150, yPos)
					playerMuteButton:SetSize(45, 45)
				else
					playerMuteButton:SetPos(965, yPos)
					playerMuteButton:SetSize(30, 30)
				end
				if v:IsMuted() then
					playerMuteButton:SetImage("icon16/sound_mute.png")
				elseif not v:IsMuted() then
					playerMuteButton:SetImage("icon16/sound.png")
				end
				playerMuteButton.DoClick = function()
					if v:IsMuted() then
						playerMuteButton:SetImage("icon16/sound.png")
						v:SetMuted(false)
					elseif not v:IsMuted() then
						playerMuteButton:SetImage("icon16/sound_mute.png")
						v:SetMuted(true)
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
	else
		Board:SetVisible(false)
	end
end

hook.Add( "CreateMove", "PopUpBoard", function()
	if (input.WasMousePressed( MOUSE_RIGHT )) and Board then  
		Board:MakePopup()
		return
	end
end )

hook.Add("ScoreboardShow", "OpenHL2CScoreBoard", function()
	ToggleBoard(true)
	return false
end)


hook.Add("ScoreboardHide", "CloseHL2CScoreBoard", function()
	ToggleBoard(false)
end)