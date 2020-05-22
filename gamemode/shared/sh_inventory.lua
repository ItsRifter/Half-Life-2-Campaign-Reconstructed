AddCSLuaFile()

function storeInventory()
	
end

if CLIENT then

surface.CreateFont("End_Stats_font", {
	font = "Arial",
	size = 28,
})

end


function showEndStats(ply)
	
	local endFrame = vgui.Create("DFrame")
	endFrame:SetSize(800, 600)
	endFrame:MakePopup()
	endFrame:SetTitle("End Map Rewards")
	endFrame:Center()
	endFrame:SetBackgroundBlur(true)
	
	local cratesPanel = vgui.Create("DPanel", endFrame)
	cratesPanel:SetSize(325, 400)
	cratesPanel:SetPos(25, 150)
		
	for i = 1, 4 do
		
		local cratesItem = vgui.Create("SpawnIcon", cratesPanel)
		local cratesIcon = cratesItem:Add("DImage")
		cratesIcon:SetSize(75, 75)
		cratesItem:SetPos(-100, 0)
		if i <= 5 then
			cratesItem:MoveTo(45 * i - 25, 25, 0.75, 1, -1, function() end)
		elseif i >= 6 and i <= 7 then
			cratesItem:MoveTo(45 * i - 255, 125, 0.75, 1, -1, function() end)
		end
		
		
		cratesItem:SetModel("models/Items/item_item_crate.mdl")
		cratesItem:SetSize(75, 75)
		cratesItem:SetToolTip("Unbox me")
		cratesItem.opened = false
		cratesItem.DoClick = function()
			local randomItem = math.random(0, 1)
			if not cratesItem.opened then
				surface.PlaySound("physics/wood/wood_box_impact_bullet1.wav")
				if randomItem == 0 then
					local randCoins = math.random(1, 25)
					cratesItem:SetModel("")
					cratesItem:SetToolTip("λ" .. randCoins)
					cratesIcon:SetImage("hl2cr/misc/coins")
					ply.hl2cPersistent.Coins = ply.hl2cPersistent.Coins + randCoins
				elseif randomItem == 1 then
					local randXP = math.random(1, 50)
					cratesItem:SetModel("")
					cratesItem:SetToolTip(randXP .. "XP")
					cratesIcon:SetImage("hl2cr/misc/xp")
					ply.hl2cPersistent.XP = ply.hl2cPersistent.XP + randXP
				--[[elseif randomItem == 2 then
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
					end--]]
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

net.Receive("TestStart", function(len, ply)
	showEndStats(ply)
end)