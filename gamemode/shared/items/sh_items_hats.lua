AddCSLuaFile() -- Add itself to files to be sent to the clients, as this file is shared

local baby_head = {
	[1] = {
		["children"] = {
			[1] = {
				["children"] = {
					[1] = {
						["children"] = {
						},
						["self"] = {
							["DrawOrder"] = 0,
							["UniqueID"] = "4193986495",
							["OwnerName"] = "self",
							["AimPartName"] = "",
							["Bone"] = "head",
							["Position"] = Vector(1.3733520507813, 0.07421875, 9.3896484375),
							["AimPartUID"] = "",
							["Hide"] = false,
							["Name"] = "",
							["AngleOffset"] = Angle(0, 0, 0),
							["EditorExpand"] = false,
							["EyeAngles"] = false,
							["PositionOffset"] = Vector(0, 0, 0),
							["IsDisturbing"] = false,
							["ClassName"] = "clip",
							["Translucent"] = false,
							["Angles"] = Angle(-65.617866516113, 4.5499247789849e-05, 0.00020061033137608),
						},
					},
				},
				["self"] = {
					["Skin"] = 0,
					["Invert"] = false,
					["LightBlend"] = 1,
					["CellShade"] = 0,
					["OwnerName"] = "self",
					["AimPartName"] = "",
					["IgnoreZ"] = false,
					["AimPartUID"] = "",
					["Passes"] = 1,
					["Name"] = "",
					["NoTextureFiltering"] = false,
					["DoubleFace"] = false,
					["PositionOffset"] = Vector(0, 0, 0),
					["IsDisturbing"] = false,
					["Fullbright"] = false,
					["EyeAngles"] = false,
					["DrawOrder"] = 0,
					["TintColor"] = Vector(0, 0, 0),
					["UniqueID"] = "3225030684",
					["Translucent"] = false,
					["LodOverride"] = -1,
					["BlurSpacing"] = 0,
					["Alpha"] = 1,
					["Material"] = "",
					["UseWeaponColor"] = false,
					["UsePlayerColor"] = false,
					["UseLegacyScale"] = false,
					["Bone"] = "head",
					["Color"] = Vector(255, 255, 255),
					["Brightness"] = 1,
					["BoneMerge"] = false,
					["BlurLength"] = 0,
					["Position"] = Vector(-12.470581054688, -0.9510498046875, -0.0224609375),
					["AngleOffset"] = Angle(0, 0, 0),
					["AlternativeScaling"] = false,
					["Hide"] = false,
					["OwnerEntity"] = false,
					["Scale"] = Vector(1, 1, 1),
					["ClassName"] = "model",
					["EditorExpand"] = true,
					["Size"] = 3.5,
					["ModelFallback"] = "",
					["Angles"] = Angle(1.9431873559952, -83.751914978027, -88.967613220215),
					["TextureFilter"] = 3,
					["Model"] = "models/props_c17/doll01.mdl",
					["BlendMode"] = "",
				},
			},
		},
		["self"] = {
			["DrawOrder"] = 0,
			["UniqueID"] = "905509648",
			["AimPartUID"] = "",
			["Hide"] = false,
			["Duplicate"] = false,
			["ClassName"] = "group",
			["OwnerName"] = "self",
			["IsDisturbing"] = false,
			["Name"] = "my outfit",
			["EditorExpand"] = true,
		},
	},
}

if CLIENT then
	net.Receive("WearHat", function(len, ply)
		local hat = net.ReadString()
		
		if hat == "no_hat" then
			LocalPlayer():ConCommand("pac_clear_parts")
			return
		elseif hat == "baby_head" then
			pac.SetupENT(LocalPlayer())
			LocalPlayer():AttachPACPart(baby_head, LocalPlayer())
		end
	end)
end
