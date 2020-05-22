surface.CreateFont("End_Stats_font", {
	font = "Arial",
	size = 28,
})


function showEndStats()
	
	local endFrame = vgui.Create("DFrame")
	endFrame:SetSize(800, 600)
	endFrame:MakePopup()
	endFrame:SetTitle("End Map Rewards")
	endFrame:Center()
	endFrame:SetBackgroundBlur(true)
	
	local cratesPanel = vgui.Create("DPanel", endFrame)
	cratesPanel:SetSize(325, 400)
	cratesPanel:SetPos(25, 150)
	
	local cratesScroll = vgui.Create("DScrollPanel", cratesPanel)
	cratesScroll:Dock(FILL)
	
	local cratesLayout = vgui.Create("DIconLayout", cratesScroll)
	cratesLayout:Dock(FILL)
	cratesLayout:SetSpaceX(5)
	cratesLayout:SetSpaceY(5)
	
	for i = 1, 5 do
		local cratesItem = cratesLayout:Add("SpawnIcon")
		local cratesIcon = cratesItem:Add("DImage")
		
		cratesIcon:SetSize(75, 75)
		
		cratesItem:SetModel("models/Items/item_item_crate.mdl")
		cratesItem:SetSize(75, 75)
		cratesItem:SetToolTip("Unbox me")
		cratesItem.opened = false
		cratesItem.DoClick = function()
			local randomItem = math.random(1, 4)
			surface.PlaySound("physics/wood/wood_box_impact_bullet1.wav")
			if not cratesItem.opened then
				if randomItem == 1 then
					cratesItem:SetModel("")
					cratesItem:SetToolTip("25 XP")
					cratesIcon:SetImage("hl2cr/misc/xp")
				elseif randomItem == 2 then
					cratesItem:SetModel("")
					cratesIcon:SetImage("hl2cr/armour_parts/health")
					cratesItem:SetToolTip("Health Module MK1")
				elseif randomItem == 3 then
					cratesItem:SetModel("")
					cratesIcon:SetImage("hl2cr/armour_parts/battery")
				elseif randomItem == 4 then
					cratesItem:SetModel("")
					cratesIcon:SetImage("hl2cr/armour_parts/suit")
					for k, v in pairs(player.GetAll()) do
						v:ChatPrint(LocalPlayer():Nick() .. " has unboxed a rare item!")
					end
				end
				cratesItem.opened = true
			end
		end
	end
	
	cratesText = vgui.Create("DLabel", cratesPanel)
	cratesText:SetText("Crates")
	cratesText:SetFont("End_Stats_font")
	cratesText:SetPos(125, 350)
	cratesText:SetColor(Color(0, 0, 0))
	cratesText:SizeToContents()
	
	local endTextPanel = vgui.Create("DPanel", endFrame)
	endTextPanel:SetSize(400, 475)
	endTextPanel:SetBackgroundColor(Color(255, 255, 255))
	endTextPanel:SetPos(400, 100)
	
	local rewardsLabel = vgui.Create("DLabel", endTextPanel)
	rewardsLabel:SetText("Rewards")
	rewardsLabel:SetPos(150, 20)
	rewardsLabel:SetColor(Color(0, 0, 0))
	rewardsLabel:SetFont("End_Stats_font")
	rewardsLabel:SizeToContents()
end

net.Receive("TestStart", showEndStats)