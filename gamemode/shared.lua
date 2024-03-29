AddCSLuaFile() -- Add itself to files to be sent to the clients

-- All of these included files call AddCSLuaFile on their own

GM.Name = "Half-Life 2 Campaign - Revisited"
GM.Author = "SuperSponer"
GM.Email = "d_thomas_smith30@hotmail.com"
GM.Website = "N/A"

resource.AddFile("resource/fonts/Coraline's Cat.ttf")
resource.AddFile("resource/fonts/Robotica.ttf")

function GM:Initialize()
	self.BaseClass.Initialize(self)
end

function addCitizenModels(model)
	table.insert(GM.citizens, {model})
end

function addRebelModels(model)
	table.insert(GM.rebels, {model})
end

function addMedicModels(model)
	table.insert(GM.medics, {model})
end

function addCPModels(model)
	table.insert(GM.police, {model})
end

function addSoldierModels(model)
	table.insert(GM.soldier, {model})
end

function addHeavSoldierModels(model)
	table.insert(GM.heavySoldier, {model})
end

function addEliteModels(model)
	table.insert(GM.eliteSoldier, {model})
end

function addCaptainModels(model)
	table.insert(GM.captainSoldier, {model})
end

function addHevModels(model)
	table.insert(GM.hev, {model})
end

function addRareHevModels(model)
	table.insert(GM.rareHev, {model})
end

function addAdminModels(model)
	table.insert(GM.admin, {model})
end

function addDonatorCitizenModels(model)
	table.insert(GM.donateCitizen, {model})
end

function addDonatorFighterModels(model)
	table.insert(GM.donateFighter, {model})
end

function addHalloweenModels(model)
	table.insert(GM.halloweenModel, {model})
end

GM.citizens = {}
GM.rebels = {}
GM.medics = {}
GM.police = {}
GM.soldier = {}
GM.heavySoldier = {}
GM.eliteSoldier = {}
GM.captainSoldier = {}
GM.hev = {}
GM.rareHev = {}
GM.admin = {}
GM.donateCitizen = {}
GM.donateFighter = {}
GM.halloweenModel = {}

addCitizenModels("models/player/Group01/female_01.mdl")
addCitizenModels("models/player/Group01/female_02.mdl")
addCitizenModels("models/player/Group01/female_03.mdl")
addCitizenModels("models/player/Group01/female_04.mdl")
addCitizenModels("models/player/Group01/female_05.mdl")
addCitizenModels("models/player/Group01/female_06.mdl")
addCitizenModels("models/player/Group01/male_01.mdl") 
addCitizenModels("models/player/Group01/male_02.mdl") 
addCitizenModels("models/player/Group01/male_03.mdl") 
addCitizenModels("models/player/Group01/male_04.mdl") 
addCitizenModels("models/player/Group01/male_05.mdl") 
addCitizenModels("models/player/Group01/male_06.mdl") 
addCitizenModels("models/player/Group01/male_07.mdl") 
addCitizenModels("models/player/Group01/male_08.mdl") 
addCitizenModels("models/player/Group01/male_09.mdl") 

addRebelModels("models/player/Group03/female_01.mdl")
addRebelModels("models/player/Group03/female_02.mdl")
addRebelModels("models/player/Group03/female_03.mdl")
addRebelModels("models/player/Group03/female_04.mdl")
addRebelModels("models/player/Group03/female_05.mdl")
addRebelModels("models/player/Group03/female_06.mdl")
addRebelModels("models/player/Group03/male_01.mdl")
addRebelModels("models/player/Group03/male_02.mdl")
addRebelModels("models/player/Group03/male_03.mdl")
addRebelModels("models/player/Group03/male_04.mdl")
addRebelModels("models/player/Group03/male_05.mdl")
addRebelModels("models/player/Group03/male_06.mdl")
addRebelModels("models/player/Group03/male_07.mdl")
addRebelModels("models/player/Group03/male_08.mdl")
addRebelModels("models/player/Group03/male_09.mdl")


addMedicModels("models/player/Group03m/female_01.mdl")
addMedicModels("models/player/Group03m/female_02.mdl")
addMedicModels("models/player/Group03m/female_03.mdl")
addMedicModels("models/player/Group03m/female_04.mdl")
addMedicModels("models/player/Group03m/female_05.mdl")
addMedicModels("models/player/Group03m/female_06.mdl")
addMedicModels("models/player/Group03m/male_01.mdl" )
addMedicModels("models/player/Group03m/male_02.mdl" )
addMedicModels("models/player/Group03m/male_03.mdl" )
addMedicModels("models/player/Group03m/male_04.mdl" )
addMedicModels("models/player/Group03m/male_05.mdl" )
addMedicModels("models/player/Group03m/male_06.mdl" )

addCPModels("models/player/police.mdl")
addCPModels("models/player/police_fem.mdl")

addSoldierModels("models/hlvr/characters/combine/grunt/combine_grunt_hlvr_player.mdl")

addHeavSoldierModels("models/hlvr/characters/combine/heavy/combine_heavy_hlvr_player.mdl")

addEliteModels("models/hlvr/characters/combine/suppressor/combine_suppressor_hlvr_player.mdl")

addCaptainModels("models/hlvr/characters/combine_captain/combine_captain_hlvr_player.mdl")

addHevModels("models/player/SGG/hev_helmet.mdl")

addRareHevModels("models/inaki/characters/gordon_freeman.mdl")

addAdminModels("models/humans/hev_mark2.mdl")

addDonatorCitizenModels("models/hlvr/characters/russell/russell_player.mdl")

addDonatorFighterModels("models/hlvr/characters/larry/larry_player.mdl")

addHalloweenModels("models/hlvr/human/corpse/zombie/zombie_common_2_player.mdl")

Register = {}
GM.ArmourItem = {}
GM.WeaponItem = {}
GM.PetItem = {}
GM.TempUpgItem = {}
GM.PermUpgItem = {}

function Register.Armour(armourItem) 
	GM.ArmourItem[armourItem.Name] = armourItem
end

function Register.Weapon(weaponItem) 
	GM.WeaponItem[weaponItem.Name] = weaponItem
end

function Register.Pet(petItem) 
	GM.PetItem[petItem.Name] = petItem
end

function Register.TempUpg(tempUpgItem) 
	GM.TempUpgItem[tempUpgItem.Name] = tempUpgItem
end

function Register.PermUpg(permUpgItem) 
	GM.PermUpgItem[permUpgItem.Name] = permUpgItem
end

include("shared/sh_player.lua")
include("shared/sh_npc.lua")
include("shared/items/sh_items_base.lua")
include("shared/shop/sh_shop_items.lua")
include("shared/items/sh_items_hats.lua")
include("shared/sh_inventory.lua")
include("shared/sh_squads.lua")