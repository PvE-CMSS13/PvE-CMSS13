//-------------------------------------------------------
//SNIPER RIFLES
//Keyword rifles. They are subtype of rifles, but still contained here as a specialist weapon.

/obj/item/ammo_magazine/sniper
	name = "\improper M42A marksman magazine (10x28mm Caseless)"
	desc = "A magazine of M252 HEAP match-grade 10x28mm ammo. An aimed shot with it will deal significant damage."
	caliber = "10x28mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/uscm.dmi'
	icon_state = "m42c" //PLACEHOLDER
	w_class = SIZE_MEDIUM
	max_rounds = 15
	default_ammo = /datum/ammo/bullet/rifle/heavy/heap/sniper
	gun_type = /obj/item/weapon/gun/rifle/sniper/M42A
	ammo_band_icon = "+m42c_band"
	ammo_band_icon_empty = "+m42c_band_e"

/obj/item/ammo_magazine/sniper/basic
	name = "\improper M42A magazine (10x28mm)"
	desc = "A magazine of M250 10x28mm ammunition. Not as effective as the match-grade kind, but still brings the hurt. An aimed shot with it will temporarily blind the targe and kindle the blaze further."
	default_ammo = /datum/ammo/bullet/rifle/heavy
	ammo_band_color = AMMO_BAND_COLOR_RUBBER

/obj/item/ammo_magazine/sniper/incendiary
	name = "\improper M42A incendiary magazine (10x28mm)"
	desc = "A magazine of M254 incendiary match-grade 10x28mm ammo. An aimed shot with it will temporarily blind the targe and kindle the blaze further."
	default_ammo = /datum/ammo/bullet/rifle/heavy/incendiary
	ammo_band_color = AMMO_BAND_COLOR_INCENDIARY

/obj/item/ammo_magazine/sniper/flak
	name = "\improper M42A flak magazine (10x28mm)"
	desc = "A magazine of M257 HEFA match-grade 10x28mm ammo. An aimed shot with it will temporarily slow the target and minimize the backlash."
	default_ammo = /datum/ammo/bullet/rifle/heavy/flak
	ammo_band_color = AMMO_BAND_COLOR_IMPACT

//XM43E1 Magazine
/obj/item/ammo_magazine/sniper/anti_materiel
	name = "\improper XM43E1 marksman magazine (10x99mm)"
	desc = "A magazine of caseless 10x99mm anti-materiel rounds, capable of penetrating through most infantry-level materiel. Depending on what you hit, it might even have enough energy to wound anything behind the target."
	max_rounds = 8
	caliber = "10x99mm"
	default_ammo = /datum/ammo/bullet/sniper/anti_materiel
	gun_type = /obj/item/weapon/gun/rifle/sniper/XM43E1

//M42C magazine

/obj/item/ammo_magazine/sniper/elite
	name = "\improper M42C marksman magazine (10x28mm)"
	desc = "A magazine of M252 HEAP match-grade 10x28mm ammo. An aimed shot with it will deal significant damage."
	default_ammo = /datum/ammo/bullet/rifle/heavy/heap/sniper
	gun_type = /obj/item/weapon/gun/rifle/sniper/elite
	caliber = "10x28mm"
	icon_state = "m42c"
	max_rounds = 6

/obj/item/ammo_magazine/sniper/elite/basic
	name = "\improper M42C magazine (10x28mm)"
	desc = "A magazine of M250 10x28mm ammunition. Not as effective as the match-grade kind, but still brings the hurt."
	default_ammo = /datum/ammo/bullet/rifle/heavy
	gun_type = /obj/item/weapon/gun/rifle/sniper/elite
	caliber = "10x28mm"
	icon_state = "m42c"
	max_rounds = 6
	ammo_band_color = AMMO_BAND_COLOR_RUBBER

/obj/item/ammo_magazine/sniper/elite/incin
	name = "\improper M42C incendiary magazine (10x28mm)"
	desc = "A magazine of M254 incendiary match-grade 10x28mm ammo. An aimed shot with it will temporarily blind the target and kindle the blaze further."
	default_ammo = /datum/ammo/bullet/rifle/heavy/incendiary
	gun_type = /obj/item/weapon/gun/rifle/sniper/elite
	caliber = "10x28mm"
	icon_state = "m42c"
	max_rounds = 6
	ammo_band_color = AMMO_BAND_COLOR_INCENDIARY

/obj/item/ammo_magazine/sniper/elite/flak
	name = "\improper M42C flak magazine (10x28mm)"
	desc = "A magazine of M257 HEFA match-grade 10x28mm ammo. An aimed shot with it will temporarily slow the target and minimize the backlash."
	default_ammo = /datum/ammo/bullet/rifle/heavy/flak
	gun_type = /obj/item/weapon/gun/rifle/sniper/elite
	caliber = "10x28mm"
	icon_state = "m42c"
	max_rounds = 6
	ammo_band_color = AMMO_BAND_COLOR_IMPACT

/obj/item/ammo_magazine/sniper/elite/overkill
	name = "\improper M42C super-sonic magazine (10x28mm)"
	desc = "A magazine of M252A1 HEAPSS match-grade 10x28mm ammo. Capable of penetrating through most infantry-level materiel. Depending on what you hit, it might even have enough energy to wound anything behind the target."
	default_ammo = /datum/ammo/bullet/sniper/elite
	gun_type = /obj/item/weapon/gun/rifle/sniper/elite
	caliber = "10x28mm"
	icon_state = "m42c"
	max_rounds = 6
	ammo_band_color = AMMO_BAND_COLOR_RUBBER

//Type 88 //Based on the actual Dragunov designated marksman rifle.

/obj/item/ammo_magazine/sniper/svd
	name = "\improper Type-88 Magazine (7.62x54mmR)"
	desc = "A large caliber magazine for the Type-88 designated marksman rifle."
	caliber = "7.62x54mmR"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/upp.dmi'
	icon_state = "type88mag"
	default_ammo = /datum/ammo/bullet/sniper/upp
	max_rounds = 12
	gun_type = /obj/item/weapon/gun/rifle/sniper/svd
	ammo_band_icon = "+type88_band"
	ammo_band_icon_empty = "+type88_band_e"

/obj/item/ammo_magazine/sniper/svd/heap
	name = "\improper Type-88 HV Magazine (7.62x54mmR)"
	desc = "A large caliber magazine for the Type-88 designated marksman rifle. This one is loaded with HV rounds, that provide some additonal force and body armor penetration.."
	ammo_band_color = AMMO_BAND_COLOR_HEAP
	default_ammo = /datum/ammo/bullet/sniper/upp/heap

/obj/item/ammo_magazine/sniper/svd/flak
	name = "\improper Type-88 flak Magazine (7.62x54mmR)"
	desc = "A large caliber magazine for the Type-88 designated marksman rifle. This one is loaded with flak rounds, which explode into spall on impact."
	ammo_band_color = AMMO_BAND_COLOR_IMPACT
	default_ammo = /datum/ammo/bullet/sniper/upp/flak

/obj/item/ammo_magazine/sniper/svd/flak/Initialize(mapload, spawn_empty)
	. = ..()
	desc = desc + SPAN_WARNING(" Be careful of collateral damage to friendlies caused by the spall.")

/obj/item/ammo_magazine/sniper/svd/pve
	name = "\improper Type-88 HP Magazine (7.62x54mmR)"
	default_ammo = /datum/ammo/bullet/sniper/upp_pve

//RMC DMR magazine

/obj/item/ammo_magazine/sniper/rmc
	name = "\improper L64A3 squash-head magazine (8.88x51mm Caseless)"
	desc = "A magazine of L10A7 squash-head match-grade 8.88x51mm ammo. An aimed shot with it will deal significant damage."
	caliber = "8.88x51mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/twe_ammo.dmi'
	icon_state = "rmcdmr"
	w_class = SIZE_MEDIUM
	max_rounds = 25
	default_ammo = /datum/ammo/bullet/rifle/heavy/rmcdmr
	gun_type = /obj/item/weapon/gun/rifle/sniper/rmc
	ammo_band_icon = "+rmcdmr_band"
	ammo_band_icon_empty = "+rmcdmr_band_e"
	ammo_band_color = AMMO_BAND_COLOR_IMPACT

//M49A magazines

/obj/item/ammo_magazine/rifle/m49a/custom
	name = "\improper A19 HV magazine (10x28mm)"
	desc = "A magazine of A19 high velocity rounds for use in the later-model M49A battle rifles. The M49A5 & M49A6 battle rifles are the only guns that can chamber these rounds."
	icon_state = "a19"
	default_ammo = /datum/ammo/bullet/rifle/heavy/spec
	max_rounds = 30
	gun_type = /obj/item/weapon/gun/rifle/m49a_custom
	ammo_band_icon = "+a19_band"
	ammo_band_icon_empty = "+a19_band_e"
	ammo_band_color = AMMO_BAND_COLOR_HIGH_IMPACT

/obj/item/ammo_magazine/rifle/m49a/custom/incendiary
	name = "\improper A19 HV incendiary magazine (10x28mm)"
	desc = "A magazine of A19 HV incendiary rounds for use in the later-model M49A battle rifles. The M49A5 & M49A6 battle rifles are the only guns that can chamber these rounds."
	default_ammo = /datum/ammo/bullet/rifle/heavy/spec/incendiary
	gun_type = /obj/item/weapon/gun/rifle/m49a_custom
	ammo_band_color = AMMO_BAND_COLOR_INCENDIARY

/obj/item/ammo_magazine/rifle/m49a/custom/explosive
	name = "\improper A19 HV explosive magazine (10x28mm)"
	desc = "A magazine of A19 HV explosive rounds for use in the later-model M49A battle rifles. The M49A5 & M49A6 battle rifles are the only guns that can chamber these rounds."
	default_ammo = /datum/ammo/bullet/rifle/heavy/spec/explosive
	gun_type = /obj/item/weapon/gun/rifle/m49a_custom
	ammo_band_color = AMMO_BAND_COLOR_EXPLOSIVE

/obj/item/ammo_magazine/rifle/m49a/custom/pve
	name = "\improper A19 HV depleted uranium magazine (10x28mm)"
	desc = "A magazine of A19 HV wall-penetrating, body-penetrating, toxic 10x28mm rounds. Handloaded by Gateway armorers for use in the M49A6 battle rifle."
	default_ammo = /datum/ammo/bullet/rifle/heavy/spec/du
	gun_type = /obj/item/weapon/gun/rifle/m49a/pve
	ammo_band_color = AMMO_BAND_COLOR_TOXIN

//-------------------------------------------------------
//SMARTGUN
/obj/item/ammo_magazine/smartgun
	name = "smartgun drum"
	caliber = "10x28mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/uscm.dmi'
	icon_state = "m56_drum"
	max_rounds = 500 //Should be 500 in total.
	w_class = SIZE_MEDIUM
	default_ammo = /datum/ammo/bullet/rifle/heavy/tracer
	gun_type = /obj/item/weapon/gun/smartgun

/obj/item/ammo_magazine/smartgun/dirty
	name = "irradiated smartgun drum"
	desc = "What at first glance appears to be a standard 500 round M56 Smartgun drum, is actually a drum loaded with irradiated rounds, providing an extra 'oomph' to to its bullets. The magazine itself is slightly modified to only fit in M56T smartguns, and is marked with a red X."
	icon_state = "m56_drum_dirty"
	default_ammo = /datum/ammo/bullet/rifle/heavy/dirty
	gun_type = /obj/item/weapon/gun/smartgun

/obj/item/ammo_magazine/smartgun/holo_targeting
	name = "holotargeting smartgun drum"
	desc = "Holotargeting rounds for use in the royal marines commando L58A3 smartgun. The drum itself is designed to only fit in L58A3 smartguns, and is marked with a blue X."
	icon_state = "m56_drum_holo"
	default_ammo = /datum/ammo/bullet/rifle/heavy/holo_target
	gun_type = /obj/item/weapon/gun/smartgun/rmc

/obj/item/ammo_magazine/smartgun/upp
	name = "automated machinegun drum"
	caliber = "12.7x40mm"
	max_rounds = 250
	desc = "Simple high-caliber 250 round machinegun drum."
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/upp.dmi'
	icon_state = "rfvs37"
	default_ammo = /datum/ammo/bullet/rifle/heavy/upp_smartgun
	gun_type = /obj/item/weapon/gun/smartgun/upp


//-------------------------------------------------------
//Flare gun. Close enough?
/obj/item/ammo_magazine/internal/flare
	name = "flare gun internal magazine"
	caliber = "FL"
	max_rounds = 1
	default_ammo = /datum/ammo/flare

//-------------------------------------------------------
//M5 RPG

/obj/item/ammo_magazine/rocket
	name = "\improper 84mm high explosive rocket"
	desc = "A rocket tube loaded with a HE warhead. Deals high damage to soft targets on direct hit and stuns most targets in a 5-meter-wide area for a short time. Has decreased effect on heavily armored targets."
	caliber = "rocket"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/uscm.dmi'
	icon_state = "rocket"

	reload_delay = 60
	matter = list("metal" = 10000)
	w_class = SIZE_MEDIUM
	max_rounds = 1
	default_ammo = /datum/ammo/rocket
	gun_type = /obj/item/weapon/gun/launcher/rocket
	flags_magazine = NO_FLAGS

/obj/item/ammo_magazine/rocket/attack_self(mob/user)
	. = ..()
	if(current_rounds <= 0)
		to_chat(user, SPAN_NOTICE("You begin taking apart the empty tube frame..."))
		if(do_after(user,10, INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
			user.visible_message("[user] deconstructs the rocket tube frame.",SPAN_NOTICE("You take apart the empty frame."))
			var/obj/item/stack/sheet/metal/M = new(get_turf(user))
			M.amount = 2
			user.drop_held_item()
			qdel(src)
	else
		to_chat(user, "Not with a missile inside!")

/obj/item/ammo_magazine/rocket/attack(mob/living/carbon/human/M, mob/living/carbon/human/user)
	if(!istype(M) || !istype(user) || get_dist(user, M) > 1)
		return
	var/obj/item/weapon/gun/launcher/in_hand = M.get_active_hand()
	if(!in_hand || !istype(in_hand))
		return
	if(!in_hand.current_mag)
		return
	var/obj/item/weapon/twohanded/offhand/off_hand = M.get_inactive_hand()
	if(!off_hand || !istype(off_hand))
		to_chat(user, SPAN_WARNING("\the [M] needs to be wielding \the [in_hand] in order to reload!"))
		return
	if(!skillcheck(M, SKILL_FIREARMS, SKILL_FIREARMS_TRAINED))
		to_chat(user, SPAN_WARNING("You don't know how to reload \the [in_hand]!"))
		return
	if(M.dir != user.dir || M.loc != get_step(user, user.dir))
		to_chat(user, SPAN_WARNING("You must be standing behind \the [M] in order to reload it!"))
		return
	if(in_hand.current_mag.current_rounds > 0)
		to_chat(user, SPAN_WARNING("\the [in_hand] is already loaded!"))
		return
	if(user.action_busy)
		return
	to_chat(user, SPAN_NOTICE("You begin reloading \the [M]'s [in_hand]! Hold still..."))
	if(!do_after(user,(in_hand.current_mag.reload_delay / 2), INTERRUPT_ALL, BUSY_ICON_FRIENDLY, M, INTERRUPT_ALL, BUSY_ICON_GENERIC))
		to_chat(user, SPAN_WARNING("Your reload was interrupted!"))
		return
	if(off_hand != M.get_inactive_hand())
		to_chat(user, SPAN_WARNING("\the [M] needs to be wielding \the [in_hand] in order to reload!"))
		return
	if(M.dir != user.dir)
		to_chat(user, SPAN_WARNING("You must be standing behind \the [M] in order to reload it!"))
		return
	user.drop_inv_item_on_ground(src)
	qdel(in_hand.current_mag)
	in_hand.replace_ammo(user,src)
	in_hand.current_mag = src
	forceMove(in_hand)
	to_chat(user, SPAN_NOTICE("You load \the [src] into \the [M]'s [in_hand]."))
	if(in_hand.reload_sound)
		playsound(M, in_hand.reload_sound, 25, 1)
	else
		playsound(M,'sound/machines/click.ogg', 25, 1)

	return 1

/obj/item/ammo_magazine/rocket/update_icon()
	if(current_rounds <= 0)
		name = "\improper 84mm spent rocket tube"
		icon_state = "rocket_e"
		desc = "Spent rocket tube for M5 RPG rocket launcher. Activate in hand to disassemble for metal."
		add_to_garbage(src)
	else
		icon_state = initial(icon_state)

/obj/item/ammo_magazine/rocket/custom/update_icon()
	if(current_rounds <= 0)
		return ..()
	if(warhead)
		if(locked)
			if(fuel && fuel.reagents.get_reagent_amount(fuel_type) >= fuel_requirement)
				icon_state = initial(icon_state) +"_locked"
			else
				icon_state = initial(icon_state) +"_no_fuel"
		else if(!locked)
			icon_state = initial(icon_state) +"_unlocked"
	else
		icon_state = initial(icon_state)

/obj/item/ammo_magazine/rocket/ap
	name = "\improper 84mm anti-armor rocket"
	icon_state = "ap_rocket"
	default_ammo = /datum/ammo/rocket/ap
	desc = "A rocket tube loaded with an AP warhead. Capable of piercing heavily armored targets. Deals very little to no splash damage. Inflicts guaranteed stun to most targets. Has high accuracy within 7 meters."

/obj/item/ammo_magazine/rocket/wp
	name = "\improper 84mm white-phosphorus rocket"
	icon_state = "wp_rocket"
	default_ammo = /datum/ammo/rocket/wp
	desc = "Rocket tube loaded with WP warhead. Has two damaging factors. On hit disperses X-Variant Napthal (blue flames) in a 4-meter radius circle, ignoring cover, while simultaneously bursting into highly heated shrapnel that ignites targets within slightly bigger area."

/obj/item/ammo_magazine/rocket/custom
	name = "\improper 84mm custom rocket"
	desc = "An 84mm custom rocket."
	icon_state = "custom_rocket"
	default_ammo = /datum/ammo/rocket/custom
	matter = list("metal" = 7500) //2 sheets
	var/obj/item/explosive/warhead/rocket/warhead
	var/obj/item/reagent_container/glass/fuel
	var/fuel_requirement = 60
	var/fuel_type = "methane"
	var/locked = FALSE

/obj/item/ammo_magazine/rocket/custom/attack_self(mob/user as mob)
	if(!locked && current_rounds)
		if(warhead)
			user.put_in_hands(warhead)
			warhead = null
		else if(fuel)
			user.put_in_hands(fuel)
			fuel = null
		update_icon()
		return
	. = ..()

/obj/item/ammo_magazine/rocket/custom/get_examine_text(mob/user)
	. = ..()
	if(fuel)
		. += SPAN_NOTICE("Contains fuel.")
	if(warhead)
		. += SPAN_NOTICE("Contains a warhead.")

/obj/item/ammo_magazine/rocket/custom/attackby(obj/item/W as obj, mob/user as mob)
	if(!skillcheck(user, SKILL_ENGINEER, SKILL_ENGINEER_TRAINED))
		to_chat(user, SPAN_WARNING("You do not know how to tinker with [name]."))
		return
	if(current_rounds <= 0)
		to_chat(user, SPAN_WARNING("The rocket tube has been used already."))
		return
	if(HAS_TRAIT(W, TRAIT_TOOL_SCREWDRIVER))
		if(!warhead)
			to_chat(user, SPAN_NOTICE("[name] must contain a warhead to do that!"))
			return
		if(locked)
			to_chat(user, SPAN_NOTICE("You unlock [name]."))
		else
			to_chat(user, SPAN_NOTICE("You lock [name]."))
		locked = !locked
		playsound(loc, 'sound/items/Screwdriver.ogg', 25, 0, 6)
	else if(istype(W,/obj/item/reagent_container/glass) && !locked)
		if(fuel)
			to_chat(user, SPAN_DANGER("The [name] already has a fuel container!"))
			return
		else
			user.temp_drop_inv_item(W)
			W.forceMove(src)
			fuel = W
			to_chat(user, SPAN_DANGER("You add [W] to [name]."))
			playsound(loc, 'sound/items/Screwdriver2.ogg', 25, 0, 6)
	else if(istype(W,/obj/item/explosive/warhead/rocket) && !locked)
		if(warhead)
			to_chat(user, SPAN_DANGER("The [name] already has a warhead!"))
			return
		var/obj/item/explosive/warhead/rocket/det = W
		if(det.assembly_stage < ASSEMBLY_LOCKED)
			to_chat(user, SPAN_DANGER("The [W] is not secured!"))
			return
		user.temp_drop_inv_item(W)
		W.forceMove(src)
		warhead = W
		to_chat(user, SPAN_DANGER("You add [W] to [name]."))
		playsound(loc, 'sound/items/Screwdriver2.ogg', 25, 0, 6)
	update_icon()

//-------------------------------------------------------
//M5 RPG'S MEAN FUCKING COUSIN

/obj/item/ammo_magazine/rocket/m57a4
	name = "\improper 84mm thermobaric rocket array"
	desc = "A thermobaric rocket tube for an M57-A4 quad launcher with 4 warheads."
	caliber = "rocket array"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/event.dmi'
	icon_state = "quad_rocket"

	max_rounds = 4
	default_ammo = /datum/ammo/rocket/wp/quad
	gun_type = /obj/item/weapon/gun/launcher/rocket/m57a4
	reload_delay = 200

/obj/item/ammo_magazine/rocket/m57a4/update_icon()
	..()
	if(current_rounds <= 0)
		name = "\improper 84mm spent rocket array"
		desc = "A spent rocket tube assembly for the M57-A4 quad launcher. Activate in hand to disassemble for metal."
		icon_state = "quad_rocket_e"

//-------------------------------------------------------
//Anti-tank rocket

/obj/item/ammo_magazine/rocket/anti_tank
	name = "\improper 84mm Anti-Tank Rocket"
	desc = "An anti-armor rocket specifically modified for penetration of armored vehicle hulls."
	caliber = "rocket"
	icon_state = "at_rocket"

	max_rounds = 1
	default_ammo = /datum/ammo/rocket/ap/anti_tank
	gun_type = /obj/item/weapon/gun/launcher/rocket/anti_tank
	reload_delay = 100


//-------------------------------------------------------
//UPP Rockets

/obj/item/ammo_magazine/rocket/upp
	name = "\improper HJRA-12 High-Explosive Rocket"
	desc = "A rocket for the UPP standard-issue HJRA-12 Handheld Anti-Tank Grenade Launcher. This one is a standard High-Explosive rocket for anti-personal or light-vehicle use."
	caliber = "88mm"
	icon_state = "hjra_explosive"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/upp.dmi'

	max_rounds = 1
	default_ammo = /datum/ammo/rocket
	gun_type = /obj/item/weapon/gun/launcher/rocket/upp
	reload_delay = 85

/obj/item/ammo_magazine/rocket/upp/update_icon()
	if(current_rounds <= 0)
		qdel(src)
	else
		icon_state = initial(icon_state)

/obj/item/ammo_magazine/rocket/upp/at
	name = "\improper HJRA-12 Anti-Tank Rocket"
	desc = "A rocket for the UPP standard-issue HJRA-12 Handheld Anti-Tank Grenade Launcher. This one is a standard Anti-Tank rocket designed to disable or destroy hostile vehicles."
	caliber = "88mm"
	icon_state = "hjra_tank"

	max_rounds = 1
	default_ammo = /datum/ammo/rocket/ap/anti_tank
	gun_type = /obj/item/weapon/gun/launcher/rocket/upp
	reload_delay = 85

/obj/item/ammo_magazine/rocket/upp/incen
	name = "\improper HJRA-12 Extreme-Intensity Incendiary Rocket"
	desc = "A rocket for the UPP standard-issue HJRA-12 Handheld Anti-Tank Grenade Launcher. This one is an extreme-intensity incendiary rocket, using an experimental chemical designated R-189 by the UPP, it is designed to melt through fortified positions and bunkers but is most commonly used in an anti-personnal role due to over-issuing and the tempatures after use in its intended role leaving the tempature of the air incompatible with human life."
	caliber = "88mm"
	icon_state = "hjra_incen"

	max_rounds = 1
	default_ammo = /datum/ammo/rocket/wp/upp
	gun_type = /obj/item/weapon/gun/launcher/rocket/upp
	reload_delay = 85

//-------------------------------------------------------
//AA Missiles

/obj/item/ammo_magazine/rocket/anti_air
	name = "\improper 70mm 'Hornet' hypervelocity anti-air missile"
	desc = "A thin missile designed to be fired by M579 ADS-C vehicles or launched from the SIM-118 MANPAD. A no-frills hypervelocity missile, the hornet relies on the kinetic energy it imparts on impact to take down targets."
	caliber = "missile"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/uscm.dmi'
	icon_state = "hornet"
	default_ammo = /datum/ammo/rocket/ap/anti_air
	gun_type = /obj/item/weapon/gun/launcher/rocket/anti_air/uscm

/obj/item/ammo_magazine/rocket/anti_air/update_icon()
	if(current_rounds <= 0)
		qdel(src)
	else
		icon_state = initial(icon_state)

/obj/item/ammo_magazine/rocket/anti_air/upp
	name = "\improper 92mm 'Goose' anti-air missile canister"
	desc = "A squat missile canister for the EMBLR surface-to-air weapons system. Unlike it's USCM counterpart, the Goose carries a small but powerful warhead designed to spread a cloud of flechettes around it's target."
	caliber = "missile"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/upp.dmi'
	icon_state = "emblr"
	default_ammo = /datum/ammo/rocket/anti_air
	gun_type = /obj/item/weapon/gun/launcher/rocket/anti_air/upp

/obj/item/ammo_magazine/rocket/anti_air/upp/update_icon()
	..()
	if(current_rounds <= 0)
		name = "\improper spent 92mm missile canister"
		desc = "A spent canister assembly for the EMBLR anti-air missile launcher."
		icon_state = "emblr_e"

//-------------------------------------------------------
// XM99 power/fuel cells

/obj/item/ammo_magazine/plasma
	name = "\improper XM99A1 battery drum"
	desc = "A hybrid battery cell and CdTe-pellet magazine designed to fit the XM99A series of phased plasma pulse rifles. Do not puncture or put in a microwave."
	caliber = "40W"
	icon_state = "xm99a_cell"
	w_class = SIZE_MEDIUM
	flags_magazine = NO_FLAGS //It's a battery, can't yank bullets or shells outa this
	max_rounds = 4
	default_ammo = /datum/ammo/energy/plasma
	gun_type = /obj/item/weapon/gun/XM99

// The "round-remover" power/fuel cell for the XM99
/obj/item/ammo_magazine/plasma/gibber
	name = "\improper XM99A1 lithium battery drum"
	desc = "A hybrid battery cell and LiTe-pellet magazine designed to fit the XM99A series of phased plasma pulse rifles. Do not puncture, put in a microwave, submerge in water or look at funny. Highly volatile."
	icon_state = "xm99a_lcell"
	max_rounds = 2
	default_ammo = /datum/ammo/energy/plasma/heavy

//-------------------------------------------------------
//P9 SHARP Rifle

/obj/item/ammo_magazine/rifle/sharp
	name = "sharp rifle magazine"
	icon_state = "sharprifle"
	item_state = "sharprifle"

	w_class = SIZE_MEDIUM
	max_rounds = 10
	default_ammo = /datum/ammo/rifle/sharp/explosive
	gun_type = /obj/item/weapon/gun/rifle/sharp
	flags_magazine = NO_FLAGS

	description_ammo = "darts"

/obj/item/ammo_magazine/rifle/sharp/explosive
	name = "\improper 9X-E sticky explosive dart magazine"
	desc = "A specialized sticky explosive dart magazine."

/obj/item/ammo_magazine/rifle/sharp/track
	name = "\improper 9X-T sticky tracking dart magazine"
	desc = "A specialized tracking dart magazine."
	icon_state = "sharprifle_tracker"
	default_ammo = /datum/ammo/rifle/sharp/track

/obj/item/ammo_magazine/rifle/sharp/track/infinite
	default_ammo = /datum/ammo/rifle/sharp/track/infinite

/obj/item/ammo_magazine/rifle/sharp/flechette
	name = "\improper 9X-F flechette dart magazine"
	desc = "A specialized flechette dart magazine."
	icon_state = "sharprifle_flechette"
	default_ammo = /datum/ammo/rifle/sharp/flechette
