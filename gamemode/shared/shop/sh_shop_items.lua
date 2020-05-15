AddCSLuaFile() -- Add itself to files to be sent to the clients, as this file is shared

function addShopWeapons(name, cost, mat)
	table.insert(weaponItems, {name, cost, mat})
end

function addShopArmours(name, cost, mat)
	table.insert(armourItems, {name, cost, mat})
end

GM.armourItems = {}
GM.weaponItems = {}

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

addShopArmours("Health Enhancer", 1000, "hlmv/gray")

addShopWeapons("Shotgun Barrel", 500, "hl2cr/weapon_parts/barrel")