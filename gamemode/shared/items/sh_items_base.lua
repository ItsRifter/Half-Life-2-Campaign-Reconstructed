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
itemBase.Name = "N/A"
itemBase.Desc = "No Description"
itemBase.Icon = ""
itemBase.Cost = 1

BaseSuitArmour = DeriveTable(itemBase)
BaseSuitArmour.ArmourPoints = 0
BaseSuitArmour.HPBoost = 0
BaseSuitArmour.BatteryBoost = 0

BaseTempUpg = DeriveTable(itemBase)
BaseTempUpg.UpgBuffs = {}
BaseTempUpg.EssenceCost = 1