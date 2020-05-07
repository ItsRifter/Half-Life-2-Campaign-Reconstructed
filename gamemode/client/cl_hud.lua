local indicators = {}
local indicators2 = {}
local lastcurtime = 0

surface.CreateFont("Indicator_Font", {
	font = "Arial",
	extended = false,
	size = 14,
	weight = 25,
	antialias = true,
})

surface.CreateFont("Map_Font", {
	font = "Arial",
	size = 128,
})

net.Receive("IndicSpawn", function()

	local xpDisplay = net.ReadInt(16)
	local coinsDisplay = net.ReadInt(16)
	local position = net.ReadVector()
	
	local colorCoins = Color(255, 140, 0)
	local colorXP = Color(100, 190, 255)
	
	local txt1 = tostring("XP " .. xpDisplay)
	local txt2 = tostring("λ" .. coinsDisplay)
	
	SpawnCoins(txt1, colorXP, position, 1)
	SpawnXP(txt2, colorCoins, position, 1)
end)

function SpawnXP(xpTxt, col, pos, ttl)
	local ind = {}
	
	ind.xpText = xpTxt
	ind.pos = Vector(pos.x, pos.y, pos.z)
	ind.col = Color(col.r, col.g, col.b)
	
	ind.ttl = ttl
	ind.life = ttl
	ind.spawntime = CurTime()
	
	surface.SetFont("Indicator_Font")
	local w, h = surface.GetTextSize(xpTxt)
	
	ind.widthH = w + math.Rand(5, 10)
	ind.heightH = h * math.Rand(4, 5)
	
	table.insert(indicators, ind)
end

function SpawnCoins(coinTxt, col, pos, ttl)
	local ind2 = {}
	
	ind2.coinText = coinTxt
	ind2.pos = Vector(pos.x, pos.y, pos.z)
	ind2.col = Color(col.r, col.g, col.b)
	
	ind2.ttl = ttl
	ind2.life = ttl
	ind2.spawntime = CurTime()
	
	surface.SetFont("Indicator_Font")
	local w, h = surface.GetTextSize(coinTxt)
	
	ind2.widthH = w - math.Rand(10, 20)
	ind2.heightH = h * math.Rand(4, 5)
	
	table.insert(indicators2, ind2)
end

hook.Add("Tick", "UpdateIndic", function()
	
	local curtime = CurTime()
	local dt = curtime - lastcurtime
	lastcurtime = curtime
	
	if #indicators == 0 then return end
	if #indicators2 == 0 then return end
	
	local ind
	local ind2
	for i=1, #indicators do
		ind = indicators[i]
		ind.life = ind.life - dt
	end
	for i=1, #indicators2 do
		ind2 = indicators2[i]
		ind2.life = ind2.life - dt
	end
	
	local i = 1
	while i <= #indicators do
		if indicators[i].life < 0 then
			table.remove(indicators, i)
		else
			i = i + 1
		end
	end
	
	while i <= #indicators2 do
		if indicators2[i].life < 0 then
			table.remove(indicators2, i)
		else
			i = i + 1
		end
	end
	
end)

hook.Add( "PostDrawTranslucentRenderables", "DrawIndic", function()
	
	if #indicators == 0 then return end
	if #indicators2 == 0 then return end
	
	local observer = (LocalPlayer():GetViewEntity() or LocalPlayer())
	local ang = observer:EyeAngles()
	ang:RotateAroundAxis( ang:Forward(), 90 )
	ang:RotateAroundAxis( ang:Right(), 90 )
	ang = Angle( 0, ang.y, ang.r )
	
	surface.SetFont("Indicator_Font")
	
	local ind
	for i=1, #indicators do
		ind = indicators[i]
		cam.Start3D2D(ind.pos, ang, 1)
			surface.SetTextColor(ind.col.r, ind.col.g, ind.col.b, (ind.life / ind.ttl * 255))
			surface.SetTextPos(-ind.widthH, -ind.heightH)
			surface.DrawText(ind.xpText)
		cam.End3D2D()
	end
	
	for i=1, #indicators2 do
		ind2 = indicators2[i]
		cam.Start3D2D(ind2.pos, ang, 1)
			surface.SetTextColor(ind2.col.r, ind2.col.g, ind2.col.b, (ind2.life / ind2.ttl * 255))
			surface.SetTextPos(-ind2.widthH, -ind2.heightH)
			surface.DrawText(ind2.coinText)
		cam.End3D2D()
	end
	
end)

local hideElements = {
	["CHudHealth"] = true,
	["CHudBattery"] = true,
}

hook.Add("HUDShouldDraw", "DisableHud", function(name)
	if game.GetMap() == "d1_trainstation_01" or game.GetMap() == "d1_trainstation_02"
	or game.GetMap() == "d1_trainstation_03" or game.GetMap() == "d1_trainstation_04" then
		if ( hideElements[ name ] ) then return false end
	elseif game.GetMap() == "d1_trainstation_05" then
		for k, hev in pairs(ents.FindByClass("item_suit")) do
			if hev:IsValid() then
				if ( hideElements[ name ] ) then return false end
			else
				return true
			end
		end
	end
end)

local shouldDrawTimer = false
local shouldDrawRestartTimer = false
net.Receive("DisplayMapTimer", function() shouldDrawTimer = true end)

hook.Add("HUDPaint", "HUDPaint_DrawCPMarker", function()
	if showNav && checkpointPosition && LocalPlayer():Team() == TEAM_ALIVE then
		local checkpointDistance = math.Round(LocalPlayer():GetPos():Distance(checkpointPosition) / 39)
		local checkpointPositionScreen = checkpointPosition:ToScreen()
		
		surface.SetDrawColor(255, 255, 255, 255)
		
		if checkpointPositionScreen.x > 32 && checkpointPositionScreen.x < w - 43 && checkpointPositionScreen.y > 32 && checkpointPositionScreen.y < h - 38 then
			surface.SetTexture(surface.GetTextureID("hl2c_nav_marker"))
			surface.DrawTexturedRect(checkpointPositionScreen.x - 14, checkpointPositionScreen.y - 14, 28, 28)
			draw.DrawText(tostring(checkpointDistance).." m", "Arial", checkpointPositionScreen.x, checkpointPositionScreen.y + 15, Color(255, 220, 0, 255), 1)
		else
			local r = math.Round(centerX / 2)
			local checkpointPositionRad = math.atan2(checkpointPositionScreen.y - centerY, checkpointPositionScreen.x - centerX)
			local checkpointPositionDeg = 0 - math.Round(math.deg(checkpointPositionRad))
			surface.SetTexture(surface.GetTextureID("hl2c_nav_pointer"))
			surface.DrawTexturedRectRotated(math.cos(checkpointPositionRad) * r + centerX, math.sin(checkpointPositionRad) * r + centerY, 32, 32, checkpointPositionDeg + 90)
		end
	end
end)

net.Receive("SurvAllDead", function() shouldDrawRestartTimer = true end)

hook.Add("HUDPaint", "HUDPaint_DrawTimer", function()

	if shouldDrawTimer and not survivalMode then
		if not timer.Exists("MapTimer") then
			timer.Create("MapTimer", 20, 1, function()
			
			end)
			surface.PlaySound("npc/overwatch/radiovoice/allunitsapplyforwardpressure.wav")
		end
			
		surface.SetDrawColor(45, 45, 45, 150)
		if ScrW() == 3840 and ScrH() == 2160 then
			surface.DrawRect(0, ScrH() / 2 + 700, ScrW(), 175)
		else
			surface.DrawRect(0, ScrH() / 2 + 175, ScrW(), 175)
		end
		draw.DrawText("Time Left: " .. math.Round(timer.TimeLeft("MapTimer"), 0), "Map_Font", ScrW() / 2, ScrH() - 350, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	
	if shouldDrawRestartTimer then
		if not timer.Exists("RestartTimer") then
			timer.Create("RestartTimer", 15, 1, function()
			
			end)
			surface.PlaySound("music/hl2_song23_suitsong3.mp3")
		end
			
		surface.SetDrawColor(45, 45, 45, 150)
		if ScrW() == 3840 and ScrH() == 2160 then
			surface.DrawRect(0, ScrH() / 2 + 700, ScrW(), 175)
		else
			surface.DrawRect(0, ScrH() / 2 + 175, ScrW(), 175)
		end
		draw.DrawText("Restarting in " .. math.Round(timer.TimeLeft("RestartTimer"), 0), "Map_Font", ScrW() / 2, ScrH() - 350, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
end)

net.Receive("DisplayRewards", function()
	local xp = net.ReadInt(32)
	local coins = net.ReadInt(32)
	chat.AddText("BONUS FOR NOT DYING ONCE")
	chat.AddText(Color(0, 150, 255), "XP: ", tostring(xp))
	chat.AddText(Color(255, 150, 0), "Coins: λ", tostring(coins))
	
end)

net.Receive("PlaySoundLevelUp", function()
	local levels = net.ReadInt(16)
	if not timer.Exists("EarRapeRemover") then
		surface.PlaySound("hl1/fvox/bell.wav")
		timer.Simple(0.7, function()
			surface.PlaySound("items/battery_pickup.wav")
		end)
	end
	timer.Create("EarRapeRemover", 2, 0, function()
		timer.Remove("EarRapeRemover")
	end)
	chat.AddText(Color(255, 230, 0), "You are now at level ", tostring(levels))
	if levels == 10 then
		chat.AddText(Color(255, 190, 0), "You have unlocked pets, type !pet")
	end
end)

net.Receive("NewSuit", function()
	local level = net.ReadInt(16)

	if level == 5 then
		chat.AddText(Color(255, 230, 0), "You've been hired by the resistance, they grant you ", Color(132, 255, 0), "rebellion suits!")
	elseif level == 15 then
		chat.AddText(Color(255, 230, 0), "Your help to the resistance has granted you ", Color(255, 0, 0), "medic suits!")
	elseif level == 25 then
		chat.AddText(Color(255, 230, 0), "You found a ", Color(0, 106, 255), "Civil Protection Suit", Color(255, 230, 0), ", luckily it's unbonded")
	elseif level == 40 then
		chat.AddText(Color(255, 230, 0), "You found a ", Color(60, 140, 255), "Combine Soldier Suit", Color(255, 230, 0), ", thankfully it won't hurt to put it on")
	elseif level == 60 then
		chat.AddText(Color(255, 230, 0), "You found a ", Color(230, 230, 230), "Combine Elite Solder Suit", Color(255, 230, 0), ", yet again it's unbonded")
	elseif level == 90 then
		chat.AddText(Color(255, 230, 0), "Dr.Kleiner has offered you the ", Color(255, 160, 0), "Mark 5 H.E.V Suit ", Color(255, 230, 0), "for your fantastic support to the resistance!")
	end
end)
local kickAmount = 0
net.Receive("WarningPetKill", function(len, ply)
	kickAmount = kickAmount + net.ReadInt(8)
	if kickAmount >= 3 then
		net.Start("KickUser")
			net.WriteInt(3600, 32)
			net.WriteString("Pet Killing")
		net.SendToServer(ply)
	end
	chat.AddText(Color(255, 0, 0), "DON'T KILL OTHER PLAYERS PETS")
end)

surface.CreateFont("Pet_Font", {
	font = "Arial",
	size = 32,
})

local meta = FindMetaTable( "Entity" )
if not meta then return end

function meta:IsPet()
	if self:IsValid() and self:IsNPC() and self:GetNWBool("PetActive") then
		return true
	else
		return false
	end
end

hook.Add("HUDPaint", "HUDPaint_DrawPetName", function()
	for k, ent in pairs(ents.FindByClass("npc_*")) do
		if ent:IsValid() and ent:IsPet() then
			local dist = LocalPlayer():GetPos():Distance(ent:GetPos())
			local pos = ent:GetPos()
			pos.z = pos.z + 15 + (dist * 0.0325)
			local ScrPos = pos:ToScreen()
			if ent:GetOwner() and LocalPlayer():GetPos():Distance(ent:GetPos()) <= 1000 then
				draw.SimpleText(tostring(ent:GetOwner():Nick()) .. "'s Pet", "Pet_Font", ScrPos.x, ScrPos.y, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
		end
	end
end)

