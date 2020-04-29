surface.CreateFont("Intro_Tab1_Title_Font", {
	font = "Arial",
	size = 36,
})

surface.CreateFont("Intro_Tab1_Font", {
	font = "Arial",
	size = 28,
})

function LobbyMenu()

	--The Frame

	local frame = vgui.Create("DFrame")
	frame:SetSize(900, 1000)
	frame:Center()
	frame:SetVisible(true)
	frame:SetDraggable(false)
	frame:ShowCloseButton(true)
	frame:SetTitle("")
	frame.Paint = function(s, w, h)
		draw.RoundedBox(0,0,0, w, h, Color(140, 140, 140, 255))
	end
	frame:MakePopup()
	
	--Property Sheet
	local TabSheet = vgui.Create( "DPropertySheet", frame )
	TabSheet:Dock( FILL ) 

	--First Tab Section
	
	local PanelTabOne = vgui.Create( "DPanel", frame )
	PanelTabOne:SetSize(800, 850)
	PanelTabOne:SetPos(0, 400)
	PanelTabOne.Paint = function(s, w, h)
		draw.RoundedBox(0,0,0, w, h, Color(170, 170, 170, 255))
	end
	
	local LabelTitle = vgui.Create( "DLabel", PanelTabOne )
	LabelTitle:SetPos(125, 100)
	LabelTitle:SetFont("Intro_Tab1_Title_Font")
	LabelTitle:SizeToContents()
	LabelTitle:SetText("Welcome to Half-Life 2: Campaign - Revisited")
	LabelTitle:SizeToContents()
	LabelTitle:SetDark( 1 )
	
	LabelDescText = vgui.Create( "DLabel", PanelTabOne )
	LabelDescText:SetPos(125, 175)
	LabelDescText:SetFont("Intro_Tab1_Font")
	LabelDescText:SetText("Test")
	
	
	TabSheet:AddSheet("Intro", PanelTabOne, nil)
	
	--Second Tab Section
	
	local PanelTabTwo = vgui.Create( "DPanel", frame )
	PanelTabTwo:SetSize(800, 850)
	PanelTabTwo:SetPos(0, 400)
	PanelTabTwo.Paint = function(s, w, h)
		draw.RoundedBox(0,0,0, w, h, Color(170, 170, 170, 255))
	end
	
	local LabelTabTwo = vgui.Create( "DLabel", PanelTabTwo )
	LabelTabTwo:SetPos(150, 200)
	LabelTabTwo:SetText("Half-Life 2: Campaign - Revisited is a cooperative gamemode based from Leiftigers gamemode but with modern updates")
	LabelTabTwo:SizeToContents()
	LabelTabTwo:SetDark( 1 )
	
	TabSheet:AddSheet("What is this?", PanelTabTwo, nil)
	
	--Third Tab Section
	
	local PanelTabThree = vgui.Create( "DPanel", frame )
	PanelTabThree:SetSize(800, 850)
	PanelTabThree:SetPos(0, 400)
	PanelTabThree.Paint = function(s, w, h)
		draw.RoundedBox(0,0,0, w, h, Color(170, 170, 170, 255))
	end
	
	local startButton = vgui.Create("DButton", PanelTabThree)
	startButton:SetSize(200, 75)
	startButton:SetPos(350, 850)
	startButton:SetText("Begin")
	startButton.DoClick = function() 
		
		net.Start("Achievement")
			net.WriteString("First_Time")
			net.WriteString("Lobby_Ach_List")
		net.SendToServer()
		frame:Close()
	end
	
	TabSheet:AddSheet("Begin Playing", PanelTabThree, nil)
end

net.Receive("Greetings_new_player", LobbyMenu)