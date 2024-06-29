/obj/structure/machinery/power/geothermal
	name = "\improper G-11 geothermal generator"
	icon = 'icons/obj/structures/machinery/geothermal.dmi'
	icon_state = "weld"
	desc = "A thermoelectric generator sitting atop a plasma-filled borehole. This one is heavily damaged. Use a blowtorch, wirecutters, then wrench to repair it."
	anchored = TRUE
	density = TRUE
	directwired = 0  //Requires a cable directly underneath
	unslashable = TRUE
	unacidable = TRUE   //NOPE.jpg
	var/power_gen_percent = 0 //100,000W at full capacity
	var/power_generation_max = 100000 //Full capacity
	var/powernet_connection_failed = 0 //Logic checking for powernets
	var/buildstate = 1 //What state of building it are we on, 0-3, 1 is "broken", the default
	var/fail_rate = 10 //% chance of failure each fail_tick check
	var/fail_check_ticks = 100 //Check for failure every this many ticks
	var/cur_tick = 0 //Tick updater
	power_machine = TRUE

//We don't want to cut/update the power overlays every single proc. Just when it actually changes. This should save on CPU cycles. Efficiency!
/obj/structure/machinery/power/geothermal/update_icon()
	..()
	if(!buildstate && is_on)
		desc = "A thermoelectric generator sitting atop a borehole dug deep in the planet's surface. It generates energy by boiling the plasma steam that rises from the well.\nIt is old technology and has a large failure rate, and must be repaired frequently.\nIt is currently on, and beeping randomly amid faint hisses of steam."
		switch(power_gen_percent)
			if(25) icon_state = "on[power_gen_percent]"
			if(50) icon_state = "on[power_gen_percent]"
			if(75) icon_state = "on[power_gen_percent]"
			if(100) icon_state = "on[power_gen_percent]"


	else if (!buildstate && !is_on)
		icon_state = "off"
		desc = "A thermoelectric generator sitting atop a borehole dug deep in the planet's surface. It generates energy by boiling the plasma steam that rises from the well.\nIt is old technology and has a large failure rate, and must be repaired frequently.\nIt is currently turned off and silent."
	else
		if(buildstate == 1)
			icon_state = "weld"
			desc = "A thermoelectric generator sitting atop a plasma-filled borehole. This one is heavily damaged. Use a blowtorch, wirecutters, then wrench to repair it."
		else if(buildstate == 2)
			icon_state = "wire"
			desc = "A thermoelectric generator sitting atop a plasma-filled borehole. This one is damaged. Use a wirecutters, then wrench to repair it."
		else
			icon_state = "wrench"
			desc = "A thermoelectric generator sitting atop a plasma-filled borehole. This one is lightly damaged. Use a wrench to repair it."

/obj/structure/machinery/power/geothermal/Initialize(mapload, ...)
	. = ..()
	if(!connect_to_network()) //Should start with a cable piece underneath, if it doesn't, something's messed up in mapping
		powernet_connection_failed = 1

/obj/structure/machinery/power/geothermal/power_change()
	return

/obj/structure/machinery/power/geothermal/process()
	if(!is_on || buildstate || !anchored) //Default logic checking
		return 0

	if(!powernet && !powernet_connection_failed) //Powernet checking, make sure there's valid cables & powernets
		if(!connect_to_network())
			powernet_connection_failed = 1 //God damn it, where'd our network go
			is_on = 0
			stop_processing()
			// Error! Check again in 15 seconds. Someone could have blown/acided or snipped a cable
			addtimer(VARSET_CALLBACK(src, powernet_connection_failed, FALSE), 15 SECONDS)
	else if(powernet) //All good! Let's fire it up!
		if(!check_failure()) //Wait! Check to see if it breaks during processing
			update_icon()
			if(power_gen_percent < 100) power_gen_percent++
			switch(power_gen_percent)
				if(10) visible_message("[icon2html(src, viewers(src))] [SPAN_NOTICE("<b>[src]</b> begins to whirr as it powers up.")]")
				if(50) visible_message("[icon2html(src, viewers(src))] [SPAN_NOTICE("<b>[src]</b> begins to hum loudly as it reaches half capacity.")]")
				if(99) visible_message("[icon2html(src, viewers(src))] [SPAN_NOTICE("<b>[src]</b> rumbles loudly as the combustion and thermal chambers reach full strength.")]")
			add_avail(power_generation_max * (power_gen_percent / 100) ) //Nope, all good, just add the power

/obj/structure/machinery/power/geothermal/proc/check_failure()
	cur_tick++
	if(cur_tick < fail_check_ticks) //Nope, not time for it yet
		return 0
	else if(cur_tick > fail_check_ticks) //Went past with no fail, reset the timer
		cur_tick = 0
	if(rand(1,100) < fail_rate) //Oh snap, we failed! Shut it down!
		if(rand(0,3) == 0)
			visible_message("[icon2html(src, viewers(src))] [SPAN_NOTICE("<b>[src]</b> beeps wildly and a fuse blows! Use wirecutters, then a wrench to repair it.")]")
			buildstate = 2
			icon_state = "wire"
		else
			visible_message("[icon2html(src, viewers(src))] [SPAN_NOTICE("<b>[src]</b> beeps wildly and sprays random pieces everywhere! Use a wrench to repair it.")]")
			buildstate = 3
			icon_state = "wrench"
		is_on = 0
		power_gen_percent = 0
		update_icon()
		cur_tick = 0
		stop_processing()
		return 1
	return 0 //Nope, all fine

/obj/structure/machinery/power/geothermal/attack_hand(mob/user as mob)
	if(!anchored) return 0 //Shouldn't actually be possible
	if(user.is_mob_incapacitated()) return 0
	if(!ishuman(user))
		to_chat(user, SPAN_DANGER("You have no idea how to use that.")) //No xenos or mankeys
		return 0

	add_fingerprint(user)

	if(!skillcheck(user, SKILL_ENGINEER, SKILL_ENGINEER_ENGI))
		to_chat(user, SPAN_WARNING("You have no clue how this thing works..."))
		return 0

	if(buildstate == 1)
		to_chat(usr, SPAN_INFO("Use a blowtorch, then wirecutters, then wrench to repair it."))
		return 0
	else if (buildstate == 2)
		to_chat(usr, SPAN_INFO("Use a wirecutters, then wrench to repair it."))
		return 0
	else if (buildstate == 3)
		to_chat(usr, SPAN_INFO("Use a wrench to repair it."))
		return 0
	if(is_on)
		visible_message("[icon2html(src, viewers(src))] [SPAN_WARNING("<b>[src]</b> beeps softly and the humming stops as [usr] shuts off the turbines.")]")
		is_on = 0
		power_gen_percent = 0
		cur_tick = 0
		icon_state = "off"
		stop_processing()
		return 1
	visible_message("[icon2html(src, viewers(src))] [SPAN_WARNING("<b>[src]</b> beeps loudly as [usr] turns on the turbines and the generator begins spinning up.")]")
	icon_state = "on10"
	is_on = 1
	cur_tick = 0
	start_processing()
	return 1

/obj/structure/machinery/power/geothermal/attackby(obj/item/O as obj, mob/user as mob)
	if(iswelder(O))
		if(!HAS_TRAIT(O, TRAIT_TOOL_BLOWTORCH))
			to_chat(user, SPAN_WARNING("You need a stronger blowtorch!"))
			return
		if(buildstate == 1 && !is_on)
			if(!skillcheck(user, SKILL_ENGINEER, SKILL_ENGINEER_ENGI))
				to_chat(user, SPAN_WARNING("You have no clue how to repair this thing."))
				return 0
			var/obj/item/tool/weldingtool/WT = O
			if(WT.remove_fuel(1, user))

				playsound(loc, 'sound/items/weldingtool_weld.ogg', 25)
				user.visible_message(SPAN_NOTICE("[user] starts welding [src]'s internal damage."),
				SPAN_NOTICE("You start welding [src]'s internal damage."))
				if(do_after(user, 200 * user.get_skill_duration_multiplier(SKILL_ENGINEER), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
					if(buildstate != 1 || is_on || !WT.isOn())
						return FALSE
					playsound(loc, 'sound/items/Welder2.ogg', 25, 1)
					buildstate = 2
					user.visible_message(SPAN_NOTICE("[user] welds [src]'s internal damage."),
					SPAN_NOTICE("You weld [src]'s internal damage."))
					update_icon()
					return TRUE
			else
				to_chat(user, SPAN_WARNING("You need more welding fuel to complete this task."))
				return
	else if(HAS_TRAIT(O, TRAIT_TOOL_WIRECUTTERS))
		if(buildstate == 2 && !is_on)
			if(!skillcheck(user, SKILL_ENGINEER, SKILL_ENGINEER_ENGI))
				to_chat(user, SPAN_WARNING("You have no clue how to repair this thing."))
				return 0
			playsound(loc, 'sound/items/Wirecutter.ogg', 25, 1)
			user.visible_message(SPAN_NOTICE("[user] starts securing [src]'s wiring."),
			SPAN_NOTICE("You start securing [src]'s wiring."))
			if(do_after(user, 120 * user.get_skill_duration_multiplier(SKILL_ENGINEER), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD, numticks = 12))
				if(buildstate != 2 || is_on)
					return FALSE
				playsound(loc, 'sound/items/Wirecutter.ogg', 25, 1)
				buildstate = 3
				user.visible_message(SPAN_NOTICE("[user] secures [src]'s wiring."),
				SPAN_NOTICE("You secure [src]'s wiring."))
				update_icon()
				return TRUE
	else if(HAS_TRAIT(O, TRAIT_TOOL_WRENCH))
		if(buildstate == 3 && !is_on)
			if(!skillcheck(user, SKILL_ENGINEER, SKILL_ENGINEER_ENGI))
				to_chat(user, SPAN_WARNING("You have no clue how to repair this thing."))
				return 0
			playsound(loc, 'sound/items/Ratchet.ogg', 25, 1)
			user.visible_message(SPAN_NOTICE("[user] starts repairing [src]'s tubing and plating."),
			SPAN_NOTICE("You start repairing [src]'s tubing and plating."))
			if(do_after(user, 150 * user.get_skill_duration_multiplier(SKILL_ENGINEER), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
				if(buildstate != 3 || is_on)
					return FALSE
				playsound(loc, 'sound/items/Ratchet.ogg', 25, 1)
				buildstate = 0
				user.count_niche_stat(STATISTICS_NICHE_REPAIR_GENERATOR)
				user.visible_message(SPAN_NOTICE("[user] repairs [src]'s tubing and plating."),
				SPAN_NOTICE("You repair [src]'s tubing and plating."))
				update_icon()
				return TRUE
	else
		return ..() //Deal with everything else, like hitting with stuff

/obj/structure/machinery/power/geothermal/ex_act(severity, direction)
	return FALSE //gameplay-wise these should really never go away

//Putting these here since it's power-related
GLOBAL_LIST_INIT(all_breaker_switches, list())

/obj/structure/machinery/colony_floodlight_switch // TODO: Repath to just breaker_switch
	name = "colony floodlight switch"
	icon = 'icons/obj/structures/machinery/power.dmi'
	icon_state = "panelnopower"
	desc = "This switch controls the floodlights surrounding the archaeology complex. It only functions when there is power."
	density = FALSE
	anchored = TRUE
	use_power = USE_POWER_IDLE
	unslashable = TRUE
	unacidable = TRUE
	power_machine = TRUE
	idle_power_usage = 0
	is_on = FALSE
	var/ispowered = FALSE
	///All machinery under our control
	var/list/machinery_list = list()
	///The types of machinery we control (define this)
	var/list/machinery_type_whitelist = list(/obj/structure/machinery/colony_floodlight)
	///The types of machinery we don't control (generated automatically)
	var/list/machinery_type_blacklist = list()

/obj/structure/machinery/colony_floodlight_switch/Initialize(mapload, ...)
	. = ..()
	for(var/obj/structure/machinery/colony_floodlight_switch/other_switch as anything in GLOB.all_breaker_switches)
		// blacklist anything other switches whitelist if theres subtype overlap
		for(var/other_whitelisted in other_switch.machinery_type_whitelist)
			if(is_path_in_list(other_whitelisted, machinery_type_whitelist))
				machinery_type_blacklist |= other_whitelisted
		for(var/our_whitelisted in machinery_type_whitelist)
			if(is_path_in_list(our_whitelisted, other_switch.machinery_type_whitelist))
				other_switch.machinery_type_blacklist |= our_whitelisted

	GLOB.all_breaker_switches += src
	return INITIALIZE_HINT_LATELOAD

/obj/structure/machinery/colony_floodlight_switch/LateInitialize()
	. = ..()
	if(length(machinery_type_whitelist))
		for(var/obj/structure/machinery/machine as anything in machines)
			if(machine.breaker_switch != null)
				continue
			if(!is_type_in_list(machine, machinery_type_whitelist))
				continue
			if(is_type_in_list(machine, machinery_type_blacklist))
				continue
			machinery_list += machine
			machine.breaker_switch = src
	start_processing()

/obj/structure/machinery/colony_floodlight_switch/Destroy()
	for(var/obj/structure/machinery/machine as anything in machinery_list)
		if(machine.breaker_switch == src)
			machine.breaker_switch = null
	machinery_list = null
	GLOB.all_breaker_switches -= src
	return ..()

/obj/structure/machinery/colony_floodlight_switch/update_icon()
	if(!ispowered)
		icon_state = "panelnopower"
	else if(is_on)
		icon_state = "panelon"
	else
		icon_state = "paneloff"

/obj/structure/machinery/colony_floodlight_switch/process()
	var/machinepower = calculate_current_power_usage()
	for(var/obj/structure/machinery/machine as anything in machinery_list)
		if(!machine.is_on)
			continue
		machinepower += machine.active_power_usage
	use_power(machinepower)

/obj/structure/machinery/colony_floodlight_switch/power_change()
	..()
	if((stat & NOPOWER))
		if(ispowered && is_on)
			toggle_machines()
		ispowered = FALSE
		set_is_on(FALSE)
	else
		ispowered = TRUE
		update_icon()

/obj/structure/machinery/colony_floodlight_switch/proc/toggle_machines()
	for(var/obj/structure/machinery/machine as anything in machinery_list)
		addtimer(CALLBACK(machine, TYPE_PROC_REF(/obj/structure/machinery, toggle_is_on)), rand(0, 5 SECONDS))

/obj/structure/machinery/colony_floodlight_switch/attack_hand(mob/user as mob)
	if(!ishuman(user))
		to_chat(user, "Nice try.")
		return FALSE
	if(!ispowered)
		to_chat(user, "Nothing happens.")
		return FALSE
	playsound(src,'sound/items/Deconstruct.ogg', 30, 1)
	use_power(5)
	toggle_is_on()
	toggle_machines()
	return TRUE


#define FLOODLIGHT_REPAIR_UNSCREW 0
#define FLOODLIGHT_REPAIR_CROWBAR 1
#define FLOODLIGHT_REPAIR_WELD 2
#define FLOODLIGHT_REPAIR_CABLE 3
#define FLOODLIGHT_REPAIR_SCREW 4

/obj/structure/machinery/colony_floodlight
	name = "colony floodlight"
	icon = 'icons/obj/structures/machinery/big_floodlight.dmi'
	icon_state = "flood_s_off"
	density = TRUE
	anchored = TRUE
	layer = ABOVE_XENO_LAYER
	unslashable = TRUE
	unacidable = TRUE
	use_power = USE_POWER_NONE //It's the switch that uses the actual power, not the lights
	needs_power = FALSE
	is_on = FALSE //Whether the floodlight is switched to on or off. Does not necessarily mean it emits light.
	health = 150
	active_power_usage = 50 //The power each floodlight takes up per process
	///Whether it has been smashed by xenos
	var/damaged = FALSE
	var/lum_value = 7
	var/repair_state = FLOODLIGHT_REPAIR_UNSCREW

/obj/structure/machinery/colony_floodlight/update_icon()
	if(damaged)
		icon_state = "flood_s_dmg"
	else if(is_on)
		icon_state = "flood_s_on"
	else
		icon_state = "flood_s_off"

/obj/structure/machinery/colony_floodlight/attackby(obj/item/I, mob/user)
	if(damaged)
		if(HAS_TRAIT(I, TRAIT_TOOL_SCREWDRIVER))
			if(!skillcheck(user, SKILL_ENGINEER, SKILL_ENGINEER_ENGI))
				to_chat(user, SPAN_WARNING("You have no clue how to repair [src]."))
				return FALSE

			if(repair_state == FLOODLIGHT_REPAIR_UNSCREW)
				playsound(loc, 'sound/items/Screwdriver.ogg', 25, 1)
				user.visible_message(SPAN_NOTICE("[user] starts unscrewing [src]'s maintenance hatch."), \
				SPAN_NOTICE("You start unscrewing [src]'s maintenance hatch."))
				if(do_after(user, 2 SECONDS, INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
					if(QDELETED(src) || repair_state != FLOODLIGHT_REPAIR_UNSCREW)
						return
					playsound(loc, 'sound/items/Screwdriver.ogg', 25, 1)
					repair_state = FLOODLIGHT_REPAIR_CROWBAR
					user.visible_message(SPAN_NOTICE("[user] unscrews [src]'s maintenance hatch."), \
					SPAN_NOTICE("You unscrew [src]'s maintenance hatch."))

			else if(repair_state == FLOODLIGHT_REPAIR_SCREW)
				playsound(loc, 'sound/items/Screwdriver.ogg', 25, 1)
				user.visible_message(SPAN_NOTICE("[user] starts screwing [src]'s maintenance hatch closed."), \
				SPAN_NOTICE("You start screwing [src]'s maintenance hatch closed."))
				if(do_after(user, 2 SECONDS, INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
					if(QDELETED(src) || repair_state != FLOODLIGHT_REPAIR_SCREW)
						return
					playsound(loc, 'sound/items/Screwdriver.ogg', 25, 1)
					damaged = FALSE
					repair_state = FLOODLIGHT_REPAIR_UNSCREW
					health = initial(health)
					user.visible_message(SPAN_NOTICE("[user] screws [src]'s maintenance hatch closed."), \
					SPAN_NOTICE("You screw [src]'s maintenance hatch closed."))
					if(is_on)
						set_light(lum_value)
					update_icon()
			return TRUE

		else if(HAS_TRAIT(I, TRAIT_TOOL_CROWBAR))
			if(!skillcheck(user, SKILL_ENGINEER, SKILL_ENGINEER_ENGI))
				to_chat(user, SPAN_WARNING("You have no clue how to repair [src]."))
				return FALSE

			if(repair_state == FLOODLIGHT_REPAIR_CROWBAR)
				playsound(loc, 'sound/items/Crowbar.ogg', 25, 1)
				user.visible_message(SPAN_NOTICE("[user] starts prying [src]'s damaged lighting assembly out."),\
				SPAN_NOTICE("You start prying [src]'s damaged lighting assembly out."))
				if(do_after(user, 2 SECONDS, INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
					if(QDELETED(src) || repair_state != FLOODLIGHT_REPAIR_CROWBAR)
						return
					playsound(loc, 'sound/items/Crowbar.ogg', 25, 1)
					repair_state = FLOODLIGHT_REPAIR_WELD
					user.visible_message(SPAN_NOTICE("[user] pries [src]'s damaged lighting assembly out."),\
					SPAN_NOTICE("You pry [src]'s damaged lighting assembly out."))
			return TRUE

		else if(iswelder(I))
			if(!HAS_TRAIT(I, TRAIT_TOOL_BLOWTORCH))
				to_chat(user, SPAN_WARNING("You need a stronger blowtorch!"))
				return
			var/obj/item/tool/weldingtool/welder = I

			if(!skillcheck(user, SKILL_ENGINEER, SKILL_ENGINEER_ENGI))
				to_chat(user, SPAN_WARNING("You have no clue how to repair [src]."))
				return FALSE

			if(repair_state == FLOODLIGHT_REPAIR_WELD)
				if(welder.remove_fuel(1, user))
					playsound(loc, 'sound/items/weldingtool_weld.ogg', 25)
					user.visible_message(SPAN_NOTICE("[user] starts welding [src]'s damage."),
					SPAN_NOTICE("You start welding [src]'s damage."))
					if(do_after(user, 4 SECONDS, INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
						if(QDELETED(src) || !welder.isOn() || repair_state != FLOODLIGHT_REPAIR_WELD)
							return
						playsound(loc, 'sound/items/Welder2.ogg', 25, 1)
						repair_state = FLOODLIGHT_REPAIR_CABLE
						user.visible_message(SPAN_NOTICE("[user] welds [src]'s damage."),
						SPAN_NOTICE("You weld [src]'s damage."))
						return TRUE
				else
					to_chat(user, SPAN_WARNING("You need more welding fuel to complete this task."))
			return TRUE

		else if(iscoil(I))
			var/obj/item/stack/cable_coil/coil = I
			if(!skillcheck(user, SKILL_ENGINEER, SKILL_ENGINEER_ENGI))
				to_chat(user, SPAN_WARNING("You have no clue how to repair [src]."))
				return FALSE

			if(repair_state == FLOODLIGHT_REPAIR_CABLE)
				if(coil.get_amount() < 2)
					to_chat(user, SPAN_WARNING("You need two coils of wire to replace the damaged cables."))
					return
				playsound(loc, 'sound/items/Deconstruct.ogg', 25, 1)
				user.visible_message(SPAN_NOTICE("[user] starts replacing [src]'s damaged cables."),\
				SPAN_NOTICE("You start replacing [src]'s damaged cables."))
				if(do_after(user, 2 SECONDS, INTERRUPT_ALL, BUSY_ICON_GENERIC))
					if(QDELETED(src) || repair_state != FLOODLIGHT_REPAIR_CABLE)
						return
					if(coil.use(2))
						playsound(loc, 'sound/items/Deconstruct.ogg', 25, 1)
						repair_state = FLOODLIGHT_REPAIR_SCREW
						user.visible_message(SPAN_NOTICE("[user] replaces [src]'s damaged cables."),\
						SPAN_NOTICE("You replace [src]'s damaged cables."))
			return TRUE

		else if(istype(I, /obj/item/device/lightreplacer))
			if(!skillcheck(user, SKILL_ENGINEER, SKILL_ENGINEER_ENGI))
				to_chat(user, SPAN_WARNING("You have no clue how to repair [src]."))
				return FALSE

			if(repair_state == FLOODLIGHT_REPAIR_UNSCREW)
				to_chat(user, SPAN_WARNING("You need to unscrew [src]'s maintenance hatch."))
				return FALSE
			if(repair_state == FLOODLIGHT_REPAIR_SCREW)
				to_chat(user, SPAN_WARNING("You need to screw [src]'s maintenance hatch."))
				return FALSE

			var/obj/item/device/lightreplacer/replacer = I
			if(!replacer.CanUse(user))
				to_chat(user, replacer.failmsg)
				return FALSE
			playsound(loc, 'sound/items/Crowbar.ogg', 25, 1)
			user.visible_message(SPAN_NOTICE("[user] starts replacing [src]'s damaged lighting assembly."),\
			SPAN_NOTICE("You start replacing [src]'s damaged lighting assembly."))
			if(do_after(user, 2 SECONDS, INTERRUPT_ALL, BUSY_ICON_GENERIC))
				if(QDELETED(src) || repair_state == FLOODLIGHT_REPAIR_SCREW)
					return
				replacer.Use(user)
				repair_state = FLOODLIGHT_REPAIR_SCREW
				user.visible_message(SPAN_NOTICE("[user] replaces [src]'s damaged lighting assembly."),\
				SPAN_NOTICE("You replace [src]'s damaged lighting assembly."))
			return TRUE

	return ..()

/obj/structure/machinery/colony_floodlight/attack_hand(mob/user)
	if(ishuman(user))
		if(damaged)
			to_chat(user, SPAN_WARNING("[src] is damaged."))
		else if(!is_on)
			to_chat(user, SPAN_WARNING("Nothing happens. Looks like it's powered elsewhere."))
		return FALSE
	return ..()

/obj/structure/machinery/colony_floodlight/get_examine_text(mob/user)
	. = ..()
	if(ishuman(user))
		if(damaged)
			. += SPAN_WARNING("It is damaged.")
			if(skillcheck(user, SKILL_ENGINEER, SKILL_ENGINEER_ENGI))
				switch(repair_state)
					if(FLOODLIGHT_REPAIR_UNSCREW) . += SPAN_INFO("You must first unscrew its maintenance hatch.")
					if(FLOODLIGHT_REPAIR_CROWBAR) . += SPAN_INFO("You must crowbar its lighting assembly out or use a light replacer.")
					if(FLOODLIGHT_REPAIR_WELD) . += SPAN_INFO("You must weld the damage to it.")
					if(FLOODLIGHT_REPAIR_CABLE) . += SPAN_INFO("You must replace its damaged cables.")
					if(FLOODLIGHT_REPAIR_SCREW) . += SPAN_INFO("You must screw its maintenance hatch closed.")
		else if(!is_on)
			. += SPAN_INFO("It doesn't seem powered.")

/obj/structure/machinery/colony_floodlight/ex_act(severity)
	switch(severity)
		if(0 to EXPLOSION_THRESHOLD_LOW)
			if(prob(25))
				set_damaged()
				return
		if(EXPLOSION_THRESHOLD_LOW to EXPLOSION_THRESHOLD_MEDIUM)
			if(prob(50))
				set_damaged()
				return
		if(EXPLOSION_THRESHOLD_MEDIUM to INFINITY)
			set_damaged()
			return

/obj/structure/machinery/colony_floodlight/proc/set_damaged()
	playsound(src, "glassbreak", 70, 1)
	damaged = TRUE
	if(is_on)
		set_light(0)
	update_icon()

/obj/structure/machinery/colony_floodlight/toggle_is_on()
	. = ..()
	if(!damaged)
		set_light(is_on ? lum_value : 0)
	return .

#undef FLOODLIGHT_REPAIR_UNSCREW
#undef FLOODLIGHT_REPAIR_CROWBAR
#undef FLOODLIGHT_REPAIR_WELD
#undef FLOODLIGHT_REPAIR_CABLE
#undef FLOODLIGHT_REPAIR_SCREW
