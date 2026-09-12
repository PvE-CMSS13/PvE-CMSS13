/obj/item/hardpoint/support/smoke_launcher
	name = "\improper M-39P Smoke Discharger"
	desc = "A support module for ATVs that shoots M60 incendiary smoke grenades to deter hitchhikers."
	icon = 'icons/obj/vehicles/hardpoints/apc.dmi'

	icon_state = "slauncher"
	disp_icon = "apc"
	disp_icon_state = "slauncher"
	activation_sounds = list('sound/weapons/gun_m92_attachable.ogg')

	activatable = TRUE

	health = 1500
	firing_arc = 120

	allowed_seat = VEHICLE_DRIVER

	ammo = new /obj/item/ammo_magazine/hardpoint/turret_smoke/incen
	max_clips = 3

	use_muzzle_flash = FALSE

	fire_delay = 1.0 SECONDS

/obj/item/hardpoint/support/smoke_launcher/set_bullet_traits()
	..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_iff)
	))

/obj/item/hardpoint/support/smoke_launcher/aev
	name = "\improper M-39Q Smoke Discharger"
	desc = "A support module for AEVs that shoots M60 incendiary smoke grenades to deter hitchhikers."
	icon = 'icons/obj/vehicles/hardpoints/tank.dmi'

	icon_state = "slauncher_0"
	disp_icon = "tank"

	firing_arc = 150
	ammo = new /obj/item/ammo_magazine/hardpoint/turret_smoke/incen/aev
	max_clips = 5

	scatter = 3
	gun_firemode = GUN_FIREMODE_BURSTFIRE
	gun_firemode_list = list(
		GUN_FIREMODE_BURSTFIRE,
	)
	burst_amount = 2
	burst_delay = 1.0 SECONDS

/obj/item/hardpoint/support/smoke_launcher/aev/try_fire(atom/target, mob/living/user, params)
	var/turf/L
	var/turf/R
	switch(owner.dir)
		if(NORTH)
			L = locate(owner.x - 2, owner.y + 4, owner.z)
			R = locate(owner.x + 2, owner.y + 4, owner.z)
		if(SOUTH)
			L = locate(owner.x + 2, owner.y - 4, owner.z)
			R = locate(owner.x - 2, owner.y - 4, owner.z)
		if(EAST)
			L = locate(owner.x + 4, owner.y + 2, owner.z)
			R = locate(owner.x + 4, owner.y - 2, owner.z)
		else
			L = locate(owner.x - 4, owner.y + 2, owner.z)
			R = locate(owner.x - 4, owner.y - 2, owner.z)

	if(shots_fired)
		target = R
	else
		target = L

	return ..()


/obj/item/hardpoint/support/smoke_launcher/twe_tank
	name = "\improper L-39T Smoke Discharger"
	desc = "A support module for the FV150, based off those used by the UA for their vehicles."
	icon = 'icons/obj/vehicles/hardpoints/twe_tank.dmi'

	icon_state = "slauncher_0"
	disp_icon = "tank"

	firing_arc = 150
	ammo = new /obj/item/ammo_magazine/hardpoint/turret_smoke/twe
	max_clips = 5

	scatter = 3
	gun_firemode = GUN_FIREMODE_BURSTFIRE
	gun_firemode_list = list(
		GUN_FIREMODE_BURSTFIRE,
	)
	burst_amount = 2
	burst_delay = 1.0 SECONDS
