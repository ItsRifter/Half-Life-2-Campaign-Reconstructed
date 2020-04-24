surface.CreateFont("Scoreboard_Title_font", {
	font = "Roboto",
	size = "18",
	weight = "36",
})

surface.CreateFont("Scoreboard_Name_font", {
	font = "Arial",
	size = "12",
	weight = "42",
})

surface.CreateFont("Scoreboard_Ping_font", {
	font = "Arial",
	size = "12",
	weight = "48",
})

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
			surface.SetDrawColor(205, 150, 45, 175)
			surface.DrawRect(0,0, w, h)
			draw.SimpleText("Half-Life 2: Campaign - Revisited", "Scoreboard_Title_font", 0, 15, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
		end
		
		local yPos = Board:GetTall() * .12
		
		local BoardNameLabel = vgui.Create("DLabel", Board)
		BoardNameLabel:SetText("Username")
		if (ScrW() == 3840 and ScrH() == 2160) then
			BoardNameLabel:SetPos(ScrW() / 6 - 510, 100)
		else
			BoardNameLabel:SetPos(ScrW() / 2 - 835, 50)
		end
		
		local BoardPingLabel = vgui.Create("DLabel", Board)
		BoardPingLabel:SetText("Ping")
		if (ScrW() == 3840 and ScrH() == 2160) then
			BoardPingLabel:SetPos(Board:GetWide() / 5 - 55, 100)
		else
			BoardPingLabel:SetPos(Board:GetWide() / 2 - 165, 50)
		end
		
		for k, v in pairs( player.GetAll() ) do
			
			local playerName = v:Nick()
			local playerPing = v:Ping()
			
			local playerNamePanel = vgui.Create("DPanel", Board)
			playerNamePanel:SetPos(0, yPos)
			playerNamePanel:SetSize(Board:GetWide() + 50, Board:GetTall() * .05)
			playerNamePanel.Paint = function(self, w, h)
				if IsValid(v) then
					surface.SetDrawColor(0, 0, 0, 200)
					surface.DrawRect(0, 0, w, h)
					draw.SimpleText(playerName, "Scoreboard_Name_font", 150, h / 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end
			end
			
			local playerPingPanel = vgui.Create("DPanel", Board)
			playerPingPanel:SetPos(0, yPos)
			playerPingPanel:SetSize(Board:GetWide() + 50, Board:GetTall() * .05)
			playerPingPanel.Paint = function(self, w, h)
				if IsValid(v) then
					if v:Ping() < 100 then
						draw.SimpleText(playerPing, "Scoreboard_Ping_font", 350, h / 2, Color(40, 255, 25, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					else if v:Ping() > 100 and v:Ping() < 200 then
						draw.SimpleText(playerPing, "Scoreboard_Ping_font", 350, h / 2, Color(255, 255, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					else
						draw.SimpleText(playerPing, "Scoreboard_Ping_font", 350, h / 2, Color(200, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					end
				end
			end
		end
			yPos = yPos + playerNamePanel:GetTall() * 1.2
		end
		
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