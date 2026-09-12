//-------------------------------------------------------
//SMARTGUN

//Come get some.
/obj/item/weapon/gun/smartgun
	name = "\improper M56A2 smartgun"
	desc = "The actual firearm in the 4-piece M56 Smartgun System. Essentially a heavy, mobile machinegun.\nYou may toggle firing restrictions by using a special action.\nAlt-click it to open the feed cover and allow for reloading."
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/uscm.dmi'
	icon_state = "m56"
	item_state = "m56"
	mouse_pointer = 'icons/effects/mouse_pointer/smartgun_mouse.dmi'

	fire_sound = "gun_smartgun"
	reload_sound = 'sound/weapons/handling/gun_sg_reload.ogg'
	unload_sound = 'sound/weapons/handling/gun_sg_unload.ogg'

	current_mag = /obj/item/ammo_magazine/smartgun
	flags_equip_slot = NO_FLAGS
	w_class = SIZE_HUGE
	force = 20
	wield_delay = WIELD_DELAY_FAST
	aim_slowdown = SLOWDOWN_ADS_SMARTGUN
	unacidable = 1
	indestructible = 1

	flags_gun_features = GUN_SPECIALIST|GUN_WIELDED_FIRING_ONLY
	gun_category = GUN_CATEGORY_HEAVY
	starting_attachment_types = list(/obj/item/attachable/smartbarrel)
	auto_retrieval_slot = WEAR_J_STORE
	start_semiauto = FALSE
	start_automatic = TRUE

	attachable_allowed = list(
		/obj/item/attachable/smartbarrel,
		/obj/item/attachable/flashlight,
	)

	ammo = /datum/ammo/bullet/rifle/heavy/tracer
	actions_types = list(
		/datum/action/item_action/smartgun/toggle_accuracy_improvement,
		/datum/action/item_action/smartgun/toggle_ammo_type,
		///datum/action/item_action/smartgun/toggle_auto_fire,
		/datum/action/item_action/smartgun/toggle_lethal_mode,
		///datum/action/item_action/smartgun/toggle_motion_detector,
		/datum/action/item_action/smartgun/toggle_recoil_compensation,
	)

	var/obj/item/smartgun_battery/battery = null
	var/battery_type = /obj/item/smartgun_battery
	/// Whether the smartgun drains the battery (Ignored if requires_battery is false)
	var/requires_power = TRUE
	/// Whether the smartgun requires a battery
	var/requires_battery = TRUE
	/// Whether the smartgun requires a harness to use
	var/requires_harness = TRUE

	var/datum/ammo/ammo_primary = /datum/ammo/bullet/rifle/heavy/tracer //Toggled ammo type
	var/datum/ammo/ammo_secondary = /datum/ammo/bullet/rifle/heavy/ap/tracer //Toggled ammo type
	var/datum/ammo/ammo_tertiary = /datum/ammo/bullet/rifle/heavy/impdet //Toggled ammo type
	var/iff_enabled = TRUE //Begin with the safety on.
	var/recoil_compensation = 0
	var/accuracy_improvement = 0
	var/auto_fire = 0
	var/motion_detector = 0
	var/drain = 75
	var/range = 7
	var/angle = 2
	var/list/angle_list = list(180,135,90,60,30)
	var/obj/item/device/motiondetector/sg/MD
	var/long_range_cooldown = 2
	var/recycletime = 120
	var/cover_open = FALSE

/obj/item/weapon/gun/smartgun/Initialize(mapload, ...)
	ammo_primary = GLOB.ammo_list[ammo_primary] //Gun initialize calls replace_ammo() so we need to set these first.
	ammo_secondary = GLOB.ammo_list[ammo_secondary]
	ammo_tertiary = GLOB.ammo_list[ammo_tertiary]
	ammo = ammo_primary
	MD = new(src)
	battery = new battery_type(src)
	. = ..()
	update_icon()

/obj/item/weapon/gun/smartgun/Destroy()
	ammo_primary = null
	ammo_secondary = null
	ammo_tertiary = null
	QDEL_NULL(MD)
	QDEL_NULL(battery)
	. = ..()

/obj/item/weapon/gun/smartgun/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 33, "muzzle_y" = 16,"rail_x" = 17, "rail_y" = 18, "under_x" = 22, "under_y" = 14, "stock_x" = 22, "stock_y" = 14, , "side_rail_x" = 17, "side_rail_y" = 18)

/obj/item/weapon/gun/smartgun/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_SG)
	fa_scatter_peak = FULL_AUTO_SCATTER_PEAK_TIER_8
	fa_max_scatter = SCATTER_AMOUNT_TIER_9
	if(accuracy_improvement)
		accuracy_mult += HIT_ACCURACY_MULT_TIER_3
	else
		accuracy_mult += HIT_ACCURACY_MULT_TIER_1
	if(recoil_compensation)
		scatter = SCATTER_AMOUNT_TIER_10
		recoil = RECOIL_OFF
	else
		scatter = SCATTER_AMOUNT_TIER_6
		recoil = RECOIL_AMOUNT_TIER_3
	damage_mult = BASE_BULLET_DAMAGE_MULT

/obj/item/weapon/gun/smartgun/set_bullet_traits()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY_ID("iff", /datum/element/bullet_trait_iff)
	))
	AddComponent(/datum/component/iff_fire_prevention)

/obj/item/weapon/gun/smartgun/get_examine_text(mob/user)
	. = ..()
	var/rounds = 0
	if(current_mag && current_mag.current_rounds)
		rounds = current_mag.current_rounds
	var/message = "[rounds ? "Ammo counter shows [rounds] round\s remaining." : "It's dry."]"
	. += message
	. += "The restriction system is [iff_enabled ? "<B>on</b>" : "<B>off</b>"]."

	if(battery && get_dist(user, src) <= 1)
		. += "A small gauge on [battery] reads: Power: [battery.power_cell.charge] / [battery.power_cell.maxcharge]."

/obj/item/weapon/gun/smartgun/clicked(mob/user, list/mods)
	if(mods[ALT_CLICK])
		if(!CAN_PICKUP(user, src))
			return ..()
		if(!locate(src) in list(user.get_active_hand(), user.get_inactive_hand()))
			return TRUE
		if(user.get_active_hand() && user.get_inactive_hand())
			to_chat(user, SPAN_WARNING("You can't do that with your hands full!"))
			return TRUE
		if(!cover_open)
			playsound(src.loc, 'sound/handling/smartgun_open.ogg', 50, TRUE, 3)
			to_chat(user, SPAN_NOTICE("You open \the [src]'s feed cover, allowing the drum to be removed."))
			cover_open = TRUE
		else
			playsound(src.loc, 'sound/handling/smartgun_close.ogg', 50, TRUE, 3)
			to_chat(user, SPAN_NOTICE("You close \the [src]'s feed cover."))
			cover_open = FALSE
		update_icon()
		return TRUE
	else
		return ..()

/obj/item/weapon/gun/smartgun/attackby(obj/item/attacking_object, mob/user)
	if(istypestrict(attacking_object, battery_type))
		var/obj/item/smartgun_battery/new_cell = attacking_object
		visible_message(SPAN_NOTICE("[user] swaps out the power cell in [src]."),
			SPAN_NOTICE("You swap out the power cell in [src] and drop the old one."))
		to_chat(user, SPAN_NOTICE("The new cell contains: [new_cell.power_cell.charge] power."))
		battery.update_icon()
		battery.forceMove(get_turf(user))
		battery = new_cell
		user.drop_inv_item_to_loc(new_cell, src)
		playsound(src, 'sound/machines/click.ogg', 25, 1)
		return

	return ..()

/obj/item/weapon/gun/smartgun/replace_magazine(mob/user, obj/item/ammo_magazine/magazine)
	if(!cover_open)
		to_chat(user, SPAN_WARNING("\The [src]'s feed cover is closed! You can't put a new drum in! (alt-click to open it)"))
		return
	. = ..()

/obj/item/weapon/gun/smartgun/unload(mob/user, reload_override, drop_override, loc_override)
	if(!cover_open)
		to_chat(user, SPAN_WARNING("\The [src]'s feed cover is closed! You can't take out the drum! (alt-click to open it)"))
		return
	. = ..()

/obj/item/weapon/gun/smartgun/update_icon()
	. = ..()
	if(cover_open)
		overlays += "+[base_gun_icon]_cover_open"
	else
		overlays += "+[base_gun_icon]_cover_closed"

//---ability actions--\\

/datum/action/item_action/smartgun/action_activate()
	. = ..()
	var/obj/item/weapon/gun/smartgun/G = holder_item
	if(!ishuman(owner))
		return
	var/mob/living/carbon/human/H = owner
	if(H.is_mob_incapacitated() || G.get_active_firearm(H, FALSE) != holder_item)
		return

/datum/action/item_action/smartgun/update_button_icon()
	return

/datum/action/item_action/smartgun/toggle_accuracy_improvement/New(Target, obj/item/holder)
	. = ..()
	name = "Toggle Accuracy Improvement"
	action_icon_state = "accuracy_improvement"
	button.name = name
	button.overlays.Cut()
	button.overlays += image('icons/mob/hud/actions.dmi', button, action_icon_state)

/datum/action/item_action/smartgun/toggle_accuracy_improvement/action_activate()
	. = ..()
	var/obj/item/weapon/gun/smartgun/G = holder_item
	G.toggle_accuracy_improvement(usr)
	if(G.accuracy_improvement)
		button.icon_state = "template_on"
	else
		button.icon_state = "template"

/datum/action/item_action/smartgun/toggle_recoil_compensation/New(Target, obj/item/holder)
	. = ..()
	name = "Toggle Recoil Compensation"
	action_icon_state = "recoil_compensation"
	button.name = name
	button.overlays.Cut()
	button.overlays += image('icons/mob/hud/actions.dmi', button, action_icon_state)

/datum/action/item_action/smartgun/toggle_recoil_compensation/action_activate()
	. = ..()
	var/obj/item/weapon/gun/smartgun/G = holder_item
	G.toggle_recoil_compensation(usr)
	if(G.recoil_compensation)
		button.icon_state = "template_on"
	else
		button.icon_state = "template"

/datum/action/item_action/smartgun/toggle_lethal_mode/New(Target, obj/item/holder)
	. = ..()
	name = "Toggle IFF"
	action_icon_state = "iff_toggle_on"
	button.name = name
	button.overlays.Cut()
	button.overlays += image('icons/mob/hud/actions.dmi', button, action_icon_state)

/datum/action/item_action/smartgun/toggle_lethal_mode/action_activate()
	. = ..()
	var/obj/item/weapon/gun/smartgun/G = holder_item
	G.toggle_lethal_mode(usr)
	if(G.iff_enabled)
		action_icon_state = "iff_toggle_on"
	else
		action_icon_state = "iff_toggle_off"
	button.overlays.Cut()
	button.overlays += image('icons/mob/hud/actions.dmi', button, action_icon_state)

/datum/action/item_action/smartgun/toggle_ammo_type/New(Target, obj/item/holder)
	. = ..()
	name = "Toggle Ammo Type"
	action_icon_state = "ammo_swap_normal"
	button.name = name
	button.overlays.Cut()
	button.overlays += image('icons/mob/hud/actions.dmi', button, action_icon_state)

/datum/action/item_action/smartgun/toggle_ammo_type/action_activate()
	. = ..()
	var/obj/item/weapon/gun/smartgun/G = holder_item
	G.toggle_ammo_type(usr)

/datum/action/item_action/smartgun/toggle_ammo_type/proc/update_icon()
	var/obj/item/weapon/gun/smartgun/G = holder_item
	if(G.ammo == G.ammo_primary)
		action_icon_state = "ammo_swap_normal"
	else if(G.ammo == G.ammo_secondary)
		action_icon_state = "ammo_swap_ap"
	else if(G.ammo == G.ammo_tertiary)
		action_icon_state = "ammo_swap_pen"
	else
		action_icon_state = "ammo_swap_normal"
	button.overlays.Cut()
	button.overlays += image('icons/mob/hud/actions.dmi', button, action_icon_state)

//more general procs

/obj/item/weapon/gun/smartgun/able_to_fire(mob/living/user)
	. = ..()
	if(.)
		if(!ishuman(user))
			return FALSE
		var/mob/living/carbon/human/H = user
		if(!skillcheckexplicit(user, SKILL_SPEC_WEAPONS, SKILL_SPEC_SMARTGUN) && !skillcheckexplicit(user, SKILL_SPEC_WEAPONS, SKILL_SPEC_ALL))
			balloon_alert(user, "insufficient skills")
			return FALSE
		if(requires_harness)
			if(!H.wear_suit || !(H.wear_suit.flags_inventory & SMARTGUN_HARNESS))
				balloon_alert(user, "harness required")
				return FALSE
		if(cover_open)
			to_chat(H, SPAN_WARNING("You can't fire \the [src] with the feed cover open! (alt-click to close)"))
			balloon_alert(user, "cannot fire; feed cover open")
			return FALSE
		if(iff_enabled)
			if(!H.glasses || !(H.glasses.flags_inventory & SMARTGUN_OPTIC))
				balloon_alert(user, "m56 headset required for iff tracking")
				return FALSE

/obj/item/weapon/gun/smartgun/unique_action(mob/user)
	if(isobserver(usr) || isxeno(usr))
		return
	toggle_ammo_type(usr)

/obj/item/weapon/gun/smartgun/proc/toggle_ammo_type(mob/user)
	if(!iff_enabled)
		to_chat(user, "[icon2html(src, usr)] Can't switch ammunition type when \the [src]'s fire restriction is disabled.")
		return
	if(ammo == ammo_primary)
		ammo = ammo_secondary
		to_chat(user, "[icon2html(src, usr)] You changed \the [src]'s ammo preparation procedures. You now fire armor-piercing rounds, offering greater penetration against armored targets compared to other rounds.")
		balloon_alert(user, "firing armor-piercing")
		drain += 50
	else if(ammo == ammo_secondary)
		ammo = ammo_tertiary
		to_chat(user, "[icon2html(src, usr)] You changed \the [src]'s ammo preparation procedures. You now fire impact-detonating rounds, which stagger most human-sized hostiles on hit and slow them down.")
		balloon_alert(user, "firing impact-detonating")
		drain += 10
	else
		ammo = ammo_primary
		to_chat(user, "[icon2html(src, usr)] You changed \the [src]'s ammo preparation procedures. You now fire highly precise rounds. These rounds are accurate and cost less power to operate.")
		balloon_alert(user, "firing highly precise")
		drain -= 60
	playsound(loc,'sound/machines/click.ogg', 25, 1)
	var/datum/action/item_action/smartgun/toggle_ammo_type/TAT = locate(/datum/action/item_action/smartgun/toggle_ammo_type) in actions
	TAT.update_icon()

/obj/item/weapon/gun/smartgun/replace_ammo()
	var/old_ammo = ammo
	..()
	if(old_ammo)
		ammo = old_ammo

/obj/item/weapon/gun/smartgun/proc/toggle_lethal_mode(mob/user)
	to_chat(user, "[icon2html(src, usr)] You [iff_enabled? "<B>disable</b>" : "<B>enable</b>"] \the [src]'s fire restriction. You will [iff_enabled ? "harm anyone in your way" : "target through IFF"].")
	playsound(loc,'sound/machines/click.ogg', 25, 1)
	iff_enabled = !iff_enabled
	ammo = ammo_primary
	var/datum/action/item_action/smartgun/toggle_ammo_type/TAT = locate(/datum/action/item_action/smartgun/toggle_ammo_type) in actions
	TAT.update_icon()
	if(iff_enabled)
		add_bullet_trait(BULLET_TRAIT_ENTRY_ID("iff", /datum/element/bullet_trait_iff))
		drain += 10
		MD.iff_signal = initial(MD.iff_signal)
	if(!iff_enabled)
		remove_bullet_trait("iff")
		drain -= 10
		MD.iff_signal = null
	SEND_SIGNAL(src, COMSIG_GUN_IFF_TOGGLED, iff_enabled)

/obj/item/weapon/gun/smartgun/Fire(atom/target, mob/living/user, params, reflex = 0, dual_wield)
	if(!requires_battery)
		return ..()

	if(battery)
		if(!requires_power)
			return ..()
		if(drain_battery())
			return ..()

/obj/item/weapon/gun/smartgun/proc/drain_battery(override_drain)

	var/actual_drain = (rand(drain / 2, drain) / 25)

	if(override_drain)
		actual_drain = (rand(override_drain / 2, override_drain) / 25)

	if(battery && battery.power_cell.charge > 0)
		if(battery.power_cell.charge > actual_drain)
			battery.power_cell.charge -= actual_drain
		else
			battery.power_cell.charge = 0
			to_chat(usr, SPAN_WARNING("[src] emits a low power warning and immediately shuts down!"))
			return FALSE
		return TRUE
	if(!battery || battery.power_cell.charge == 0)
		balloon_alert(usr, "low power")
		return FALSE
	return FALSE

/obj/item/weapon/gun/smartgun/proc/toggle_recoil_compensation(mob/user)
	to_chat(user, "[icon2html(src, usr)] You [recoil_compensation? "<B>disable</b>" : "<B>enable</b>"] \the [src]'s recoil compensation.")
	playsound(loc,'sound/machines/click.ogg', 25, 1)
	recoil_compensation = !recoil_compensation
	if(recoil_compensation)
		drain += 50
	else
		drain -= 50
	recalculate_attachment_bonuses() //Includes set_gun_config_values() as well as attachments.

/obj/item/weapon/gun/smartgun/proc/toggle_accuracy_improvement(mob/user)
	to_chat(user, "[icon2html(src, usr)] You [accuracy_improvement? "<B>disable</b>" : "<B>enable</b>"] \the [src]'s accuracy improvement.")
	playsound(loc,'sound/machines/click.ogg', 25, 1)
	accuracy_improvement = !accuracy_improvement
	if(accuracy_improvement)
		drain += 50
	else
		drain -= 50
	recalculate_attachment_bonuses()

/obj/item/weapon/gun/smartgun/empty
	current_mag = null

//CO SMARTGUN
/obj/item/weapon/gun/smartgun/co
	name = "\improper M56C 'Cavalier' smartgun"
	desc = "The actual firearm in the 4-piece M56C Smartgun system. Back order only. Besides a more robust weapons casing, an ID lock system and a fancy paintjob, the gun's performance is identical to the standard-issue M56B.\nAlt-click it to open the feed cover and allow for reloading."
	icon_state = "m56c"
	item_state = "m56c"
	var/mob/living/carbon/human/linked_human
	var/is_locked = TRUE

/obj/item/weapon/gun/smartgun/co/Initialize(mapload, ...)
	LAZYADD(actions_types, /datum/action/item_action/co_sg/toggle_id_lock)
	. = ..()

/obj/item/weapon/gun/smartgun/co/able_to_fire(mob/user)
	. = ..()
	if(is_locked && linked_human && linked_human != user)
		if(linked_human.is_revivable() || linked_human.stat != DEAD)
			to_chat(user, SPAN_WARNING("[icon2html(src, usr)] Trigger locked by [src]. Unauthorized user."))
			playsound(loc,'sound/weapons/gun_empty.ogg', 25, 1)
			return FALSE

		linked_human = null
		is_locked = FALSE
		UnregisterSignal(linked_human, COMSIG_PARENT_QDELETING)

// ID lock action \\

/datum/action/item_action/co_sg/action_activate()
	. = ..()
	var/obj/item/weapon/gun/smartgun/co/protag_gun = holder_item
	if(!ishuman(owner))
		return
	var/mob/living/carbon/human/protagonist = owner
	if(protagonist.is_mob_incapacitated() || protag_gun.get_active_firearm(protagonist, FALSE) != holder_item)
		return

/datum/action/item_action/co_sg/update_button_icon()
	return

/datum/action/item_action/co_sg/toggle_id_lock/New(Target, obj/item/holder)
	. = ..()
	name = "Toggle ID lock"
	action_icon_state = "id_lock_locked"
	button.name = name
	button.overlays.Cut()
	button.overlays += image('icons/mob/hud/actions.dmi', button, action_icon_state)

/datum/action/item_action/co_sg/toggle_id_lock/action_activate()
	. = ..()
	var/obj/item/weapon/gun/smartgun/co/protag_gun = holder_item
	protag_gun.toggle_lock()
	if(protag_gun.is_locked)
		action_icon_state = "id_lock_locked"
	else
		action_icon_state = "id_lock_unlocked"
	button.overlays.Cut()
	button.overlays += image('icons/mob/hud/actions.dmi', button, action_icon_state)

/obj/item/weapon/gun/smartgun/co/proc/toggle_lock(mob/user)
	if(linked_human && usr != linked_human)
		to_chat(usr, SPAN_WARNING("[icon2html(src, usr)] Action denied by \the [src]. Unauthorized user."))
		return
	else if(!linked_human)
		name_after_co(usr)

	is_locked = !is_locked
	to_chat(usr, SPAN_NOTICE("[icon2html(src, usr)] You [is_locked? "lock": "unlock"] \the [src]."))
	playsound(loc,'sound/machines/click.ogg', 25, 1)

// action end \\

/obj/item/weapon/gun/smartgun/co/pickup(user)
	if(!linked_human)
		src.name_after_co(user, src)
		to_chat(usr, SPAN_NOTICE("[icon2html(src, usr)] You pick up \the [src], registering yourself as its owner."))
	..()


/obj/item/weapon/gun/smartgun/co/proc/name_after_co(mob/living/carbon/human/H, obj/item/weapon/gun/smartgun/co/I)
	linked_human = H
	RegisterSignal(linked_human, COMSIG_PARENT_QDELETING, PROC_REF(remove_idlock))

/obj/item/weapon/gun/smartgun/co/get_examine_text()
	. = ..()
	if(linked_human)
		if(is_locked)
			. += SPAN_NOTICE("It is registered to [linked_human].")
		else
			. += SPAN_NOTICE("It is registered to [linked_human] but has its fire restrictions unlocked.")
	else
		. += SPAN_NOTICE("It's unregistered. Pick it up to register yourself as its owner.")
	if(!iff_enabled)
		. += SPAN_WARNING("Its IFF restrictions are disabled.")

/obj/item/weapon/gun/smartgun/co/proc/remove_idlock()
	SIGNAL_HANDLER
	linked_human = null

/obj/item/weapon/gun/smartgun/dirty
	name = "\improper M56A3 'Dirty' smartgun"
	desc = "The actual firearm in the 4-piece M56A3 Smartgun System. Ruggedized electronics and a slightly lighter frame are the only differences between this and the standard UA-issue A2 model.\nYou may toggle firing restrictions by using a special action.\nAlt-click it to open the feed cover and allow for reloading."
	flags_gun_features = GUN_WY_RESTRICTED|GUN_SPECIALIST|GUN_WIELDED_FIRING_ONLY
	drain = 30	//Slightly more power effictient than the basic model

/obj/item/weapon/gun/smartgun/dirty/Initialize(mapload, ...)
	. = ..()
	MD.iff_signal = FACTION_PMC


//TERMINATOR SMARTGUN
/obj/item/weapon/gun/smartgun/dirty/elite
	name = "\improper M56A3-T 'Terminator' smartgun"
	current_mag = /obj/item/ammo_magazine/smartgun/dirty
	ammo = /obj/item/ammo_magazine/smartgun/dirty
	ammo_primary = /datum/ammo/bullet/rifle/heavy/dirty //Toggled ammo type
	ammo_secondary = /datum/ammo/bullet/rifle/heavy/ap/dirty ///Toggled ammo type
	ammo_tertiary = /datum/ammo/bullet/rifle/heavy/impdet/dirty
	desc = "The actual firearm in the 4-piece M56A3-T Smartgun System. If you have this, you're about to bring some serious pain to anyone in your way.\nYou may toggle firing restrictions by using a special action.\nAlt-click it to open the feed cover and allow for reloading."

/obj/item/weapon/gun/smartgun/dirty/elite/Initialize(mapload, ...)
	. = ..()
	MD.iff_signal = FACTION_WY_DEATHSQUAD

/obj/item/weapon/gun/smartgun/dirty/elite/set_gun_config_values()
	..()
	set_burst_amount(BURST_AMOUNT_TIER_5)
	set_burst_delay(FIRE_DELAY_TIER_12)
	if(!recoil_compensation)
		scatter = SCATTER_AMOUNT_TIER_8
	burst_scatter_mult = SCATTER_AMOUNT_TIER_10
	set_fire_delay(FIRE_DELAY_TIER_12)
	fa_scatter_peak = FULL_AUTO_SCATTER_PEAK_TIER_10
	fa_max_scatter = SCATTER_AMOUNT_NONE


// CLF SMARTGUN

/obj/item/weapon/gun/smartgun/clf
	name = "\improper M56A2 'Freedom' smartgun"
	desc = "The actual firearm in the 4-piece M56A2 Smartgun System. Essentially a heavy, mobile machinegun. This one has the CLF logo carved over the manufacturing stamp.\nYou may toggle firing restrictions by using a special action.\nAlt-click it to open the feed cover and allow for reloading."

/obj/item/weapon/gun/smartgun/clf/Initialize(mapload, ...)
	. = ..()
	MD.iff_signal = FACTION_CLF

/obj/item/weapon/gun/smartgun/admin
	requires_power = FALSE
	requires_battery = FALSE
	requires_harness = FALSE

/obj/item/smartgun_battery
	name = "\improper DV9 smartgun battery"
	desc = "A standard-issue 9-volt lithium dry-cell battery, most commonly used within the USCMC to power smartguns. Per the manual, one battery is good for up to 50000 rounds and plugs directly into the smartgun's power receptacle, which is only compatible with this type of battery. Various auxiliary modes usually bring the round count far lower. While this cell is incompatible with most standard electrical system, it can be charged by common rechargers in a pinch. USCMC smartgunners often guard them jealously."

	icon = 'icons/obj/structures/machinery/power.dmi'
	icon_state = "smartguncell"

	force = 5
	throwforce = 5
	throw_speed = SPEED_VERY_FAST
	throw_range = 5
	w_class = SIZE_SMALL

	var/obj/item/cell/high/power_cell

/obj/item/smartgun_battery/Initialize(mapload)
	. = ..()

	power_cell = new(src)

/obj/item/smartgun_battery/get_examine_text(mob/user)
	. = ..()

	. += SPAN_NOTICE("The power indicator reads [power_cell.charge] charge out of [power_cell.maxcharge] total.")

/obj/item/smartgun_battery/upp
	name = "\improper GB-12-U3 battery"
	desc = "UPP standard-issue 12-volt lead-acid battery, used by the UPPAC to power just about anything short of armored vehicles. This one seems to be a variant made to power automated machineguns. Also could be used as a blunt weapon."
	icon_state = "smartguncell_upp"
	force = 15
	throwforce = 25 //pretty aerodynamic
	throw_range = 7

/obj/item/weapon/gun/smartgun/rmc
	name = "\improper L58A3 smartgun"
	desc = "The actual firearm in the L58A3 'Smart' General Purpose Machine Gun System. A heavily modified variant of the UA's M56 system, it is used by the Three World Empires Royal Marines Commando units to offer supporting fire for their sections.\nYou may toggle firing restrictions by using a special action.\nAlt-click it to open the feed cover and allow for reloading."
	current_mag = /obj/item/ammo_magazine/smartgun/holo_targeting
	ammo = /obj/item/ammo_magazine/smartgun/holo_targeting
	ammo_primary = /datum/ammo/bullet/rifle/heavy/holo_target //Toggled ammo type
	ammo_secondary = /datum/ammo/bullet/rifle/heavy/holo_target/ap ///Toggled ammo type
	ammo_tertiary = /datum/ammo/bullet/rifle/heavy/holo_target/impdet
	flags_gun_features = GUN_SPECIALIST|GUN_WIELDED_FIRING_ONLY
	zoomdevicename = "gunsight"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/twe_guns.dmi'
	icon_state = "magsg"
	item_state = "magsg"
	starting_attachment_types = list(/obj/item/attachable/l56a2_smartgun)

/obj/item/weapon/gun/smartgun/rmc/Initialize(mapload, ...)
	. = ..()
	MD.iff_signal = FACTION_TWE

/obj/item/weapon/gun/smartgun/rmc/handle_starting_attachment()
	..()
	var/obj/item/attachable/scope/mini/rmcsg/optic = new(src)
	optic.hidden = TRUE
	optic.flags_attach_features &= ~ATTACH_REMOVABLE
	optic.Attach(src)
	update_attachable(optic.slot)

/obj/item/weapon/gun/smartgun/rmc/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_LMG)
	fa_scatter_peak = FULL_AUTO_SCATTER_PEAK_TIER_8
	fa_max_scatter = SCATTER_AMOUNT_TIER_9
	if(accuracy_improvement)
		accuracy_mult += HIT_ACCURACY_MULT_TIER_3
	else
		accuracy_mult += HIT_ACCURACY_MULT_TIER_1
	if(recoil_compensation)
		scatter = SCATTER_AMOUNT_TIER_10
		recoil = RECOIL_OFF
	else
		scatter = SCATTER_AMOUNT_TIER_6
		recoil = RECOIL_AMOUNT_TIER_3
	damage_mult = BASE_BULLET_DAMAGE_MULT

//For the RMC ship, giving them access to weapons early but no ammo
/obj/item/weapon/gun/smartgun/rmc/unloaded
	current_mag = null

/obj/item/weapon/gun/smartgun/silenced
	name = "XM56A4 smartgun"
	desc = "An experimental smartgun variant currently undergoing field testing. This model is outfitted with integrated suppressor and modified internal mechanism."
	starting_attachment_types = list(/obj/item/attachable/smartbarrel/suppressed)

/obj/item/weapon/gun/smartgun/upp
	name = "\improper RVS-37 automated machinegun"
	desc = "A Russian-led project with input from the ground forces of Vietnam and Spain, the RVS-37 \"Canyon\" is the near peer response to the venerable M56 Smartgun."
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/upp.dmi'
	icon_state = "rfvs37"
	item_state = "rfvs37"
	fire_sound = 'sound/weapons/gun_m56d_auto.ogg'
	mouse_pointer = 'icons/effects/mouse_pointer/upp_smartgun_mouse.dmi'
	current_mag = /obj/item/ammo_magazine/smartgun/upp
	ammo = /obj/item/ammo_magazine/smartgun/upp
	ammo_primary = /datum/ammo/bullet/rifle/heavy/upp_smartgun //Toggled ammo type
	ammo_secondary = /datum/ammo/bullet/rifle/heavy/upp_smartgun/ap ///Toggled ammo type
	ammo_tertiary = /datum/ammo/bullet/rifle/heavy/upp_smartgun/flak
	flags_equip_slot = SLOT_BACK|SLOT_BLOCK_SUIT_STORE
	flags_gun_features = GUN_SPECIALIST|GUN_WIELDED_FIRING_ONLY
	flags_item = TWOHANDED|SMARTGUNNER_BACKPACK_OVERRIDE
	starting_attachment_types = list(/obj/item/attachable/upp_smartgun)
	auto_retrieval_slot = WEAR_BACK
	start_semiauto = TRUE
	battery_type = /obj/item/smartgun_battery/upp
	attachable_allowed = list(
		/obj/item/attachable/upp_smartgun,
	)
	actions_types = list(
		/datum/action/item_action/smartgun/toggle_accuracy_improvement,
		/datum/action/item_action/smartgun/toggle_ammo_type,
		/datum/action/item_action/smartgun/toggle_lethal_mode,
		/datum/action/item_action/smartgun/toggle_recoil_compensation,
		/datum/action/item_action/smartgun/toggle_retrieval,
	)

/obj/item/weapon/gun/smartgun/upp/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 36, "muzzle_y" = 16,"rail_x" = 17, "rail_y" = 18, "under_x" = 22, "under_y" = 14, "stock_x" = 22, "stock_y" = 14, , "side_rail_x" = 17, "side_rail_y" = 18)

/obj/item/weapon/gun/smartgun/upp/toggle_ammo_type(mob/user)
	if(!iff_enabled)
		to_chat(user, "[icon2html(src, usr)] Can't switch ammunition type when \the [src]'s fire restriction is disabled.")
		return
	if(ammo == ammo_primary)
		ammo = ammo_secondary
		to_chat(user, "[icon2html(src, usr)] You changed \the [src]'s ammo preparation procedures. You now fire armor-piercing rounds, offering greater penetration against armored targets compared to other rounds.")
		balloon_alert(user, "firing armor-piercing")
		drain += 50
	else if(ammo == ammo_secondary)
		ammo = ammo_tertiary
		to_chat(user, "[icon2html(src, usr)] You changed \the [src]'s ammo preparation procedures. You now fire flak rounds, which release a rain of heavy shrapnel.")
		balloon_alert(user, "firing flak")
		drain += 100
	else
		ammo = ammo_primary
		to_chat(user, "[icon2html(src, usr)] You changed \the [src]'s ammo preparation procedures. You now fire highly precise rounds. These rounds are accurate and cost less power to operate.")
		balloon_alert(user, "firing highly precise")
		drain -= 150
	playsound(loc,'sound/machines/click.ogg', 25, 1)
	var/datum/action/item_action/smartgun/toggle_ammo_type/TAT = locate(/datum/action/item_action/smartgun/toggle_ammo_type) in actions
	TAT.update_icon()

/obj/item/weapon/gun/smartgun/upp/set_gun_config_values()
	..()
	set_burst_amount(BURST_AMOUNT_TIER_3)
	set_burst_delay(FIRE_DELAY_TIER_8)
	set_fire_delay(FIRE_DELAY_TIER_10)
	fa_scatter_peak = FULL_AUTO_SCATTER_PEAK_TIER_8
	fa_max_scatter = SCATTER_AMOUNT_TIER_9
	if(accuracy_improvement)
		accuracy_mult += HIT_ACCURACY_MULT_TIER_6
	else
		accuracy_mult += HIT_ACCURACY_MULT_TIER_3
	if(recoil_compensation)
		scatter = SCATTER_AMOUNT_TIER_10
		recoil = RECOIL_OFF
	else
		scatter = SCATTER_AMOUNT_TIER_6
		recoil = RECOIL_AMOUNT_TIER_3
	damage_mult = BASE_BULLET_DAMAGE_MULT

/datum/action/item_action/smartgun/toggle_retrieval/New(Target, obj/item/holder)
	. = ..()
	name = "Toggle Retrieval"
	action_icon_state = "retrieve_1"
	button.name = name
	button.overlays.Cut()
	button.overlays += image('icons/mob/hud/actions.dmi', button, action_icon_state)

/datum/action/item_action/smartgun/toggle_retrieval/action_activate()
	. = ..()
	var/obj/item/weapon/gun/smartgun/gun = holder_item
	if(gun.auto_retrieval_slot)
		gun.auto_retrieval_slot = null
		gun.RemoveElement(/datum/element/drop_retrieval/gun, WEAR_BACK)
		action_icon_state = "retrieve_0"
	else
		gun.auto_retrieval_slot = WEAR_BACK
		gun.AddElement(/datum/element/drop_retrieval/gun, WEAR_BACK)
		action_icon_state = "retrieve_1"
	button.overlays.Cut()
	button.overlays += image('icons/mob/hud/actions.dmi', button, action_icon_state)
