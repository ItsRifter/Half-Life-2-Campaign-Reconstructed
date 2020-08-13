AddCSLuaFile() -- Add itself to files to be sent to the clients, as this file is shared

function DeriveTable(DerivedTable)
	local newTable = {}
	for k, v in pairs(DerivedTable) do
		if type(v) ~= "table" then
			newTable[k] = v
		else
			newTable[k] = table.Copy(v)
		end
	end
	return newTable
end

function createItemBase(tableItem, itemName, itemDesc, iconMat)
	local newItem = DeriveTable(tableItem)
	newItem.Name = itemName
	newItem.Desc = itemDesc
	newItem.Icon = iconMat
	return newItem
end

itemBase = {}
itemBase.Name = "default"
itemBase.Desc = "No Description"
itemBase.Icon = "icons/junk_metalcan1"
itemBase.Cost = 1

BaseEquipment = DeriveTable(itemBase)
BaseEquipment.ReqLevel = 1
BaseEquipment.Buffs = {}
BaseEquipment.DeBuffs = {}

BaseSuitArmour = DeriveTable(BaseEquipment)
BaseSuitArmour.Armour = 1

BaseTempUpg = DeriveTable(itemBase)
BaseTempUpg.UpgBuffs = {}
BaseTempUpg.EssenceCost = 1

BaseWeapon = DeriveTable(BaseEquipment)
BaseWeapon.Damage = 2