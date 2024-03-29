local indicators = {}
local indicators2 = {}
local lastcurtime = 0

net.Receive("SendClientColours", function()
	colours = net.ReadColor()
	colourBool = net.ReadBool()
	font = net.ReadString()
end)

surface.CreateFont("Default", {
	font = "Arial",
	size = 48,
})

surface.CreateFont("Spooky", {
	font = "Coraline's Cat",
	size = 48,
})

surface.CreateFont("Robotic", {
	font = "Robotica",
	size = 48,
})

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

net.Receive("AdminJoin", function()
	local id = net.ReadString()
	if id == "STEAM_0:1:7832469" then
		surface.PlaySound("vo/Citadel/gman_exit01.wav")
	elseif id == "STEAM_0:0:6009886" then
		surface.PlaySound("ambient/levels/outland/ol07_advisorblast04.wav")
	elseif id == "STEAM_0:0:97860967" then
		surface.PlaySound("vo/npc/barney/ba_laugh02.wav")
	end
end)

net.Receive("IndicSpawn", function()

	local xpDisplay = net.ReadInt(16)
	local coinsDisplay = net.ReadInt(16)
	
	local position = net.ReadVector()
	
	local colorCoins = Color(100, 190, 255)
	local colorXP = Color(255, 140, 0)
	
	local txt1 = "XP " .. xpDisplay
	local txt2 = "λ" .. coinsDisplay
	
	SpawnCoins(txt1, colorCoins, position, 1)
	SpawnXP(txt2, colorXP, position, 1)
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
local survivalMode = false
local shouldDrawTimer = false
local shouldDrawRestartTimer = false
local shouldDrawDeathTimer = false
local deathSeconds = 0
net.Receive("DisplayMapTimer", function() 
	if game.GetMap() ~= "d3_breen_01" or game.GetMap() ~= "ep1_c17_06" or game.GetMap() ~= "ep2_outland_12a" or game.GetMap() ~= "d2_lostcoast" then
		chat.AddText(Color(235, 150, 50),	"Enough players have finished, changing map in 20 seconds")
	end
	shouldDrawTimer = true
end)

net.Receive("DisplayDeathTimer", function() 
	shouldDrawDeathTimer = true 
	deathSeconds = net.ReadInt(16)
	survivalMode = net.ReadBool()
end)

net.Receive("SurvAllDead", function() shouldDrawRestartTimer = true end)

net.Receive("FailedMap", function() shouldDrawRestartTimer = true end)
local WINMAPS = {
	["d3_breen_01"] = true,
	["ep1_c17_06"] = true,
	["ep2_outland_12a"] = true,
	["d2_lostcoast"] = true,
}
hook.Add("HUDPaint", "HUDPaint_DrawTimer", function()


	if shouldDrawTimer and not survivalMode and not WINMAPS[game.GetMap()] then
		if not timer.Exists("MapTimerClient") then
			timer.Create("MapTimerClient", 20, 1, function() timer.Remove("MapTimerClient")	end)
			surface.PlaySound("npc/overwatch/radiovoice/allunitsapplyforwardpressure.wav")
		end
			
		surface.SetDrawColor(45, 45, 45, 150)
		if ScrW() == 3840 and ScrH() == 2160 then
			surface.DrawRect(0, ScrH() / 2 + 700, ScrW(), 175)
		else
			surface.DrawRect(0, ScrH() / 2 + 175, ScrW(), 175)
		end
		draw.DrawText("Time Left: " .. math.Round(timer.TimeLeft("MapTimerClient"), 0), "Map_Font", ScrW() / 2, ScrH() - 350, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	
	elseif shouldDrawTimer and WINMAPS[game.GetMap()] then
		if not timer.Exists("MapTimer") then
			timer.Create("MapTimer", 35, 1, function() end)
			surface.PlaySound("hl2cr/ending_triumph.mp3")
		end
			
		surface.SetDrawColor(45, 45, 45, 150)
		if ScrW() == 3840 and ScrH() == 2160 then
			surface.DrawRect(0, ScrH() / 2 + 700, ScrW(), 175)
		else
			surface.DrawRect(0, ScrH() / 2 + 175, ScrW(), 175)
		end
		draw.DrawText("Time Left: " .. math.Round(timer.TimeLeft("MapTimer"), 0), "Map_Font", ScrW() / 2, ScrH() - 350, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	elseif shouldDrawRestartTimer then
		if not timer.Exists("RestartTimer") then
			timer.Create("RestartTimer", 15, 1, function()
				timer.Remove("RestartTimer")
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
	elseif shouldDrawDeathTimer and not LocalPlayer():Alive() then
		if not timer.Exists("DeathTimer") then
			timer.Create("DeathTimer", deathSeconds, 1, function()
				timer.Remove("DeathTimer")
				shouldDrawDeathTimer = false
			end)
		end
		surface.SetDrawColor(45, 45, 45, 150)
		if ScrW() == 3840 and ScrH() == 2160 then
			surface.DrawRect(0, ScrH() / 2 + 700, ScrW(), 175)
		else
			surface.DrawRect(0, ScrH() / 2 + 175, ScrW(), 175)
		end
		draw.DrawText("You will respawn in " .. math.Round(timer.TimeLeft("DeathTimer"), 0) .. " seconds", "Map_Font", ScrW() / 2, ScrH() - 350, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	elseif LocalPlayer():Team() == TEAM_COMPLETED_MAP or survivalMode then
		shouldDrawDeathTimer = false
	end
end)

net.Receive("PlaySoundLevelUp", function()
	local levels = net.ReadInt(32)
	if not timer.Exists("EarRapeRemover") then
		surface.PlaySound("hl1/fvox/bell.wav")
		timer.Simple(0.7, function()
			surface.PlaySound("items/battery_pickup.wav")
		end)
	end
	timer.Create("EarRapeRemover", 2, 1, function()
		timer.Remove("EarRapeRemover")
	end)
	
	chat.AddText(Color(255, 230, 0), "You are now at level ", tostring(levels))
	if levels == 5 then
		chat.AddText(Color(255, 230, 0), "You've been hired by the resistance, they grant you ", Color(132, 255, 0), "rebellion suits!")
	elseif levels == 10 then
	elseif levels == 15 then
		chat.AddText(Color(255, 230, 0), "Your help to the resistance has granted you ", Color(255, 0, 0), "medic suits!")
	elseif levels == 20 then
		chat.AddText(Color(255, 230, 0), "You found a ", Color(0, 106, 255), "Civil Protection Suit", Color(255, 230, 0), ", luckily it's unbonded")
	elseif levels == 35 then
		chat.AddText(Color(255, 230, 0), "You found a ", Color(60, 140, 255), "Combine Grunt Suit", Color(255, 230, 0), ", thankfully it won't hurt to put it on")
	elseif levels == 50 then
		chat.AddText(Color(255, 230, 0), "You found a ", Color(60, 140, 255), "Combine Heavy Grunt Suit", Color(255, 230, 0), ", thankfully it won't hurt to put it on")
	elseif levels == 65 then
		chat.AddText(Color(255, 230, 0), "You found a ", Color(230, 230, 230), "Combine Suppressor Suit", Color(255, 230, 0), ", yet again it's unbonded")	
	elseif levels == 80 then
		chat.AddText(Color(255, 230, 0), "You found a ", Color(230, 230, 230), "Combine Captain Suit", Color(255, 230, 0), ", yet again it's unbonded")
	elseif levels == 100 then
		chat.AddText(Color(255, 230, 0), "Dr.Kleiner has offered you the ", Color(255, 160, 0), "Mark 5 H.E.V Suit ", Color(255, 230, 0), "for your fantastic support to the resistance!")
		
	end
end)

surface.CreateFont("Pet_Font_User", {
	font = "Arial",
	size = 26,
})

surface.CreateFont("Pet_Font_Name", {
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

local FRIENDLY_NPCS = {
	["npc_kleiner"] = true,
	["npc_monk"] = true,
	["npc_alyx"] = true,
	["npc_barney"] = true,
	["npc_breen"] = true,
	["npc_citizen"] = true,
	["npc_vortigaunt"] = true,
	["npc_mossman"] = true,
	["npc_magnusson"] = true
}
function meta:IsFriendly()
	if self:IsValid() and self:IsNPC() and FRIENDLY_NPCS[self:GetClass()] then
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
			if ent:GetOwner():IsValid() and dist <= 1000 then
				draw.SimpleText(ent:GetOwner():Nick() .. "'s Pet", "Pet_Font_User", ScrPos.x, ScrPos.y + 35, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.SimpleText(ent:GetOwner():GetNWString("PetName"), "Pet_Font_Name", ScrPos.x, ScrPos.y, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
		end
	end
end)

hook.Add("HUDPaint", "HUDPaint_DrawNPCHP", function()
	for k, ent in pairs(ents.FindByClass("npc_*")) do
		if ent:IsNPC() and (not ent:IsPet() and not ent:IsFriendly()) and colourBool then
			local dist = LocalPlayer():GetPos():Distance(ent:GetPos())
			local pos = ent:GetPos()
			if string.find(ent:GetClass(), "headcrab") then
				pos.z = ent:GetPos().z + 5 + (dist * 0.0325)
			else
				pos.z = ent:GetPos().z + 45 + (dist * 0.0325)
			end
			local ScrPos = pos:ToScreen()
			if ent:GetOwner() and LocalPlayer():GetPos():Distance(ent:GetPos()) <= 200 then
				draw.SimpleText(ent:GetClass(), font, ScrPos.x, ScrPos.y, Color(colours.r, colours.b, colours.g, colours.a), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.SimpleText("Health: " .. ent:Health(), font, ScrPos.x, ScrPos.y + 50, Color(colours.r, colours.b, colours.g, colours.a), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
		end
	end
end)