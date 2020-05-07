local function AddHat(hatTable, model, vector, angle)
	hatTable.Model = hatTable.Model or {}
	if type(hatTable.Model) != "table" then hatTable.Model = {} end
		table.insert(hatTable.Model, {Model = model, Position = vector, Angle = angle})
	return hatTable
end