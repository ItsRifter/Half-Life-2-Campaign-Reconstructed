--Themes
HL2CR = {}

HL2CR.ThemeDefault = {
	primary = Color(215, 120, 0, 175),
	background = Color(205, 155, 90),
	userPanel = Color(0, 110, 170),
	buttons = Color(255, 178, 0),
	buttonActive = Color(255, 190, 50),
}

COLOUR_Pet_MODEL_PANEL = Color(100, 100, 100, 75)
COLOUR_Pet_MAIN_PANEL = Color(100, 100, 100)
COLOUR_Pet_EVOL_PANEL = Color(0, 0, 0)

local F4_FRAME = {}

function F4_FRAME:Init()
	self.f4 = self:Add("DPanel")
	self.f4:Dock(TOP)
	self.f4.Paint = function(self, w, h)
		draw.RoundedBoxEx(6, 0, 0, w, h, HL2CR.ThemeDefault.primary, true, true, false, false)
	end
	
	self.f4.closeBtn = self.f4:Add("DButton")
	self.f4.closeBtn:Dock(RIGHT)
	self.f4.closeBtn:SetText("Close")
	self.f4.closeBtn.Paint = function(self, w, h)
		surface.SetDrawColor(HL2CR.ThemeDefault.buttons)
		surface.DrawRect(0, 0, w, h)
	end
	
	self.f4.closeBtn.DoClick = function(pnl)
		self:Remove()
	end
end

function F4_FRAME:PerformLayout(w, h)
	self.f4:SetTall(48)
end

function F4_FRAME:Paint(w, h)
	draw.RoundedBox(12, 0, 0, w, h, HL2CR.ThemeDefault.background)
end

function F4_FRAME:Close()
	self:Remove()
end

vgui.Register("HL2CR.f4Frame", F4_FRAME)

local F4_BTN = {}

function F4_BTN:Init()
	self.f4buttons = {}
end

function F4_BTN:AddTab(name, panel)
	local i = table.Count(self.f4buttons) + 1
	self.f4buttons[i] = self:Add("DButton")
	
	self.f4buttons[i].Paint = function(self, w, h) return end
	
	local btn = self.f4buttons[i]
	btn:Dock(LEFT)
	btn.id = i
	btn:DockMargin(0, 2, 0, 0)
	btn:SetText(name)
	btn:SetFont("F4_Buttons_font")
	btn:SizeToContents()
	btn.paint = function(self, w, h)
		if self.active == btn.id then
			surface.SetDrawColor(Color(192, 57, 43))
			surface.DrawRect(0, h - 2, w, 2)
		end
	end
	
	btn.DoClick = function(pnl)
		self:SetActive(btn.id)
	end
end

function F4_BTN:GetActiveName()
	for i, btn in pairs(self.f4buttons) do
		if !btn:GetDisabled() then
			return btn:GetText()
		end
	end
end

function F4_BTN:SetActiveName(name)
	for i, btn in pairs(self.f4buttons) do
		if btn:GetText() == name then
			self:SetActive(btn.id)
		end
	end
end

function F4_BTN:SetActive(id)
	local btn = self.f4buttons[id]
	if (!IsValid(btn)) then return end
	
	local activeBtn = self.f4buttons[self.active]
	if (IsValid(activeBtn)) then
		activeBtn:SetTextColor(buttonActive)
	end
	
	self.active = id
	
	btn:SetTextColor(HL2CR.ThemeDefault.buttons)
end

vgui.Register("HL2CR.f4Btn", F4_BTN)

local PET_FRAME = {}

function PET_FRAME:Init()
	self.Pet = self:Add("DPanel")
	self.Pet:Dock(TOP)
	self.Pet.Paint = function(self, w, h)
		draw.RoundedBoxEx(6, 0, 0, w, h, HL2CR.ThemeDefault.primary, true, true, false, false)
	end
	
	self.Pet.closeBtn = self.Pet:Add("DButton")
	self.Pet.closeBtn:Dock(RIGHT)
	self.Pet.closeBtn:SetText("Close")
	self.Pet.closeBtn.Paint = function(self, w, h)
		surface.SetDrawColor(HL2CR.ThemeDefault.buttons)
		surface.DrawRect(0, 0, w, h)
	end
	
	self.Pet.closeBtn.DoClick = function(pnl)
		self:Remove()
		music:Stop()
	end
end

function PET_FRAME:PerformLayout(w, h)
	self.Pet:SetTall(48)
end

function PET_FRAME:Paint(w, h)
	draw.RoundedBox(12, 0, 0, w, h, HL2CR.ThemeDefault.background)
end

function PET_FRAME:Close()
	self:Remove()
end

vgui.Register("HL2CR.petFrame", PET_FRAME)

local PET_BTN = {}

function PET_BTN:Init()
	self.buttons = {}
end

function PET_BTN:AddTab(name, panel)
	local i = table.Count(self.buttons) + 1
	self.buttons[i] = self:Add("DButton")
	
	self.buttons[i].Paint = function(self, w, h) return end
	
	local btn = self.buttons[i]
	btn:Dock(LEFT)
	btn.id = i
	btn:DockMargin(0, 2, 0, 0)
	btn:SetText(name)
	btn:SetFont("Pet_Evol_Font")
	btn:SizeToContents()
	btn.paint = function(self, w, h)
		if self.active == btn.id then
			surface.SetDrawColor(Color(192, 57, 43))
			surface.DrawRect(0, h - 2, w, 2)
		end
	end
	
	btn.DoClick = function(pnl)
		self:SetActive(btn.id)
	end
end

function PET_BTN:GetActiveName()
	for i, btn in pairs(self.buttons) do
		if !btn:GetDisabled() then
			return btn:GetText()
		end
	end
end

function PET_BTN:SetActiveName(name)
	for i, btn in pairs(self.buttons) do
		if btn:GetText() == name then
			self:SetActive(btn.id)
		end
	end
end

function PET_BTN:SetActive(id)
	local btn = self.buttons[id]
	if (!IsValid(btn)) then return end
	
	local activeBtn = self.buttons[self.active]
	if (IsValid(activeBtn)) then
		activeBtn:SetTextColor(buttonActive)
	end
	
	self.active = id
	
	btn:SetTextColor(HL2CR.ThemeDefault.buttons)
end

vgui.Register("HL2CR.petBtn", PET_BTN)