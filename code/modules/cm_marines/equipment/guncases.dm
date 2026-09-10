/obj/item/storage/box/guncase
	name = "\improper gun case"
	desc = "It has space for firearm(s). Sometimes magazines or other munitions as well."
	icon = 'icons/obj/items/storage/kits.dmi'
	icon_state = "guncase"
	w_class = SIZE_HUGE
	max_w_class = SIZE_HUGE //shouldn't be a problem since we can only store the guns and ammo.
	storage_slots = 1
	slowdown = 1
	can_hold = list()//define on a per case basis for the original firearm.
	foldable = TRUE
	foldable = /obj/item/stack/sheet/mineral/plastic//it makes sense
	ground_offset_y = 5

/obj/item/storage/box/guncase/update_icon()
	if(LAZYLEN(contents))
		icon_state = initial(icon_state)
	else
		icon_state = "[initial(icon_state)]_e"

/obj/item/storage/box/guncase/Initialize()
	. = ..()
	update_icon()

//------------
/obj/item/storage/box/guncase/vp78
	name = "\improper VP78 pistol case"
	desc = "A gun case containing a VP78. Comes with two magazines."
	can_hold = list(/obj/item/weapon/gun/pistol/vp78, /obj/item/ammo_magazine/pistol/vp78)
	storage_slots = 3

/obj/item/storage/box/guncase/vp78/fill_preset_inventory()
	new /obj/item/weapon/gun/pistol/vp78(src)
	new /obj/item/ammo_magazine/pistol/vp78(src)
	new /obj/item/ammo_magazine/pistol/vp78(src)

//------------
/obj/item/storage/box/guncase/smartpistol
	name = "\improper SU-6 pistol case"
	desc = "A gun case containing a SU-6 smart pistol. Comes with a full belt holster."
	can_hold = list(/obj/item/storage/belt/gun/smartpistol, /obj/item/weapon/gun/pistol/smart, /obj/item/ammo_magazine/pistol/smart)
	storage_slots = 2

/obj/item/storage/box/guncase/smartpistol/fill_preset_inventory()
	new /obj/item/storage/belt/gun/smartpistol/full_nogun(src)
	new /obj/item/weapon/gun/pistol/smart(src)

//------------
/obj/item/storage/box/guncase/mou53
	name = "\improper MOU53 shotgun case"
	desc = "A gun case containing a MOU53 shotgun. It does come loaded, but you'll still have to find ammunition as you go."
	storage_slots = 2
	can_hold = list(/obj/item/weapon/gun/shotgun/double/mou53, /obj/item/attachable/stock/mou53)

/obj/item/storage/box/guncase/mou53/fill_preset_inventory()
	new /obj/item/weapon/gun/shotgun/double/mou53(src)
	new /obj/item/attachable/stock/mou53(src)

//------------
/obj/item/storage/box/guncase/lmg
	name = "\improper M41AE2 heavy pulse rifle case"
	desc = "A plastic hard weapon case containing the M41AE2 Heavy Pulse Rifle and three magazines."
	storage_slots = 4
	can_hold = list(/obj/item/weapon/gun/rifle/lmg, /obj/item/ammo_magazine/hpr_box)

/obj/item/storage/box/guncase/lmg/fill_preset_inventory()
	new /obj/item/weapon/gun/rifle/lmg(src)
	new /obj/item/ammo_magazine/hpr_box(src)
	new /obj/item/ammo_magazine/hpr_box(src)
	new /obj/item/ammo_magazine/hpr_box(src)

//------------
/obj/item/storage/box/guncase/m41aMK1
	name = "\improper M41A pulse rifle MK1 case"
	desc = "A gun case containing a loaded M41A pulse rifle MK1 and two additional magazines."
	storage_slots = 3
	can_hold = list(/obj/item/weapon/gun/rifle/m41aMK1, /obj/item/ammo_magazine/rifle/m41aMK1)

/obj/item/storage/box/guncase/m41aMK1/fill_preset_inventory()
	new /obj/item/weapon/gun/rifle/m41aMK1(src)
	new /obj/item/ammo_magazine/rifle/m41aMK1(src)
	new /obj/item/ammo_magazine/rifle/m41aMK1(src)


/obj/item/storage/box/guncase/m41aMK1AP
	name = "\improper M41A pulse rifle MK1 AP case"
	desc = "A gun case containing a M41A pulse rifle MK1 loaded with AP rounds and two additional magazines."
	storage_slots = 3
	can_hold = list(/obj/item/weapon/gun/rifle/m41aMK1, /obj/item/ammo_magazine/rifle/m41aMK1)

/obj/item/storage/box/guncase/m41aMK1AP/fill_preset_inventory()
	new /obj/item/weapon/gun/rifle/m41aMK1/ap(src)
	new /obj/item/ammo_magazine/rifle/m41aMK1/ap(src)
	new /obj/item/ammo_magazine/rifle/m41aMK1/ap(src)

//------------
//M79 grenade launcher
/obj/item/storage/box/guncase/m79
	name = "\improper M79 grenade launcher case"
	desc = "A gun case containing a modernized M79 grenade launcher. Comes with 3 baton slugs, 3 hornet shells and 3 star shell grenades."
	storage_slots = 4
	can_hold = list(/obj/item/weapon/gun/launcher/grenade/m81/m79, /obj/item/storage/box/packet)

/obj/item/storage/box/guncase/m79/fill_preset_inventory()
	new /obj/item/weapon/gun/launcher/grenade/m81/m79(src)

/obj/item/storage/box/guncase/heavy/m92_upp
	name = "\improper OG-60 grenade launcher case"
	desc = "A case for storing an OG-60 grenade launcher."
	icon_state = "m92uppcase"
	storage_slots = 2
	can_hold = list(/obj/item/weapon/gun/launcher/grenade/m92/upp, /obj/item/storage/pouch/explosive, /obj/item/storage/box/packet/high_explosive/upp)
	max_w_class = SIZE_HUGE

/obj/item/storage/box/guncase/heavy/m92_upp/fill_preset_inventory()
	new /obj/item/weapon/gun/launcher/grenade/m92/upp/stored(src)
	new /obj/item/storage/pouch/explosive(src)

/obj/item/storage/box/guncase/heavy/m92_upp/update_icon()
	overlays.Cut()
	if(opened)
		overlays += image(icon, "uppbigcase_lid_open")
	else
		overlays += image(icon, "m92uppcase_lid")
		return
	if(locate(/obj/item/weapon/gun/launcher/grenade/m92/upp) in contents)
		overlays += image(icon, "+m92_upp")
	var/obj/item/storage/pouch/explosive/nade_pouch = locate(/obj/item/storage/pouch/explosive) in contents
	if(nade_pouch)
		if(!nade_pouch.contents.len)
			overlays += image(icon, "+nade_pouch")
		else
			overlays += image(icon, "+nade_pouch_full")

/obj/item/storage/box/guncase/heavy/m92_upp/preloaded
	storage_slots = 5

/obj/item/storage/box/guncase/heavy/m92_upp/preloaded/fill_preset_inventory()
	new /obj/item/weapon/gun/launcher/grenade/m92/upp/stored(src)
	new /obj/item/storage/pouch/explosive/upp/impact(src)
	new /obj/item/storage/box/packet/high_explosive/upp/impact(src)
	new /obj/item/storage/box/packet/high_explosive/upp/ap(src)
	new /obj/item/storage/box/packet/high_explosive/upp/incend(src)
//------------
//R4T lever action rifle
/obj/item/storage/box/guncase/r4t_scout
	name = "\improper R4T lever action rifle case"
	desc = "A gun case containing a R4T lever action rifle, intended for scouting. Comes with an ammunition belt, the optional revolver attachment for it, two boxes of ammunition, a sling, and a stock for the rifle."
	storage_slots = 7
	can_hold = list(/obj/item/weapon/gun/lever_action/r4t, /obj/item/attachable/stock/r4t, /obj/item/attachable/magnetic_harness/lever_sling, /obj/item/ammo_magazine/lever_action, /obj/item/ammo_magazine/lever_action/training, /obj/item/storage/belt/shotgun/lever_action, /obj/item/storage/belt/gun/m44/lever_action/attach_holster, /obj/item/device/motiondetector/m717)

/obj/item/storage/box/guncase/r4t_scout/fill_preset_inventory()
	new /obj/item/weapon/gun/lever_action/r4t(src)
	new /obj/item/attachable/stock/r4t(src)
	new /obj/item/attachable/magnetic_harness/lever_sling(src)
	new /obj/item/ammo_magazine/lever_action(src)
	new /obj/item/ammo_magazine/lever_action(src)
	new /obj/item/storage/belt/shotgun/lever_action(src)
	new /obj/item/storage/belt/gun/m44/lever_action/attach_holster(src)

/obj/item/storage/box/guncase/xm88
	name = "\improper XM88 heavy rifle case"
	desc = "A gun case containing a XM88 Heavy Rifle, a prototype weapon designed for use against heavily armored infantry targets and light vehicles. Contains an ammunition belt, two boxes of ammunition, the XS-9 Targeting Relay attachment, and the stock for the rifle."
	storage_slots = 6
	can_hold = list(/obj/item/weapon/gun/lever_action/xm88, /obj/item/attachable/stock/xm88, /obj/item/attachable/scope/mini/xm88, /obj/item/ammo_magazine/lever_action/xm88, /obj/item/storage/belt/shotgun/xm88)

/obj/item/storage/box/guncase/xm88/fill_preset_inventory()
	new /obj/item/weapon/gun/lever_action/xm88(src)
	new /obj/item/attachable/stock/xm88(src)
	new /obj/item/attachable/scope/mini/xm88(src)
	new /obj/item/ammo_magazine/lever_action/xm88(src)
	new /obj/item/ammo_magazine/lever_action/xm88(src)
	new /obj/item/storage/belt/shotgun/xm88(src)

//------------
/obj/item/storage/box/guncase/flamer
	name = "\improper M240A1 incinerator case"
	desc = "A gun case containing a M240A1 incinerator unit. It does come loaded, but you'll still have to find extra tanks as you go."
	storage_slots = 4
	can_hold = list(/obj/item/weapon/gun/flamer, /obj/item/ammo_magazine/flamer_tank, /obj/item/attachable/attached_gun/extinguisher)

/obj/item/storage/box/guncase/flamer/fill_preset_inventory()
	new /obj/item/weapon/gun/flamer(src)
	new /obj/item/ammo_magazine/flamer_tank(src)
	new /obj/item/ammo_magazine/flamer_tank(src)
	new /obj/item/attachable/attached_gun/extinguisher(src)

/obj/item/storage/box/guncase/flamer/special
	storage_slots = 3

/obj/item/storage/box/guncase/flamer/special/fill_preset_inventory()
	new /obj/item/weapon/gun/flamer(src)
	new /obj/item/ammo_magazine/flamer_tank(src)
	new /obj/item/attachable/attached_gun/extinguisher/pyro(src)

/obj/item/storage/box/guncase/flamer/weak
	desc = "A gun case containing a M240A1 incinerator unit alongside impure napalm, cheap but should still get the job done."
	storage_slots = 4

/obj/item/storage/box/guncase/flamer/weak/fill_preset_inventory()
	new /obj/item/weapon/gun/flamer/weak(src)
	new /obj/item/ammo_magazine/flamer_tank/weak(src)
	new /obj/item/ammo_magazine/flamer_tank/weak(src)

/obj/item/storage/box/guncase/m42c
	name = "\improper M42C scoped rifle case"
	desc = "A gun case containing an M42C Scoped Rifle and several magazines."
	storage_slots = 7

/obj/item/storage/box/guncase/m42c/fill_preset_inventory()
	new /obj/item/weapon/gun/rifle/sniper/elite(src)
	new /obj/item/ammo_magazine/sniper/elite/basic(src)
	new /obj/item/ammo_magazine/sniper/elite/basic(src)
	new /obj/item/ammo_magazine/sniper/elite/basic(src)
	new /obj/item/ammo_magazine/sniper/elite/basic(src)
	new /obj/item/ammo_magazine/sniper/elite/basic(src)
	new /obj/item/ammo_magazine/sniper/elite/basic(src)

/obj/item/storage/box/guncase/m42c/heap

/obj/item/storage/box/guncase/m42c/heap/fill_preset_inventory()
	new /obj/item/weapon/gun/rifle/sniper/elite/heap(src)
	new /obj/item/ammo_magazine/sniper/elite(src)
	new /obj/item/ammo_magazine/sniper/elite(src)
	new /obj/item/ammo_magazine/sniper/elite(src)
	new /obj/item/ammo_magazine/sniper/elite(src)
	new /obj/item/ammo_magazine/sniper/elite(src)
	new /obj/item/ammo_magazine/sniper/elite(src)

//------------ heavy cases

/obj/item/storage/box/guncase/heavy
	name = "heavy gun case"
	desc = "You shouldn't be seeing this."
	icon_state = null
	use_sound = "toolbox"
	var/move_delay_mult = 2

/obj/item/storage/box/guncase/heavy/pickup(mob/user, silent)
	. = ..()
	RegisterSignal(user, COMSIG_HUMAN_POST_MOVE_DELAY, PROC_REF(handle_movedelay))

/obj/item/storage/box/guncase/heavy/proc/handle_movedelay(mob/user, list/movedata)
	SIGNAL_HANDLER
	if(locate(/obj/item/storage/box/guncase/heavy) in user.contents)
		movedata["move_delay"] += move_delay_mult

/obj/item/storage/box/guncase/heavy/dropped(mob/user, silent)
	. = ..()
	UnregisterSignal(user, COMSIG_HUMAN_POST_MOVE_DELAY)

/obj/item/storage/box/guncase/heavy/sentry
	name = "\improper UA 571-C sentry gun case"
	desc = "A gun case containing the UA 571-C sentry unit, a spare drum, and a sentry laptop."
	icon_state = "sentrycase"
	storage_slots = 3
	can_hold = list(/obj/item/defenses/handheld/sentry, /obj/item/ammo_magazine/sentry, /obj/item/device/sentry_computer)

/obj/item/storage/box/guncase/heavy/sentry/fill_preset_inventory()
	new /obj/item/defenses/handheld/sentry(src)
	new /obj/item/ammo_magazine/sentry(src)
	new /obj/item/device/sentry_computer(src)

/obj/item/storage/box/guncase/heavy/sentry/update_icon()
	overlays.Cut()
	if(opened)
		overlays += image(icon, "case_lid_open")
	else
		overlays += image(icon, "sentrycase_lid")
		return
	if(locate(/obj/item/defenses/handheld/sentry) in contents)
		overlays += image(icon, "+sentry")
	if(locate(/obj/item/ammo_magazine/sentry) in contents)
		overlays += image(icon, "+sentrymag")
	if(locate(/obj/item/device/sentry_computer) in contents)
		overlays += image(icon, "+sentrycomp")

/obj/item/storage/box/guncase/heavy/sentry/pmc_platoon
	name = "\improper UA 571-C-WY sentry guncase"
	desc = "A gun case containing the UA 571-C-WY sentry gun, a spare drum, and a sentry laptop."
	icon_state = "sentrycase"
	storage_slots = 3
	can_hold = list(/obj/item/defenses/handheld/sentry/pmc_platoon, /obj/item/ammo_magazine/sentry, /obj/item/device/sentry_computer)

/obj/item/storage/box/guncase/heavy/sentry/pmc_platoon/fill_preset_inventory()
	new /obj/item/defenses/handheld/sentry/pmc_platoon(src)
	new /obj/item/ammo_magazine/sentry(src)
	new /obj/item/device/sentry_computer(src)


/obj/item/storage/box/guncase/heavy/sentryupp
	name = "\improper UPPAC 32-H sentry gun case"
	desc = "A gun case containing the UPPAC 32-H sentry unit, a spare drum, and a sentry laptop."
	icon_state = "uppsentrycase"
	storage_slots = 3
	can_hold = list(/obj/item/defenses/handheld/sentry/upp, /obj/item/ammo_magazine/sentry/upp, /obj/item/device/sentry_computer)

/obj/item/storage/box/guncase/heavy/sentryupp/fill_preset_inventory()
	new /obj/item/defenses/handheld/sentry/upp(src)
	new /obj/item/ammo_magazine/sentry/upp(src)
	new /obj/item/device/sentry_computer(src)

/obj/item/storage/box/guncase/heavy/sentryupp/update_icon()
	overlays.Cut()
	if(opened)
		overlays += image(icon, "uppbigcase_lid_open")
	else
		overlays += image(icon, "uppsentrycase_lid")
		return
	if(locate(/obj/item/defenses/handheld/sentry) in contents)
		overlays += image(icon, "+uppsentry")
	if(locate(/obj/item/ammo_magazine/sentry) in contents)
		overlays += image(icon, "+uppsentrymag")
	if(locate(/obj/item/device/sentry_computer) in contents)
		overlays += image(icon, "+sentrycomp")


/obj/item/storage/box/guncase/heavy/shotgun
	name = "\improper Ithaca 37 shotgun case"
	desc = "A heavy case for storing an Ithaca 37 pump-action shotgun, an antique from a bygone era of human history."
	icon_state = "shotguncase"
	storage_slots = 6
	can_hold = list(/obj/item/weapon/gun/shotgun/pump, /obj/item/storage/large_holster/m37, /obj/item/attachable/stock/shotgun, /obj/item/ammo_magazine/shotgun/buckshot, /obj/item/ammo_magazine/shotgun/slugs)

/obj/item/storage/box/guncase/heavy/shotgun/fill_preset_inventory()
	new /obj/item/weapon/gun/shotgun/pump(src)
	new /obj/item/ammo_magazine/shotgun/buckshot(src)
	new /obj/item/ammo_magazine/shotgun/slugs(src)
	new /obj/item/storage/pouch/shotgun(src)
	new /obj/item/storage/large_holster/m37(src)
	new /obj/item/attachable/stock/shotgun(src)

/obj/item/storage/box/guncase/heavy/shotgun/update_icon()
	overlays.Cut()
	if(opened)
		overlays += image(icon, "bigcase_lid_open")
	else
		overlays += image(icon, "shotguncase_lid")
		return
	if(locate(/obj/item/weapon/gun/shotgun/pump) in contents)
		overlays += image(icon, "+shotgun")
	if(locate(/obj/item/ammo_magazine/shotgun/buckshot) in contents)
		overlays += image(icon, "+buckshot")
	if(locate(/obj/item/ammo_magazine/shotgun/slugs) in contents)
		overlays += image(icon, "+slug")
	if(locate(/obj/item/storage/large_holster/m37) in contents)
		overlays += image(icon, "+scabbard")
	if(locate(/obj/item/attachable/stock/shotgun) in contents)
		overlays += image(icon, "+stock")

/obj/item/storage/box/guncase/heavy/shotgun/type23
	name = "\improper KS29 shotgun case"
	desc = "A case for storing a KS29 combat shotgun."
	icon_state = "ks29case"
	storage_slots = 2
	can_hold = list(/obj/item/weapon/gun/shotgun/type23, /obj/item/attachable/stock/type23)
	max_w_class = SIZE_HUGE
/obj/item/storage/box/guncase/heavy/shotgun/type23/fill_preset_inventory()
	new /obj/item/weapon/gun/shotgun/type23/unloaded/stored(src)
	new /obj/item/attachable/stock/type23(src)

/obj/item/storage/box/guncase/heavy/shotgun/type23/update_icon()
	overlays.Cut()
	if(opened)
		overlays += image(icon, "uppbigcase_lid_open")
	else
		overlays += image(icon, "ks29case_lid")
		return
	if(locate(/obj/item/weapon/gun/shotgun/type23) in contents)
		overlays += image(icon, "+ks29")

/obj/item/storage/box/guncase/heavy/smg
	name = "\improper M39 submachinegun case"
	desc = "A case for storing an M39 submachinegun and accompanying magazines."
	icon_state = "guncase"
	storage_slots = 8
	can_hold = list(/obj/item/weapon/gun/smg/m39, /obj/item/ammo_magazine/smg/m39)
	max_w_class = SIZE_HUGE

/obj/item/storage/box/guncase/heavy/smg/fill_preset_inventory()
	new /obj/item/weapon/gun/smg/m39/forecon(src)
	new /obj/item/ammo_magazine/smg/m39/extended(src)
	new /obj/item/ammo_magazine/smg/m39/extended(src)
	new /obj/item/ammo_magazine/smg/m39/extended(src)
	new /obj/item/ammo_magazine/smg/m39/extended(src)
	new /obj/item/ammo_magazine/smg/m39/extended(src)
	new /obj/item/ammo_magazine/smg/m39/extended(src)

/obj/item/storage/box/guncase/heavy/smg/type64
	name = "\improper Type 64 submachinegun case"
	desc = "A case for storing a Type 64 submachinegun."
	icon_state = "t64case"
	storage_slots = 8
	can_hold = list(/obj/item/weapon/gun/smg/bizon, /obj/item/ammo_magazine/smg/bizon)
	max_w_class = SIZE_HUGE


/obj/item/storage/box/guncase/heavy/smg/type64/update_icon()
	overlays.Cut()
	if(opened)
		overlays += image(icon, "uppbigcase_lid_open")
	else
		overlays += image(icon, "t64case_lid")
		return
	if(locate(/obj/item/weapon/gun/smg/bizon) in contents)
		overlays += image(icon, "+t64")
	var/mag_tally = 0
	for(var/obj/item/ammo_magazine/smg/bizon/mag in contents)
		mag_tally++
		if(mag_tally >= 2)
			if(istype(mag, /obj/item/ammo_magazine/smg/bizon/heap))
				var/image/source_image = image(icon, "+t64_heap_mag")
				source_image.pixel_x = 0
				overlays += source_image
			else
				var/image/source_image = image(icon, "+t64_mag")
				source_image.pixel_x = 0
				overlays += source_image
		if(mag_tally > 5)
			if(istype(mag, /obj/item/ammo_magazine/smg/bizon/heap))
				var/image/source_image = image(icon, "+t64_heap_mag")
				source_image.pixel_x = 6
				overlays += source_image
			else
				var/image/source_image = image(icon, "+t64_mag")
				source_image.pixel_x = 6
				overlays += source_image


/obj/item/storage/box/guncase/heavy/smg/type64/fill_preset_inventory()
	new /obj/item/weapon/gun/smg/bizon/upp/stored(src)
	new /obj/item/ammo_magazine/smg/bizon(src)
	new /obj/item/ammo_magazine/smg/bizon(src)
	new /obj/item/ammo_magazine/smg/bizon(src)
	new /obj/item/ammo_magazine/smg/bizon(src)
	new /obj/item/ammo_magazine/smg/bizon(src)
	new /obj/item/ammo_magazine/smg/bizon(src)

/obj/item/storage/box/guncase/heavy/smg/type64/heap/fill_preset_inventory()
	new /obj/item/weapon/gun/smg/bizon/upp/stored(src)
	new /obj/item/ammo_magazine/smg/bizon/heap(src)
	new /obj/item/ammo_magazine/smg/bizon/heap(src)
	new /obj/item/ammo_magazine/smg/bizon/heap(src)
	new /obj/item/ammo_magazine/smg/bizon/heap(src)
	new /obj/item/ammo_magazine/smg/bizon/heap(src)
	new /obj/item/ammo_magazine/smg/bizon/heap(src)

/obj/item/storage/box/guncase/heavy/m49a_pve
	name = "\improper M49A6 battle rifle case"
	desc = "A large case for storing an M49A6, a modified USCM battle rifle capable of firing the brutal A19 depleted uranium bullets."
	icon_state = "r2case"
	storage_slots = 8
	can_hold = list(/obj/item/weapon/gun/rifle/m49a/pve, /obj/item/ammo_magazine/rifle/m49a/custom, /obj/item/ammo_magazine/rifle/m49a/custom/explosive, /obj/item/ammo_magazine/rifle/m49a/custom/incendiary, /obj/item/ammo_magazine/rifle/m49a/custom/pve)

/obj/item/storage/box/guncase/heavy/m49a_pve/fill_preset_inventory()
	new /obj/item/weapon/gun/rifle/m49a/pve(src)
	new /obj/item/ammo_magazine/rifle/m49a/custom/pve(src)
	new /obj/item/ammo_magazine/rifle/m49a/custom/pve(src)
	new /obj/item/ammo_magazine/rifle/m49a/custom(src)
	new /obj/item/ammo_magazine/rifle/m49a/custom(src)
	new /obj/item/ammo_magazine/rifle/m49a/custom(src)
	new /obj/item/ammo_magazine/rifle/m49a/custom/explosive(src)
	new /obj/item/ammo_magazine/rifle/m49a/custom/incendiary(src)

/obj/item/storage/box/guncase/heavy/m49a_pve/update_icon()
	overlays.Cut()
	if(opened)
		overlays += image(src.icon, "bigcase_lid_open")
	else
		overlays += image(src.icon, "r2case_lid")
		return
	if(locate(/obj/item/weapon/gun/rifle/m49a/pve) in src.contents)
		overlays += image(src.icon, "+r2")

/obj/item/storage/box/guncase/heavy/sniper
	name = "\improper M42A sniper case"
	desc = "A case for storing an M42A sniper rifle."
	icon_state = "guncase"
	storage_slots = 6
	can_hold = list(/obj/item/weapon/gun/rifle/sniper/M42A, /obj/item/ammo_magazine/sniper, /obj/item/device/binoculars)
	max_w_class = SIZE_HUGE

/obj/item/storage/box/guncase/heavy/sniper/fill_preset_inventory()
	new /obj/item/weapon/gun/rifle/sniper/M42A(src)
	new /obj/item/ammo_magazine/sniper/basic(src)
	new /obj/item/ammo_magazine/sniper/basic(src)
	new /obj/item/ammo_magazine/sniper/basic(src)
	new /obj/item/ammo_magazine/sniper/basic(src)
	new /obj/item/device/binoculars/range/designator/spotter(src)

/obj/item/storage/box/guncase/heavy/sniper/svd_iff
	name = "\improper Type 88-I sniper case"
	desc = "A case for storing a Type 88-I sniper rifle."
	icon_state = "t88case"
	storage_slots = 10
	can_hold = list(/obj/item/weapon/gun/rifle/sniper/svd, /obj/item/ammo_magazine/sniper/svd, /obj/item/device/binoculars)
	max_w_class = SIZE_HUGE

/obj/item/storage/box/guncase/heavy/sniper/svd_iff/fill_preset_inventory()
	new /obj/item/weapon/gun/rifle/sniper/svd/iff/stored(src)
	new /obj/item/ammo_magazine/sniper/svd(src)
	new /obj/item/ammo_magazine/sniper/svd(src)
	new /obj/item/ammo_magazine/sniper/svd(src)
	new /obj/item/ammo_magazine/sniper/svd(src)
	new /obj/item/ammo_magazine/sniper/svd(src)
	new /obj/item/ammo_magazine/sniper/svd(src)
	new /obj/item/ammo_magazine/sniper/svd(src)
	new /obj/item/ammo_magazine/sniper/svd(src)
	new /obj/item/device/binoculars/range/designator/spotter(src)

/obj/item/storage/box/guncase/heavy/sniper/svd_iff/update_icon()
	overlays.Cut()
	if(opened)
		overlays += image(icon, "uppbigcase_lid_open")
	else
		overlays += image(icon, "t88case_lid")
		return
	if(locate(/obj/item/weapon/gun/rifle/sniper/svd) in contents)
		overlays += image(icon, "+t88")
	if(locate(/obj/item/ammo_magazine/sniper/svd/flak) in contents)
		overlays += image(icon, "+t88_flak_mag")
	else
		if(locate(/obj/item/ammo_magazine/sniper/svd) in contents)
			overlays += image(icon, "+t88_mag")
	if(locate(/obj/item/device/binoculars) in contents)
		overlays += image(icon, "+bino")

/obj/item/storage/box/guncase/heavy/sniper/svd_iff/heap/fill_preset_inventory()
	new /obj/item/weapon/gun/rifle/sniper/svd/iff/stored(src)
	new /obj/item/ammo_magazine/sniper/svd/heap(src)
	new /obj/item/ammo_magazine/sniper/svd/heap(src)
	new /obj/item/ammo_magazine/sniper/svd/heap(src)
	new /obj/item/ammo_magazine/sniper/svd/heap(src)
	new /obj/item/ammo_magazine/sniper/svd/flak(src)
	new /obj/item/ammo_magazine/sniper/svd/flak(src)
	new /obj/item/ammo_magazine/sniper/svd/flak(src)
	new /obj/item/ammo_magazine/sniper/svd/flak(src)
	new /obj/item/device/binoculars/range/designator/spotter(src)

/obj/item/storage/box/guncase/heavy/XM99
	name = "\improper XM99A plasma rifle case"
	desc = "A heavy case for storing an XM99A phased plasma pulse rifle, an experimental and deadly energy weapon system."
	icon_state = "xm99case"
	storage_slots = 7
	can_hold = list(/obj/item/weapon/gun/XM99, /obj/item/attachable/scope/pve, /obj/item/ammo_magazine/plasma)

/obj/item/storage/box/guncase/heavy/XM99/fill_preset_inventory()
	new /obj/item/weapon/gun/XM99(src)
	new /obj/item/attachable/scope/pve(src)
	new /obj/item/ammo_magazine/plasma(src)
	new /obj/item/ammo_magazine/plasma(src)
	new /obj/item/ammo_magazine/plasma(src)
	new /obj/item/ammo_magazine/plasma(src)
	new /obj/item/ammo_magazine/plasma(src)

/obj/item/storage/box/guncase/heavy/XM99/update_icon()
	overlays.Cut()
	if(opened)
		overlays += image(icon, "bigcase_lid_open")
	else
		overlays += image(icon, "xm99case_lid")
		return
	if(locate(/obj/item/weapon/gun/XM99) in contents)
		overlays += image(icon, "+xm99")

/obj/item/storage/box/guncase/heavy/hpr
	name = "\improper M41AE2 heavy pulse rifle case"
	desc = "A case storing an M41AE2 heavy pulse rifle, a heavier variant of the M41A designed for sustained automatic fire."
	icon_state = "hprcase"
	storage_slots = 3
	can_hold = list(/obj/item/weapon/gun/rifle/lmg, /obj/item/ammo_magazine/hpr_box)

/obj/item/storage/box/guncase/heavy/hpr/fill_preset_inventory()
	new /obj/item/weapon/gun/rifle/lmg(src)
	new /obj/item/ammo_magazine/hpr_box(src)
	new /obj/item/ammo_magazine/hpr_box(src)

/obj/item/storage/box/guncase/heavy/hpr/update_icon()
	overlays.Cut()
	if(opened)
		overlays += image(src.icon, "bigcase_lid_open")
	else
		overlays += image(src.icon, "hprcase_lid")
		return
	var/obj/item/weapon/gun/rifle/lmg/lmg = locate() in contents
	if(lmg)
		overlays += image(src.icon, "+[lmg.base_gun_icon]")

/obj/item/storage/box/guncase/heavy/hpr/recon/fill_preset_inventory()
	new /obj/item/weapon/gun/rifle/lmg/recon(src)
	new /obj/item/ammo_magazine/hpr_box/recon(src)
	new /obj/item/ammo_magazine/hpr_box/recon(src)

/obj/item/storage/box/guncase/heavy/rmcsmg
	name = "\improper L6A2 SMG CQWS case"
	desc = "A heavy case for storing an L6A2 Close-Quarters-Weapon-System, along with several magazines of squad-head ammunition for it."
	icon_state = "rmcsmgcase"
	storage_slots = 6
	can_hold = list(/obj/item/weapon/gun/smg/m39/elite/rmc, /obj/item/ammo_magazine/smg/m39/squash)

/obj/item/storage/box/guncase/heavy/rmcsmg/fill_preset_inventory()
	new /obj/item/weapon/gun/smg/m39/elite/rmc(src)
	new /obj/item/ammo_magazine/smg/m39/squash(src)
	new /obj/item/ammo_magazine/smg/m39/squash(src)
	new /obj/item/ammo_magazine/smg/m39/squash(src)
	new /obj/item/ammo_magazine/smg/m39/squash(src)
	new /obj/item/ammo_magazine/smg/m39/squash(src)

/obj/item/storage/box/guncase/heavy/rmcsmg/update_icon()
	overlays.Cut()
	if(opened)
		overlays += image(icon, "rmcbigcase_lid_open")
	else
		overlays += image(icon, "rmcsmgcase_lid")
		return
	if(locate(/obj/item/weapon/gun/smg/m39/elite/rmc) in contents)
		overlays += image(icon, "+l6a2")
	if(locate(/obj/item/ammo_magazine/smg/m39/squash) in contents)
		overlays += image(icon, "+mags")

/obj/item/storage/box/guncase/heavy/motiondetectors
	name = "\improper motion detectors case"
	desc = "A case containing four individual handheld motion detectors."
	icon_state = "mdcase"
	storage_slots = 4
	can_hold = list(/obj/item/device/motiondetector)

/obj/item/storage/box/guncase/heavy/motiondetectors/fill_preset_inventory()
	new /obj/item/device/motiondetector(src)
	new /obj/item/device/motiondetector(src)
	new /obj/item/device/motiondetector(src)
	new /obj/item/device/motiondetector(src)

/obj/item/storage/box/guncase/heavy/motiondetectors/update_icon()
	overlays.Cut()
	if(opened)
		overlays += image(icon, "case_lid_open")
	else
		overlays += image(icon, "mdcase_lid")
		return

	if(length(contents) >= storage_slots)
		var/image/source_image = image(icon, "+md")
		source_image.pixel_x = 0
		overlays += source_image
	if(length(contents) >= storage_slots * 0.75)
		var/image/source_image = image(icon, "+md")
		source_image.pixel_x = 6
		overlays += source_image
	if(length(contents) >= storage_slots * 0.5)
		var/image/source_image = image(icon, "+md")
		source_image.pixel_x = 12
		overlays += source_image
	if(length(contents) >= storage_slots * 0.25)
		var/image/source_image = image(src.icon, "+md")
		source_image.pixel_x = 18
		overlays += source_image

/obj/item/storage/box/guncase/heavy/motiondetectors/pmc
	name = "\improper motion detectors case"
	desc = "A case containing four individual handheld motion detectors."
	icon_state = "mdcase"
	storage_slots = 4
	can_hold = list(/obj/item/device/motiondetector/hacked/pmc)

/obj/item/storage/box/guncase/heavy/motiondetectors/pmc/fill_preset_inventory()
	new /obj/item/device/motiondetector/hacked/pmc(src)
	new /obj/item/device/motiondetector/hacked/pmc(src)
	new /obj/item/device/motiondetector/hacked/pmc(src)
	new /obj/item/device/motiondetector/hacked/pmc(src)


/obj/item/storage/box/guncase/heavy/motiondetectors/upp
	name = "\improper motion detectors case"
	desc = "A case containing four individual handheld motion detectors."
	icon_state = "uppmdcase"
	storage_slots = 4
	can_hold = list(/obj/item/device/motiondetector/upp)

/obj/item/storage/box/guncase/heavy/motiondetectors/upp/fill_preset_inventory()
	new /obj/item/device/motiondetector/upp(src)
	new /obj/item/device/motiondetector/upp(src)
	new /obj/item/device/motiondetector/upp(src)
	new /obj/item/device/motiondetector/upp(src)

/obj/item/storage/box/guncase/heavy/motiondetectors/upp/update_icon()
	overlays.Cut()
	if(opened)
		overlays += image(icon, "uppbigcase_lid_open")
	else
		overlays += image(icon, "uppmdcase_lid")
		return

	if(length(contents) >= storage_slots)
		var/image/source_image = image(icon, "+uppmd")
		source_image.pixel_x = 0
		overlays += source_image
	if(length(contents) >= storage_slots * 0.75)
		var/image/source_image = image(icon, "+uppmd")
		source_image.pixel_x = 6
		overlays += source_image
	if(length(contents) >= storage_slots * 0.5)
		var/image/source_image = image(icon, "+uppmd")
		source_image.pixel_x = 12
		overlays += source_image
	if(length(contents) >= storage_slots * 0.25)
		var/image/source_image = image(src.icon, "+uppmd")
		source_image.pixel_x = 18
		overlays += source_image


/obj/item/storage/box/guncase/heavy/motiondetectors/rmc
	name = "\improper motion detectors case"
	desc = "A case containing four L107 handheld motion detectors."
	icon_state = "rmcmdcase"
	storage_slots = 4
	can_hold = list(/obj/item/device/motiondetector/hacked/twe)

/obj/item/storage/box/guncase/heavy/motiondetectors/rmc/fill_preset_inventory()
	new /obj/item/device/motiondetector/hacked/twe(src)
	new /obj/item/device/motiondetector/hacked/twe(src)
	new /obj/item/device/motiondetector/hacked/twe(src)
	new /obj/item/device/motiondetector/hacked/twe(src)

/obj/item/storage/box/guncase/heavy/motiondetectors/rmc/update_icon()
	overlays.Cut()
	if(opened)
		overlays += image(icon, "rmcbigcase_lid_open")
	else
		overlays += image(icon, "rmcmdcase_lid")
		return

	if(length(contents) >= storage_slots)
		var/image/source_image = image(icon, "+md")
		source_image.pixel_x = 0
		overlays += source_image
	if(length(contents) >= storage_slots * 0.75)
		var/image/source_image = image(icon, "+md")
		source_image.pixel_x = 6
		overlays += source_image
	if(length(contents) >= storage_slots * 0.5)
		var/image/source_image = image(icon, "+md")
		source_image.pixel_x = 12
		overlays += source_image
	if(length(contents) >= storage_slots * 0.25)
		var/image/source_image = image(src.icon, "+md")
		source_image.pixel_x = 18
		overlays += source_image

/obj/item/storage/box/guncase/heavy/fuel
	name = "\improper M240A1 fuel canister case"
	desc = "A heavy case containing six fuel canisters for the M240A1 incinerator unit."
	icon_state = "fuelcase"
	storage_slots = 6
	can_hold = list(/obj/item/ammo_magazine/flamer_tank)

/obj/item/storage/box/guncase/heavy/fuel/fill_preset_inventory()
	new /obj/item/ammo_magazine/flamer_tank(src)
	new /obj/item/ammo_magazine/flamer_tank(src)
	new /obj/item/ammo_magazine/flamer_tank(src)
	new /obj/item/ammo_magazine/flamer_tank(src)
	new /obj/item/ammo_magazine/flamer_tank(src)
	new /obj/item/ammo_magazine/flamer_tank(src)

/obj/item/storage/box/guncase/heavy/fuel/update_icon()
	overlays.Cut()
	if(opened)
		overlays += image(icon, "bigcase_lid_open")
	else
		overlays += image(icon, "fuelcase_lid")
		return
	var/tank_tally = 0
	for(var/obj/item/ammo_magazine/flamer_tank/tank in contents)
		tank_tally++
		if(tank_tally > initial(storage_slots))
			return
		if(istype(tank, /obj/item/ammo_magazine/flamer_tank/upp/gellied))
			if(tank_tally <= 3)
				var/image/source_image = image(icon, "+uppfuel_g_bottom")
				source_image.pixel_x = tank_tally*8-8
				overlays += source_image
			else
				var/image/source_image = image(icon, "+uppfuel_g")
				source_image.pixel_x = tank_tally*8-8-(24)
				overlays += source_image
		else
			if(istype(tank, /obj/item/ammo_magazine/flamer_tank/upp))
				if(tank_tally <= 3)
					var/image/source_image = image(icon, "+uppfuel_bottom")
					source_image.pixel_x = tank_tally*8-8
					overlays += source_image
				else
					var/image/source_image = image(icon, "+uppfuel")
					source_image.pixel_x = tank_tally*8-8-(24)
					overlays += source_image
			else
				if(istype(tank, /obj/item/ammo_magazine/flamer_tank))
					if(tank_tally <= 3)
						var/image/source_image = image(icon, "+fuel_bottom")
						source_image.pixel_x = tank_tally*8-8
						overlays += source_image
					else
						var/image/source_image = image(icon, "+fuel")
						source_image.pixel_x = tank_tally*8-8-(24)
						overlays += source_image

/obj/item/storage/box/guncase/heavy/fuel/pmc
	name = "\improper M240A1 fuel canister case"
	desc = "A heavy case containing six EX-fuel canisters for the M240A1 incinerator unit."
	icon_state = "fuelcase"
	storage_slots = 6
	can_hold = list(/obj/item/ammo_magazine/flamer_tank/EX)

/obj/item/storage/box/guncase/heavy/fuel/pmc/fill_preset_inventory()
	new /obj/item/ammo_magazine/flamer_tank/EX(src)
	new /obj/item/ammo_magazine/flamer_tank/EX(src)
	new /obj/item/ammo_magazine/flamer_tank/EX(src)
	new /obj/item/ammo_magazine/flamer_tank/EX(src)
	new /obj/item/ammo_magazine/flamer_tank/EX(src)
	new /obj/item/ammo_magazine/flamer_tank/EX(src)

/obj/item/storage/box/guncase/heavy/uppfuel
	name = "\improper LPO80 fuel canister case"
	desc = "A heavy case containing six fuel canisters for the LPO80 incinerator unit."
	icon_state = "uppfuelcase"
	storage_slots = 6
	can_hold = list(/obj/item/ammo_magazine/flamer_tank)

/obj/item/storage/box/guncase/heavy/uppfuel/update_icon()
	overlays.Cut()
	if(opened)
		overlays += image(icon, "uppbigcase_lid_open")
	else
		overlays += image(icon, "uppfuelcase_lid")
		return
	var/tank_tally = 0
	for(var/obj/item/ammo_magazine/flamer_tank/tank in contents)
		tank_tally++
		if(tank_tally > initial(storage_slots))
			return
		if(istype(tank, /obj/item/ammo_magazine/flamer_tank/upp/gellied))
			if(tank_tally <= 3)
				var/image/source_image = image(icon, "+uppfuel_g_bottom")
				source_image.pixel_x = tank_tally*8-8
				overlays += source_image
			else
				var/image/source_image = image(icon, "+uppfuel_g")
				source_image.pixel_x = tank_tally*8-8-(24)
				overlays += source_image
		else
			if(istype(tank, /obj/item/ammo_magazine/flamer_tank/upp))
				if(tank_tally <= 3)
					var/image/source_image = image(icon, "+uppfuel_bottom")
					source_image.pixel_x = tank_tally*8-8
					overlays += source_image
				else
					var/image/source_image = image(icon, "+uppfuel")
					source_image.pixel_x = tank_tally*8-8-(24)
					overlays += source_image
			else
				if(istype(tank, /obj/item/ammo_magazine/flamer_tank))
					if(tank_tally <= 3)
						var/image/source_image = image(icon, "+fuel_bottom")
						source_image.pixel_x = tank_tally*8-8
						overlays += source_image
					else
						var/image/source_image = image(icon, "+fuel")
						source_image.pixel_x = tank_tally*8-8-(24)
						overlays += source_image

/obj/item/storage/box/guncase/heavy/uppfuel/fill_preset_inventory()
	new /obj/item/ammo_magazine/flamer_tank/upp(src)
	new /obj/item/ammo_magazine/flamer_tank/upp(src)
	new /obj/item/ammo_magazine/flamer_tank/upp(src)
	new /obj/item/ammo_magazine/flamer_tank/upp(src)
	new /obj/item/ammo_magazine/flamer_tank/upp(src)
	new /obj/item/ammo_magazine/flamer_tank/upp(src)

/obj/item/storage/box/guncase/heavy/uppfuel/gellied
	name = "\improper LPO80 B-Gel fuel canister case"
	desc = "A heavy case containing six fuel B-Gel canisters for the LPO80 incinerator unit."
	icon_state = "uppfuelcase"
	storage_slots = 6
	can_hold = list(/obj/item/ammo_magazine/flamer_tank)

/obj/item/storage/box/guncase/heavy/uppfuel/gellied/fill_preset_inventory()
	new /obj/item/ammo_magazine/flamer_tank/upp/gellied(src)
	new /obj/item/ammo_magazine/flamer_tank/upp/gellied(src)
	new /obj/item/ammo_magazine/flamer_tank/upp/gellied(src)
	new /obj/item/ammo_magazine/flamer_tank/upp/gellied(src)
	new /obj/item/ammo_magazine/flamer_tank/upp/gellied(src)
	new /obj/item/ammo_magazine/flamer_tank/upp/gellied(src)

//------------
/obj/item/storage/box/guncase/m56d
	name = "\improper M56D heavy machine gun case"
	desc = "A gun case containing a M56D heavy machine gun. You'll need to order resupplies from requisitions or scavenge them on the field. How do they fit all this into a case? Wouldn't you need a crate."
	storage_slots = 8
	can_hold = list(/obj/item/device/m56d_gun, /obj/item/ammo_magazine/m56d, /obj/item/device/m56d_post, /obj/item/tool/wrench, /obj/item/tool/screwdriver, /obj/item/ammo_magazine/m56d, /obj/item/pamphlet/skill/machinegunner, /obj/item/storage/belt/marine/m2c)

/obj/item/storage/box/guncase/m56d/fill_preset_inventory()
	new /obj/item/device/m56d_gun(src)
	new /obj/item/ammo_magazine/m56d(src)
	new /obj/item/ammo_magazine/m56d(src)
	new /obj/item/device/m56d_post(src)
	new /obj/item/tool/wrench(src)
	new /obj/item/tool/screwdriver(src)
	new /obj/item/pamphlet/skill/machinegunner(src)
	new /obj/item/storage/belt/marine/m2c(src)

//------------
/obj/item/storage/box/guncase/m2c
	name = "\improper M2C heavy machine gun case"
	desc = "A gun case containing a M2C heavy machine gun. It doesn't come loaded, but it does have spare ammunition. You'll have to order extras from requisitions."
	storage_slots = 7
	can_hold = list(/obj/item/pamphlet/skill/machinegunner, /obj/item/device/m2c_gun, /obj/item/ammo_magazine/m2c, /obj/item/storage/belt/marine/m2c, /obj/item/pamphlet/skill/machinegunner)

/obj/item/storage/box/guncase/m2c/fill_preset_inventory()
	new /obj/item/pamphlet/skill/machinegunner(src)
	new /obj/item/device/m2c_gun(src)
	new /obj/item/ammo_magazine/m2c(src)
	new /obj/item/ammo_magazine/m2c(src)
	new /obj/item/ammo_magazine/m2c(src)
	new /obj/item/ammo_magazine/m2c(src)
	new /obj/item/storage/belt/marine/m2c(src)

//------------
/obj/item/storage/box/guncase/m41a
	name = "\improper M41A pulse rifle MK2 case"
	desc = "A gun case containing a M41A pulse rifle MK2."
	storage_slots = 5
	can_hold = list(/obj/item/weapon/gun/rifle/m41a, /obj/item/ammo_magazine/rifle)

/obj/item/storage/box/guncase/m41a/fill_preset_inventory()
	new /obj/item/weapon/gun/rifle/m41a(src)
	for(var/i = 1 to 4)
		new /obj/item/ammo_magazine/rifle(src)


//------------
/obj/item/storage/box/guncase/shotguncombat
	name = "\improper M120 tactical shotgun case"
	desc = "A gun case containing an unloaded M120 tactical shotgun, two boxes of 12 gauge buckshot, and one box of 12 gauge slug."
	icon_state = "guncase"
	storage_slots = 3
	can_hold = list(/obj/item/weapon/gun/shotgun/combat, /obj/item/ammo_magazine/shotgun/buckshot, /obj/item/ammo_magazine/shotgun/slugs)

/obj/item/storage/box/guncase/shotguncombat/fill_preset_inventory()
	new /obj/item/weapon/gun/shotgun/combat(src)
	new /obj/item/ammo_magazine/shotgun/buckshot(src)
	new /obj/item/ammo_magazine/shotgun/slugs(src)

/obj/item/storage/box/guncase/shotgunpump
	name = "\improper Ithaca 37 pump-action shotgun case"
	desc = "A gun case containing an unloaded Ithaca 37 pump-action shotgun, a box of 12 gauge buckshot, and a box of 12 gauge slugs."
	icon_state = "matebacase"
	storage_slots = 6
	can_hold = list(/obj/item/weapon/gun/shotgun/pump, /obj/item/storage/large_holster/m37, /obj/item/attachable/stock/shotgun, /obj/item/ammo_magazine/shotgun/buckshot, /obj/item/ammo_magazine/shotgun/slugs)

/obj/item/storage/box/guncase/shotgunpump/fill_preset_inventory()
	new /obj/item/weapon/gun/shotgun/pump(src)
	new /obj/item/ammo_magazine/shotgun/buckshot(src)
	new /obj/item/ammo_magazine/shotgun/slugs(src)
	new /obj/item/storage/pouch/shotgun(src)
	new /obj/item/storage/large_holster/m37(src)
	new /obj/item/attachable/stock/shotgun(src)


/obj/item/storage/box/guncase/shotgunpump/special
	name = "\improper Ithaca 37 pump-action shotgun case"
	desc = "A gun case containing an unloaded Ithaca 37 pump-action shotgun and one box of 12 gauge USCM Special buckshot."
	icon_state = "matebacase"
	storage_slots = 2

/obj/item/storage/box/guncase/shotgunpump/special/fill_preset_inventory()
	new /obj/item/weapon/gun/shotgun/pump(src)
	new /obj/item/ammo_magazine/shotgun/buckshot/special(src)
	new /obj/item/storage/pouch/shotgun(src)
	new /obj/item/storage/large_holster/m37(src)

/obj/item/storage/box/guncase/random_old_upp_gun
	name = "old weapon case"
	desc = "A scratched up wooden crate. What is inside?"
	icon_state = "kit_case"
	storage_slots = 2
	can_hold = list(/obj/item/weapon/gun/shotgun/double/upp, /obj/item/storage/pouch/shotgun, /obj/item/weapon/gun/pistol/skorpion, /obj/item/storage/pouch/magazine/pistol,/obj/item/ammo_magazine/handful/shotgun/buckshot)

/obj/item/storage/box/guncase/random_old_upp_gun/fill_preset_inventory()
	var/random_weapon = rand(1,2)
	switch(random_weapon)
		if(1)
			storage_slots = 3
			new /obj/item/weapon/gun/shotgun/double/upp(src)
			var/obj/item/storage/pouch/shotgun/pouch = new /obj/item/storage/pouch/shotgun(src)
			new /obj/item/ammo_magazine/handful/shotgun/buckshot(pouch)
			new /obj/item/ammo_magazine/handful/shotgun/buckshot(pouch)
			new /obj/item/ammo_magazine/handful/shotgun/buckshot(pouch)
			new /obj/item/ammo_magazine/handful/shotgun/buckshot(pouch)
			new /obj/item/ammo_magazine/handful/shotgun/buckshot(pouch)
			new /obj/item/ammo_magazine/handful/shotgun/buckshot(src)
			pouch.update_icon()
		if(2)
			new /obj/item/weapon/gun/pistol/skorpion(src)
			var/obj/item/storage/pouch/magazine/pistol/pouch = new /obj/item/storage/pouch/magazine/pistol(src)
			new /obj/item/ammo_magazine/pistol/skorpion(pouch)
			new /obj/item/ammo_magazine/pistol/skorpion(pouch)
			new /obj/item/ammo_magazine/pistol/skorpion(pouch)
			new /obj/item/ammo_magazine/pistol/skorpion(pouch)
			pouch.update_icon()
	var/obj/item/weapon/gun/safety = locate(/obj/item/weapon/gun) in contents
	safety.flags_gun_features ^= GUN_TRIGGER_SAFETY

/obj/item/storage/box/guncase/hg45
	name = "\improper HG 45 pistol case"
	desc = "A gun case containing a HG 45 pistol."
	storage_slots = 6
	can_hold = list(/obj/item/weapon/gun/pistol/highpower, /obj/item/ammo_magazine/pistol/highpower)

/obj/item/storage/box/guncase/hg45/fill_preset_inventory()
	if(prob(30))
		new /obj/item/weapon/gun/pistol/highpower(src)
		new /obj/item/ammo_magazine/pistol/highpower(src)
		new /obj/item/ammo_magazine/pistol/highpower(src)
		new /obj/item/ammo_magazine/pistol/highpower(src)
		new /obj/item/ammo_magazine/pistol/highpower(src)
		new /obj/item/ammo_magazine/pistol/highpower(src)
		new /obj/item/ammo_magazine/pistol/highpower(src)


/obj/item/storage/box/guncase/nsg23_marine
	name = "\improper NSG-23 assault rifle case"
	desc = "A gun case containing a NSG L23A1 assault rifle. While usually seen in the hands of PMCs, this weapon is sometimes issued to USCM personnel."
	storage_slots = 6
	can_hold = /obj/item/ammo_magazine/rifle/nsg23

/obj/item/storage/box/guncase/nsg23_marine/fill_preset_inventory()
	new /obj/item/weapon/gun/rifle/nsg23(src)
	new /obj/item/ammo_magazine/rifle/nsg23/ap(src)
	new /obj/item/ammo_magazine/rifle/nsg23(src)
	new /obj/item/ammo_magazine/rifle/nsg23(src)
	new /obj/item/ammo_magazine/rifle/nsg23(src)
	new /obj/item/ammo_magazine/rifle/nsg23(src)

/obj/item/storage/box/guncase/nsg23_marine/pve

/obj/item/storage/box/guncase/nsg23_marine/pve/fill_preset_inventory()
	new /obj/item/weapon/gun/rifle/nsg23/no_lock/pve(src)
	new /obj/item/ammo_magazine/rifle/nsg23(src)
	new /obj/item/ammo_magazine/rifle/nsg23(src)
	new /obj/item/ammo_magazine/rifle/nsg23(src)
	new /obj/item/ammo_magazine/rifle/nsg23(src)
	new /obj/item/ammo_magazine/rifle/nsg23(src)

/obj/item/storage/box/guncase/nsg23_marine/pve/heap

/obj/item/storage/box/guncase/nsg23_marine/pve/heap/fill_preset_inventory()
	new /obj/item/weapon/gun/rifle/nsg23/no_lock/pve/heap(src)
	new /obj/item/ammo_magazine/rifle/nsg23/heap(src)
	new /obj/item/ammo_magazine/rifle/nsg23/heap(src)
	new /obj/item/ammo_magazine/rifle/nsg23/heap(src)
	new /obj/item/ammo_magazine/rifle/nsg23/heap(src)
	new /obj/item/ammo_magazine/rifle/nsg23/heap(src)


/obj/item/storage/box/guncase/m3717
	name = "\improper M37-17 pump shotgun case"
	desc = "A gun case containing a M37-17 pump shotgun. Rarely seen issued to USCM vessels on the edges of inhabited space who need the extra bang for their buck (literally) the M37-17 has. Like this one! Well, if it had the budget for it."
	storage_slots = 4
	can_hold = list(/obj/item/weapon/gun/shotgun/pump/dual_tube/cmb/m3717, /obj/item/ammo_magazine/shotgun/buckshot)

/obj/item/storage/box/guncase/m3717/fill_preset_inventory()
	new /obj/item/weapon/gun/shotgun/pump/dual_tube/cmb/m3717(src)
	new /obj/item/ammo_magazine/shotgun/buckshot(src)
	new /obj/item/ammo_magazine/shotgun/buckshot(src)
	new /obj/item/ammo_magazine/shotgun/buckshot(src)

/obj/item/storage/box/guncase/m1911
	name = "\improper M1911 service pistol case"
	desc = "A gun case containing a M1911 service pistol. It might be three centuries old but it's still a damn good pistol. Back-issue only, though."
	storage_slots = 7
	can_hold = list(/obj/item/weapon/gun/pistol/m1911, /obj/item/ammo_magazine/pistol/m1911)

/obj/item/storage/box/guncase/m1911/fill_preset_inventory()
	new /obj/item/weapon/gun/pistol/m1911(src)
	new /obj/item/ammo_magazine/pistol/m1911(src)
	new /obj/item/ammo_magazine/pistol/m1911(src)
	new /obj/item/ammo_magazine/pistol/m1911(src)
	new /obj/item/ammo_magazine/pistol/m1911(src)
	new /obj/item/ammo_magazine/pistol/m1911(src)
	new /obj/item/ammo_magazine/pistol/m1911(src)
	new /obj/item/ammo_magazine/pistol/m1911(src)

/obj/item/storage/box/guncase/m1911/socom
	name = "\improper SOCOM M1911 service pistol case"
	storage_slots = 7
	can_hold = list(/obj/item/weapon/gun/pistol/m1911/socom, /obj/item/ammo_magazine/pistol/m1911)

/obj/item/storage/box/guncase/m1911/socom/fill_preset_inventory()
	new /obj/item/weapon/gun/pistol/m1911/socom(src)
	new /obj/item/ammo_magazine/pistol/m1911(src)
	new /obj/item/ammo_magazine/pistol/m1911(src)
	new /obj/item/ammo_magazine/pistol/m1911(src)
	new /obj/item/ammo_magazine/pistol/m1911(src)
	new /obj/item/ammo_magazine/pistol/m1911(src)
	new /obj/item/ammo_magazine/pistol/m1911(src)
	new /obj/item/ammo_magazine/pistol/m1911(src)

/obj/item/storage/box/guncase/cane_gun_kit
	name = "spy-agent cane case"
	desc = "A gun case containing a top-secret Gun Cane chambered in .44, alongside two spare handfuls of said caliber. Make sure to fold this after you use it!"
	can_hold = list(/obj/item/weapon/gun/shotgun/double/cane, /obj/item/ammo_magazine/handful/revolver)
	storage_slots = 3

/obj/item/storage/box/guncase/cane_gun_kit/fill_preset_inventory()
	new /obj/item/weapon/gun/shotgun/double/cane(src)
	new /obj/item/ammo_magazine/handful/revolver/marksman/six_rounds(src)
	new /obj/item/ammo_magazine/handful/revolver/marksman/six_rounds(src)

/obj/item/storage/box/guncase/vulture
	name = "\improper M707 anti-materiel rifle case"
	desc = "A gun case containing a M707 \"Vulture\" anti-materiel rifle and its requisite spotting tools."
	icon_state = "guncase_blue"
	storage_slots = 7
	can_hold = list(
		/obj/item/weapon/gun/boltaction/vulture,
		/obj/item/ammo_magazine/rifle/boltaction/vulture,
		/obj/item/device/vulture_spotter_tripod,
		/obj/item/device/vulture_spotter_scope,
		/obj/item/tool/screwdriver,
		/obj/item/pamphlet/trait/vulture,
	)

/obj/item/storage/box/guncase/vulture/fill_preset_inventory()
	var/obj/item/weapon/gun/boltaction/vulture/rifle = new(src)
	new /obj/item/ammo_magazine/rifle/boltaction/vulture(src)
	new /obj/item/device/vulture_spotter_tripod(src)
	new /obj/item/device/vulture_spotter_scope(src, WEAKREF(rifle))
	new /obj/item/tool/screwdriver(src) // Spotter scope needs a screwdriver to disassemble
	new /obj/item/pamphlet/trait/vulture(src) //both pamphlets give use of the scope and the rifle
	new /obj/item/pamphlet/trait/vulture(src)

/obj/item/storage/box/guncase/vulture/skillless
	storage_slots = 5

/obj/item/storage/box/guncase/vulture/skillless/fill_preset_inventory()
	var/obj/item/weapon/gun/boltaction/vulture/skillless/rifle = new(src)
	new /obj/item/ammo_magazine/rifle/boltaction/vulture(src)
	new /obj/item/device/vulture_spotter_tripod(src)
	new /obj/item/device/vulture_spotter_scope/skillless(src, WEAKREF(rifle))
	new /obj/item/tool/screwdriver(src) // Spotter scope needs a screwdriver to disassemble

/obj/item/storage/box/guncase/vulture/holo_target
	name = "\improper M707 holo-targetting anti-materiel rifle case"
	desc = "A gun case containing the M707 \"Vulture\" anti-materiel rifle and its requisite spotting tools. This variant is pre-loaded with <b>IFF-CAPABLE</b> holo-targeting rounds."

/obj/item/storage/box/guncase/vulture/holo_target/fill_preset_inventory()
	var/obj/item/weapon/gun/boltaction/vulture/holo_target/rifle = new(src)
	new /obj/item/ammo_magazine/rifle/boltaction/vulture/holo_target(src)
	new /obj/item/device/vulture_spotter_tripod(src)
	new /obj/item/device/vulture_spotter_scope(src, WEAKREF(rifle))
	new /obj/item/tool/screwdriver(src)
	new /obj/item/pamphlet/trait/vulture(src)
	new /obj/item/pamphlet/trait/vulture(src)

/obj/item/storage/box/guncase/vulture/holo_target/skillless
	storage_slots = 5

/obj/item/storage/box/guncase/vulture/holo_target/skillless/fill_preset_inventory()
	var/obj/item/weapon/gun/boltaction/vulture/holo_target/skillless/rifle = new(src)
	new /obj/item/ammo_magazine/rifle/boltaction/vulture/holo_target(src)
	new /obj/item/device/vulture_spotter_tripod(src)
	new /obj/item/device/vulture_spotter_scope/skillless(src, WEAKREF(rifle))
	new /obj/item/tool/screwdriver(src)


/obj/item/storage/box/guncase/xm51
	name = "\improper M1771 shotgun case"
	desc = "A gun case containing the Model 1771 Cobra Max Tactical shotgun. Comes with two spare magazines, two spare shell boxes, an optional stock and a belt to holster the weapon."
	storage_slots = 7
	can_hold = list(/obj/item/weapon/gun/rifle/xm51, /obj/item/ammo_magazine/rifle/xm51, /obj/item/storage/belt/gun/xm51, /obj/item/attachable/stock/xm51)

/obj/item/storage/box/guncase/xm51/fill_preset_inventory()
	new /obj/item/attachable/stock/xm51(src)
	new /obj/item/weapon/gun/rifle/xm51(src)
	new /obj/item/ammo_magazine/rifle/xm51(src)
	new /obj/item/ammo_magazine/rifle/xm51(src)
	new /obj/item/ammo_magazine/shotgun/buckshot/light(src)
	new /obj/item/ammo_magazine/shotgun/buckshot/light(src)
	new /obj/item/storage/belt/gun/xm51(src)

//Handgun case for Military police vendor three mag , a railflashligh and the handgun.

//VP70 Combat Pistol
/obj/item/storage/box/guncase/vp70
	name = "\improper VP70 Combat Pistol case"
	desc = "A gun case containing a VP70 Combat Pistol."
	storage_slots = 8
	can_hold = list(/obj/item/attachable/flashlight, /obj/item/weapon/gun/pistol/vp70, /obj/item/ammo_magazine/pistol/vp70)

/obj/item/storage/box/guncase/vp70/fill_preset_inventory()
	new /obj/item/attachable/flashlight(src)
	new /obj/item/weapon/gun/pistol/vp70(src)
	new /obj/item/ammo_magazine/pistol/vp70(src)
	new /obj/item/ammo_magazine/pistol/vp70(src)
	new /obj/item/ammo_magazine/pistol/vp70(src)
	new /obj/item/ammo_magazine/pistol/vp70(src)
	new /obj/item/ammo_magazine/pistol/vp70(src)
	new /obj/item/ammo_magazine/pistol/vp70(src)

//M44 Combat Revolver
/obj/item/storage/box/guncase/m44
	name = "\improper M44 Combat Revolver case"
	desc = "A gun case containing a M44 Combat Revolver loaded with marksman ammo."
	storage_slots = 8
	can_hold = list(/obj/item/attachable/flashlight, /obj/item/weapon/gun/revolver/m44, /obj/item/ammo_magazine/revolver)

/obj/item/storage/box/guncase/m44/fill_preset_inventory()
	new /obj/item/attachable/flashlight(src)
	new /obj/item/weapon/gun/revolver/m44/mp(src)
	new /obj/item/ammo_magazine/revolver/marksman(src)
	new /obj/item/ammo_magazine/revolver/marksman(src)
	new /obj/item/ammo_magazine/revolver/marksman(src)
	new /obj/item/ammo_magazine/revolver/marksman(src)
	new /obj/item/ammo_magazine/revolver/marksman(src)
	new /obj/item/ammo_magazine/revolver/marksman(src)

//M4A3 Service Pistol
/obj/item/storage/box/guncase/m4a3
	name = "\improper M4A3 Service Pistol case"
	desc = "A gun case containing a M4A3 Service Pistol."
	storage_slots = 8
	can_hold = list(/obj/item/attachable/flashlight, /obj/item/weapon/gun/pistol/m4a3, /obj/item/ammo_magazine/pistol)

/obj/item/storage/box/guncase/m4a3/fill_preset_inventory()
	new /obj/item/attachable/flashlight(src)
	new /obj/item/weapon/gun/pistol/m4a3(src)
	new /obj/item/ammo_magazine/pistol(src)
	new /obj/item/ammo_magazine/pistol(src)
	new /obj/item/ammo_magazine/pistol(src)
	new /obj/item/ammo_magazine/pistol(src)
	new /obj/item/ammo_magazine/pistol(src)
	new /obj/item/ammo_magazine/pistol(src)
