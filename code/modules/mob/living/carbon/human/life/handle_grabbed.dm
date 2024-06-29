
// Why is this proc in its own .dm file?
/mob/living/carbon/proc/handle_grabbed()
	if(!pulledby)
		return

	/// Rewrote this to be a little different, so that the normal effects don't apply to xeno grabs.
	switch(pulledby.grab_level)
		if(GRAB_AGGRESSIVE to GRAB_CARRY)
			drop_held_items()
		if(GRAB_CHOKE)
			drop_held_items()
			apply_damage(3, OXY)
			apply_stamina_damage(5)
		if(GRAB_XENO) /// Alien grabs inflict pain when the human is not incapacitated, but not the other effects.
			/// Ignoring restrained with (TRUE). The grab does *not* restrain by itself. See /mob/living/carbon/human/is_mob_restrained(check_grab = TRUE)
			/// This is too allow the human a chance to fight back, with guns or melee.
			return is_mob_incapacitated(TRUE) || pain.apply_pain(PAIN_XENO_DRAG)

