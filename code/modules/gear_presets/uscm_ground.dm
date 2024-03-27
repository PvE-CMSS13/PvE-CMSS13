//Squad/Platoon roles are in uscm.dm. Synth is in synths.dm.

/datum/equipment_preset/uscm_ground
	faction = FACTION_USCM_GROUND
	faction_group = FACTION_LIST_MARINE
	languages = list(LANGUAGE_ENGLISH)
	idtype = /obj/item/card/id/dogtag

	utility_under = list(/obj/item/clothing/under/marine)
	utility_hat = list(/obj/item/clothing/head/cmcap)
	utility_gloves = list(/obj/item/clothing/gloves/marine)
	utility_shoes = list(/obj/item/clothing/shoes/marine)
	utility_extra = list(/obj/item/clothing/head/beret/cm, /obj/item/clothing/head/beret/cm/tan)

	service_under = list(/obj/item/clothing/under/marine/officer/bridge)
	service_over = list(/obj/item/clothing/suit/storage/jacket/marine/service, /obj/item/clothing/suit/storage/jacket/marine/service/mp)
	service_hat = list(/obj/item/clothing/head/cmcap)
	service_shoes = list(/obj/item/clothing/shoes/dress)

	dress_under = list(/obj/item/clothing/under/marine/dress)
	dress_over = list(/obj/item/clothing/suit/storage/jacket/marine/dress)
	dress_hat = list(/obj/item/clothing/head/marine/peaked)
	dress_gloves = list(/obj/item/clothing/gloves/marine/dress)
	dress_shoes = list(/obj/item/clothing/shoes/dress)

//*****************************************************************************************************/

/datum/equipment_preset/uscm_ground/oco
	name = "USCM Outpost Commanding Officer (OCO)"
	flags = EQUIPMENT_PRESET_START_OF_ROUND|EQUIPMENT_PRESET_MARINE

	idtype = /obj/item/card/id/gold
	assignment = JOB_USCM_GROUND_CO
	rank = JOB_USCM_GROUND_CO
	paygrade = "MO3"
	role_comm_title = "OCO"
	minimum_age = 30
	skills = /datum/skills/XO

	minimap_icon = list("cic" = MINIMAP_ICON_COLOR_COMMANDER)
	minimap_background = MINIMAP_ICON_BACKGROUND_CIC

	dress_extra = list(/obj/item/storage/large_holster/ceremonial_sword/full)

/datum/equipment_preset/uscm_ground/oco/New()
	. = ..()
	access = list(
		ACCESS_USCM_GROUND_GENERAL,
		ACCESS_USCM_GROUND_MAINT,
		ACCESS_USCM_GROUND_SYNTH,
		ACCESS_USCM_GROUND_MEDICAL,
		ACCESS_USCM_GROUND_ARMORY,
		ACCESS_USCM_GROUND_GUEST,
		ACCESS_USCM_GROUND_LOCKDOWN,
		ACCESS_USCM_GROUND_PLATOONL,
		ACCESS_USCM_GROUND_CO_OFFICE,
		ACCESS_USCM_GROUND_CO_QUARTERS,
		ACCESS_USCM_GROUND_LT,
		ACCESS_USCM_GROUND_WAREHOUSE,
		ACCESS_USCM_GROUND_COMMAND,
		ACCESS_USCM_GROUND_CHECKPOINT,
	)

/datum/equipment_preset/uscm_ground/oco/load_race(mob/living/carbon/human/new_human, client/mob_client)
	..()
	ADD_TRAIT(new_human, TRAIT_EMOTE_CD_EXEMPT, TRAIT_SOURCE_JOB)

/datum/equipment_preset/uscm_ground/oco/load_gear(mob/living/carbon/human/new_human)
	var/back_item = /obj/item/storage/backpack/satchel
	if (new_human.client && new_human.client.prefs && (new_human.client.prefs.backbag == 1))
		back_item = /obj/item/storage/backpack/marine

	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/uscm_ground/cmd(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/officer/bridge(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/service(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/dress(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/marine/peaked/service(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new back_item(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/large(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/large(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/mateba/cmateba/full(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/storage/mateba_case/captain(new_human), WEAR_IN_BACK)

//*****************************************************************************************************/

/datum/equipment_preset/uscm_ground/ao
	name = "USCM Outpost Adjunct Officer (AO)"
	flags = EQUIPMENT_PRESET_START_OF_ROUND|EQUIPMENT_PRESET_MARINE

	idtype = /obj/item/card/id/silver
	assignment = JOB_USCM_GROUND_AO
	rank = JOB_USCM_GROUND_AO
	paygrade = "MO2"
	role_comm_title = "AO"
	minimum_age = 27
	skills = /datum/skills/auxiliary_officer

	minimap_icon = list("cic" = MINIMAP_ICON_COLOR_HEAD)
	minimap_background = MINIMAP_ICON_BACKGROUND_CIC

/datum/equipment_preset/uscm_ground/ao/New()
	. = ..()
	access = list(
		ACCESS_USCM_GROUND_GENERAL,
		ACCESS_USCM_GROUND_MAINT,
		ACCESS_USCM_GROUND_SYNTH,
		ACCESS_USCM_GROUND_MEDICAL,
		ACCESS_USCM_GROUND_ARMORY,
		ACCESS_USCM_GROUND_GUEST,
		ACCESS_USCM_GROUND_LOCKDOWN,
		ACCESS_USCM_GROUND_PLATOONL,
		ACCESS_USCM_GROUND_LT,
		ACCESS_USCM_GROUND_CO_OFFICE,
		ACCESS_USCM_GROUND_WAREHOUSE,
		ACCESS_USCM_GROUND_COMMAND,
		ACCESS_USCM_GROUND_CHECKPOINT,
	)

/datum/equipment_preset/uscm_ground/ao/load_gear(mob/living/carbon/human/new_human)
	var/back_item = /obj/item/storage/backpack/satchel
	if (new_human.client && new_human.client.prefs && (new_human.client.prefs.backbag == 1))
		back_item = /obj/item/storage/backpack/marine

	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/uscm_ground/cmd(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/officer/bridge(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new back_item(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/large(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/large(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range(new_human), WEAR_L_STORE)

//*****************************************************************************************************/

/datum/equipment_preset/uscm_ground/civilian
	name = "USCM Outpost Visiting Civilian (Random)"
	flags = EQUIPMENT_PRESET_START_OF_ROUND

	access = list(ACCESS_USCM_GROUND_GUEST)
	assignment = JOB_USCM_GROUND_CIVILIAN
	rank = JOB_USCM_GROUND_CIVILIAN
	paygrade = "C"
	role_comm_title = "Civ"
	skills = /datum/skills/civilian/researcher
	idtype = /obj/item/card/id/silver/cl

	minimap_icon = "civilian"
	minimap_background = MINIMAP_ICON_BACKGROUND_CIVILIAN
	var/spec //Selects some things for them at random at spawn. Not meant to be configurable.

#define CIVILIAN_BIOLOGIST "Biologist"
#define CIVILIAN_ARACHAEOLOGIST "Archaeologist"
#define CIVILIAN_ANTHROPOLOGIST "Anthropologist"
#define CIVILIAN_LINGUIST "Linguist"

/datum/equipment_preset/uscm_ground/civilian/load_preset()
	spec = pick(CIVILIAN_BIOLOGIST, CIVILIAN_ARACHAEOLOGIST, CIVILIAN_ANTHROPOLOGIST, CIVILIAN_LINGUIST)
	assignment = initial(assignment) + "- [spec]"

	if(spec == CIVILIAN_LINGUIST)
		languages = ALL_HUMAN_LANGUAGES //Linguists get all human languages, but they have fewer skills.
		skills = /datum/skills/civilian/researcher/linguist
	else
		skills = initial(skills)
		languages = initial(languages)

	return ..()

/datum/equipment_preset/uscm_ground/civilian/load_gear(mob/living/carbon/human/new_human)
	var/back_item = /obj/item/storage/backpack/satchel

	new_human.equip_to_slot_or_del(new back_item(new_human), WEAR_BACK)
	switch(spec)
		if(CIVILIAN_BIOLOGIST)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/under/rank/worker_overalls (new_human), WEAR_BODY)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/brown(new_human), WEAR_FEET)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/botanic_leather(new_human), WEAR_HANDS)
			new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/vials/full(new_human), WEAR_R_STORE)
			new_human.equip_to_slot_or_del(new /obj/item/device/mass_spectrometer(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/device/analyzer/plant_analyzer(new_human), WEAR_IN_BACK)

		if(CIVILIAN_ARACHAEOLOGIST)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/under/liaison_suit/brown(new_human), WEAR_BODY)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/hiking(new_human), WEAR_FEET)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/bomber(new_human), WEAR_JACKET)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/det_hat(new_human), WEAR_HEAD)
			new_human.equip_to_slot_or_del(new /obj/item/device/binoculars(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/tool/hand_labeler(new_human), WEAR_IN_BACK)

		if(CIVILIAN_ANTHROPOLOGIST)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/under/tshirt/r_bla(new_human), WEAR_BODY)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/leather(new_human), WEAR_FEET)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/vest/grey(new_human), WEAR_JACKET)
			new_human.equip_to_slot_or_del(new /obj/item/folder(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/device/camera(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/device/camera_film(new_human), WEAR_IN_BACK)

		if(CIVILIAN_LINGUIST)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/under/suit_jacket/red, WEAR_BODY)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(new_human), WEAR_FEET)
			new_human.equip_to_slot_or_del(new /obj/item/device/taperecorder(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/notepad(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/folder(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/tool/pen/fountain(new_human), WEAR_IN_BACK)

	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/uscm_ground(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/device/flashlight(new_human), WEAR_L_HAND)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/large(new_human), WEAR_L_STORE)

#undef CIVILIAN_BIOLOGIST
#undef CIVILIAN_ARACHAEOLOGIST
#undef CIVILIAN_ANTHROPOLOGIST
#undef CIVILIAN_LINGUIST

//*****************************************************************************************************/
