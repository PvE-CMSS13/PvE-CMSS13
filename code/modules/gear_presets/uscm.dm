/datum/equipment_preset/uscm
	name = "USCM"
	faction = FACTION_MARINE
	faction_group = FACTION_LIST_MARINE
	languages = list(LANGUAGE_ENGLISH)
	idtype = /obj/item/card/id/dogtag

	utility_under = list(/obj/item/clothing/under/marine)
	utility_hat = list(/obj/item/clothing/head/cmcap)
	utility_gloves = list(/obj/item/clothing/gloves/marine)
	utility_shoes = list(/obj/item/clothing/shoes/marine/knife)

	service_under = list(/obj/item/clothing/under/marine/service)
	service_over = list(/obj/item/clothing/suit/storage/jacket/marine/service)
	service_hat = list(/obj/item/clothing/head/marine/peaked/service)
	service_shoes = list(/obj/item/clothing/shoes/laceup)

	dress_under = list(/obj/item/clothing/under/marine/blues)
	dress_over = list(/obj/item/clothing/suit/storage/jacket/marine/dress)
	dress_hat = list(/obj/item/clothing/head/marine/dress_cover)
	dress_gloves = list(/obj/item/clothing/gloves/marine/dress)
	dress_shoes = list(/obj/item/clothing/shoes/laceup)
	var/auto_squad_name
	///Allows the squad to be set even if spawned on admin z level
	var/ert_squad = FALSE

/datum/equipment_preset/uscm/load_status(mob/living/carbon/human/new_human)
	new_human.nutrition = rand(NUTRITION_VERYLOW, NUTRITION_LOW)

/datum/equipment_preset/uscm/load_name(mob/living/carbon/human/new_human, randomise)
	new_human.gender = pick(MALE, FEMALE)
	var/datum/preferences/A = new
	A.randomize_appearance(new_human)
	var/random_name = capitalize(pick(new_human.gender == MALE ? first_names_male : first_names_female)) + " " + capitalize(pick(last_names))
	var/static/list/colors = list("BLACK" = list(15, 15, 10), "BROWN" = list(48, 38, 18), "BROWN" = list(48, 38, 18),"BLUE" = list(29, 51, 65), "GREEN" = list(40, 61, 39), "STEEL" = list(46, 59, 54))
	var/static/list/hair_colors = list("BLACK" = list(15, 15, 10), "BROWN" = list(48, 38, 18), "AUBURN" = list(77, 48, 36), "BLONDE" = list(95, 76, 44))
	var/hair_color = pick(hair_colors)
	new_human.r_hair = hair_colors[hair_color][1]
	new_human.g_hair = hair_colors[hair_color][2]
	new_human.b_hair = hair_colors[hair_color][3]
	new_human.r_facial = hair_colors[hair_color][1]
	new_human.g_facial = hair_colors[hair_color][2]
	new_human.b_facial = hair_colors[hair_color][3]
	var/eye_color = pick(colors)
	new_human.r_eyes = colors[eye_color][1]
	new_human.g_eyes = colors[eye_color][2]
	new_human.b_eyes = colors[eye_color][3]
	if(new_human.gender == MALE)
		new_human.h_style = pick("Undercut", "Partly Shaved", "Side Undercut", "Side Hang Undercut (Reverse)", "Undercut, Top", "Medium Fade", "High Fade", "Coffee House Cut")
		new_human.f_style = pick("Shaved", "Shaved", "Shaved", "Shaved", "Shaved", "Shaved", "3 O'clock Shadow", "3 O'clock Moustache", "5 O'clock Shadow", "5 O'clock Moustache", "7 O'clock Shadow", "7 O'clock Moustache",)
	else
		new_human.h_style = pick("Side Undercut", "Side Hang Undercut (Reverse)", "Undercut, Top", "CIA", "CIA","Mulder", "Pixie Cut Left", "Pixie Cut Right", "Bun")
	new_human.change_real_name(new_human, random_name)
	new_human.age = rand(20,35)

/datum/equipment_preset/uscm/load_preset(mob/living/carbon/human/new_human, randomise, count_participant)
	. = ..()
	if(!auto_squad_name || (is_admin_level(new_human.z) && !ert_squad))
		return
	if(!GLOB.data_core.manifest_modify(new_human.real_name, WEAKREF(new_human), assignment, rank))
		GLOB.data_core.manifest_inject(new_human)

	var/obj/item/card/id/ID = new_human.wear_id
	var/datum/money_account/acct = create_account(new_human, rand(30, 50), GLOB.paygrades[ID.paygrade])
	ID.associated_account_number = acct.account_number

	var/datum/squad/auto_squad = get_squad_by_name(auto_squad_name)
	if(auto_squad)
		transfer_marine_to_squad(new_human, auto_squad, new_human.assigned_squad, new_human.wear_id)
	if(!ert_squad && !auto_squad.active)
		auto_squad.engage_squad(FALSE)

	if(!auto_squad)
		transfer_marine_to_squad(new_human, pick(RoleAuthority.squads), new_human.assigned_squad, new_human.wear_id)

	new_human.marine_buyable_categories[MARINE_CAN_BUY_EAR] = 0
	new_human.sec_hud_set_ID()
	new_human.hud_set_squad()

	if(new_human.wear_l_ear)
		if(istype(new_human.wear_l_ear, /obj/item/device/radio/headset/almayer/marine))
			var/obj/item/device/radio/headset/almayer/marine/equipped_headset = new_human.wear_l_ear
			equipped_headset.add_hud_tracker(new_human)
	else if(new_human.wear_r_ear)
		if(istype(new_human.wear_r_ear, /obj/item/device/radio/headset/almayer/marine))
			var/obj/item/device/radio/headset/almayer/marine/equipped_headset = new_human.wear_r_ear
			equipped_headset.add_hud_tracker(new_human)


//*****************************************************************************************************/
/datum/equipment_preset/uscm/pfc
	name = "USCM Squad Rifleman"
	flags = EQUIPMENT_PRESET_START_OF_ROUND|EQUIPMENT_PRESET_MARINE

	access = list(ACCESS_MARINE_PREP)
	assignment = JOB_SQUAD_MARINE
	rank = JOB_SQUAD_MARINE
	paygrade = "ME2"
	role_comm_title = "RFN"
	skills = /datum/skills/pfc

	minimap_icon = "private"

/datum/equipment_preset/uscm/pfc/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)

/datum/equipment_preset/uscm/pfc/cryo
	name = "USCM Cryo Squad Rifleman"
	auto_squad_name = SQUAD_MARINE_CRYO

/datum/equipment_preset/uscm/pfc/cryo/load_gear(mob/living/carbon/human/new_human)
	..()
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/cryo(new_human), WEAR_L_EAR)

/datum/equipment_preset/uscm/pfc/cryo
	name = "USCM Cryo Squad Rifleman"
	auto_squad_name = SQUAD_MARINE_CRYO

/datum/equipment_preset/uscm/pfc/cryo/load_gear(mob/living/carbon/human/new_human)
	..()
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/cryo(new_human), WEAR_L_EAR)

/datum/equipment_preset/uscm/pfc/lesser_rank
	paygrade = "ME1"

/datum/equipment_preset/uscm/pfc/upp
	name = "UPP Squad Rifleman"
	paygrade = "UE2"
	access = list(ACCESS_UPP_GENERAL)
	languages = list(LANGUAGE_RUSSIAN)
	faction_group = list(FACTION_UPP)
	faction = FACTION_UPP

/datum/equipment_preset/uscm/pfc/upp/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/lightpack/upp(new_human), WEAR_BACK)

/datum/equipment_preset/uscm/pfc/upp/lesser_rank
	paygrade = "UE1"

/datum/equipment_preset/uscm/pfc/forecon
	name = "FORECON Squad Rifleman"
	paygrade = "ME3"
	skills = /datum/skills/pfc/recon

/datum/equipment_preset/uscm/pfc/forecon/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)


/datum/equipment_preset/uscm/pfc/forecon/lesser_rank
	paygrade = "ME2"

//*****************************************************************************************************/

/datum/equipment_preset/uscm/sg
	name = "USCM Squad Smartgunner"
	flags = EQUIPMENT_PRESET_START_OF_ROUND|EQUIPMENT_PRESET_MARINE

	access = list(ACCESS_MARINE_PREP, ACCESS_MARINE_SMARTPREP)
	assignment = JOB_SQUAD_SMARTGUN
	rank = JOB_SQUAD_SMARTGUN
	paygrade = "ME4"
	role_comm_title = "SG"
	skills = /datum/skills/smartgunner

	minimap_icon = "smartgunner"

/datum/equipment_preset/uscm/sg/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)

/datum/equipment_preset/uscm/sg/cryo
	name = "USCM Cryo Squad Smartgunner"
	auto_squad_name = SQUAD_MARINE_CRYO

/datum/equipment_preset/uscm/sg/cryo/load_gear(mob/living/carbon/human/new_human)
	..()
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/cryo(new_human), WEAR_L_EAR)

/datum/equipment_preset/uscm/sg/lesser_rank
	paygrade = "ME3"

/datum/equipment_preset/uscm/sg/upp
	name = "UPP Squad Machinegunner"
	access = list(ACCESS_UPP_GENERAL, ACCESS_UPP_MACHINEGUN)
	assignment = "Machinegunner"
	paygrade = "UE4"
	role_comm_title = "MG"
	languages = list(LANGUAGE_RUSSIAN)
	faction_group = list(FACTION_UPP)
	faction = FACTION_UPP

/datum/equipment_preset/uscm/sg/upp/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/lightpack/upp(new_human), WEAR_BACK)

/datum/equipment_preset/uscm/sg/upp/lesser_rank
	paygrade = "UE3"

/datum/equipment_preset/uscm/sg/forecon
	name = "FORECON Squad Smartgunner"
	paygrade = "ME5"
	skills = /datum/skills/smartgunner/recon

/datum/equipment_preset/uscm/sg/forecon/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)

/datum/equipment_preset/uscm/sg/forecon/lesser_rank
	paygrade = "ME4"

//*****************************************************************************************************/

/datum/equipment_preset/uscm/sg/full
	name = "USCM Squad Smartgunner"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE

/datum/equipment_preset/uscm/sg/full/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/smartgunner(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/smartgun(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/specrag(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/night/m56_goggles/no_nightvision(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/smartgunner/full(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine(new_human), WEAR_HANDS)

/datum/equipment_preset/uscm/sg/full/load_status(mob/living/carbon/human/new_human)
	return //No cryo munchies

/datum/equipment_preset/uscm/rto
	name = "USCM Radio Telephone Operator"
	flags = EQUIPMENT_PRESET_START_OF_ROUND|EQUIPMENT_PRESET_MARINE

	access = list(ACCESS_MARINE_PREP, ACCESS_MARINE_SPECPREP)
	assignment = JOB_SQUAD_RTO
	rank = JOB_SQUAD_RTO
	paygrade = "ME4"
	role_comm_title = "RTO"
	skills = /datum/skills/pfc

	minimap_icon = "rto"

/datum/equipment_preset/uscm/rto/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)

/datum/equipment_preset/uscm/rto/lesser_rank
	paygrade = "ME3"

//*****************************************************************************************************/

/datum/equipment_preset/uscm/tank
	name = "USCM Vehicle Crewman (CRMN) (Cryo)"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE

	access = list(
		ACCESS_MARINE_PREP,
		ACCESS_MARINE_CREWMAN,
		ACCESS_MARINE_ALPHA,
		ACCESS_MARINE_BRAVO,
		ACCESS_MARINE_CHARLIE,
		ACCESS_MARINE_DELTA,
	)
	assignment = JOB_CREWMAN
	rank = JOB_CREWMAN
	paygrade = "ME4"
	role_comm_title = "CRMN"
	minimum_age = 30
	skills = /datum/skills/tank_crew

	minimap_icon = "vc"

/datum/equipment_preset/uscm/tank/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)


/datum/equipment_preset/uscm/tank/load_status(mob/living/carbon/human/new_human)
	return

//*****************************************************************************************************/

/datum/equipment_preset/uscm/tank/full
	name = "USCM Vehicle Crewman (CRMN)"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE

/datum/equipment_preset/uscm/tank/full/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/mcom/vc(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/operations(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/brown(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/tool/weldpack(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/medium(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/mod88/normalpoint(new_human), WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/mod88/normalpoint(new_human), WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/pistol(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/mod88(new_human), WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/pilot(new_human), WEAR_HEAD)

/*****************************************************************************************************/

/datum/equipment_preset/uscm/medic
	name = "USCM Squad Hospital Corpsman"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE
	access = list(ACCESS_MARINE_PREP, ACCESS_MARINE_MEDPREP, ACCESS_MARINE_MEDBAY)
	assignment = JOB_SQUAD_MEDIC
	rank = JOB_SQUAD_MEDIC
	paygrade = "ME4"
	role_comm_title = "HM"
	skills = /datum/skills/combat_medic

	minimap_icon = "medic"

	utility_under = list(/obj/item/clothing/under/marine)

/datum/equipment_preset/uscm/medic/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)

/datum/equipment_preset/uscm/medic/cryo
	name = "USCM Cryo Squad Hospital Corpsman"
	auto_squad_name = SQUAD_MARINE_CRYO

/datum/equipment_preset/uscm/medic/cryo/load_gear(mob/living/carbon/human/new_human)
	..()
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/cryo/med(new_human), WEAR_L_EAR)

/datum/equipment_preset/uscm/medic/lesser_rank
	paygrade = "ME3"

/datum/equipment_preset/uscm/medic/upp
	name = "UPP Sanitar"
	paygrade = "UE4"
	access = list(ACCESS_UPP_GENERAL, ACCESS_UPP_MEDPREP, ACCESS_UPP_MEDICAL)
	assignment = "Sanitar"
	languages = list(LANGUAGE_RUSSIAN, LANGUAGE_ENGLISH, LANGUAGE_CHINESE)
	faction_group = list(FACTION_UPP)
	faction = FACTION_UPP

/datum/equipment_preset/uscm/medic/upp/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/medic/upp(new_human), WEAR_BACK)

/datum/equipment_preset/uscm/medic/upp/lesser_rank
	paygrade = "UE3"

/datum/equipment_preset/uscm/medic/forecon
	name = "FORECON Squad Corpsman"
	assignment = "Squad Corpsman"
	paygrade = "ME5"
	skills = /datum/skills/combat_medic/recon

/datum/equipment_preset/uscm/medic/forecon/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel/standard(new_human), WEAR_BACK)

/datum/equipment_preset/uscm/medic/forecon/lesser_rank
	paygrade = "ME4"

//*****************************************************************************************************/

/datum/equipment_preset/uscm/tl
	name = "USCM Squad Sergeant"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE

	access = list(ACCESS_MARINE_PREP, ACCESS_MARINE_TL_PREP)
	assignment = JOB_SQUAD_TEAM_LEADER
	rank = JOB_SQUAD_TEAM_LEADER
	paygrade = "ME5"
	role_comm_title = "SqSgt"
	skills = /datum/skills/tl
	minimap_icon = "tl"

/datum/equipment_preset/uscm/tl/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)

/datum/equipment_preset/uscm/tl/cryo
	name = "USCM Cryo Squad Sergeant"
	auto_squad_name = SQUAD_MARINE_CRYO

/datum/equipment_preset/uscm/tl/cryo/load_gear(mob/living/carbon/human/new_human)
	..()
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/cryo/tl(new_human), WEAR_L_EAR)

/datum/equipment_preset/uscm/tl/upp
	name = "UPP Squad Sergeant"
	paygrade = "UE5"
	access = list(ACCESS_UPP_GENERAL, ACCESS_UPP_TLPREP)
	languages = list(LANGUAGE_RUSSIAN, LANGUAGE_ENGLISH, LANGUAGE_CHINESE)
	faction_group = list(FACTION_UPP)
	faction = FACTION_UPP

/datum/equipment_preset/uscm/tl/upp/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/lightpack/upp(new_human), WEAR_BACK)

/datum/equipment_preset/uscm/tl/forecon
	name = "FORECON Assistant Squad Leader"
	assignment = "Assistant Squad Leader"
	paygrade = "ME6"
	role_comm_title = "aSL"
	skills = /datum/skills/tl/recon

/datum/equipment_preset/uscm/tl/forecon/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel/standard(new_human), WEAR_BACK)


//*****************************************************************************************************/

/datum/equipment_preset/uscm/leader
	name = "USCM Platoon Sergeant"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE
	access = list(ACCESS_MARINE_PREP, ACCESS_MARINE_LEADER, ACCESS_MARINE_DROPSHIP)
	assignment = JOB_SQUAD_LEADER
	rank = JOB_SQUAD_LEADER
	paygrade = "ME7"
	role_comm_title = "PltSgt"
	minimum_age = 27
	skills = /datum/skills/SL

	minimap_icon = "leader"

/datum/equipment_preset/uscm/leader/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)

/datum/equipment_preset/uscm/leader/cryo
	name = "USCM Cryo Platoon Sergeant"
	auto_squad_name = SQUAD_MARINE_CRYO

/datum/equipment_preset/uscm/leader/cryo/load_gear(mob/living/carbon/human/new_human)
	..()
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/cryo/lead(new_human), WEAR_L_EAR)

/datum/equipment_preset/uscm/leader/lesser_rank
	paygrade = "ME6"

/datum/equipment_preset/uscm/leader/upp
	name = "UPP Platoon Sergeant"
	access = list(ACCESS_UPP_GENERAL, ACCESS_UPP_LEADERSHIP, ACCESS_UPP_FLIGHT)
	languages = list(LANGUAGE_RUSSIAN, LANGUAGE_ENGLISH) //ground commander and stuff
	paygrade = "UE7"
	faction_group = list(FACTION_UPP)
	faction = FACTION_UPP

/datum/equipment_preset/uscm/leader/upp/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/lightpack/upp(new_human), WEAR_BACK)

/datum/equipment_preset/uscm/leader/upp/lesser_rank
	paygrade = "UE6"

/datum/equipment_preset/uscm/leader/forecon
	name = "FORECON Squad Leader"
	assignment = "Squad Leader"
	paygrade = "ME8"
	role_comm_title = "SL"

/datum/equipment_preset/uscm/leader/forecon/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel/standard(new_human), WEAR_BACK)

/datum/equipment_preset/uscm/leader/forecon/lesser_rank
	paygrade = "ME7"

//*****************************************************************************************************/
// ERT members that spawn with full gear from DEFCON

/datum/equipment_preset/uscm/private_equipped
	name = "USCM Squad Rifleman (Equipped)"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE

	access = list(ACCESS_MARINE_PREP)
	assignment = JOB_SQUAD_MARINE
	rank = JOB_SQUAD_MARINE
	paygrade = "ME2"
	role_comm_title = "RFN"
	skills = /datum/skills/pfc

	minimap_icon = "private"

/datum/equipment_preset/uscm/private_equipped/load_status(mob/living/carbon/human/new_human)
	new_human.nutrition = NUTRITION_NORMAL

/datum/equipment_preset/uscm/private_equipped/load_rank(mob/living/carbon/human/new_human)
	if(new_human.client)
		if(get_job_playtime(new_human.client, rank) < JOB_PLAYTIME_TIER_1)
			return "ME1"
	return paygrade

/datum/equipment_preset/uscm/private_equipped/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/cryo(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/medium(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare/full(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine(new_human), WEAR_HANDS)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/MRE(new_human), WEAR_IN_BACK)

	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/m41amk1(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human.back), WEAR_IN_BACK)

/datum/equipment_preset/uscm/private_equipped/cryo
	name = "USCM Cryo Squad Rifleman (Equipped)"
	auto_squad_name = SQUAD_MARINE_CRYO

/datum/equipment_preset/uscm/private_equipped/upp
	name = "UPP Squad Rifleman"
	paygrade = "UE2"
	access = list(ACCESS_UPP_GENERAL)
	languages = list(LANGUAGE_RUSSIAN, LANGUAGE_CHINESE)
	faction_group = list(FACTION_UPP)
	faction = FACTION_UPP

/datum/equipment_preset/uscm/private_equipped/upp/load_gear(mob/living/carbon/human/new_human)
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/lightpack/upp(new_human), WEAR_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/UPP, WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/UPP, WEAR_HEAD)
	//body
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/UPP, WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/faction/UPP, WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/snacks/upp(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/snacks/upp(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/type71(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/machete/full, WEAR_IN_BELT)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/upp_knife, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/brown, WEAR_HANDS)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/type71, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/type71, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/type71, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)

/datum/equipment_preset/uscm/private_equipped/upp/lesser_rank
	paygrade = "UE1"


//*****************************************************************************************************/

/datum/equipment_preset/uscm/leader_equipped
	name = "USCM Platoon Sergeant (Equipped)"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE

	access = list(ACCESS_MARINE_PREP, ACCESS_MARINE_LEADER, ACCESS_MARINE_DROPSHIP)
	assignment = JOB_SQUAD_LEADER
	rank = JOB_SQUAD_LEADER
	paygrade = "ME7"
	role_comm_title = "PltSgt"
	minimum_age = 27
	skills = /datum/skills/SL

	minimap_icon = "leader"

/datum/equipment_preset/uscm/leader_equipped/load_status(mob/living/carbon/human/new_human)
	new_human.nutrition = NUTRITION_NORMAL

/datum/equipment_preset/uscm/leader_equipped/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/leader(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/cryo/lead(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/leader(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare/full(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine(new_human), WEAR_HANDS)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/MRE(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/m41amk1(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human.back), WEAR_IN_BACK)

/datum/equipment_preset/uscm/leader_equipped/cryo
	name = "USCM Cryo Platoon Sergeant (Equipped)"
	auto_squad_name = SQUAD_MARINE_CRYO

//*****************************************************************************************************/

/datum/equipment_preset/uscm/smartgunner_equipped
	name = "USCM Squad Smartgunner (Equipped)"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE

	access = list(ACCESS_MARINE_PREP, ACCESS_MARINE_SMARTPREP)
	assignment = JOB_SQUAD_SMARTGUN
	rank = JOB_SQUAD_SMARTGUN
	paygrade = "ME3"
	role_comm_title = "SG"
	skills = /datum/skills/smartgunner

	minimap_icon = "smartgunner"

/datum/equipment_preset/uscm/smartgunner_equipped/load_status(mob/living/carbon/human/new_human)
	new_human.nutrition = NUTRITION_NORMAL

/datum/equipment_preset/uscm/smartgunner_equipped/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/smartgunner(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/smartgun(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare/full(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/MRE(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/smartgunner/full(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/night/m56_goggles/no_nightvision(new_human), WEAR_EYES)


	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/cryo(new_human), WEAR_L_EAR)

/datum/equipment_preset/uscm/smartgunner_equipped/cryo
	name = "USCM Cryo Squad Smartgunner (Equipped)"
	auto_squad_name = SQUAD_MARINE_CRYO

//*****************************************************************************************************/

/datum/equipment_preset/uscm/medic_equipped
	name = "USCM Squad Hospital Corpsman (Equipped)"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE

	access = list(ACCESS_MARINE_PREP, ACCESS_MARINE_MEDPREP, ACCESS_MARINE_MEDBAY)
	assignment = JOB_SQUAD_MEDIC
	rank = JOB_SQUAD_MEDIC
	paygrade = "ME4"
	role_comm_title = "HM"
	skills = /datum/skills/combat_medic

	minimap_icon = "medic"

	utility_under = list(/obj/item/clothing/under/marine)

/datum/equipment_preset/uscm/medic_equipped/load_status(mob/living/carbon/human/new_human)
	new_human.nutrition = NUTRITION_NORMAL

/datum/equipment_preset/uscm/medic_equipped/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/medic(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/cryo/med(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/medium(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine(new_human), WEAR_BACK)
	if(prob(50))
		new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/surgical(new_human), WEAR_FACE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/regular(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/adv(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/defibrillator(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/medical/lifesaver/full(new_human), WEAR_WAIST)
	if(new_human.disabilities & NEARSIGHTED)
		new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/health/prescription(new_human), WEAR_EYES)
	else
		new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/health(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/medkit/full(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare/full(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine(new_human), WEAR_HANDS)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/MRE(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human.back), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human.back), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human.back), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/tool/surgery/surgical_line(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/surgery/synthgraft(new_human), WEAR_IN_BACK)

/datum/equipment_preset/uscm/medic_equipped/cryo
	name = "USCM Cryo Hospital Corpsman (Equipped)"
	auto_squad_name = SQUAD_MARINE_CRYO

//*****************************************************************************************************/

/datum/equipment_preset/uscm/specialist_equipped/sniper
	name = "USCM Scout Sniper"

/datum/equipment_preset/uscm/specialist_equipped/sniper/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/jungle/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/night/m42_night_goggles(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/ghillie(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/ghillie(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/smock(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/sniper/incendiary(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/sniper/flak(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/sniper/flak(new_human), WEAR_IN_BACK)

	new_human.equip_to_slot_or_del(new /obj/item/storage/box/MRE(new_human), WEAR_IN_BACK)

	spawn_weapon(/obj/item/weapon/gun/rifle/sniper/M42A, /obj/item/ammo_magazine/sniper, new_human, 0, 5)

//*****************************************************************************************************/

/datum/equipment_preset/uscm/tl_equipped
	name = "USCM Squad Sergeant (Equipped)"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE

	access = list(ACCESS_MARINE_PREP, ACCESS_MARINE_TL_PREP)
	assignment = JOB_SQUAD_TEAM_LEADER
	rank = JOB_SQUAD_TEAM_LEADER
	paygrade = "ME5"
	role_comm_title = "SqSgt"
	skills = /datum/skills/tl

	minimap_icon = "tl"

/datum/equipment_preset/uscm/tl_equipped/load_status(mob/living/carbon/human/new_human)
	new_human.nutrition = NUTRITION_NORMAL

/datum/equipment_preset/uscm/tl_equipped/load_gear(mob/living/carbon/human/new_human)
	//TODO: add backpacks and satchels
	var/obj/item/clothing/under/marine/U = new(new_human)
	var/obj/item/clothing/accessory/storage/webbing/W = new()
	U.attach_accessory(new_human, W)
	new_human.equip_to_slot_or_del(U, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/m4a3/vp78(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/rto(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/cryo/tl(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/medium(src), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine(src), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel/rto(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/medium(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/mod88/normalpoint(new_human), WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/mod88/normalpoint(new_human), WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/pistol(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/mod88(new_human), WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars(new_human), WEAR_L_HAND)

	new_human.back.pickup(new_human)

/datum/equipment_preset/uscm/tl_equipped/cryo
	name = "USCM Cryo Squad Sergeant (Equipped)"
	auto_squad_name = SQUAD_MARINE_CRYO

//############ Marine Raiders #############
//Operator
/datum/equipment_preset/uscm/marsoc
	name = "USCM Raider"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = "Marine Raider"
	rank = JOB_MARINE_RAIDER
	role_comm_title = "Op."
	languages = list(LANGUAGE_ENGLISH, LANGUAGE_TSL)
	skills = /datum/skills/commando/deathsquad
	auto_squad_name = SQUAD_SOF
	ert_squad = TRUE
	paygrade = "ME6"

	minimap_icon = "private"

/datum/equipment_preset/uscm/marsoc/load_status(mob/living/carbon/human/new_human)
	new_human.nutrition = NUTRITION_NORMAL

/datum/equipment_preset/uscm/marsoc/New()
	. = ..()
	access = get_access(ACCESS_LIST_GLOBAL)

/datum/equipment_preset/uscm/marsoc/load_gear(mob/living/carbon/human/new_human)
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/marsoc, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/high_explosive/super, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/high_explosive/super, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/high_explosive/super, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/phosphorus, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/phosphorus, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/phosphorus, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/motiondetector, WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/sof, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/pmc/marsoc, WEAR_FACE)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/sof, WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/buckshot, WEAR_IN_HELMET)
	//uniform
	var/obj/item/clothing/under/marine/veteran/marsoc/M = new()
	var/obj/item/clothing/accessory/storage/black_vest/W = new()
	M.attach_accessory(new_human, W)
	new_human.equip_to_slot_or_del(M, WEAR_BODY)
	for(var/i in 1 to W.hold.storage_slots)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/buckshot, WEAR_IN_ACCESSORY)
	//jacket
	var/obj/item/clothing/suit/storage/marine/sof/armor = new()
	new_human.equip_to_slot_or_del(armor, WEAR_JACKET)
	for(var/i in 1 to armor.storage_slots)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/xm40/heap, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41a/elite/xm40, WEAR_J_STORE)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/shotgun/combat/marsoc, WEAR_WAIST)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine, WEAR_HANDS)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/medical/socmed/full, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/tools/tactical/full, WEAR_R_STORE)

/datum/equipment_preset/uscm/marsoc/load_rank(mob/living/carbon/human/new_human)
	if(new_human.client)
		if(get_job_playtime(new_human.client, rank) > JOB_PLAYTIME_TIER_2)
			return "ME7"
	return paygrade

//Covert Raiders
/datum/equipment_preset/uscm/marsoc/covert
	name = "Marine Raiders (!DEATHSQUAD! Covert)"
	uses_special_name = TRUE
/datum/equipment_preset/uscm/marsoc/covert/load_name(mob/living/carbon/human/new_human, randomise)
	new_human.gender = MALE
	new_human.change_real_name(new_human, "[pick(nato_phonetic_alphabet)]")
	new_human.age = rand(20,30)
/datum/equipment_preset/uscm/marsoc/covert/load_rank(mob/living/carbon/human/new_human)
	return "O"

//Team Leader
/datum/equipment_preset/uscm/marsoc/sl
	name = "Marine Raider Team Leader (!DEATHSQUAD!)"
	assignment = JOB_MARINE_RAIDER_SL
	rank = JOB_MARINE_RAIDER_SL
	role_comm_title = "TL."
	paygrade = "MO1"
	skills = /datum/skills/commando/deathsquad/leader

	minimap_icon = "leader"

/datum/equipment_preset/uscm/marsoc/sl/load_rank(mob/living/carbon/human/new_human)
	if(new_human.client)
		if(get_job_playtime(new_human.client, rank) > JOB_PLAYTIME_TIER_2)
			return "MO2"
	return paygrade

//Codenamed Team Leader
/datum/equipment_preset/uscm/marsoc/sl/covert
	name = "Marine Raider Team Leader (!DEATHSQUAD! Covert)"
	uses_special_name = TRUE
/datum/equipment_preset/uscm/marsoc/sl/covert/load_name(mob/living/carbon/human/new_human, randomise)
	new_human.gender = MALE
	new_human.change_real_name(new_human, "[pick(nato_phonetic_alphabet)]")
	new_human.age = rand(20,30)
/datum/equipment_preset/uscm/marsoc/sl/covert/load_rank(mob/living/carbon/human/new_human)
	return "O"
//Officer
/datum/equipment_preset/uscm/marsoc/cmd
	name = "Marine Raider Officer (!DEATHSQUAD!)"
	assignment = JOB_MARINE_RAIDER_CMD
	rank = JOB_MARINE_RAIDER_CMD
	role_comm_title = "CMD."
	paygrade = "MO3"
	skills = /datum/skills/commando/deathsquad/officer

/datum/equipment_preset/uscm/marsoc/cmd/load_rank(mob/living/carbon/human/new_human)
	if(new_human.client)
		if(get_job_playtime(new_human.client, rank) > JOB_PLAYTIME_TIER_3)
			return "MO4"
	return paygrade
