/datum/human_ai_brain
	/// The firearm the AI is using as its primary weapon
	var/obj/item/weapon/gun/primary_weapon
	/// Any other firearms the AI has that it considers "secondary"
	var/list/obj/item/weapon/gun/secondary_weapons = list()
	//var/obj/item/weapon/primary_melee
	/// Appraisal datum
	var/datum/firearm_appraisal/gun_data
	/// If we've tried to reload (and failed) with our current inventory
	var/tried_reload = FALSE
	/// Cooldown for if we've fired too many rounds in a burst (for recoil)
	COOLDOWN_DECLARE(fire_overload_cooldown)
	/// Generic cooldown for things like shotgun pumping, bolt racking, etc. This stops us from firing for however long specified
	COOLDOWN_DECLARE(stop_fire_cooldown)

/datum/human_ai_brain/proc/should_reload()
	if(!primary_weapon)
		return FALSE

	if(primary_weapon.has_ammunition())
		return FALSE

	return TRUE
