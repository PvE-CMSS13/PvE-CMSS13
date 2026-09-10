//Refer to life.dm for caller

/mob/living/carbon/human/proc/breathe()

	//NOTE: Breathing happens once per FOUR TICKS, unless the last breath fails. In which case it happens once per ONE TICK! So oxyloss healing is done once per 4 ticks while oxyloss damage is applied once per tick!

	if(reagents.has_reagent("lexorin"))
		return
	if(istype(loc, /obj/structure/machinery/cryo_cell))
		return
	if(species && (species.flags & (NO_BREATHE|IS_SYNTHETIC)))
		return

	var/list/air_info

	/*if(istype(loc, /atom/movable))
		var/atom/movable/container = loc
		container.handle_internal_lifeform(src)*/

	//First, check for air from internal atmosphere (using an air tank and mask generally)
	air_info = get_breath_from_internal()

	//No breath from internal atmosphere so get breath from location
	if(!air_info)
		var/turf/T = get_turf(loc)
		if((get_ai_brain() && GLOB.human_ai_breathe_space) || GLOB.all_human_breathe_space)
			//list(gas_type, temperature, moles, proportion_is_oxygen, pressure)
			air_info = list("air", T20C, 0.1, O2STANDARD, ONE_ATMOSPHERE)
		else
			air_info = T.return_air()

		//Handle filtering
		var/block = 0
		if(wear_mask)
			if(wear_mask.flags_inventory & BLOCKGASEFFECT)
				block = 1
		if(glasses)
			if(glasses.flags_inventory & BLOCKGASEFFECT)
				block = 1
		if(head)
			if(head.flags_inventory & BLOCKGASEFFECT)
				block = 1

		if(!block)
			for(var/obj/effect/particle_effect/smoke/chem/smoke in view(1, src))
				if(smoke.reagents.total_volume)
					smoke.reagents.reaction(src, INGEST)
					smoke.reagents.copy_to(src, 10) //I dunno, maybe the reagents enter the blood stream through the lungs?
					break //If they breathe in the nasty stuff once, no need to continue checking
	handle_breath(air_info)

#define OXYGEN_SLOW_ALARM_PERCENT 0.15

#define BASE_FREQ_SOUND 44100
#define MAX_DEVIATION_FREQ 22000

/mob/living/carbon/human/proc/get_breath_from_internal()
	if(internal)
		if(istype(buckled,/obj/structure/machinery/optable))
			var/obj/structure/machinery/optable/O = buckled
			if(O.anes_tank)
				return O.anes_tank.return_air()
			return null
		if(get_dist(internal.loc, loc) > 1)
			eva_oxygen_beeping(force_off = TRUE)
			internal = null
			playsound(src, 'sound/effects/internals_close.ogg', 60, TRUE)
		if(!(check_for_oxygen_mask()))
			eva_oxygen_beeping(force_off = TRUE)
			internal = null
			playsound(src, 'sound/effects/internals_close.ogg', 60, TRUE)
		if(internal)
			eva_oxygen_beeping()
			return internal.take_air()
	return null

/mob/living/carbon/human/proc/eva_oxygen_beeping(force_off = FALSE)
	if(locate(/obj/item/clothing/head/helmet/space) in contents)
		var/obj/item/clothing/head/helmet/space/beeper = locate(/obj/item/clothing/head/helmet/space) in contents
		if(force_off)
			beeper.beep_loop.stop()
			return
		if(internal.pressure < internal.pressure_full*OXYGEN_SLOW_ALARM_PERCENT)
			var scale = 1 - (internal.pressure / internal.pressure_full)
			var deviation = (scale ** 3) * MAX_DEVIATION_FREQ
			beeper.beep_loop.vary =	BASE_FREQ_SOUND + deviation
			beeper.beep_loop.start()
		else
			beeper.beep_loop.stop()
	else if (locate(/obj/item/clothing/head/helmet/marine/pressure) in contents)
		var/obj/item/clothing/head/helmet/marine/pressure/beeper = locate(/obj/item/clothing/head/helmet/marine/pressure) in contents
		if(force_off)
			beeper.beep_loop.stop()
			return
		if(internal.pressure < internal.pressure_full*OXYGEN_SLOW_ALARM_PERCENT)
			var scale = 1 - (internal.pressure / internal.pressure_full)
			var deviation = (scale ** 3) * MAX_DEVIATION_FREQ
			beeper.beep_loop.vary =	BASE_FREQ_SOUND + deviation
			beeper.beep_loop.start()
		else
			beeper.beep_loop.stop()


/// Easier than programming AI to setup their internals
GLOBAL_VAR_INIT(human_ai_breathe_space, TRUE)
/client/proc/toggle_human_ai_breathe_space()
	set name = "Toggle Human AI Need Air"
	set category = "Game Master.HumanAI"

	if(!admin_holder || !check_rights(R_MOD, FALSE))
		return

	GLOB.human_ai_breathe_space = !GLOB.human_ai_breathe_space
	message_admins("[src] has [GLOB.human_ai_breathe_space ? "enabled" : "disabled"] Human AI being damaged by lacking oxygen internals in space.")

/// Easier than programming AI to setup their internals
GLOBAL_VAR_INIT(all_human_breathe_space, FALSE)
/client/proc/toggle_all_human_breathe_space()
	set name = "Toggle Atmosphere Always Good"
	set category = "Admin.Flags"

	if(!admin_holder || !check_rights(R_MOD, FALSE))
		return

	GLOB.all_human_breathe_space = !GLOB.all_human_breathe_space
	message_admins("[src] has [GLOB.all_human_breathe_space ? "enabled" : "disabled"] ALL Humans will now ignore the cold and lack of air in space.")

//list(gas_type, temperature, moles, proportion_is_oxygen, pressure)
/mob/living/carbon/human/proc/handle_breath(list/air_info)
	oxygen_alert = 0 // so unless no air info is returned (which happens only when gasping or lack of atmosphere) it'll always be 0
	if(status_flags & GODMODE)
		return
	var/oxygen_pressure = air_info[3]*air_info[4]
	var/breath_fail_ratio
	var/safe_pressure_min = species.breath_pressure
	var/datum/internal_organ/lungs =  internal_organs_by_name["lungs"]
	// Lung damage increases the minimum safe pressure.
	if(!(chem_effect_flags & CHEM_EFFECT_ORGAN_STASIS))
		safe_pressure_min *= 1 + rand(1,5) * (min(3,lungs.damage/lungs.min_broken_damage) * (reagents.has_reagent("inaprovaline") ? 0.33 : 1))
	var/inhale_efficiency
	if(air_info[3] == 0 || air_info[5] == 0) //stop divide by zero runtime
		inhale_efficiency = 0
	else
		inhale_efficiency = ((oxygen_pressure/air_info[3])*air_info[5])/safe_pressure_min
	// Not enough to breathe
	if(inhale_efficiency < 1)
		breath_fail_ratio = 1 - inhale_efficiency //handle_regular_hud_updates.dm
		oxygen_alert = breath_fail_ratio
		if(inhale_efficiency < 0.8)
			if(prob(30*breath_fail_ratio))
				emote("gasp")
			if(prob(20))
				to_chat(src, SPAN_WARNING("It's hard to breathe..."))
	else
		breath_fail_ratio = 0
	apply_damage(round(HUMAN_MAX_OXYLOSS*breath_fail_ratio, 0.1 ), OXY)

	apply_damage(-2*(max(1, inhale_efficiency-0.3)), OXY) //-2 oxy healing is baseline
	//return 0

	switch(air_info[1])
		if(GAS_TYPE_N2O)
			if(!isyautja(src)) // Prevent Predator anesthetic memes
				var/SA_pp = air_info[5]
				if(SA_pp > 20) // Enough to make us paralysed for a bit
					apply_effect(3, PARALYZE) // 3 gives them one second to wake up and run away a bit!
					//Enough to make us sleep as well
					if(SA_pp > 30)
						sleeping = min(sleeping+4, 10)
				else if(SA_pp > 1) // There is sleeping gas in their lungs, but only a little, so give them a bit of a warning
					if(prob(20))
						spawn(0) emote(pick("giggle", "laugh"))
	return 1
