/obj/item/ammo_magazine/hardpoint/turret_smoke
	name = "Turret Smoke Screen Magazine"
	desc = "A smoke grenades magazine used by tank turret."
	caliber = "grenade"
	icon_state = "slauncher_1"
	w_class = SIZE_LARGE
	default_ammo = /datum/ammo/grenade_container/smoke
	max_rounds = 10
	gun_type = /obj/item/hardpoint/holder/tank_turret

/obj/item/ammo_magazine/hardpoint/turret_smoke/update_icon()
	icon_state = "slauncher_[current_rounds <= 0 ? "0" : "1"]"

/obj/item/ammo_magazine/hardpoint/turret_smoke/uppapc
	name = "UPP Turret Smoke Screen Magazine"
	desc = "A smoke grenades magazine used by upp apc turret."
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/upp.dmi'
	icon_state = "upp_slauncher_1"
	default_ammo = /datum/ammo/grenade_container/smoke/upp
	gun_type = /obj/item/hardpoint/holder/apc_turret

/obj/item/ammo_magazine/hardpoint/turret_smoke/incen
	name = "Smoke Discharger Magazine"
	desc = "A magazine of modified M60 incendiary smoke grenades used by the ATVs discharger array."
	default_ammo = /datum/ammo/grenade_container/incen
	max_rounds = 8

/obj/item/ammo_magazine/hardpoint/turret_smoke/incen/aev
	desc = "A magazine of modified M60 incendiary smoke grenades used by the AEVs discharger array."
	max_rounds = 12

/obj/item/ammo_magazine/hardpoint/turret_smoke/twe
	max_rounds = 6
