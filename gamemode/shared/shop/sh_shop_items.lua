AddCSLuaFile() -- Add itself to files to be sent to the clients, as this file is shared

-- Armour items - Shop
local armourItem = createItemBase(BaseSuitArmour, "Health_Module_MK1", "Improves your life expectancy", "hl2cr/armour_parts/health")
armourItem.Cost = 1000
Register.Armour(armourItem)

local armourItem = createItemBase(BaseSuitArmour, "Health_Module_MK2", "Improves your life expectancy", "hl2cr/armour_parts/healthmk2")
armourItem.Cost = 1500
Register.Armour(armourItem)

local armourItem = createItemBase(BaseSuitArmour, "Suit_Battery_Pack", "Start with more suit power", "hl2cr/armour_parts/battery")
armourItem.Cost = 1500
Register.Armour(armourItem)

local armourItem = createItemBase(BaseSuitArmour, "Pair_Gloves", "Warmer hands right?", "hl2cr/armour_parts/gloves")
armourItem.Cost = 3500
Register.Armour(armourItem)

local armourItem = createItemBase(BaseSuitArmour, "Mark_VII_Suit", "Better than the last version they had", "hl2cr/armour_parts/suit")
armourItem.Cost = 25000
Register.Armour(armourItem)

local armourItem = createItemBase(BaseSuitArmour, "Mark_VII_Helmet", "Protects your head from bumps", "hl2cr/armour_parts/helmet")
armourItem.Cost = 17500
Register.Armour(armourItem)

--[[ REMAKE INTO PET ITEMS
-- Pet items - Shop
local weaponItem = createItemBase(BaseWeapon, "Shotgun_Barrel", "A shotgun barrel", "hl2cr/weapon_parts/barrel")
weaponItem.Cost = 2500
Register.Weapon(weaponItem)

local weaponItem = createItemBase(BaseWeapon, "SMG_Muzzle", "A Sub-Machine gun Muzzle", "hl2cr/weapon_parts/muzzle")
weaponItem.Cost = 1250
Register.Weapon(weaponItem)

local weaponItem = createItemBase(BaseWeapon, "Crossbow_Scope", "A scope attachment", "hl2cr/weapon_parts/scope")
weaponItem.Cost = 1750
Register.Weapon(weaponItem)
-]]

--Temporary Upgrades (only lasts until player leaves)
local tempUpgItem = createItemBase(BaseTempUpg, "Health Boost", "Bullets mean nothing to you\n+5HP", "hl2cr/armour_parts/health")
tempUpgItem.EssenceCost = 5
Register.TempUpg(tempUpgItem)

local tempUpgItem = createItemBase(BaseTempUpg, "Self Healing", "Your body manages to self-heal any damage\nafter a certain time", "hl2cr/armour_parts/health")
tempUpgItem.EssenceCost = 10
Register.TempUpg(tempUpgItem)