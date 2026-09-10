/datum/ai_action/reload
	name = "Reload"
	action_flags = ACTION_USING_HANDS
	var/currently_reloading

/datum/ai_action/reload/get_weight(datum/human_ai_brain/brain)
	if(brain.tried_reload)
		return 0

	if(!brain.gun_data)
		return 0

	if(!brain.should_reload())
		return 0

	return ACTION_WEIGHT_RELOAD

/datum/ai_action/reload/Destroy(force, ...)
	currently_reloading = FALSE
	return ..()

/datum/ai_action/reload/trigger_action()
	. = ..()

	if(currently_reloading)
		return ONGOING_ACTION_UNFINISHED

	var/obj/item/weapon/gun/primary_weapon = brain.primary_weapon
	if(!primary_weapon || brain.tried_reload || !brain.should_reload())
		return ONGOING_ACTION_COMPLETED

	reload()
	return ONGOING_ACTION_UNFINISHED

/datum/ai_action/reload/proc/reload()
	set waitfor = FALSE

	var/obj/item/weapon/gun/primary_weapon = brain.primary_weapon
	var/mob/living/carbon/tied_human = brain.tied_human

	var/datum/firearm_appraisal/gun_data = brain.gun_data
	if(gun_data.disposable)
		tied_human.drop_held_item(primary_weapon)
		brain.to_pickup -= primary_weapon
		brain.set_primary_weapon(null)
		qdel(src)
		return

	currently_reloading = TRUE

	/// Find ammo
	var/obj/item/ammo_magazine/mag = primary_ammo_search()
	if(!mag)
		brain.tried_reload = TRUE
		qdel(src)
		return

	brain.say_reload_line()
	gun_data.do_reload(primary_weapon, mag, tied_human, brain)

	/// When do_reload() stops sleeping, let us check things one last time
	currently_reloading = FALSE

/datum/ai_action/reload/proc/primary_ammo_search()
	for(var/obj/item/ammo_magazine/mag as anything in brain.equipment_map[HUMAN_AI_AMMUNITION])
		if(istype(brain.primary_weapon, mag.gun_type) && mag.ai_can_use(brain.tied_human, src))
			return mag
