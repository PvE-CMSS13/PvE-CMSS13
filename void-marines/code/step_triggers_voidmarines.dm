//chatgpt shitcode

/obj/effect/step_trigger/sound_trigger
	name = "Sound Trigger"
	desc = "Plays a sound when stepped on."
	var/sound/sound_effect = null
	var/last_played_time = 0 // Последнее время воспроизведения

/obj/effect/step_trigger/sound_trigger/Initialize()
	. = ..()
	if(!sound_effect)
		sound_effect = 'sound/effects/EMpulse.ogg' // default

/obj/effect/step_trigger/sound_trigger/Trigger(atom/movable/A)
    if(!A || istype(A, /mob/dead/observer))
        return

    if(world.time - last_played_time < 30) // Интервал в 3 секунду
        return

    last_played_time = world.time
    if(sound_effect)
        playsound(src.loc, sound_effect, 50, 1)

//**************
//***rad_shit***
//**************

#define RADIATION_TOXIN_AMOUNT 2

/obj/effect/blocker/radioactive
	anchored = TRUE
	density = FALSE
	opacity = FALSE
	unacidable = TRUE
	layer = ABOVE_FLY_LAYER
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	icon = 'icons/old_stuff/mark.dmi'
	icon_state = "spawn_shuttle"

/obj/effect/blocker/radioactive/Initialize(mapload, ...)
	. = ..()
	return INITIALIZE_HINT_LATELOAD

/obj/effect/blocker/radioactive/LateInitialize()
	. = ..()
	icon_state = null

/obj/effect/blocker/radioactive/Crossed(atom/A)
	if(isliving(A))
		var/mob/living/M = A
		if(!istype(M.loc, /turf))
			return

		apply_radiation_effect(M)
		START_PROCESSING(SSobj, src)

/obj/effect/blocker/radioactive/process()
	var/mobs_present = 0
	for(var/mob/living/carbon/M in range(0, src))
		mobs_present++
		apply_radiation_effect(M)

	if(mobs_present < 1)
		STOP_PROCESSING(SSobj, src)

/obj/effect/blocker/radioactive/proc/apply_radiation_effect(mob/living/M)
	if(M.stat == DEAD)
		return

	if(isxeno(M))
		return

	M.reagents.add_reagent("toxin", RADIATION_TOXIN_AMOUNT)
	to_chat(M, SPAN_DANGER("You feel an unpleasant burning sensation on your skin."))

#undef RADIATION_TOXIN_AMOUNT
