/**
 * A datum that stores relevant faction information, hud icon procs, and other relevant info.
 *
 * I don't exactly know what the original intent of this datum was, but as of right now it's a way to categorize and expand faction bookkeeping.
 * As of writing this note, only the major factions are represented, and allow for group behavior, sub-faction behavior, and other functions.
 * More factions can be added, so long as they are strictly defined, but it may not needed unless those factions have a major presence.
 * Smaller factions should probably be rolled into larger categories. Such a VAI being a subfaction of mercs.
 * One possible major addition that is not already implemented is Yautja, or predators.
 */
/datum/faction
	var/name = "Neutral Faction"
	var/faction_tag = FACTION_NEUTRAL
	var/list/faction_tag_group //Should be generated on New(), if it needs one. Set faction_tag to null in that case. Factions that use the same hud/procs, or sub-factions of one main faction.
	var/hud_type = FACTION_HUD
	var/skip_init = FALSE //In case we don't want initialize the subtype.
	var/access_all = ACCESS_LIST_COLONIAL_ALL //All of the access for that faction. These should be properly configured for new factions.
	var/access_main = ACCESS_LIST_COLONIAL_ALL //Main access, but not all access. Not strictly necessary, can be the same as access_all.
	var/access_regions = ACCESS_LIST_COLONIAL_REGIONS //Region map for the ID changer.

/datum/faction/proc/modify_hud_holder(image/holder, mob/living/carbon/human/H)
	return

/datum/faction/proc/get_antag_guns_snowflake_equipment()
	return list()

/datum/faction/proc/get_antag_guns_sorted_equipment()
	return list()

/// Overwrite this if the check needs to account for something special, like sub-factions. uscm.dm for an example.
/datum/faction/proc/get_faction_access(faction_to_check, all_access = TRUE)
	return get_access(all_access ? access_all : access_main)

/// Pretty straightforward. Override if you need it to return a variant list.
/datum/faction/proc/get_faction_regions(faction_to_check)
	return get_access(access_regions)
/**
 * Returns a list of faction departments.
 *
 * Ovewrite this for individual factions if they get their own ID changing consoles. Might be useful elsewhere. Grabs a list of roles mapped to various departments. Check job.dm defines.
 * Since there are no proper colonist jobs, instead having survivors, this is defaulted to the marine role list. Update as needed.
 */
/datum/faction/proc/get_faction_departments(faction_to_check)
	if(Check_WO())//This check is a crutch for now. WO can be removed entirely given that it's pretty old and is mostly replaced by Remote Outpost.
		return list(
			"Command" = ROLES_CIC & ROLES_WO,
			"Auxiliary Command" = ROLES_AUXIL_SUPPORT & ROLES_WO,
			"Miscellaneous" = ROLES_MISC & ROLES_WO,
			"Security" = ROLES_POLICE & ROLES_WO,
			"Engineering" = ROLES_ENGINEERING & ROLES_WO,
			"Supply" = ROLES_REQUISITION & ROLES_WO,
			"Medical and Science" = ROLES_MEDICAL & ROLES_WO,
			"Marines" = ROLES_MARINES
		)
	else
		return list(
			"Command" = ROLES_CIC - ROLES_WO,
			"Auxiliary Command" = ROLES_AUXIL_SUPPORT - ROLES_WO,
			"Miscellaneous" = ROLES_MISC - ROLES_WO,
			"Security" = ROLES_POLICE - ROLES_WO,
			"Engineering" = ROLES_ENGINEERING - ROLES_WO,
			"Supply" = ROLES_REQUISITION - ROLES_WO,
			"Medical and Science" = ROLES_MEDICAL - ROLES_WO,
			"Marines" = ROLES_MARINES
		)
