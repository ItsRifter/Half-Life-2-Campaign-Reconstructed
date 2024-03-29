AddCSLuaFile() -- Add itself to files to be sent to the clients, as this file is shared

--Weapon Items - Shop
local wepItem = createItemBase(BaseWeapon, "Medkit", "Become a medic with this kit", "hl2cr/weapons/medkit")
wepItem.Cost = 5000
Register.Weapon(wepItem)

local wepItem = createItemBase(BaseWeapon, "One_Handed_Autogun", "Weaponry at its finest", "hl2cr/weapons/shotgun")
wepItem.Cost = 17500
Register.Weapon(wepItem)

local wepItem = createItemBase(BaseWeapon, "Unbonded_Pulse_Rifle", "There is an AR3?", "hl2cr/weapons/rifle")
wepItem.Cost = 20000
Register.Weapon(wepItem)

local wepItem = createItemBase(BaseWeapon, "Heavy_Shotgun", "Bulky and heavy shotgun", "hl2cr/skills/shells")
wepItem.Cost = 45000
Register.Weapon(wepItem)

local wepItem = createItemBase(BaseWeapon, "Rusty_DB", "How does this hold more than two shells?", "vgui/achievements/hl2_beat_toxictunnel")
wepItem.Cost = 30000
Register.Weapon(wepItem)

local wepItem = createItemBase(BaseWeapon, "BF_HMG", "Quite massive, think you can carry it?", "vgui/achievements/hl2_get_airboatgun")
wepItem.Cost = 100000
Register.Weapon(wepItem)

-- Armour items - Shop
--Upg Items
local upgItem = createItemBase(BaseSuitArmour, "Health_Module_MK1", "Improves your life expectancy", "hl2cr/armour_parts/health")
upgItem.Cost = 1000
upgItem.HPBoost = 5
upgItem.PrestigeReq = 0
Register.Armour(upgItem)

local upgItem = createItemBase(BaseSuitArmour, "Health_Module_MK2", "Improves your life expectancy", "hl2cr/armour_parts/healthmk2")
upgItem.Cost = 2750
upgItem.HPBoost = 10
upgItem.PrestigeReq = 0
Register.Armour(upgItem)

local upgItem = createItemBase(BaseSuitArmour, "Health_Module_MK3", "Improves your life expectancy", "hl2cr/armour_parts/healthmk3")
upgItem.Cost = 6500
upgItem.HPBoost = 15
upgItem.PrestigeReq = 1
Register.Armour(upgItem)

local upgItem = createItemBase(BaseSuitArmour, "Suit_Battery_Pack_MK1", "Start with more suit power", "hl2cr/armour_parts/battery")
upgItem.Cost = 1500
upgItem.BatteryBoost = 5
upgItem.PrestigeReq = 0
Register.Armour(upgItem)

local upgItem = createItemBase(BaseSuitArmour, "Suit_Battery_Pack_MK2", "Start with more suit power", "hl2cr/armour_parts/batterymk2")
upgItem.Cost = 3500
upgItem.BatteryBoost = 10
upgItem.PrestigeReq = 1
Register.Armour(upgItem)

local upgItem = createItemBase(BaseSuitArmour, "Suit_Battery_Pack_MK3", "Start with more suit power", "hl2cr/armour_parts/batterymk3")
upgItem.Cost = 10500
upgItem.BatteryBoost = 20
upgItem.PrestigeReq = 2
Register.Armour(upgItem)

--Helmet Items
local helmItem = createItemBase(BaseSuitArmour, "Steel_Helmet", "Protects your head from bumps", "hl2cr/armour_parts/helmet")
helmItem.Cost = 37500
helmItem.ArmourPoints = 15
helmItem.PrestigeReq = 1
Register.Armour(helmItem)

local helmItem = createItemBase(BaseSuitArmour, "Soldier_Helmet", "A soldiers helmet", "hl2cr/armour_parts/soldierhelm")
helmItem.Cost = 13500
helmItem.ArmourPoints = 10
helmItem.PrestigeReq = 1
Register.Armour(helmItem)

local helmItem = createItemBase(BaseSuitArmour, "HECU_Gasmask", "Old soldier gasmask, at least it works", "hl2cr/armour_parts/hecu")
helmItem.Cost = 7500
helmItem.ArmourPoints = 6
helmItem.PrestigeReq = 0
Register.Armour(helmItem)

--Suit Items
local suitItem = createItemBase(BaseSuitArmour, "Mark_VII_Suit", "Better than the last version they had", "hl2cr/armour_parts/suit")
suitItem.Cost = 50000
suitItem.ArmourPoints = 25
suitItem.PrestigeReq = 2
Register.Armour(suitItem)

local suitItem = createItemBase(BaseSuitArmour, "Metal_Chestplate", "Can it withstand a bullet?", "hl2cr/armour_parts/metalchest")
suitItem.Cost = 22500
suitItem.ArmourPoints = 15
suitItem.PrestigeReq = 1
Register.Armour(suitItem)

local suitItem = createItemBase(BaseSuitArmour, "Leather_Chestplate", "This isn't a fallout...", "hl2cr/armour_parts/leather")
suitItem.Cost = 5000
suitItem.ArmourPoints = 5
suitItem.PrestigeReq = 0
Register.Armour(suitItem)

--Shoulder Items - counts as arm
local shoulderItem = createItemBase(BaseSuitArmour, "Steel_Padding", "Take less damage on the shoulders", "hl2cr/armour_parts/steelpadding")
shoulderItem.Cost = 15000
shoulderItem.ArmourPoints = 10
shoulderItem.PrestigeReq = 1
Register.Armour(shoulderItem)

local shoulderItem = createItemBase(BaseSuitArmour, "Shoulder_Plate", "Can take impacts on the shoulder", "hl2cr/armour_parts/shoulderplate")
shoulderItem.Cost = 8000
shoulderItem.ArmourPoints = 8
shoulderItem.PrestigeReq = 0
Register.Armour(shoulderItem)

local shoulderItem = createItemBase(BaseSuitArmour, "Spiked_Padding", "Spiked shoulders", "hl2cr/armour_parts/spikedpadding")
shoulderItem.Cost = 22500
shoulderItem.ArmourPoints = 14
shoulderItem.PrestigeReq = 1
Register.Armour(shoulderItem)

--Hand Items
local handItem = createItemBase(BaseSuitArmour, "Pair_Gloves", "Warmer hands right?", "hl2cr/armour_parts/gloves")
handItem.Cost = 3500
handItem.ArmourPoints = 2
handItem.PrestigeReq = 0
Register.Armour(handItem)

local handItem = createItemBase(BaseSuitArmour, "Leather_Gloves", "Not comfy but will do", "hl2cr/armour_parts/leathergloves")
handItem.Cost = 4500
handItem.ArmourPoints = 4
handItem.PrestigeReq = 0
Register.Armour(handItem)

local handItem = createItemBase(BaseSuitArmour, "Steel_Gloves", "Harden Gloves", "hl2cr/armour_parts/steelglove")
handItem.Cost = 6000
handItem.ArmourPoints = 5
handItem.PrestigeReq = 1
Register.Armour(handItem)

--Boot Items
local bootItem = createItemBase(BaseSuitArmour, "Steel_Boots", "Harden Boots", "hl2cr/armour_parts/steelboot")
bootItem.Cost = 10500
bootItem.ArmourPoints = 7
bootItem.PrestigeReq = 1
Register.Armour(bootItem)

local bootItem = createItemBase(BaseSuitArmour, "Metal_Boots", "Metallic Boots", "hl2cr/armour_parts/metalboot")
bootItem.Cost = 6500
bootItem.ArmourPoints = 5
bootItem.PrestigeReq = 0
Register.Armour(bootItem)

--Special event items

--local specialItem = createItemBase(BaseSuitArmour, "Witch_Hat", "Happy Halloween!", "hl2cr/armour_parts/witchhat")
--specialItem.Cost = 35000
--Register.Armour(specialItem)

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
local tempUpgItem = createItemBase(BaseTempUpg, "Health_Boost", "Bullets mean nothing to you", "hl2cr/skills/health")
tempUpgItem.EssenceCost = 0
tempUpgItem.Cost = 1500
tempUpgItem.PrestigeReq = 0
Register.TempUpg(tempUpgItem)

local tempUpgItem = createItemBase(BaseTempUpg, "Shotgun_Blaster", "Your shotgun can deal more damage", "hl2cr/skills/shells")
tempUpgItem.EssenceCost = 2
tempUpgItem.Cost = 2500
tempUpgItem.PrestigeReq = 0
Register.TempUpg(tempUpgItem)

local tempUpgItem = createItemBase(BaseTempUpg, "Self_Healing", "Your body manages to self-heal any damage\nafter a certain time", "hl2cr/skills/health")
tempUpgItem.EssenceCost = 5
tempUpgItem.Cost = 0
tempUpgItem.PrestigeReq = 0
Register.TempUpg(tempUpgItem)

local tempUpgItem = createItemBase(BaseTempUpg, "Self_Healing_2", "Your body manages to self-heal any damage\nafter a certain time better", "hl2cr/skills/health")
tempUpgItem.EssenceCost = 10
tempUpgItem.Cost = 0
tempUpgItem.PrestigeReq = 1
Register.TempUpg(tempUpgItem)

local tempUpgItem = createItemBase(BaseTempUpg, "Self_Healing_3", "Your body manages to self-heal any damage\nafter a certain time even better", "hl2cr/skills/health")
tempUpgItem.EssenceCost = 15
tempUpgItem.Cost = 0
tempUpgItem.PrestigeReq = 1
Register.TempUpg(tempUpgItem)

local tempUpgItem = createItemBase(BaseTempUpg, "Blast_Resistance", "Explosions are just a scratch to you", "hl2cr/skills/blast_resist")
tempUpgItem.EssenceCost = 20
tempUpgItem.Cost = 5000
tempUpgItem.PrestigeReq = 1
Register.TempUpg(tempUpgItem)

local permUpgItem = createItemBase(BaseTempUpg, "Vampirism", "Leech enemies health on crowbar kill by chance", "hl2cr/skills/vampire")
permUpgItem.EssenceCost = 10
permUpgItem.Cost = 2000
permUpgItem.CrystalCost = 2
permUpgItem.PrestigeReq = 1
Register.PermUpg(permUpgItem)

local permUpgItem = createItemBase(BaseTempUpg, "Fire_Bullets", "Set your enemies on fire by chance", "hl2cr/skills/firebullets")
permUpgItem.EssenceCost = 15
permUpgItem.Cost = 5000
permUpgItem.CrystalCost = 4
permUpgItem.PrestigeReq = 2
Register.PermUpg(permUpgItem)

local permUpgItem = createItemBase(BaseTempUpg, "Fire_Resist", "Resistance to Fire\nnow it feels cozy", "hl2cr/skills/fireresist")
permUpgItem.EssenceCost = 5
permUpgItem.Cost = 500
permUpgItem.CrystalCost = 1
permUpgItem.PrestigeReq = 0
Register.PermUpg(permUpgItem)

local permUpgItem = createItemBase(BaseTempUpg, "Suit_Power_Boost", "Extra battery life for your suit", "hl2cr/skills/speed")
permUpgItem.EssenceCost = 0
permUpgItem.Cost = 7500
permUpgItem.CrystalCost = 5
permUpgItem.PrestigeReq = 1
Register.PermUpg(permUpgItem)