//Refer to life.dm for caller

/mob/living/carbon/human/proc/handle_pulse()

	if(species && species.flags & NO_BLOOD)
		return PULSE_NONE //No blood, no pulse.

	if(stat == DEAD || status_flags & FAKEDEATH)
		return PULSE_NONE //That's it, you're dead, nothing can influence your pulse

	if(floor(blood_volume) <= BLOOD_VOLUME_BAD) //How much blood do we have
		return PULSE_THREADY //not enough :(

	if(species && species.mob_flags & NOBIOSCAN)
		return pick(PULSE_THREADY, PULSE_SLOW, PULSE_FAST, PULSE_2FAST) //Scanner freaking the hell out

	return PULSE_NORM
