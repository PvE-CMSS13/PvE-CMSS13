// Only a single flag for now, so no reason to global define.
#define FLAGS_TENT_GIVE_MEDICAL_BONUS (1<<0)

/// Structures serving as landmarks and providing a buff to its users.
/// A notable code feature is that they use a separate roof image that phases out when you enter the tent.
/obj/structure/tent
	name = "tent"
	icon = 'icons/obj/structures/tents_deployed_classic.dmi'
	desc = "Can be torn down with an entrenching tool."
	opacity = FALSE // Seems only the initial turf blocks light, not all of the multitile. Therefore, useless.
	layer = INTERIOR_WALL_SOUTH_LAYER
	health = 200
	appearance_flags = TILE_BOUND

	/// Turf dimensions along the X axis, beginning from left, at ground level
	var/x_dim = 2
	/// Turf dimensions along the Y axis, beginning from bottom, at ground level
	var/y_dim = 4
	/// locs of the tent minus entrance turfs. We use these to determine the active bounds of the tent.
	var/list/bound_turfs

	/// How much cold protection to add to entering humans - Full body clothing means complete (1) protection
	var/cold_protection_factor = 0.4

	/// Roof display icon_state or null to disable
	var/roof_state
	/// Roof image displayed on the roof plane
	var/obj/effect/roof_visible_obj
	/// This is the image object that overrides our roof, outputted to clients who need to see it.
	var/image/roof_hidden_image
	/// Our masking object to fade the external gameplane while inside the tent. Only outputted when needed.
	var/image/building_mask_image

	var/flags_tent = NO_FLAGS

	/// Medical boost it gives with FLAGS_TENT_GIVE_MEDICAL_BONUS.
	var/surgery_speed_mult = 0
	var/surgery_pain_reduction = 0

/obj/structure/tent/Initialize(mapload, ...)
	. = ..()
	bound_width = x_dim * world.icon_size
	bound_height = y_dim * world.icon_size
	bound_turfs = locs - locate_entrances()
	register_turf_signals()
	RegisterSignal(src, COMSIG_ATOM_TURF_CHANGE, PROC_REF(register_turf_signals))

	switch(SSmapping.configs[GROUND_MAP].camouflage_type)
		if("jungle")
			icon = 'icons/obj/structures/tents_deployed_jungle.dmi'
		if("desert")
			icon = 'icons/obj/structures/tents_deployed_desert.dmi'
		if("snow")
			icon = 'icons/obj/structures/tents_deployed_snow.dmi'
		if("urban")
			icon = 'icons/obj/structures/tents_deployed_urban.dmi'

	if(roof_state)
		roof_visible_obj = new()
		roof_visible_obj.vis_flags = VIS_INHERIT_ID|VIS_INHERIT_ICON
		roof_visible_obj.plane = ROOF_VISIBLE_PLANE
		roof_visible_obj.icon_state = roof_state
		vis_contents += roof_visible_obj

		roof_hidden_image = image(icon, roof_visible_obj, roof_state, CEILING_FIXTURE_LAYER, dir)
		roof_hidden_image.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
		roof_hidden_image.plane = ROOF_HIDDEN_PLANE
		roof_hidden_image.appearance_flags = KEEP_TOGETHER
		roof_hidden_image.override = TRUE

		building_mask_image = image(icon, src, "[icon_state]_fov_blocker", ABOVE_FLY_LAYER, dir)
		building_mask_image.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
		building_mask_image.plane = BUILDING_MASK_PLANE

/obj/structure/tent/Destroy()
	vis_contents -= roof_visible_obj
	QDEL_NULL(roof_visible_obj)
	QDEL_NULL(roof_hidden_image)
	QDEL_NULL(building_mask_image)
	. = ..()

/// Small helper proc to determine where the entrances are located, dynamically.
/obj/structure/tent/proc/locate_entrances(list/entrance_offset)
	if(!entrance_offset)
		return FALSE
	var/offset_copy[] = entrance_offset.Copy()
	var/turf/current_turf
	var/entrance_turfs[0]
	var/entrance_length = length(offset_copy) * 0.5
	while(entrance_length-- > 0)
		current_turf = locate(offset_copy[1] + x, offset_copy[2] + y, z)
		entrance_turfs += current_turf
		offset_copy.Cut(1, 3)
	return entrance_turfs

/obj/structure/tent/proc/register_turf_signals()
	SIGNAL_HANDLER
	for(var/turf/turf in bound_turfs)
		RegisterSignal(turf, COMSIG_TURF_ENTERED, PROC_REF(movable_entering_tent), override = TRUE)

/obj/structure/tent/proc/movable_entering_tent(turf/hooked, mob/subject_mob)
	SIGNAL_HANDLER

	/*
	* MOB_COVERED_FROM_WEATHER isn't super accurate, but it's fine as a generic boolean for the time being.
	* flags_atom is full of completely irrelevant garbage, so I don't want to add to that. Ideally,
	* flags_movable_atom would be a thing. Or at least a better organization of current flags into proper
	* categories.
	*/
	if(!istype(subject_mob) || subject_mob.mob_flags & MOB_COVERED_FROM_WEATHER)
		return FALSE

	RegisterSignal(subject_mob, list(COMSIG_MOVABLE_TURF_ENTERED), PROC_REF(mob_moved))
	subject_mob.RegisterSignal(src, COMSIG_PARENT_QDELETING, TYPE_PROC_REF(/mob, tent_deletion_clean_up))
	if(ishuman(subject_mob))
		RegisterSignal(subject_mob, COMSIG_HUMAN_COLD_PROTECTION_APPLY_MODIFIERS, PROC_REF(cold_protection))
		if(flags_tent & FLAGS_TENT_GIVE_MEDICAL_BONUS)
			RegisterSignal(subject_mob, COMSIG_HUMAN_SURGERY_APPLY_MODIFIERS, PROC_REF(apply_surgery_modifiers))

	// Mob entered our humble tent.
	if(roof_visible_obj && subject_mob.client && subject_mob.hud_used)
		var/atom/movable/screen/plane_master/roof_plane = subject_mob.hud_used.plane_masters["[ROOF_HIDDEN_PLANE]"]
		var/atom/movable/screen/plane_master/building_mask_plane = subject_mob.hud_used.plane_masters["[BUILDING_MASK_PLANE]"]
		if(roof_plane)
			subject_mob.client.images |= roof_hidden_image /// Roof_vis_obj may not exist.
			animate(roof_plane.relay, alpha = 40, time = 0.5 SECONDS)
		if(building_mask_plane)
			subject_mob.client.images |= building_mask_image
			building_mask_plane.relay.mouse_opacity = MOUSE_OPACITY_TRANSPARENT /// Changes to trasparent, so that we can't see what is outside.
			var/filter_color = building_mask_plane.relay.get_filter("fov_color")
			var/filter_blur = building_mask_plane.relay.get_filter("motion_blur")
			animate(filter_color, color = list(0,0,0,0, 0,0,0,0, 1,1,1,0, 0,0,0,1, 0,0,0,0), time = 0.5 SECONDS)
			animate(building_mask_plane.relay, alpha = 225, time = 0.5 SECONDS, flags = ANIMATION_PARALLEL)
			animate(filter_blur, x=1, y=1, time = 0.5 SECONDS, flags = ANIMATION_PARALLEL)

	// This will prevent weather effects from influencing their screen (also stops physical effects, for the time being).
	subject_mob.mob_flags |= MOB_COVERED_FROM_WEATHER
	return TRUE

/obj/structure/tent/proc/cold_protection(mob/source, list/protection_data)
	SIGNAL_HANDLER
	protection_data["protection"] += cold_protection_factor

/obj/structure/tent/proc/mob_moved(mob/subject, turf/target_turf)
	SIGNAL_HANDLER
	if(!(target_turf in bound_turfs)) // Exited the tent
		mob_exited_tent(subject)

/obj/structure/tent/proc/mob_exited_tent(mob/subject_mob)
	UnregisterSignal(subject_mob, list(COMSIG_MOVABLE_TURF_ENTERED, COMSIG_HUMAN_COLD_PROTECTION_APPLY_MODIFIERS, COMSIG_HUMAN_SURGERY_APPLY_MODIFIERS))
	subject_mob.UnregisterSignal(src, COMSIG_PARENT_QDELETING)

	if(roof_visible_obj && subject_mob.client) /// Only matters if the mob has a client.
		if(subject_mob.hud_used)
			var/atom/movable/screen/plane_master/roof_plane = subject_mob.hud_used.plane_masters["[ROOF_HIDDEN_PLANE]"]
			var/atom/movable/screen/plane_master/building_mask_plane = subject_mob.hud_used.plane_masters["[BUILDING_MASK_PLANE]"]
			if(roof_plane)
				animate(roof_plane.relay, alpha = 255, time = 0.5 SECONDS)
			if(building_mask_plane)
				building_mask_plane.relay.mouse_opacity = MOUSE_OPACITY_ICON /// The default, icon-based.
				var/filter_color = building_mask_plane.relay.get_filter("fov_color")
				var/filter_blur = building_mask_plane.relay.get_filter("motion_blur")
				animate(filter_color, color = list(1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1, 0,0,0,0), time = 0.5 SECONDS)
				animate(building_mask_plane.relay, alpha = 255, time = 0.5 SECONDS, flags = ANIMATION_PARALLEL)
				animate(filter_blur, x=0, y=0, time = 0.5 SECONDS, flags = ANIMATION_PARALLEL)
		if(QDELING(src)) /// Tent is being deleted, remove the images right away.
			subject_mob.client.images -= list(roof_hidden_image, building_mask_image)
		else /// Gives time for animations.
			addtimer(CALLBACK(src, PROC_REF(remove_client_image), subject_mob), 0.5 SECONDS)

	subject_mob.mob_flags &= ~MOB_COVERED_FROM_WEATHER // Remove the flag.
	return TRUE

/mob/proc/tent_deletion_clean_up(obj/structure/tent/deleting_tent)
	SIGNAL_HANDLER
	deleting_tent.mob_exited_tent(src)

/obj/structure/tent/proc/remove_client_image(mob/subject_mob)
	if(QDELETED(subject_mob) || (get_turf(subject_mob) in bound_turfs))
		return FALSE
	subject_mob.client?.images -= list(roof_hidden_image, building_mask_image)
	return TRUE

/obj/structure/tent/attack_alien(mob/living/carbon/xenomorph/M)
	if(unslashable)
		return

	M.animation_attack_on(src)
	health -= rand(M.melee_damage_lower, M.melee_damage_upper)
	playsound(src, 'sound/items/paper_ripped.ogg', 25, 1)

	M.visible_message(SPAN_DANGER("[M] [M.slashes_verb] [src]!"), \
	SPAN_DANGER("You [M.slash_verb] [src]!"), null, 5, CHAT_TYPE_XENO_COMBAT)

	if(health <= 0)
		visible_message(SPAN_BOLDWARNING("[src] collapses!"))
		qdel(src)

	return XENO_ATTACK_ACTION

/obj/structure/tent/attackby(obj/item/item, mob/user)
	var/obj/item/tool/shovel/shovel = item
	if(!istype(shovel) || shovel.folded || user.action_busy)
		return
	visible_message(SPAN_HIGHDANGER("[user] is trying to tear down [src]!"))
	playsound(src, 'sound/items/paper_ripped.ogg', 25, 1)

	if(!do_after(user, 150, INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_HOSTILE, src) || QDELETED(src))
		return

	visible_message(SPAN_HIGHDANGER("[user] tears down [src]!"))
	playsound(src, 'sound/items/paper_ripped.ogg', 25, 1)
	qdel(src)

/obj/structure/tent/get_projectile_hit_boolean(obj/projectile/P)
	. = ..()
	return FALSE // Always fly through the tent

/// Command tent, providing basics for field command: a phone, and an overwatch console
/obj/structure/tent/cmd
	icon_state = "cmd_interior"
	roof_state = "cmd_top"
	desc = "A standard USCM Command Tent. This one comes equipped with a self-powered Overwatch Console and a Telephone. It is very frail, do not burn, expose to sharp objects, or explosives. Can be torn down with an entrenching tool."

/obj/structure/tent/cmd/locate_entrances(list/entrance_offset = list(0, 0, 1, 0))
	. = ..()

/// Medical tent, procures a buff to surgery speed
/obj/structure/tent/med
	icon_state = "med_interior"
	roof_state = "med_top"
	desc = "A standard USCM Medical Tent. This one comes equipped with advanced field surgery facilities. It is very fragile however and won't withstand the rigors of war. Can be torn down with an entrenching tool."
	flags_tent = FLAGS_TENT_GIVE_MEDICAL_BONUS
	surgery_speed_mult = 0.9
	surgery_pain_reduction = 5

/obj/structure/tent/med/locate_entrances(list/entrance_offset = list(0, 0, 1, 0))
	. = ..()

/// While the proc is now generic and can be applied elsewhere, easier to find it here.
/obj/structure/tent/proc/apply_surgery_modifiers(mob/living/carbon/human/source, list/surgery_data)
	SIGNAL_HANDLER
	surgery_data["surgery_speed"] *= surgery_speed_mult
	surgery_data["pain_reduction"] += surgery_pain_reduction

/// Big Tent. It's just Big. Use it for shelter or organization!
/obj/structure/tent/big
	icon_state = "big_interior"
	roof_state = "big_top"
	x_dim = 3
	y_dim = 4

/obj/structure/tent/big/locate_entrances(list/entrance_offset = list(0, 0, 1, 0, 2, 0))
	. = ..()

/obj/structure/tent/reqs
	icon_state = "reqs_interior"
	roof_state = "reqs_top"
	x_dim = 4
	y_dim = 4

/obj/structure/tent/reqs/locate_entrances(list/entrance_offset = list(0, 0, 1, 0))
	. = ..()

#undef FLAGS_TENT_GIVE_MEDICAL_BONUS
