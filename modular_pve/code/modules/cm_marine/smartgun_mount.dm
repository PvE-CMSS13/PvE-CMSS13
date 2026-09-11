/obj/structure/machinery/m56d_hmg/mg_turret/whiskey_pve
	rounds = 700 //I don't want them to have stupid amounts of ammo.
	rounds_max = 700

/// Pretty much identical to a wired barricade.
/obj/structure/machinery/m56d_hmg/mg_turret/whiskey_pve/initialize_pass_flags(datum/pass_flags_container/pass_flags)
	..()
	if (pass_flags)
		pass_flags.flags_can_pass_all = NONE /// Resets default flags.
		pass_flags.flags_can_pass_front = NONE
		pass_flags.flags_can_pass_behind = PASS_OVER^(PASS_OVER_ACID_SPRAY|PASS_OVER_THROW_MOB)

/// Special handling since this object is not ON_BORDER, we have to manually check how the pass is going to work.
/obj/structure/machinery/m56d_hmg/mg_turret/whiskey_pve/BlockedPassDirs(atom/movable/mover, target_dir)
	var/mover_flags_pass = (mover.pass_flags.flags_pass|mover.flags_pass_temp) & ~mover.flags_pass_temp_negative
	/// It normally only checks can_pass_behind when moving out of a turf through BlockedExitDirs().
	return (mover_flags_pass & pass_flags.flags_can_pass_behind && target_dir != REVERSE_DIR(dir)) ? NO_BLOCKED_MOVEMENT : ..()

/obj/structure/machinery/m56d_hmg/mg_turret/whiskey_pve/folding //folding barricade version.
	desc = "A scoped M56D heavy machine gun mounted behind a metal shield. Drag its sprite onto yourself to man it. Ctrl-click it to toggle burst fire."
	icon_state = "towergun_folding"
	icon_full = "towergun_folding"
	icon_empty = "towergun_folding"
