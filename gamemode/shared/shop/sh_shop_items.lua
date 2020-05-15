AddCSLuaFile() -- Add itself to files to be sent to the clients, as this file is shared

-- Armour items
local ArmourItem = createItemBase(itemBase, "Health Enhancer MK1", "Improves your life expectancy", "hlmv/gray")
ArmourItem.Cost = 1000
Register.Armour(ArmourItem)

local ArmourItem = createItemBase(itemBase, "Health Enhancer MK2", "Improves your life expectancy", "hlmv/gray")
ArmourItem.Cost = 1000
Register.Armour(ArmourItem)

-- Weapon items
local WeaponItem = createItemBase(itemBase, "Shotgun Barrel", "A shotgun barrel", "hl2cr/weapon_parts/barrel")
WeaponItem.Cost = 1000
Register.Weapon(WeaponItem)

armourList = {
	{name = "Health Enhancer", cost = 1000, mat = "hlmv/gray"},
	{name = "Suit Battery Pack", cost = 2500, mat = "hl2cr/armour_parts/battery"},
	{name = "Mark VII Suit", cost = 25000, mat = "hl2cr/armour_parts/suit"}	
}

weaponList = {
	{name = "Shotgun Barrel", cost = 500, mat = "hl2cr/weapon_parts/barrel"},
	{name = "SMG Muzzle", cost = 250, mat = "hl2cr/weapon_parts/muzzle"},
	{name = "Crossbow Scope", cost = 750, mat = "hl2cr/weapon_parts/scope"},
	{name = "High Explosive Rocket", cost = 5000, mat = "hl2cr/weapon_parts/rocket"}
}