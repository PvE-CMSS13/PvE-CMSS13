/datum/equipment_preset/uscm_ground
	faction = FACTION_MARINE
	faction_group = FACTION_LIST_UA
	languages = list(LANGUAGE_ENGLISH)
	idtype = /obj/item/card/id/dogtag

//USCM Outpost Marines

/datum/equipment_preset/uscm_ground/oco
	name = "USCM Outpost Commanding Officer (OCO)"
	flags = EQUIPMENT_PRESET_START_OF_ROUND|EQUIPMENT_PRESET_MARINE

	idtype = /obj/item/card/id/gold
	assignment = JOB_USCM_GROUND_CO
	rank = JOB_USCM_GROUND_CO
	paygrades = list(PAY_SHORT_MO3 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "OCO"
	minimum_age = 30
	skills = /datum/skills/oco

	minimap_icon = list("cic" = MINIMAP_ICON_COLOR_COMMANDER)
	minimap_background = MINIMAP_ICON_BACKGROUND_CIC

/datum/equipment_preset/uscm_ground/oco/New()
	. = ..()
	access = get_access(ACCESS_LIST_MARINE_ALL)

/datum/equipment_preset/uscm_ground/oco/load_race(mob/living/carbon/human/new_human, client/mob_client)
	..()
	ADD_TRAIT(new_human, TRAIT_EMOTE_CD_EXEMPT, TRAIT_SOURCE_JOB)

/datum/equipment_preset/uscm_ground/oco/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/mcom/cdrcom(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/officer/bridge(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/service(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/marine/peaked/service(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/large(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/large(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/m4a3/m1911/forecon_officer(new_human), WEAR_WAIST)

//*****************************************************************************************************/

/datum/equipment_preset/uscm_ground/ao
	name = "USCM Outpost Adjutant Officer (AO)"
	flags = EQUIPMENT_PRESET_START_OF_ROUND|EQUIPMENT_PRESET_MARINE

	idtype = /obj/item/card/id/silver
	assignment = JOB_USCM_GROUND_AO
	rank = JOB_USCM_GROUND_AO
	paygrades = list(PAY_SHORT_MO2 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "AO"
	minimum_age = 27
	skills = /datum/skills/AO

	minimap_icon = list("cic" = MINIMAP_ICON_COLOR_HEAD)
	minimap_background = MINIMAP_ICON_BACKGROUND_CIC

/datum/equipment_preset/uscm_ground/ao/New()
	. = ..()
	access = get_access(ACCESS_LIST_MARINE_MAIN)

/datum/equipment_preset/uscm_ground/ao/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/mcom/cdrcom(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/officer/boiler(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/service(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/bridge(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/large(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/large(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range(new_human), WEAR_L_STORE)

//USCM Outpost Support/Command staff

/datum/equipment_preset/synth/uscm/uscm_ground
	name = "USCM Outpost Maintenance Synthetic"
	assignment = "Maintenance Synthetic"
	rank = JOB_USCM_GROUND_SYNTH

/datum/equipment_preset/synth/uscm/uscm_ground/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/mcom/synth/outpost(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/rank/synthetic(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/white(new_human), WEAR_FEET)

//USCM Outpost Civillian staff

/datum/equipment_preset/uscm_ground/civilian
	name = "USCM Outpost Visiting Civilian (Random)"
	flags = EQUIPMENT_PRESET_START_OF_ROUND

	faction = FACTION_NEUTRAL

	access = list(ACCESS_CIVILIAN_PUBLIC)
	assignment = JOB_USCM_GROUND_CIVILIAN
	rank = JOB_USCM_GROUND_CIVILIAN
	paygrades = list(PAY_SHORT_CIV = JOB_PLAYTIME_TIER_0)
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
	faction_group = FACTION_LIST_UA + FACTION_NEUTRAL
	spec = pick(CIVILIAN_BIOLOGIST, CIVILIAN_ARACHAEOLOGIST, CIVILIAN_ANTHROPOLOGIST, CIVILIAN_LINGUIST)
	assignment += ": [spec]"

	if(spec == CIVILIAN_LINGUIST)
		languages = ALL_HUMAN_LANGUAGES //Linguists get all human languages, but they have fewer skills.
		skills = /datum/skills/civilian/researcher/linguist
	else
		skills = initial(skills)
		languages = list(LANGUAGE_ENGLISH) ///initial(languages) probably returns null as lists initialize at runtime.

	return ..()

/datum/equipment_preset/uscm_ground/civilian/load_id(mob/living/carbon/human/new_human, client/mob_client)
	. = ..()
	assignment = initial(assignment) /// This will reset it after it has been used, so that it is properly referenced elsewhere.

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
			new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/civilian/brown(new_human), WEAR_FEET)
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

	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/outpost(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/device/flashlight(new_human), WEAR_L_HAND)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/large(new_human), WEAR_L_STORE)

#undef CIVILIAN_BIOLOGIST
#undef CIVILIAN_ARACHAEOLOGIST
#undef CIVILIAN_ANTHROPOLOGIST
#undef CIVILIAN_LINGUIST

//*****************************************************************************************************/
//Rifleman

/datum/equipment_preset/uscm/pfc/uscm_ground
	name = "USCM Outpost Squad Rifleman"
	flags = EQUIPMENT_PRESET_START_OF_ROUND|EQUIPMENT_PRESET_MARINE

	access = list(ACCESS_MARINE_PREP)
	assignment = JOB_USCM_GROUND_SQUAD_MARINE
	skills = /datum/skills/pfc/uscm_ground

/datum/equipment_preset/uscm/pfc/uscm_ground/lance_corporal
	name = parent_type::name + " (E3 Rank)"
	paygrades = list(PAY_SHORT_ME3 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uscm/pfc/uscm_ground/private
	name = parent_type::name + " (E1 Rank)"
	paygrades = list(PAY_SHORT_ME1 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uscm/pfc/uscm_ground/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils/uscm_ground(new_human), WEAR_L_EAR)

//*****************************************************************************************************/
//Smartgunner

/datum/equipment_preset/uscm/sg/uscm_ground
	name = "USCM Outpost Squad Smartgunner"
	flags = EQUIPMENT_PRESET_START_OF_ROUND|EQUIPMENT_PRESET_MARINE
	access = list(ACCESS_MARINE_PREP, ACCESS_MARINE_SMARTPREP)
	assignment = JOB_USCM_GROUND_SQUAD_SMARTGUNNER
	skills = /datum/skills/smartgunner/uscm_ground

/datum/equipment_preset/uscm/sg/uscm_ground/lance_corporal
	name = parent_type::name + " (E3 Rank)"
	paygrades = list(PAY_SHORT_ME3 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uscm/sg/uscm_ground/pfc
	name = parent_type::name + " (E2 Rank)"
	paygrades = list(PAY_SHORT_ME2 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uscm/sg/uscm_ground/private
	name = parent_type::name + " (E1 Rank)"
	paygrades = list(PAY_SHORT_ME1 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uscm/sg/uscm_ground/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils/uscm_ground(new_human), WEAR_L_EAR)

//*****************************************************************************************************/
//Corpsman

/datum/equipment_preset/uscm/medic/uscm_ground
	name = "USCM Outpost Section Corpsman"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE
	access = list(ACCESS_MARINE_PREP, ACCESS_MARINE_MEDPREP, ACCESS_MARINE_MEDBAY)
	assignment = JOB_USCM_GROUND_SQUAD_MEDIC
	skills = /datum/skills/combat_medic_pve/uscm_ground

/datum/equipment_preset/uscm/medic/uscm_ground/lance_corporal
	name = parent_type::name + " (E3 Rank)"
	paygrades = list(PAY_SHORT_ME3 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uscm/medic/uscm_ground/pfc
	name = parent_type::name + " (E2 Rank)"
	paygrades = list(PAY_SHORT_ME2 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uscm/medic/uscm_ground/private
	name = parent_type::name + " (E1 Rank)"
	paygrades = list(PAY_SHORT_ME1 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uscm/medic/uscm_ground/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils/uscm_ground(new_human), WEAR_L_EAR)

//*****************************************************************************************************/
//Combat Engineer

/datum/equipment_preset/uscm/engineer/uscm_ground
	name = "USCM Outpost Section Combat Engineer"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE
	access = list(ACCESS_MARINE_PREP, ACCESS_MARINE_ENGPREP, ACCESS_CIVILIAN_ENGINEERING)
	assignment = JOB_USCM_GROUND_SQUAD_ENGI
	skills = /datum/skills/combat_engineer/uscm_ground

/datum/equipment_preset/uscm/engineer/uscm_ground/pfc
	name = parent_type::name + " (E2 Rank)"
	paygrades = list(PAY_SHORT_ME2 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uscm/engineer/uscm_ground/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/sapper, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils/uscm_ground(new_human), WEAR_L_EAR)

//*****************************************************************************************************/
//Weapons Specialist

/datum/equipment_preset/uscm/specialist/uscm_ground
	name = "USCM Outpost Section Weapons Specialist"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE
	access = list(ACCESS_MARINE_PREP, ACCESS_MARINE_SPECPREP)
	assignment = JOB_USCM_GROUND_SQUAD_SPECIALIST
	rank = JOB_SQUAD_SPECIALIST
	paygrades = list(PAY_SHORT_ME3 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "Spc"
	skills = /datum/skills/specialist/uscm_ground
	minimap_icon = "spec"

/datum/equipment_preset/uscm/specialist/uscm_ground/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils/uscm_ground(new_human), WEAR_L_EAR)

//*****************************************************************************************************/
//Squad Leader

/datum/equipment_preset/uscm/tl/uscm_ground
	name = "USCM Outpost Squad Leader"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE

	access = list(ACCESS_MARINE_PREP, ACCESS_MARINE_TL_PREP)
	assignment = JOB_USCM_GROUND_SQUAD_TEAM_LEADER
	skills = /datum/skills/tl/uscm_ground

/datum/equipment_preset/uscm/tl/uscm_ground/corporal
	name = parent_type::name + " (E4 Rank)"
	paygrades = list(PAY_SHORT_ME4 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uscm/tl/uscm_ground/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils/uscm_ground(new_human), WEAR_L_EAR)

//*****************************************************************************************************/
//Section Sergeant

/datum/equipment_preset/uscm/leader/uscm_ground
	name = "USCM Outpost Section Sergeant"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE
	access = list(ACCESS_MARINE_PREP, ACCESS_MARINE_LEADER, ACCESS_MARINE_DROPSHIP)
	assignment = JOB_USCM_GROUND_SQUAD_LEADER
	skills = /datum/skills/SL/uscm_ground

/datum/equipment_preset/uscm/leader/uscm_ground/staff_sergeant
	name = parent_type::name + " (E6 Rank)"
	paygrades = list(PAY_SHORT_ME6 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uscm/leader/uscm_ground/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils/uscm_ground(new_human), WEAR_L_EAR)
