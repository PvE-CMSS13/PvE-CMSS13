/obj/item/storage/box/spec/B18/outpost
	name = "\improper B18 Future Warrior equipment case"
	desc = "A large case containing non-standard weaponry and the B18 armor platform, designed to minimize battlefield injury. The B18 system is unlikely to leave field testing due to budget cuts even though it is reported to be highly effective. \nDrag this sprite onto yourself to open it up! NOTE: You cannot put items back inside this case."
	kit_overlay = "b18"

/obj/item/storage/box/spec/B18/outpost/fill_preset_inventory()
	. = ..()
	new /obj/item/storage/pouch/machete/full(src)
	new /obj/item/storage/belt/shotgun/full/mou53(src)
	new /obj/item/weapon/gun/shotgun/double/mou53/outpost(src)
	new /obj/item/attachable/angledgrip(src)
	new /obj/item/attachable/stock/mou53(src)

/obj/item/storage/box/spec/plasma
	name = "\improper Experimental Equipment operator case"
	desc = "A large case containing multiple pieces of experimental equipment awaiting field-trials. The XM99A is a more mobile version of the M78 PIG, though it trades some of the energy delivery for that additional mobility. Packaged alongside is the SU-6 \"Smart-Pistol\", utilising jet-assisted munitions to cut back on friendly fire incidents, and a prototype set of \"battlefield awareness\" armor. \nDrag this sprite onto yourself to open it up! NOTE: You cannot put items back inside this case."
	kit_overlay = "amr"

/obj/item/storage/box/spec/plasma/fill_preset_inventory()
	new /obj/item/clothing/suit/marine/medium/rto/md(src)
	new /obj/item/storage/belt/gun/smartpistol/full(src)
	new /obj/item/ammo_box/magazine/su6(src)
	new /obj/item/weapon/gun/XM99(src)
	new /obj/item/attachable/scope/pve(src)
	new /obj/item/ammo_magazine/plasma(src)
	new /obj/item/ammo_magazine/plasma(src)
	new /obj/item/ammo_magazine/plasma(src)
	new /obj/item/ammo_magazine/plasma(src)
	new /obj/item/ammo_magazine/plasma(src)

/obj/item/storage/box/spec/bulwark
	name = "\improper Pointman Breacher case"
	desc = "A large case containing heavy armor, a large ballistic-rated shield, along with a high-capacity sidearm and spare ammo for it. The \"Bulwark\" combat load is a rare sight to see outside of VBSS operations, but is equally as capable of plugging up holes in defensive lines by themselves as they are being the first one through a freshly made breach. \nDrag this sprite onto yourself to open it up! NOTE: You cannot put items back inside this case."
	kit_overlay = "+defense"

/obj/item/storage/box/spec/bulwark/fill_preset_inventory()
	new /obj/item/clothing/suit/marine/heavy/smooth(src)
	new /obj/item/weapon/gun/smg/m39/forecon/outpost(src)
	new /obj/item/ammo_box/magazine/m39/heap(src)
	new /obj/item/storage/belt/marine/m39/heap(src)
	new /obj/item/weapon/shield/riot/ballistic/outpost(src)
	new /obj/item/storage/box/packet/sebb(src)
	new /obj/item/storage/pouch/machete/full(src)
