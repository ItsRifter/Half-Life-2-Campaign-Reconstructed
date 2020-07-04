AddCSLuaFile()

net.Receive("Purchase", function(len, ply)
	local itemName = net.ReadString()
	
	if itemName == "Health Module MK1" then
		SubCoins(ply, 1000)
	elseif itemName == "Health Module MK2" then
		SubCoins(ply, 1500)
	elseif itemName == "Suit Battery Pack" then
		SubCoins(ply, 1500)
	elseif itemName == "Mark VII Suit" then
		SubCoins(ply, 25000)
	elseif itemName == "Mark VII Helmet" then
		SubCoins(ply, 17500)
	end
	
	ply.hl2cPersistent.Inventory = ply.hl2cPersistent.Inventory .. " " .. itemName
	ply:SetNWString("Inventory", ply.hl2cPersistent.Inventory .. " " .. itemName)
	

end)

local minRewards = 1
local maxRewards = 2
local neverDiedBonus = false
function giveRewards(ply)
	if not ply.hasDiedOnce then
		neverDiedBonus = true
	else
		neverDiedBonus = false
	end
	
	for i = minRewards, maxRewards do
		randCoins = math.random(1, 25)
		ply.hl2cPersistent.Coins = ply.hl2cPersistent.Coins + randCoins
		
		randXP = math.random(1, 50)
		ply.hl2cPersistent.XP = ply.hl2cPersistent.XP + randXP
	end
	
	net.Start("ShowEndStats")
		net.WriteInt(randCoins, 32)
		net.WriteInt(randXP, 32)
		net.WriteBool(neverDiedBonus)
		net.WriteBool(ply.crowbarOnly)
		net.WriteInt(GetConVar("hl2c_difficulty"):GetInt(), 8)
	net.Send(ply)
end

if CLIENT then
	surface.CreateFont("End_Stats_font", {
		font = "Arial",
		size = 28,
	})
	surface.CreateFont("Rewards_Font", {
		font = "Arial",
		bold = true,
		size = 22,
	})
end


net.Receive("ShowEndStats", function()
	
	local coins = net.ReadInt(32)
	local xp = net.ReadInt(32)
	local boolDeaths = net.ReadBool()
	local boolCrowbar = net.ReadBool()
	local diffBoost = net.ReadInt(8)
	
	local endFrame = vgui.Create("DFrame")
	endFrame:SetSize(800, 600)
	endFrame:MakePopup()
	endFrame:SetTitle("End Map Rewards")
	endFrame:Center()
	endFrame:SetBackgroundBlur(true)
	
	local itemsPanel = vgui.Create("DPanel", endFrame)
	itemsPanel:SetSize(325, 400)
	itemsPanel:SetPos(25, 150)	
	
	local itemsLayout = vgui.Create("DIconLayout", itemsPanel)
	itemsLayout:Dock(FILL)
	itemsLayout:SetSpaceY(5)
	itemsLayout:SetSpaceX(10)

	local xpReward = itemsLayout:Add("SpawnIcon")
	xpReward:SetImage("hl2cr/misc/xp")
	xpReward:SetToolTip(xp .. " XP") 
	
	local coinReward = itemsLayout:Add("SpawnIcon")
	coinReward:SetImage("hl2cr/misc/coins")
	coinReward:SetToolTip("λ" .. coins) 

	itemsText = vgui.Create("DLabel", itemsPanel)
	itemsText:SetText("Crates")
	itemsText:SetFont("End_Stats_font")
	itemsText:SetPos(125, 350)
	itemsText:SetColor(Color(0, 0, 0))
	itemsText:SizeToContents()
	
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
	
	if boolDeaths then
		local rewardsTextNoDeaths = vgui.Create("DLabel", endTextPanel)
		rewardsTextNoDeaths:SetText("NO DEATHS: " .. 50 * diffBoost .. "XP, λ" .. 25 * diffBoost) 
		rewardsTextNoDeaths:SetFont("Rewards_Font")
		rewardsTextNoDeaths:SizeToContents()	
		rewardsTextNoDeaths:SetColor(Color(0, 0, 0))
		rewardsTextNoDeaths:SetPos(100, 65)
	end
	if boolCrowbar then
		local rewardsTextNoDeaths = vgui.Create("DLabel", endTextPanel)
		rewardsTextNoDeaths:SetText("CROWBAR ONLY: " .. 75 * diffBoost .. "XP, λ" .. 45 * diffBoost) 
		rewardsTextNoDeaths:SetFont("Rewards_Font")
		rewardsTextNoDeaths:SizeToContents()	
		rewardsTextNoDeaths:SetColor(Color(0, 0, 0))
		rewardsTextNoDeaths:SetPos(100, 95)
	end
	
end)