NEXT_MAP = "d1_eli_02"

INFO_PLAYER_SPAWN = {Vector( 982, 4167, -1371 ), 180}

TRIGGER_CHECKPOINT = {
	{Vector(-174, 2777, -1280), Vector(29, 2818, -1119)},
	{Vector(214, 2040, -1277), Vector(254, 2124, -1171)},
	{Vector(371, 1760, -2736), Vector(533, 1801, -2615)},
	{Vector(154, 2042, -2735), Vector(191, 2211, -2629)},
	{Vector(-574, 2049, -2736), Vector(-536, 2217, -2629)},
	{Vector(-692, 1053, -2688), Vector(-490, 1093, -2527)}	
}

TRIGGER_DELAYMAPLOAD = {Vector(-703, 989, -2688), Vector(-501, 1029, -2527)}

local MAPSCRIPT = {}

function MAPSCRIPT:InitPost()

	for k, v in pairs(ents.FindByName("song_dam")) do
		v:SetKeyValue("message", "music/hl1_song20.mp3")
	end
end

function MAPSCRIPT:PostPlayerSpawn(ply)
	ply:Give("weapon_crowbar")
	ply:Give("weapon_pistol")
	ply:Give("weapon_smg1")
	ply:Give("weapon_frag")
	ply:Give("weapon_357")
end

return MAPSCRIPT