AddCSLuaFile() -- Add itself to files to be sent to the clients, as this file is shared

-- Armour items
local ArmourItem = createItemBase(BaseSuitArmour, "Health Enhancer MK1", "Improves your life expectancy", "hlmv/gray")
ArmourItem.Cost = 1000
Register.Armour(ArmourItem)

local ArmourItem = createItemBase(BaseSuitArmour, "Health Enhancer MK2", "Improves your life expectancy", "hlmv/gray")
ArmourItem.Cost = 1500
Register.Armour(ArmourItem)

local ArmourItem = createItemBase(BaseSuitArmour, "Suit Battery Pack", "Better armour capacity", "hl2cr/armour_parts/battery")
ArmourItem.Cost = 1500
Register.Armour(ArmourItem)

local ArmourItem = createItemBase(BaseSuitArmour, "Mark VII Suit", "Better than the last version they had", "hl2cr/armour_parts/suit")
ArmourItem.Cost = 25000
Register.Armour(ArmourItem)

local ArmourItem = createItemBase(BaseSuitArmour, "Mark VII Helmet", "Mind your head", "hl2cr/armour_parts/suit")
ArmourItem.Cost = 17500
Register.Armour(ArmourItem)

-- Weapon items
local WeaponItem = createItemBase(BaseSuitWeapon, "Shotgun Barrel", "A shotgun barrel", "hl2cr/weapon_parts/barrel")
WeaponItem.Cost = 2500
Register.Weapon(WeaponItem)

local WeaponItem = createItemBase(BaseSuitWeapon, "SMG Muzzle", "A Sub-Machine gun Muzzle", "hl2cr/weapon_parts/muzzle")
WeaponItem.Cost = 1250
Register.Weapon(WeaponItem)

local WeaponItem = createItemBase(BaseSuitWeapon, "Crossbow Scope", "A scope attachment", "hl2cr/weapon_parts/scope")
WeaponItem.Cost = 1750
Register.Weapon(WeaponItem)

local WeaponItem = createItemBase(BaseSuitWeapon, "High Explosive Rocket", "A high impact explosive rocket", "hl2cr/weapon_parts/rocket")
WeaponItem.Cost = 10000
Register.Weapon(WeaponItem)