
// Called when the item is in the active hand, and clicked; alternately, there is an 'activate held object' verb or you can hit pagedown.
/obj/item/proc/attack_self(mob/user)
	SHOULD_CALL_PARENT(TRUE)
	SEND_SIGNAL(src, COMSIG_ITEM_ATTACK_SELF, user)
	SEND_SIGNAL(user, COMSIG_MOB_ITEM_ATTACK_SELF, src)

	if(flags_item & CAN_DIG_SHRAPNEL && ishuman(user))
		dig_out_shrapnel(user)

// No comment
/atom/proc/attackby(obj/item/W, mob/living/user, list/mods)
	if(SEND_SIGNAL(src, COMSIG_PARENT_ATTACKBY, W, user, mods) & COMPONENT_NO_AFTERATTACK)
		return TRUE
	SEND_SIGNAL(user, COMSIG_MOB_PARENT_ATTACKBY, src, W)
	return FALSE

/atom/movable/attackby(obj/item/W, mob/living/user)
	. = ..()
	if(W && !.)
		if(!(W.flags_item & NOBLUDGEON))
			visible_message(SPAN_DANGER("[src] has been hit by [user] with [W]."), null, null, 5, CHAT_TYPE_MELEE_HIT)
			user.animation_attack_on(src)
			user.flick_attack_overlay(src, "punch")

/mob/living/attackby(obj/item/I, mob/user)
	/* Commented surgery code, proof of concept. Would need to tweak human attackby to prevent duplication; mob/living don't have separate limb objects.
	if((user.mob_flags & SURGERY_MODE_ON) && user.a_intent & (INTENT_HELP|INTENT_DISARM))
		safety = TRUE
		var/datum/surgery/current_surgery = active_surgeries[user.zone_selected]
		if(current_surgery)
			if(current_surgery.attempt_next_step(user, I))
				return TRUE
		else if(initiate_surgery_moment(I, src, null, user))
			return TRUE
	*/
	if(istype(I) && ismob(user))
		return I.attack(src, user)


// Proximity_flag is 1 if this afterattack was called on something adjacent, in your square, or on your person.
// Click parameters is the params string from byond Click() code, see that documentation.
/obj/item/proc/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	return FALSE


/obj/item/proc/attack(mob/living/target, mob/living/user)
	if((flags_item & NOBLUDGEON) || (MODE_HAS_TOGGLEABLE_FLAG(MODE_NO_ATTACK_DEAD) && target.stat == DEAD && !user.get_target_lock(target.faction_group)))
		return FALSE

	if(SEND_SIGNAL(target, COMSIG_ITEM_ATTEMPT_ATTACK, user, src) & COMPONENT_CANCEL_ATTACK) //Sent by target mob.
		return FALSE

	if(SEND_SIGNAL(src, COMSIG_ITEM_ATTACK, user, target) & COMPONENT_CANCEL_ATTACK) //Sent by source item.
		return FALSE

	if(ishuman(user))
		var/mob/living/carbon/human/human_user = user
		if(!human_user.melee_allowed)
			to_chat(human_user, SPAN_DANGER("You are currently unable to attack."))
			return FALSE

	var/showname = "."
	if(user)
		if(target == user)
			showname = " by themselves."
		else
			showname = " by [user]."
	if(!(user in viewers(target, null)))
		showname = "."

	if(user.a_intent == INTENT_HELP && ((user.client?.prefs && user.client?.prefs?.toggle_prefs & TOGGLE_HELP_INTENT_SAFETY) || (user.mob_flags & SURGERY_MODE_ON)))
		playsound(loc, 'sound/effects/pop.ogg', 25, 1)
		user.visible_message(SPAN_NOTICE("[target] has been poked with [src][showname]"),\
			SPAN_NOTICE("You poke [target == user ? "yourself":target] with [src]."), null, 4)

		return FALSE

	if(ishuman(user) && ishuman_strict(target) && user.a_intent == INTENT_GRAB && user.zone_selected == "mouth")
		var/mob/living/carbon/human/human_target = target
		var/mob/living/carbon/human/human_user = user
		if(force >= MELEE_FORCE_NORMAL && !isnull(sharp) && sharp == IS_SHARP_ITEM_ACCURATE)
			if(!user.get_target_lock(target.faction_group))
				if(target.stat != DEAD)
					if(!user.action_busy)
						if(!HAS_TRAIT_FROM(target, TRAIT_FLOORED, THROATSLIT_TRAIT))
							if(human_target.pulledby == human_user)
								if(target.dir == user.dir && target.loc == get_step(user, user.dir) || target.body_position == LYING_DOWN || human_target.handcuffed)


									user.visible_message(SPAN_DANGER("[user] grabs [target] and is about to slit their throat with [src]."), SPAN_HIGHDANGER("You grab [target]'s head and prepare to slice open their throat with [src]."))
									to_chat(target, SPAN_HIGHDANGER("[user] grabs you and pins you and pulls your head back exposing your throat."))

									throat_slit_stun(target, user)
									human_target.reset_pixel_shift()
									human_user.pixel_shift_target_mob(target, 12)

									if(!do_after(user, 4 SECONDS * human_user.get_skill_duration_multiplier(SKILL_CQC), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_HOSTILE, target, INTERRUPT_OUT_OF_RANGE, BUSY_ICON_HOSTILE))
										remove_throat_slit_stun(target)
										human_target.reset_pixel_shift()
										to_chat(user, SPAN_WARNING("You were interrupted!"))
										return FALSE
									ADD_TRAIT(target, TRAIT_FLOORED, THROATSLIT_TRAIT)

									target.visible_message(SPAN_DANGER("[user] slit open [target]'s throat! They made quite a bloody mess!"), SPAN_HIGHDANGER("[user] slits your throat! Oh god!"))
									to_chat(user, SPAN_DANGER("You slit open their throat. No getting up from that."))
									playsound(target, 'sound/weapons/slice.ogg', 25, 1)
									target.apply_damage(100, BRUTE, "head")
									target.apply_damage(300, OXYLOSS)

									var/obj/limb/head/head = human_target.get_limb("head")
									human_target.spray_blood(rand(0,181), head)
									human_target.reset_pixel_shift()

									if(do_after(target, 2 SECONDS, INTERRUPT_NONE))
										target.death(create_cause_data("throat slit"))
										REMOVE_TRAIT(target, TRAIT_FLOORED, THROATSLIT_TRAIT)
										human_target.spray_blood(rand(0,181), head)

									remove_throat_slit_stun(target)
									return TRUE
								else
									to_chat(user, SPAN_WARNING("You must be directly behind your target! Or they must be on the ground or restrained!"))
							else
								to_chat(user, SPAN_WARNING("You need a grab a hold of them to do this!"))
						else
							to_chat(user, SPAN_WARNING("It's already done. They're as good as dead."))
					else
						to_chat(user, SPAN_WARNING("You are busy doing something else!"))
				else
					to_chat(user, SPAN_WARNING("They're already dead. What's the point?"))
			else
				to_chat(user, SPAN_WARNING("Why would you think to do this? What is wrong with you? They're on your side!"))
		else
			to_chat(user, SPAN_HELPFUL("You'd need a more suitable weapon for this!"))
		return FALSE

	if(ishuman(target) && target.stat == DEAD && user.a_intent == INTENT_DISARM && user.zone_selected == "mouth" )
		if(!isnull(sharp) && sharp >= IS_SHARP_ITEM_ACCURATE)
			if(!user.action_busy)
				if(target.pulledby != user || (target.pulledby?.grab_level < GRAB_AGGRESSIVE && !iszombie(target)))
					to_chat(user, SPAN_NOTICE(iszombie(target) ? "You need to grab hold to do this!" : "You need to get a secure grip to do this!"))
					return FALSE

				var/mob/living/carbon/human/human_target = target
				var/mob/living/carbon/human/human_user = user
				var/obj/limb/limb = human_target.get_limb("head")
				if(limb.status & LIMB_DESTROYED)
					to_chat(user, SPAN_NOTICE("What head?"))
					return FALSE
				var/time_to_decap = HUMAN_DEAD_DECAP_DELAY * user.get_skill_duration_multiplier(SKILL_CQC)
				if(iszombie(target))
					time_to_decap /= 2
				human_target.reset_pixel_shift()
				human_user.pixel_shift_target_mob(target, 12)

				to_chat(user, SPAN_WARNING(iszombie(target) ? "Your [src.name] easily starts to cut through [target]'s neck!" : "You start to cut off [target]'s head!"))
				human_target.add_splatter_floor()
				playsound(human_target, 'sound/effects/blood_squirt.ogg', 40, TRUE)

				if(do_after(user, (time_to_decap)/2, INTERRUPT_ALL, BUSY_ICON_HOSTILE, target, INTERRUPT_MOVED ) && target.stat == DEAD)
					human_target.add_splatter_floor()
					playsound(human_target, 'sound/effects/bone_break2.ogg', 25, TRUE)

					if(do_after(user, (time_to_decap)/2, INTERRUPT_ALL, BUSY_ICON_HOSTILE, target, INTERRUPT_MOVED) && target.stat == DEAD)
						user.visible_message(SPAN_WARNING(SPAN_BOLD("[user] brutally decapitates [target]!")), SPAN_WARNING(SPAN_BOLD("You decapitate [target]! What a mess!")), null)
						human_target.spray_blood(rand(0, 181), limb)
						limb.droplimb(0,0, user)
						human_target.reset_pixel_shift()
						if(do_after(target, 2 SECONDS, INTERRUPT_NONE))
							human_target.spray_blood(rand(0, 181), limb)
						return TRUE
				human_target.reset_pixel_shift()
				to_chat(user, SPAN_WARNING("You were interrupted!"))
			else
				to_chat(user, SPAN_WARNING("You are busy doing something else!"))
			return FALSE
		else
			to_chat(user, SPAN_NOTICE("You hack away uselessly at [target]."))
			to_chat(user, SPAN_HELPFUL("You should find a better weapon."))
	/////////////////////////
	user.attack_log += "\[[time_stamp()]\]<font color='red'> Attacked [key_name(target)] with [name] (INTENT: [uppertext(intent_text(user.a_intent))]) (DAMTYE: [uppertext(damtype)])</font>"
	target.attack_log += "\[[time_stamp()]\]<font color='orange'> Attacked by  [key_name(user)] with [name] (INTENT: [uppertext(intent_text(user.a_intent))]) (DAMTYE: [uppertext(damtype)])</font>"
	msg_admin_attack("[key_name(user)] attacked [key_name(target)] with [name] (INTENT: [uppertext(intent_text(user.a_intent))]) (DAMTYE: [uppertext(damtype)]) in [get_area(src)] ([src.loc.x],[src.loc.y],[src.loc.z]).", src.loc.x, src.loc.y, src.loc.z)

	/////////////////////////

	add_fingerprint(user)

	var/power = force
	if(user.skills)
		power = floor(power * (1 + 0.25 * user.skills.get_skill_level(SKILL_MELEE_WEAPONS))) //25% bonus per melee level
	if(!ishuman(target))
		var/used_verb = "attacked"
		if(LAZYLEN(attack_verb))
			used_verb = pick(attack_verb)
		user.visible_message(SPAN_DANGER("[target] has been [used_verb] with [src][showname]."), \
			SPAN_DANGER("You [used_verb] [target == user ? "yourself":target] with [src]."), null, 5, CHAT_TYPE_MELEE_HIT)

		user.animation_attack_on(target)
		user.flick_attack_overlay(target, "punch")
		if(isxeno(target))
			var/mob/living/carbon/xenomorph/X = target
			power = armor_damage_reduction(GLOB.xeno_melee, power, X.armor_deflection + X.armor_deflection_buff - X.armor_deflection_debuff, 20, 0, 0, X.armor_integrity)
			var/armor_punch = armor_break_calculation(GLOB.xeno_melee, power, X.armor_deflection + X.armor_deflection_buff - X.armor_deflection_debuff, 20, 0, 0, X.armor_integrity)
			X.apply_armorbreak(armor_punch)
		if(hitsound)
			playsound(loc, hitsound, 25, 1)
		switch(damtype)
			if("brute")
				target.apply_damage(power,BRUTE)
			if("fire")
				target.apply_damage(power,BURN)
				to_chat(target, SPAN_WARNING("It burns!"))
		if(power > 5)
			target.last_damage_data = create_cause_data(initial(name), user)
			user.track_hit(initial(name))
			if(user.faction == target.faction)
				user.track_friendly_fire(initial(name))
		target.updatehealth()
	else
		var/mob/living/carbon/human/human_target = target
		var/hit = human_target.attacked_by(src, user)
		if (hit && hitsound)
			playsound(loc, hitsound, 25, 1)
		return hit
	return TRUE

/obj/item/proc/throat_slit_stun(mob/living/target, mob/living/user)
	target.anchored = TRUE
	ADD_TRAIT(target, TRAIT_IMMOBILIZED, THROATSLIT_TRAIT)
	ADD_TRAIT(target, TRAIT_UNDENSE, THROATSLIT_TRAIT)

	playsound(target, 'sound/weapons/thudswoosh.ogg', 25, 1, 7)


/obj/item/proc/remove_throat_slit_stun(mob/living/target)
	target.anchored = FALSE
	REMOVE_TRAIT(target, TRAIT_IMMOBILIZED, THROATSLIT_TRAIT)
	REMOVE_TRAIT(target, TRAIT_UNDENSE, THROATSLIT_TRAIT)
