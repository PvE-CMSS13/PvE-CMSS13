/datum/faction
	var/name = "Neutral Faction"
	var/faction_tag = FACTION_NEUTRAL
	var/list/faction_tag_group //Should be generated on New(), if it needs one. Set faction_tag to null in that case. Factions that use the same hud/procs.
	var/hud_type = FACTION_HUD
	var/skip_init = FALSE //In case we don't want initialize the subtype.

/datum/faction/proc/modify_hud_holder(image/holder, mob/living/carbon/human/H)
	return

/datum/faction/proc/get_antag_guns_snowflake_equipment()
	return list()

/datum/faction/proc/get_antag_guns_sorted_equipment()
	return list()
