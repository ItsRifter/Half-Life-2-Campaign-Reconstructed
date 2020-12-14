--Taken from the AUX Suit addon
AddCSLuaFile()

if SERVER then

	local DEFAULT_FLASHLIGHT_RATE = 0.4
	local DEFAULT_DOWNTIME = 0.5
	local DEFAULT_EP2_RATE = 1.23
	local DEFAULT_EP2_RECOVERY_RATE = 0.01
	local ID, LABEL = "flashlight", "FLASHLIGHT"

	function GetFlashlightPower(player)
		return player.flashlight.power
	end

	--[[
	Returns whether the player's flashlight has power
	@param {Player} player
	@return {boolean} has enough power
	]]
	function HasFlashlightPower(player)
		return GetFlashlightPower(player) > 0
	end

	--[[
	Sets an amount of flashlight power to a player
	@param {Player} player
	@param {number} amount
	]]
	function SetFlashlightPower(player, amount)
		player.flashlight.power = amount
	end

	function AddFlashlightPower(player, amount)
		-- Add power
		SetFlashlightPower(player, math.Clamp(GetFlashlightPower(player) + amount, 0, 1))

		-- Check if it ran out of battery
		if (not HasFlashlightPower(player)) then
			player:Flashlight(false)
		end

	-- Send it to the player
		net.Start("ep2_flashlight")
			net.WriteFloat(GetFlashlightPower(player))
		net.Send(player)
	end

	--[[
	Drains a self power supply for the flashlight, turns it off if it
	runs out of battery and regenerates it if off
	@param {Player} player
	]]
	local function EpisodeFlashlight(player)
		RemoveExpense(player, ID)
		if (player.flashlight.tick < CurTime() and not (player:FlashlightIsOn() and GetEP2ExpenseMul() <= 0) and not (not player:FlashlightIsOn() and GetEP2RecoveryMul() <= 0)) then
			if (player:FlashlightIsOn()) then
				AddFlashlightPower(player, -0.01)
				player.flashlight.tick = CurTime() + DEFAULT_EP2_RATE / GetEP2ExpenseMul()
			else
				AddFlashlightPower(player, 0.01)
				player.flashlight.tick = CurTime() + DEFAULT_EP2_RECOVERY_RATE / GetEP2RecoveryMul()
			end
		end
	end

	--[[
	Based on configuration, will either drain the auxiliar power or it's own
	flashlight supply
	]]
	hook.Add("Tick", "_flashlight", function()
		for k, player in pairs(player.GetAll()) do
			if (not player:IsSuitEquipped()) then
				if (player:CanUseFlashlight()) then
					if (player:FlashlightIsOn()) then
						player:Flashlight(false)
					end
				player:AllowFlashlight(false)
				end
				return
				else
				if (not player:CanUseFlashlight()) then
					player:AllowFlashlight(true)
				end
			end
		end
	end)	
end

if CLIENT then
	
	function GetScale()
		return ScrH() / 768
	end

	-- Parameters
	local HORIZONTAL_OFFSET, VERTICAL_OFFSET = 431, 19
	local COLOUR = Color(255, 238, 23)
	local FWIDTH, FHEIGHT = 59, 38
	local LIGHT_IDLE, LIGHT_ACTIVE = "®", "©"
	local ALPHA_ACTIVE, ALPHA_IDLE = 1, 0.18

	-- Variables
	local power = 1
	local colour = 1
	local alpha = ALPHA_IDLE
	local barAlpha = 0

	-- Create scaled font
	surface.CreateFont( "_flashlight", {
		font = "HalfLife2",
		size = math.Round(51 * GetScale()),
		weight = 0,
		additive = true,
		antialias = true
	})

	--[[
	Returns the amount of flashlight battery the client acknowledges the player has
	@return {number} flashlight battery
	]]
	function GetFlashlight()
		return power
	end

	--[[
	Returns the flashlight HUD component colour
	@return {Color} colour
	]]
	local function GetColour()
		return Color(255, 238, 23, 175)
	end

	--[[
	Animates the flashlight HUD component
	@param {number}
	]]
	local function Animate()
		-- Colour
		local col = 1
		if (power < 0.2) then col = 0 end
		colour = Lerp(FrameTime() * 4, colour, col)

		-- Alpha
		local a = ALPHA_IDLE
		if (LocalPlayer():FlashlightIsOn()) then a = ALPHA_ACTIVE end
		alpha = Lerp(FrameTime() * 4, alpha, a)

		a = 0
		if (power < 1) then a = 1 end
		barAlpha = Lerp(FrameTime() * 30, barAlpha, a)
	end

	--[[
	Draws the flashlight icon
	@param {number} x
	@param {number} y
	@param {boolean} is the flashlight active
	@param {Color|nil} colour
	@param {number|nil} alpha
	@param {number|nil} horizontal alignment
	]]
	local function DrawFlashlightIcon(x, y, active, col, a, align)
		col = col or GetColour()
		a = a or alpha
		align = align or TEXT_ALIGN_LEFT
		local icon = LIGHT_IDLE
		if (active) then icon = LIGHT_ACTIVE end
		draw.SimpleText(icon, "_flashlight", x, y, GetColour(), align)
	end

	--[[
	Draws the flashlight panel
	@param {number} x
	@param {number} y
	]]
	
	function DrawBar(x, y, w, h, m, amount, value, col, a, bgA)
		col = col or GetColour();
		a = a or alpha;
		bgA = bgA or 0.4;

		-- Background
		for i=0, amount do
			draw.RoundedBox(0, x + math.Round((w + m) * GetScale()) * i, y, math.Round(w * GetScale()), math.Round(h * GetScale()), Color(col.r * 0.8, col.g * 0.8, col.b * 0.8, col.a * bgA * a));
		end

		-- Foreground
		if (value <= 0) then return; end
		for i=0, math.Round(value * amount) do
			draw.RoundedBox(0, x + math.Round((w + m) * GetScale()) * i, y, math.Round(w * GetScale()), math.Round(h * GetScale()), Color(col.r, col.g, col.b, col.a * a));
		end
	end
	
	function DrawFlashlightHUD(x, y)
		if not LocalPlayer():Alive() then power = 1 return end
		local w, h = math.floor(FWIDTH * GetScale()), math.floor(FHEIGHT * GetScale())
		y = y - h
		Animate()
		draw.RoundedBox(6, x, y, w, h, Color(0, 0, 0, 80))
		DrawBar(x + 7 * GetScale(), y + 29 * GetScale(), 3, 3, 1, 10, power, GetColour(), barAlpha, 0.3)
		DrawFlashlightIcon(x + w * 0.51, y - h * 0.35, LocalPlayer():FlashlightIsOn(), nil, nil, TEXT_ALIGN_CENTER)
	end

	--[[
	Draws the default HUD component
	Calls the "EP2FlashlightHUDPaint" hook to see if it's overriden (in case you want to make your own)
	]]
	
	function GetEP2HUDPos()
		return 412.0000000, 20;
	end
	
	hook.Add("HUDPaint", "_flashlight_hud", function()
		if (LocalPlayer():FlashlightIsOn() and GetConVar("cl_drawhud"):GetInt() > 0 and LocalPlayer():IsSuitEquipped()) then
			local x, y = GetEP2HUDPos()
			DrawFlashlightHUD(math.Round(x * GetScale()), ScrH() - math.Round(y * GetScale()))
		end
	end)

	-- Receive EP2 flashlight power amount
	net.Receive("ep2_flashlight", function(len)
		power = net.ReadFloat()
	end)
end