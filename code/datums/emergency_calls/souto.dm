//Best ert ever

/datum/emergency_call/souto
	name = "Souto Man"
	mob_max = 1
	mob_min = 1
	objectives = "Party like it's 1999!"
	probability = 0

/datum/emergency_call/souto/New()
	arrival_message = "Give a round of applause for the marine who sent in ten-thousand Souto tabs to get me here! [MAIN_SHIP_NAME], Souto Man's here to party with YOU!"
	return ..()

/datum/emergency_call/souto/create_member(datum/mind/M, turf/override_spawn_loc)
	var/turf/spawn_loc = override_spawn_loc ? override_spawn_loc : get_spawn_point()

	if(!istype(spawn_loc))
		return //Didn't find a useable spawn point.

	var/mob/living/carbon/human/H = new(spawn_loc)
	M.transfer_to(H, TRUE)

	arm_equipment(H, /datum/equipment_preset/other/souto, TRUE, TRUE)

	to_chat(H, SPAN_ROLE_HEADER("You are Souto Man! You should bring awareness to the Souto brand!"))
	to_chat(H, SPAN_ROLE_BODY("Your job is to party hard and share Souto. Make sure those marines are never thirsty again!"))

	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), H, SPAN_BOLD("Objectives: [objectives]")), 1 SECONDS)

/datum/emergency_call/souto/cryo
	name = "Souto Man (Cryo)"
	probability = 0
	name_of_spawn = /obj/effect/landmark/ert_spawns/distress_cryo
	shuttle_id = ""

/obj/item/weapon/gun/rifle/m41aMK1/airsoft
	name = "\improper M41A pulse rifle replica"
	desc = "A convincing replica of a Pulse action 10x24mm caseless assault rifle of the USCMC, personal friend of any LARPER. Features an integrated 30mm grenade launcher and ammo tube that can hold four grenades on backup."
	icon = 'icons/obj/structures/props/crosses.dmi'
	icon_state = "m41airsoft" //Placeholder.
	item_state = "m41airsoft" //Placeholder.
	fire_sound = 'sound/items/syringeproj.ogg'
	reload_sound = 'sound/weapons/handling/m41_reload.ogg'
	unload_sound = 'sound/weapons/handling/m41_unload.ogg'
	current_mag = /obj/item/ammo_magazine/rifle/m41aMK1/airsoft
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/reddot,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/reflex,
		/obj/item/attachable/scope/pve,
		/obj/item/attachable/attached_gun/grenade/mk1,
		/obj/item/attachable/stock/rifle/collapsible,
		/obj/item/attachable/sling,
	)

	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER
	starting_attachment_types = list(/obj/item/attachable/attached_gun/grenade/mk1, /obj/item/attachable/stock/rifle/collapsible)
	start_automatic = TRUE

/obj/item/weapon/gun/rifle/m41aMK1/airsoft/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 32, "muzzle_y" = 18,"rail_x" = 12, "rail_y" = 23, "under_x" = 23, "under_y" = 13, "stock_x" = 24, "stock_y" = 14, "side_rail_x" = 23, "side_rail_y" = 16)


/obj/item/weapon/gun/rifle/m41aMK1/airsoft/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_11)
	set_burst_amount(BURST_AMOUNT_TIER_4)
	set_burst_delay(FIRE_DELAY_TIER_11)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_3
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_7
	scatter = SCATTER_AMOUNT_TIER_9
	burst_scatter_mult = SCATTER_AMOUNT_TIER_9
	scatter_unwielded = SCATTER_AMOUNT_TIER_2
	damage_mult = BASE_BULLET_DAMAGE_MULT
	damage_falloff_mult = 0
	recoil_unwielded = RECOIL_OFF

/obj/item/ammo_magazine/rifle/m41aMK1/airsoft
	name = "\improper M41A airsoft magazine (6mm BB)"
	desc = "A long rectangular box magazine for the M41A. Holds 190 6mm BB pellets."
	icon_state = "m41a_mk1"
	max_rounds = 190
	gun_type = /obj/item/weapon/gun/rifle/m41aMK1/airsoft
	default_ammo = /datum/ammo/bullet/rifle/airsoft
	ammo_band_icon = "+m41a_mk1_band"
	ammo_band_icon_empty = "+m41a_mk1_band_e"
	bonus_overlay = "m41a_mk1_overlay"

/datum/ammo/bullet/rifle/airsoft
	name = "6mm BB"
	headshot_state = HEADSHOT_OVERLAY_MEDIUM
	damage = 1
	penetration = ARMOR_PENETRATION_TIER_1
	accurate_range = 16
	accuracy = HIT_ACCURACY_TIER_4
	scatter = SCATTER_AMOUNT_TIER_10
	shell_speed = AMMO_SPEED_TIER_2
	effective_range_max = 7
	damage_falloff = DAMAGE_FALLOFF_TIER_7
	max_range = 24

/obj/item/explosive/grenade/slug/baton/foam
	name = "\improper Foam Dart"
	desc = "It's nerf or nothing! Ages 8 and up."
	icon = 'icons/obj/items/toy.dmi'
	icon_state = "foamdart"
	item_state = "foamdart"
	inactive_icon = "foamdart"
	caliber = "30mm"
	antigrief_protection = FALSE
	underslug_launchable = TRUE
	hand_throwable = FALSE
	impact_damage = 1
	slowdown_time = 2
	knockout_time = 0.8
	dazed_time = 1.7

/obj/item/explosive/grenade/slug/baton/foam/Initialize()
	. = ..()
	setDir(NORTH) //so they're oriented properly in our inventory

/obj/structure/largecrate/supply/ammo/m41a/larp
	name = "\improper M41A magazine case (x50)"
	desc = "An ammunition case containing 50 M41A BB magazines."
	supplies = list(/obj/item/ammo_magazine/rifle/m41aMK1/airsoft = 50)

/obj/structure/largecrate/supply/ammo/baton/foam
	name = "\improper Foam Dart case (x50)"
	desc = "An ammunition case containing 50 M41A Foam Darts."
	supplies = list(/obj/item/storage/box/packet/baton/foam = 50)

/obj/item/storage/box/packet/baton/foam
	name = "\improper Foam Dart grenade packet"
	desc = "It contains five Foam Dart."
	packet_icon = "hedp-p"
	content_type = /obj/item/explosive/grenade/slug/baton/foam
