/// Returns a human AI brain, if this human has one
/mob/living/carbon/human/proc/get_ai_brain()
	RETURN_TYPE(/datum/human_ai_brain)

	var/list/out_brain = list()
	SEND_SIGNAL(src, COMSIG_HUMAN_GET_AI_BRAIN, out_brain)
	if(length(out_brain))
		return out_brain[1]

/// Hacky getter proc used as part of the get_ai_brain() proc
/datum/human_ai_brain/proc/get_ai_brain(datum/source, list/out_brain)
	SIGNAL_HANDLER

	out_brain += src

/// Returns if this AI has a given action, based on path
/datum/human_ai_brain/proc/has_ongoing_action(path)
	if(!ispath(path))
		return FALSE

	for(var/datum/ai_action/action as anything in ongoing_actions)
		if(istype(action, path))
			return TRUE

	return FALSE

/// Given an order reference, sets it as this AI's current order
/datum/human_ai_brain/proc/set_current_order(datum/ai_order/ref)
	if(!ref)
		return

	current_order = ref
	current_order.brains += src

/// Nulls out this AI's current order
/datum/human_ai_brain/proc/remove_current_order()
	if(current_order)
		current_order.brains -= src
	current_order = null

/// Returns TRUE if the target is friendly/neutral to us
/// This is THE hottest proc that Human AI invokes, so please be careful in adding more to it
/datum/human_ai_brain/proc/faction_check(atom/target)
	if(ismob(target))
		var/mob/mob_target = target

		if(mob_target.faction == tied_human.faction)
			return TRUE

		if(mob_target.faction in friendly_factions)
			return TRUE

		if(mob_target.faction in neutral_factions)
			return TRUE
	if(istype(target, /obj/vehicle/multitile))
		var/obj/vehicle/multitile/vehicle_target = target
		if(vehicle_target.vehicle_faction == tied_human.faction)
			return TRUE

		if(vehicle_target.vehicle_faction in friendly_factions)
			return TRUE

		if(vehicle_target.vehicle_faction in neutral_factions)
			return TRUE
	if(isdefenses(target))
		var/obj/structure/machinery/defenses/defense_target = target
		if(tied_human.faction in defense_target.faction_group)
			return TRUE
		return FALSE

	return FALSE

/// Removes neutral faction status from a given faction
/datum/human_ai_brain/proc/on_neutral_faction_betray(faction)
	if(!tied_human.faction)
		return

	var/datum/human_ai_faction/our_faction = SShuman_ai.human_ai_factions[tied_human.faction]
	if(!our_faction)
		return

	our_faction.remove_neutral_faction(faction)
	our_faction.reapply_faction_data()

/// Announces whenever an AI is handcuffed so that GMs can force someone in or take over themselves
/datum/human_ai_brain/proc/on_handcuffed(datum/source)
	SIGNAL_HANDLER

	if((tied_human.stat >= DEAD) || tied_human.client)
		return

	message_admins("AI human [tied_human.real_name] has been handcuffed while alive or unconscious.", tied_human.x, tied_human.y, tied_human.z)

/// Assuming an item is in the AI's hands, this ensures it is their actively selected hand
/datum/human_ai_brain/proc/ensure_primary_hand(obj/item/held_item)
	if(tied_human.get_inactive_hand() == held_item)
		tied_human.swap_hand()

/// Unholsters the AI's primary weapon, dropping anything that might obstruct it.
/datum/human_ai_brain/proc/unholster_primary()
	if(!primary_weapon || tied_human.l_hand == primary_weapon || tied_human.r_hand == primary_weapon)
		return

	var/cur_hand = tied_human.get_active_hand()
	if(cur_hand)
		tied_human.drop_held_item(cur_hand)

	tied_human.u_equip(primary_weapon)
	tied_human.put_in_active_hand(primary_weapon)

	primary_weapon.guaranteed_delay_time = world.time
	primary_weapon.wield_time = world.time
	primary_weapon.pull_time = world.time

/// Tells the AI to wield their primary weapon, can be called if they aren't holding it or if they are already wielding it
/datum/human_ai_brain/proc/wield_primary()
	primary_weapon?.wield(tied_human)

/// wield_primary() with a delay inbuilt
/datum/human_ai_brain/proc/wield_primary_sleep()
	wield_primary()
	sleep(max(primary_weapon?.wield_delay, short_action_delay * action_delay_mult))

/// Holsters the AI's primary weapon if possible
/datum/human_ai_brain/proc/holster_primary()
	if(tied_human.s_store || (tied_human.l_hand != primary_weapon && tied_human.r_hand != primary_weapon))
		return FALSE

	return tied_human.equip_to_slot_if_possible(primary_weapon, WEAR_J_STORE, TRUE)

/// Melee system currently only supports bootknives.
/datum/human_ai_brain/proc/unholster_melee()
	if(istype(tied_human.l_hand, /obj/item) || istype(tied_human.r_hand, /obj/item))
		return TRUE

	var/cur_hand = tied_human.get_active_hand()
	if(cur_hand)
		tied_human.drop_held_item(cur_hand)

	if(tied_human.shoes)
		var/obj/item/melee_weapon = tied_human.shoes.remove_item(tied_human)
		drawn_melee_weapon = melee_weapon
		RegisterSignal(drawn_melee_weapon, COMSIG_ITEM_DROPPED, PROC_REF(on_melee_dropped))
		return melee_weapon

/// Signal for if a melee weapon is dropped
/datum/human_ai_brain/proc/on_melee_dropped()
	SIGNAL_HANDLER

	UnregisterSignal(drawn_melee_weapon, COMSIG_ITEM_DROPPED)
	drawn_melee_weapon = null

/// Quick and dirty proc to holster a melee weapon if the AI is holding one.
/datum/human_ai_brain/proc/holster_melee()
	if(!drawn_melee_weapon)
		return TRUE

	if(drawn_melee_weapon.loc != tied_human)
		on_melee_dropped()
		return TRUE

	if(tied_human.shoes && tied_human.shoes.can_be_inserted(drawn_melee_weapon))
		return tied_human.shoes.attempt_insert_item(tied_human, drawn_melee_weapon)

	tied_human.drop_held_item(drawn_melee_weapon)
	return FALSE

/// Tells the AI to unwield *something*, prioritizing melee
/datum/human_ai_brain/proc/unholster_any_weapon()
	if(iszombie(tied_human))
		var/cur_hand = tied_human.get_active_hand()
		if(isnull(cur_hand)) //Check if we have a hand. If not try the other one? Claws are stuck to hands so if this is null we've lost the hand
			var/obj/limb/hand/r_hand/right_hand	= tied_human.get_limb("r_hand")
			var/obj/limb/hand/l_hand/left_hand = tied_human.get_limb("l_hand")
			if(!(left_hand.status & LIMB_DESTROYED) || !(right_hand.status & LIMB_DESTROYED)) //We have hands?
				tied_human.swap_hand()
				cur_hand = tied_human.get_active_hand()
			else
				return FALSE
	if(unholster_melee())
		tied_human.a_intent_change(INTENT_GRAB)
		return TRUE
	if(primary_weapon)
		unholster_primary()
		ensure_primary_hand(primary_weapon)
		wield_primary()
		tied_human.a_intent_change(INTENT_GRAB)
		return TRUE
	// insert any viable weapon slot macros in here
