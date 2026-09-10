/datum/equipment_preset/uscm
	name = "USCM"
	faction = FACTION_MARINE
	faction_group = FACTION_LIST_UA
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
	service_shoes = list(/obj/item/clothing/shoes/laceup)

	dress_under = list(/obj/item/clothing/under/marine/dress/blues/senior)
	dress_over = list(/obj/item/clothing/suit/storage/jacket/marine/dress/blues/nco)
	dress_hat = list(/obj/item/clothing/head/marine/dress_cover)
	dress_gloves = list(/obj/item/clothing/gloves/marine/dress)
	dress_shoes = list(/obj/item/clothing/shoes/laceup)
	var/auto_squad_name
	///Allows the squad to be set even if spawned on admin z level
	var/ert_squad = FALSE

/datum/equipment_preset/uscm/load_name(mob/living/carbon/human/new_human, randomise)
	new_human.gender = pick(75;MALE,25;FEMALE)
	var/datum/preferences/A = new
	A.randomize_appearance(new_human)
	var/random_name = capitalize(pick(new_human.gender == MALE ? GLOB.first_names_male : GLOB.first_names_female)) + " " + capitalize(pick(GLOB.last_names))
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
		new_human.h_style = pick("Side Undercut", "Side Hang Undercut (Reverse)", "Undercut, Top", "CIA", "Mulder", "Pvt. Redding", "Pixie Cut Left", "Pixie Cut Right", "Bun")
	new_human.change_real_name(new_human, random_name)
	new_human.age = rand(20,35)

/datum/equipment_preset/uscm/load_status(mob/living/carbon/human/new_human)
	new_human.nutrition = NUTRITION_VERYLOW

/datum/equipment_preset/uscm/load_preset(mob/living/carbon/human/new_human, randomise, count_participant)
	. = ..()
	if(!auto_squad_name || (should_block_game_interaction(new_human) && !ert_squad))
		return
	if(!GLOB.data_core.manifest_modify(new_human.real_name, WEAKREF(new_human), assignment, rank))
		GLOB.data_core.manifest_inject(new_human)

	var/obj/item/card/id/ID = new_human.get_idcard()
	var/datum/money_account/acct = create_account(new_human, rand(30, 50), GLOB.paygrades[ID.paygrade])
	ID.associated_account_number = acct.account_number

	var/datum/squad/auto_squad = get_squad_by_name(auto_squad_name)
	if(auto_squad)
		transfer_marine_to_squad(new_human, auto_squad, new_human.assigned_squad, ID)
	if(!ert_squad && !auto_squad.active)
		auto_squad.engage_squad(FALSE)

	if(!auto_squad)
		transfer_marine_to_squad(new_human, pick(GLOB.RoleAuthority.squads), new_human.assigned_squad, new_human.wear_id)

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

/datum/equipment_preset/uscm/proc/add_marsoc_weapon(mob/living/carbon/human/new_human)
	if(prob(66))
		new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1/forecon(new_human), WEAR_J_STORE)
	else
		new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m46c(new_human), WEAR_J_STORE)


//*****************************************************************************************************/
/datum/equipment_preset/uscm/pfc
	name = "USCM Squad Rifleman"
	flags = EQUIPMENT_PRESET_START_OF_ROUND|EQUIPMENT_PRESET_MARINE

	access = list(ACCESS_MARINE_PREP)
	assignment = JOB_SQUAD_MARINE
	rank = JOB_SQUAD_MARINE
	paygrades = list(PAY_SHORT_ME2 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "RFN"
	skills = /datum/skills/pfc

	minimap_icon = "private"
	dress_under = list(/obj/item/clothing/under/marine/dress/blues)
	dress_over = list(/obj/item/clothing/suit/storage/jacket/marine/dress/blues)

/datum/equipment_preset/uscm/pfc/lance_corporal
	name = parent_type::name + " (E3 Rank)"
	paygrades = list(PAY_SHORT_ME3 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uscm/pfc/private
	name = parent_type::name + " (E1 Rank)"
	paygrades = list(PAY_SHORT_ME1 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uscm/pfc/upp
	name = "UPP Squad Infantryman"
	assignment = JOB_SQUAD_MARINE_UPP
	paygrades = list(PAY_SHORT_UE2 = JOB_PLAYTIME_TIER_0)
	access = list(ACCESS_UPP_GENERAL)
	languages = list(LANGUAGE_RUSSIAN, LANGUAGE_CHINESE)
	faction_group = list(FACTION_UPP)
	faction = FACTION_UPP

/datum/equipment_preset/uscm/pfc/upp/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "Naval Infantry Telnyashka"

/datum/equipment_preset/uscm/pfc/upp/private
	name = parent_type::name + " (E1 Rank)"
	paygrades = list(PAY_SHORT_UE1 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uscm/pfc/forecon
	name = "FORECON Squad Rifleman"
	paygrades = list(PAY_SHORT_ME3 = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/pfc/recon

/datum/equipment_preset/uscm/pfc/forecon/pfc
	name = parent_type::name + " (E2 Rank)"
	paygrades = list(PAY_SHORT_ME2 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uscm/pfc/forecon/corporal
	name = parent_type::name + " (E4 Rank)"
	paygrades = list(PAY_SHORT_ME4 = JOB_PLAYTIME_TIER_0)

//*****************************************************************************************************/

/datum/equipment_preset/uscm/sg
	name = "USCM Squad Smartgunner"
	flags = EQUIPMENT_PRESET_START_OF_ROUND|EQUIPMENT_PRESET_MARINE

	access = list(ACCESS_MARINE_PREP, ACCESS_MARINE_SMARTPREP)
	assignment = JOB_SQUAD_SMARTGUN
	rank = JOB_SQUAD_SMARTGUN
	paygrades = list(PAY_SHORT_ME4 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "SG"
	skills = /datum/skills/smartgunner

	minimap_icon = "smartgunner"
	dress_under = list(/obj/item/clothing/under/marine/dress/blues)
	dress_over = list(/obj/item/clothing/suit/storage/jacket/marine/dress/blues)

/datum/equipment_preset/uscm/sg/lance_corporal
	name = parent_type::name + " (E3 Rank)"
	paygrades = list(PAY_SHORT_ME3 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uscm/sg/pfc
	name = parent_type::name + " (E2 Rank)"
	paygrades = list(PAY_SHORT_ME2 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uscm/sg/private
	name = parent_type::name + " (E1 Rank)"
	paygrades = list(PAY_SHORT_ME1 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uscm/sg/upp
	name = "UPP Squad Machinegunner"
	access = list(ACCESS_UPP_GENERAL, ACCESS_UPP_MACHINEGUN)
	assignment = JOB_SQUAD_SMARTGUN_UPP
	paygrades = list(PAY_SHORT_UE4 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "MG"
	languages = list(LANGUAGE_RUSSIAN, LANGUAGE_CHINESE)
	faction_group = list(FACTION_UPP)
	faction = FACTION_UPP

/datum/equipment_preset/uscm/sg/upp/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "Naval Infantry Telnyashka"

/datum/equipment_preset/uscm/sg/upp/corporal
	name = parent_type::name + " (E3 Rank)"
	paygrades = list(PAY_SHORT_UE3 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uscm/sg/upp/senior_private
	name = parent_type::name + " (E2 Rank)"
	paygrades = list(PAY_SHORT_UE2 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uscm/sg/upp/private
	name = parent_type::name + " (E1 Rank)"
	paygrades = list(PAY_SHORT_UE1 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uscm/sg/forecon
	name = "FORECON Squad Smartgunner"
	paygrades = list(PAY_SHORT_ME5 = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/smartgunner/recon

/datum/equipment_preset/uscm/sg/forecon/corporal
	name = parent_type::name + " (E4 Rank)"
	paygrades = list(PAY_SHORT_ME4 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uscm/sg/forecon/lance_corporal
	name = parent_type::name + " (E3 Rank)"
	paygrades = list(PAY_SHORT_ME3 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uscm/sg/forecon/pfc
	name = parent_type::name + " (E2 Rank)"
	paygrades = list(PAY_SHORT_ME2 = JOB_PLAYTIME_TIER_0)

//*****************************************************************************************************/

/datum/equipment_preset/uscm/rto
	name = "USCM Radio Telephone Operator"
	flags = EQUIPMENT_PRESET_START_OF_ROUND|EQUIPMENT_PRESET_MARINE

	access = list(ACCESS_MARINE_PREP, ACCESS_MARINE_SPECPREP)
	assignment = JOB_SQUAD_RTO
	rank = JOB_SQUAD_RTO
	paygrades = list(PAY_SHORT_ME4 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "RTO"
	skills = /datum/skills/pfc

	minimap_icon = "rto"

/datum/equipment_preset/uscm/rto/lance_corporal
	name = parent_type::name + " (E3 Rank)"
	paygrades = list(PAY_SHORT_ME3 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uscm/rto/pfc
	name = parent_type::name + " (E2 Rank)"
	paygrades = list(PAY_SHORT_ME2 = JOB_PLAYTIME_TIER_0)

//*****************************************************************************************************/

/datum/equipment_preset/uscm/medic
	name = "USCM Squad Hospital Corpsman"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE
	access = list(ACCESS_MARINE_PREP, ACCESS_MARINE_MEDPREP, ACCESS_MARINE_MEDBAY)
	assignment = JOB_SQUAD_MEDIC
	rank = JOB_SQUAD_MEDIC
	paygrades = list(PAY_SHORT_ME4 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "HM"
	skills = /datum/skills/combat_medic_pve

	minimap_icon = "medic"

	utility_under = list(/obj/item/clothing/under/marine)
	dress_under = list(/obj/item/clothing/under/marine/dress/blues)
	dress_over = list(/obj/item/clothing/suit/storage/jacket/marine/dress/blues)

/datum/equipment_preset/uscm/medic/lance_corporal
	name = parent_type::name + " (E3 Rank)"
	paygrades = list(PAY_SHORT_ME3 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uscm/medic/pfc
	name = parent_type::name + " (E2 Rank)"
	paygrades = list(PAY_SHORT_ME2 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uscm/medic/private
	name = parent_type::name + " (E1 Rank)"
	paygrades = list(PAY_SHORT_ME1 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uscm/medic/upp
	name = "UPP Platoon Sanitar"
	paygrades = list(PAY_SHORT_UE4 = JOB_PLAYTIME_TIER_0)
	access = list(ACCESS_UPP_GENERAL, ACCESS_UPP_MEDPREP, ACCESS_UPP_MEDICAL)
	assignment = JOB_SQUAD_MEDIC_UPP
	role_comm_title = "PltStr"
	languages = list(LANGUAGE_RUSSIAN, LANGUAGE_CHINESE)
	faction_group = list(FACTION_UPP)
	faction = FACTION_UPP

/datum/equipment_preset/uscm/medic/upp/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "Naval Infantry Telnyashka"

/datum/equipment_preset/uscm/medic/upp/corporal
	name = parent_type::name + " (E3 Rank)"
	paygrades = list(PAY_SHORT_UE3 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uscm/medic/upp/senior_private
	name = parent_type::name + " (E2 Rank)"
	paygrades = list(PAY_SHORT_UE2 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uscm/medic/upp/private
	name = parent_type::name + " (E1 Rank)"
	paygrades = list(PAY_SHORT_UE1 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uscm/medic/forecon
	name = "FORECON Squad Corpsman"
	assignment = JOB_SQUAD_MEDIC_FORECON
	paygrades = list(PAY_SHORT_ME5 = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/combat_medic/recon

/datum/equipment_preset/uscm/medic/forecon/corporal
	name = parent_type::name + " (E4 Rank)"
	paygrades = list(PAY_SHORT_ME4 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uscm/medic/forecon/lance_corporal
	name = parent_type::name + " (E3 Rank)"
	paygrades = list(PAY_SHORT_ME4 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uscm/medic/forecon/pfc
	name = parent_type::name + " (E2 Rank)"
	paygrades = list(PAY_SHORT_ME4 = JOB_PLAYTIME_TIER_0)

//*****************************************************************************************************/

/datum/equipment_preset/uscm/tl
	name = "USCM Squad Leader"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE

	access = list(ACCESS_MARINE_PREP, ACCESS_MARINE_TL_PREP)
	assignment = JOB_SQUAD_TEAM_LEADER
	rank = JOB_SQUAD_TEAM_LEADER
	paygrades = list(PAY_SHORT_ME5 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "SqLdr"
	skills = /datum/skills/tl
	minimap_icon = "tl"

/datum/equipment_preset/uscm/tl/corporal
	name = parent_type::name + " (E4 Rank)"
	paygrades = list(PAY_SHORT_ME4 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uscm/tl/upp
	name = "UPP Squad Sergeant"
	assignment = JOB_SQUAD_TEAM_LEADER_UPP
	role_comm_title = "SqSgt"
	paygrades = list(PAY_SHORT_UE5 = JOB_PLAYTIME_TIER_0)
	access = list(ACCESS_UPP_GENERAL, ACCESS_UPP_TLPREP)
	languages = list(LANGUAGE_RUSSIAN, LANGUAGE_CHINESE)
	faction_group = list(FACTION_UPP)
	faction = FACTION_UPP

/datum/equipment_preset/uscm/tl/upp/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "Naval Infantry Telnyashka"

/datum/equipment_preset/uscm/tl/upp/junior_sergeant
	name = parent_type::name + " (E4 Rank)"
	paygrades = list(PAY_SHORT_UE4 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uscm/tl/forecon
	name = "FORECON Assistant Squad Leader"
	assignment = JOB_SQUAD_TEAM_LEADER_FORECON
	paygrades = list(PAY_SHORT_ME6 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "ARSL"
	skills = /datum/skills/tl/recon

/datum/equipment_preset/uscm/tl/forecon/sergeant
	name = parent_type::name + " (E5 Rank)"
	paygrades = list(PAY_SHORT_ME5 = JOB_PLAYTIME_TIER_0)

/*****************************************************************************************************/

/datum/equipment_preset/uscm/engineer
	name = "USCM Squad Combat Engineer"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE

	access = list(ACCESS_MARINE_PREP, ACCESS_MARINE_ENGPREP, ACCESS_CIVILIAN_ENGINEERING)
	assignment = JOB_SQUAD_ENGI
	rank = JOB_SQUAD_ENGI
	paygrades = list(PAY_SHORT_ME3 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "ComEng"
	skills = /datum/skills/combat_engineer

	minimap_icon = "engi"

	utility_under = list(/obj/item/clothing/under/marine)
	dress_under = list(/obj/item/clothing/under/marine/dress/blues)
	dress_over = list(/obj/item/clothing/suit/storage/jacket/marine/dress/blues)

/datum/equipment_preset/uscm/engineer/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel/tech(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/sapper, WEAR_IN_BACK) //So they get their unit rep

/datum/equipment_preset/uscm/engineer/pfc
	name = parent_type::name + " (E2 Rank)"
	paygrades = list(PAY_SHORT_ME2 = JOB_PLAYTIME_TIER_0)

//*****************************************************************************************************/

/datum/equipment_preset/uscm/leader
	name = "USCM Section Sergeant"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE
	access = list(ACCESS_MARINE_PREP, ACCESS_MARINE_LEADER, ACCESS_MARINE_DROPSHIP)
	assignment = JOB_SQUAD_LEADER
	rank = JOB_SQUAD_LEADER
	paygrades = list(PAY_SHORT_ME7 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "SctSgt"
	minimum_age = 27
	skills = /datum/skills/SL

	minimap_icon = "leader"

/datum/equipment_preset/uscm/leader/staff_sergeant
	name = parent_type::name + " (E6 Rank)"
	paygrades = list(PAY_SHORT_ME6 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uscm/leader/upp
	name = "UPP Platoon Sergeant"
	assignment = JOB_SQUAD_LEADER_UPP
	role_comm_title = "PltSgt"
	access = list(ACCESS_UPP_GENERAL, ACCESS_UPP_LEADERSHIP, ACCESS_UPP_FLIGHT)
	paygrades = list(PAY_SHORT_UE7 = JOB_PLAYTIME_TIER_0)
	languages = list(LANGUAGE_RUSSIAN, LANGUAGE_ENGLISH, LANGUAGE_CHINESE)
	faction_group = list(FACTION_UPP)
	faction = FACTION_UPP

/datum/equipment_preset/uscm/leader/upp/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "Naval Infantry Telnyashka"

/datum/equipment_preset/uscm/leader/upp/senior_sergeant
	name = parent_type::name + " (E6 Rank)"
	paygrades = list(PAY_SHORT_UE6 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uscm/leader/forecon
	name = "FORECON Squad Leader"
	assignment = JOB_SQUAD_LEADER_FORECON
	paygrades = list(PAY_SHORT_ME8 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "RSL"

/datum/equipment_preset/uscm/leader/forecon/gunnery_sergeant
	name = parent_type::name + " (E7 Rank)"
	paygrades = list(PAY_SHORT_ME7 = JOB_PLAYTIME_TIER_0)

//*****************************************************************************************************/
// ERT members that spawn with full gear from DEFCON

/datum/equipment_preset/uscm/private_equipped
	name = "USCM Squad Rifleman (Equipped)"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE

	access = list(ACCESS_MARINE_PREP)
	assignment = JOB_SQUAD_MARINE
	rank = JOB_SQUAD_MARINE
	paygrades = list(PAY_SHORT_ME2 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "RFN"
	skills = /datum/skills/pfc

	minimap_icon = "private"
	dress_under = list(/obj/item/clothing/under/marine/dress/blues)
	dress_over = list(/obj/item/clothing/suit/storage/jacket/marine/dress/blues)

/datum/equipment_preset/uscm/private_equipped/load_status(mob/living/carbon/human/new_human)
	new_human.nutrition = NUTRITION_NORMAL

/datum/equipment_preset/uscm/private_equipped/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "Marine Undershirt"
	new_human.underwear = "Marine Boxers"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/weldingtool(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/wirecutters(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/folded(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/canteen, WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils/foxtrot(new_human), WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine(new_human), WEAR_HEAD)
	add_uscm_cover(new_human)
	add_uscm_goggles(new_human)
	//uniform
	add_uscm_uniform(new_human)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1/preloaded(new_human), WEAR_J_STORE)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_BELT)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/jungle/knife(new_human), WEAR_FEET)
	add_combat_gloves(new_human)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare/full(new_human), WEAR_R_STORE)

	if(SSmapping.configs[GROUND_MAP].environment_traits[MAP_COLD])
		new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/rebreather/scarf, WEAR_FACE)

//*****************************************************************************************************/

/datum/equipment_preset/uscm/private_equipped/battlerifle
	name = "USCM Squad Sniper (Equipped, M49A6)"


/datum/equipment_preset/uscm/private_equipped/battlerifle/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "Marine Undershirt"
	new_human.underwear = "Marine Boxers"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/weldingtool(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/wirecutters(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/folded(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/canteen, WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils/foxtrot(new_human), WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine(new_human), WEAR_HEAD)
	add_uscm_cover(new_human)
	add_uscm_goggles(new_human)
	//uniform
	add_uscm_uniform(new_human)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m49a/pve/with_scope(new_human), WEAR_J_STORE)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m49a/custom/pve(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m49a(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m49a(new_human), WEAR_IN_BELT)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/jungle/knife(new_human), WEAR_FEET)
	add_combat_gloves(new_human)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare/full(new_human), WEAR_R_STORE)

	if(SSmapping.configs[GROUND_MAP].environment_traits[MAP_COLD])
		new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/rebreather/scarf, WEAR_FACE)

//*****************************************************************************************************/
//*****************************************************************************************************/

/datum/equipment_preset/uscm/private_equipped/grenade
	name = "USCM Squad Grenadier (Equipped, M92 HEFA+Misc)"


/datum/equipment_preset/uscm/private_equipped/grenade/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "Marine Undershirt"
	new_human.underwear = "Marine Boxers"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/weldingtool(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/wirecutters(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/folded(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/canteen, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/high_explosive/airburst/canister(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/packet/sebb(new_human), WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils/foxtrot(new_human), WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine(new_human), WEAR_HEAD)
	add_uscm_cover(new_human)
	add_uscm_goggles(new_human)
	//uniform
	add_uscm_uniform(new_human)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/m40/frag_smoke(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/launcher/grenade/m92/frag(new_human), WEAR_J_STORE)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/m4a3/full/ap(new_human), WEAR_WAIST)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/jungle/knife(new_human), WEAR_FEET)
	add_combat_gloves(new_human)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare/full(new_human), WEAR_R_STORE)

	if(SSmapping.configs[GROUND_MAP].environment_traits[MAP_COLD])
		new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/rebreather/scarf, WEAR_FACE)

//*****************************************************************************************************/

/datum/equipment_preset/uscm/private_equipped/eva
	name = "USCM Squad Rifleman (Equipped, EVA)"

/datum/equipment_preset/uscm/private_equipped/eva/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "Marine Undershirt"
	new_human.underwear = "Marine Boxers"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/screwdriver(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/wirecutters(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/folded(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tank/emergency_oxygen, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/canteen, WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils/foxtrot(new_human), WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/pressure/uscm(new_human), WEAR_HEAD)
	add_uscm_cover(new_human)
	//uniform
	add_uscm_uniform(new_human)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/space/pressure/uscm/armband(new_human), WEAR_JACKET)
	add_eva_suit_accessory(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/small/space(new_human), WEAR_ACCESSORY)
	if(prob(70))
		new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1/preloaded(new_human), WEAR_J_STORE)
		//waist
		new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine(new_human), WEAR_WAIST)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_BELT)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_BELT)
	else
		new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m49a(new_human), WEAR_J_STORE)
		//waist
		new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine(new_human), WEAR_WAIST)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m49a(new_human), WEAR_IN_BELT)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m49a(new_human), WEAR_IN_BELT)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m49a(new_human), WEAR_IN_BELT)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m49a(new_human), WEAR_IN_BELT)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/jungle/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine(new_human), WEAR_HANDS)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare/full(new_human), WEAR_R_STORE)

//*****************************************************************************************************/

/datum/equipment_preset/uscm/private_equipped/eva/grenade
	name = "USCM Squad Grenadier (Equipped, M92 HEFA+Misc, EVA)"

/datum/equipment_preset/uscm/private_equipped/eva/grenade/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "Marine Undershirt"
	new_human.underwear = "Marine Boxers"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/wirecutters(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/canteen, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/packet/hefa(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/sebb(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/packet/canister(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/smokebomb(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tank/emergency_oxygen, WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils/foxtrot(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/tool/screwdriver(new_human), WEAR_R_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/pressure/uscm(new_human), WEAR_HEAD)
	add_uscm_cover(new_human)
	//uniform
	add_uscm_uniform(new_human)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/space/pressure/uscm/armband(new_human), WEAR_JACKET)
	add_eva_suit_accessory(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/small/space(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/launcher/grenade/m92/frag(new_human), WEAR_J_STORE)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/m4a3/full/ap(new_human), WEAR_WAIST)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/jungle/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine(new_human), WEAR_HANDS)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare/full(new_human), WEAR_R_STORE)

//*****************************************************************************************************/

/datum/equipment_preset/uscm/private_equipped/eva/battlerifle
	name = "USCM Squad Sniper (Equipped, M49A6, EVA)"

/datum/equipment_preset/uscm/private_equipped/eva/battlerifle/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "Marine Undershirt"
	new_human.underwear = "Marine Boxers"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/screwdriver(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/wirecutters(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/folded(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tank/emergency_oxygen, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/canteen, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m49a/custom/pve(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m49a/custom/pve(new_human), WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils/foxtrot(new_human), WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/pressure/uscm(new_human), WEAR_HEAD)
	add_uscm_cover(new_human)
	//uniform
	add_uscm_uniform(new_human)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/space/pressure/uscm/armband(new_human), WEAR_JACKET)
	add_eva_suit_accessory(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/small/space(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m49a/pve/with_scope(new_human), WEAR_J_STORE)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/m4a3/full/ap(new_human), WEAR_WAIST)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/jungle/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine(new_human), WEAR_HANDS)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare/full(new_human), WEAR_R_STORE)

//*****************************************************************************************************/

/datum/equipment_preset/uscm/private_equipped/eva/flamer
	name = "USCM Squad Rifleman (Equipped, Incinerator, EVA)"

/datum/equipment_preset/uscm/private_equipped/eva/flamer/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "Marine Undershirt"
	new_human.underwear = "Marine Boxers"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/screwdriver(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/wirecutters(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/folded(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tank/emergency_oxygen, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/canteen, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/flamer_tank(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/flare(new_human), WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils/foxtrot(new_human), WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/pressure/uscm(new_human), WEAR_HEAD)
	add_uscm_cover(new_human)
	//uniform
	add_uscm_uniform(new_human)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/space/pressure/uscm/armband_engie(new_human), WEAR_JACKET)
	add_eva_suit_accessory(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/small/space(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/flamer(new_human), WEAR_J_STORE)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/m4a3/full/ap(new_human), WEAR_WAIST)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/jungle/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine(new_human), WEAR_HANDS)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine/pistol/large/vp70(new_human), WEAR_R_STORE)

//*****************************************************************************************************/

/datum/equipment_preset/uscm/smartgunner_equipped
	name = "USCM Squad Smartgunner (Equipped)"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE

	access = list(ACCESS_MARINE_PREP, ACCESS_MARINE_SMARTPREP)
	assignment = JOB_SQUAD_SMARTGUN
	rank = JOB_SQUAD_SMARTGUN
	paygrades = list(PAY_SHORT_ME4 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "SG"
	skills = /datum/skills/smartgunner

	minimap_icon = "smartgunner"
	dress_under = list(/obj/item/clothing/under/marine/dress/blues)
	dress_over = list(/obj/item/clothing/suit/storage/jacket/marine/dress/blues)

/datum/equipment_preset/uscm/smartgunner_equipped/load_status(mob/living/carbon/human/new_human)
	new_human.nutrition = NUTRITION_NORMAL

/datum/equipment_preset/uscm/smartgunner_equipped/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "Marine Undershirt"
	new_human.underwear = "Marine Boxers"
	//back
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils/foxtrot(new_human), WEAR_L_EAR)
	//head
	var/random_cover = rand(1,3)
	switch(random_cover)
		if(1 to 2)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine(new_human), WEAR_HEAD)
			add_uscm_cover(new_human)
		if(3)
			new_human.equip_to_slot_or_del(new 	/obj/item/device/overwatch_camera(new_human), WEAR_R_EAR)
	add_uscm_goggles(new_human)
	//uniform
	add_uscm_uniform(new_human)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/smartgunner(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m56/preset(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/smartgun(new_human), WEAR_J_STORE)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/smartgunner/garrow(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smartgun(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/m4a3(new_human), WEAR_IN_BELT)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/jungle/knife(new_human), WEAR_FEET)
	add_combat_gloves(new_human)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare/full(new_human), WEAR_R_STORE)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/night/m56_goggles/no_nightvision(new_human), WEAR_EYES)

	if(SSmapping.configs[GROUND_MAP].environment_traits[MAP_COLD])
		new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/rebreather/scarf, WEAR_FACE)
//*****************************************************************************************************/

//*****************************************************************************************************/

/datum/equipment_preset/uscm/smartgunner_equipped/eva
	name = "USCM Squad Smartgunner (Equipped, EVA)"

/datum/equipment_preset/uscm/smartgunner_equipped/eva/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "Marine Undershirt"
	new_human.underwear = "Marine Boxers"
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils/foxtrot(new_human), WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/pressure/uscm(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/canteen, WEAR_IN_HELMET)
	new_human.equip_to_slot_or_del(new /obj/item/tank/emergency_oxygen, WEAR_IN_HELMET)
	add_uscm_cover(new_human)
	//uniform
	add_uscm_uniform(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/droppouch(new_human), WEAR_ACCESSORY)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/space/pressure/uscm/armband(new_human), WEAR_JACKET)
	add_eva_suit_accessory(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/small/space(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/smartgun(new_human), WEAR_J_STORE)
	//back
	if(prob(90))
		new_human.equip_to_slot_or_del(new /obj/item/storage/large_holster/machete/smartgunner/full(new_human), WEAR_BACK)
	else
	//i like to keep this handy, for close encounters
		new_human.equip_to_slot_or_del(new /obj/item/storage/large_holster/m37/full(new_human), WEAR_BACK)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/buckshot(new_human), WEAR_IN_ACCESSORY)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/buckshot(new_human), WEAR_IN_ACCESSORY)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/buckshot(new_human), WEAR_IN_ACCESSORY)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/buckshot(new_human), WEAR_IN_ACCESSORY)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/smartgunner/garrow(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smartgun(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/m4a3(new_human), WEAR_IN_BELT)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/jungle/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine(new_human), WEAR_HANDS)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare/full(new_human), WEAR_R_STORE)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/night/m56_goggles/no_nightvision(new_human), WEAR_EYES)

	if(SSmapping.configs[GROUND_MAP].environment_traits[MAP_COLD])
		new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/rebreather/scarf, WEAR_FACE)
//*****************************************************************************************************/

/datum/equipment_preset/uscm/tl_equipped
	name = "USCM Squad Leader (Equipped)"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE

	access = list(ACCESS_MARINE_PREP, ACCESS_MARINE_TL_PREP)
	assignment = JOB_SQUAD_TEAM_LEADER
	rank = JOB_SQUAD_TEAM_LEADER
	paygrades = list(PAY_SHORT_ME5 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "SqLdr"
	skills = /datum/skills/tl

	minimap_icon = "tl"

/datum/equipment_preset/uscm/tl_equipped/load_status(mob/living/carbon/human/new_human)
	new_human.nutrition = NUTRITION_NORMAL

/datum/equipment_preset/uscm/tl_equipped/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "Marine Undershirt"
	new_human.underwear = "Marine Boxers"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/weldingtool(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/wirecutters(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/folded(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/canteen, WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils/foxtrot(new_human), WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine(new_human), WEAR_HEAD)
	add_uscm_cover(new_human)
	add_uscm_goggles(new_human)
	//uniform
	add_uscm_uniform(new_human)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/mag/mk1(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1/preloaded(new_human), WEAR_J_STORE)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/general_belt(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range/designator(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/flare/signal(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/plastic/breaching_charge(new_human), WEAR_IN_BELT)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/jungle/knife(new_human), WEAR_FEET)
	add_combat_gloves(new_human)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare/full(new_human), WEAR_R_STORE)

	if(SSmapping.configs[GROUND_MAP].environment_traits[MAP_COLD])
		new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/rebreather/scarf, WEAR_FACE)
//*****************************************************************************************************/

//*****************************************************************************************************/

/datum/equipment_preset/uscm/tl_equipped/eva
	name = "USCM Squad Leader (Equipped, EVA)"

/datum/equipment_preset/uscm/tl_equipped/eva/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "Marine Undershirt"
	new_human.underwear = "Marine Boxers"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/wirecutters(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/screwdriver(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/hypospray/autoinjector/nutriment, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/canteen, WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils/foxtrot(new_human), WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/pressure/uscm(new_human), WEAR_HEAD)
	add_uscm_cover(new_human)
	//uniform
	add_uscm_uniform(new_human)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/space/pressure/uscm/armband(new_human), WEAR_JACKET)
	add_eva_suit_accessory(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/small/space(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1/preloaded(new_human), WEAR_J_STORE)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/general_belt(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range/designator(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/flare/signal(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/plastic/breaching_charge(new_human), WEAR_IN_BELT)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/jungle/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine(new_human), WEAR_HANDS)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare/full(new_human), WEAR_R_STORE)

	if(SSmapping.configs[GROUND_MAP].environment_traits[MAP_COLD])
		new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/rebreather/scarf, WEAR_FACE)
//*****************************************************************************************************/
/datum/equipment_preset/uscm/medic_equipped
	name = "USCM Squad Hospital Corpsman (Equipped)"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE

	access = list(ACCESS_MARINE_PREP, ACCESS_MARINE_MEDPREP, ACCESS_MARINE_MEDBAY)
	assignment = JOB_SQUAD_MEDIC
	rank = JOB_SQUAD_MEDIC
	paygrades = list(PAY_SHORT_ME4 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "HM"
	skills = /datum/skills/combat_medic

	minimap_icon = "medic"

	utility_under = list(/obj/item/clothing/under/marine)
	dress_under = list(/obj/item/clothing/under/marine/dress/blues)
	dress_over = list(/obj/item/clothing/suit/storage/jacket/marine/dress/blues)

/datum/equipment_preset/uscm/medic_equipped/load_status(mob/living/carbon/human/new_human)
	new_human.nutrition = NUTRITION_NORMAL

/datum/equipment_preset/uscm/medic_equipped/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "Marine Undershirt"
	new_human.underwear = "Marine Boxers"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel/medic(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/surgery/surgical_line(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/surgery/synthgraft(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/softpack/regular(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/softpack/adv(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/healthanalyzer/soul(new_human), WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils/foxtrot(new_human), WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/medic(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/canteen, WEAR_IN_HELMET)
	add_uscm_cover(new_human)
	add_uscm_goggles(new_human)
	//uniform
	add_uscm_uniform(new_human)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/mag/mk1(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1/preloaded(new_human), WEAR_J_STORE)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/medical/lifesaver/full(new_human), WEAR_WAIST)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/jungle/knife(new_human), WEAR_FEET)
	add_combat_gloves(new_human)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/medkit/full(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare/full(new_human), WEAR_R_STORE)

	if(SSmapping.configs[GROUND_MAP].environment_traits[MAP_COLD])
		new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/rebreather/scarf, WEAR_FACE)
//*****************************************************************************************************/

/datum/equipment_preset/uscm/medic_equipped/eva
	name = "USCM Squad Hospital Corpsman (Equipped, EVA)"


/datum/equipment_preset/uscm/medic_equipped/eva/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "Marine Undershirt"
	new_human.underwear = "Marine Boxers"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel/medic(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/surgery/surgical_line(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/surgery/synthgraft(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/regular(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/adv(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tank/emergency_oxygen/double(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/hypospray/autoinjector/nutriment(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/smokebomb/green(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/weldingtool(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/surgical_case/regular, WEAR_L_HAND)
	new_human.equip_to_slot_or_del(new /obj/item/tank/emergency_oxygen/double(new_human), WEAR_R_HAND)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils/foxtrot(new_human), WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/pressure/uscm(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/canteen, WEAR_IN_HELMET)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/hypospray/autoinjector/nutriment, WEAR_IN_HELMET)
	new_human.equip_to_slot_or_del(new /obj/item/device/helmet_visor/medical/advanced, WEAR_IN_HELMET)
	add_uscm_cover(new_human)
	//uniform
	add_uscm_uniform(new_human)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/space/pressure/uscm/armband_medical(new_human), WEAR_JACKET)
	add_eva_suit_accessory(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/mag/mk1(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1/preloaded(new_human), WEAR_J_STORE)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/medical/lifesaver/full/liquid(new_human), WEAR_WAIST)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/magboots(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine(new_human), WEAR_HANDS)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/medkit/full(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare/full(new_human), WEAR_R_STORE)
//*****************************************************************************************************/

/datum/equipment_preset/uscm/leader_equipped
	name = "USCM Section Sergeant (Equipped)"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE

	access = list(ACCESS_MARINE_PREP, ACCESS_MARINE_LEADER, ACCESS_MARINE_DROPSHIP)
	assignment = JOB_SQUAD_LEADER
	rank = JOB_SQUAD_LEADER
	paygrades = list(PAY_SHORT_ME7 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "SctSgt"
	minimum_age = 27
	skills = /datum/skills/SL

	minimap_icon = "leader"

/datum/equipment_preset/uscm/leader_equipped/load_status(mob/living/carbon/human/new_human)
	new_human.nutrition = NUTRITION_NORMAL

/datum/equipment_preset/uscm/leader_equipped/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "Marine Undershirt"
	new_human.underwear = "Marine Boxers"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/weldingtool(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/wirecutters(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/folded(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/canteen, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/flare(new_human), WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils/foxtrot(new_human), WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine(new_human), WEAR_HEAD)
	add_uscm_cover(new_human)
	add_uscm_goggles(new_human)
	//uniform
	add_uscm_uniform(new_human)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/mag/mk1(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1/preloaded(new_human), WEAR_J_STORE)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/general_belt(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range/designator(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/vp70(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/vp70(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/flare/signal(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/plastic/breaching_charge(new_human), WEAR_IN_BELT)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/jungle/knife(new_human), WEAR_FEET)
	add_combat_gloves(new_human)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/pistol/alt(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/vp70(new_human), WEAR_IN_R_STORE)

	if(SSmapping.configs[GROUND_MAP].environment_traits[MAP_COLD])
		new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/rebreather/scarf, WEAR_FACE)
//*****************************************************************************************************/

/datum/equipment_preset/uscm/leader_equipped/eva
	name = "USCM Section Sergeant (Equipped, EVA)"

/datum/equipment_preset/uscm/leader_equipped/eva/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "Marine Undershirt"
	new_human.underwear = "Marine Boxers"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/wirecutters(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/screwdriver(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/regular, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/canteen, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/flare(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/hypospray/autoinjector/nutriment, WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils/foxtrot(new_human), WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/pressure/uscm(new_human), WEAR_HEAD)
	add_uscm_cover(new_human)
	//uniform
	add_uscm_uniform(new_human)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/space/pressure/uscm/armband_engie(new_human), WEAR_JACKET)
	add_eva_suit_accessory(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/mag/mk1(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1/preloaded(new_human), WEAR_J_STORE)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/general_belt(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range/designator(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/vp70(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/vp70(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/flare/signal(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/plastic/breaching_charge(new_human), WEAR_IN_BELT)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/jungle/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine(new_human), WEAR_HANDS)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/pistol/alt(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/vp70(new_human), WEAR_IN_R_STORE)

	if(SSmapping.configs[GROUND_MAP].environment_traits[MAP_COLD])
		new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/rebreather/scarf, WEAR_FACE)



/datum/equipment_preset/uscm/engineer_equipped
	name = "USCM Squad Combat Engineer (Equipped)"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE

	access = list(ACCESS_MARINE_PREP, ACCESS_MARINE_ENGPREP, ACCESS_CIVILIAN_ENGINEERING)
	assignment = JOB_SQUAD_ENGI
	rank = JOB_SQUAD_ENGI
	paygrades = list(PAY_SHORT_ME3 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "ComEng"
	skills = /datum/skills/combat_engineer

	minimap_icon = "engi"

	utility_under = list(/obj/item/clothing/under/marine)
	dress_under = list(/obj/item/clothing/under/marine/dress/blues)
	dress_over = list(/obj/item/clothing/suit/storage/jacket/marine/dress/blues)

/datum/equipment_preset/uscm/engineer_equipped/load_status(mob/living/carbon/human/new_human)
	new_human.nutrition = NUTRITION_NORMAL

/datum/equipment_preset/uscm/engineer_equipped/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "Marine Undershirt"
	new_human.underwear = "Marine Boxers"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/engineerpack/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/canteen(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/toolkit/full(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/defenses/handheld/sentry(new_human), WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils/foxtrot(new_human), WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine(new_human), WEAR_HEAD)
	add_uscm_cover(new_human)
	add_uscm_goggles(new_human)
	//uniform
	add_uscm_uniform(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/sapper, WEAR_ACCESSORY)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/mag/mk1(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1/preloaded(new_human), WEAR_J_STORE)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/utility/full(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/folded(new_human), WEAR_IN_BELT)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/jungle/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine(new_human), WEAR_HANDS)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/construction/full_barbed_wire(new_human), WEAR_R_STORE)

	if(SSmapping.configs[GROUND_MAP].environment_traits[MAP_COLD])
		new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/rebreather/scarf, WEAR_FACE)

/datum/equipment_preset/uscm/engineer_equipped/lesser_rank
	name = parent_type::name + " (E2 Rank)"
	paygrades = list(PAY_SHORT_ME2 = JOB_PLAYTIME_TIER_0)

//*****************************************************************************************************/

//*****************************************************************************************************/

/datum/equipment_preset/uscm/engineer_equipped/eva_flamer
	name = "USCM Squad Combat Engineer (Equipped, EVA, Incinerator)"


/datum/equipment_preset/uscm/engineer_equipped/eva_flamer/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "Marine Undershirt"
	new_human.underwear = "Marine Boxers"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/engineerpack/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/flamer_tank/gellied(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/defenses/handheld/sentry(new_human), WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils/foxtrot(new_human), WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/pressure/uscm(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/canteen(new_human), WEAR_IN_HELMET)
	add_uscm_cover(new_human)
	//uniform
	add_uscm_uniform(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/sapper, WEAR_ACCESSORY)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/space/pressure/uscm/armband_engie(new_human), WEAR_JACKET)
	add_eva_suit_accessory(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/small/space(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1/preloaded(new_human), WEAR_J_STORE)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/utility/full, WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/cell/high(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/circuitboard/apc(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/plastic/breaching_charge(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/folded(new_human), WEAR_IN_BELT)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/jungle/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine(new_human), WEAR_HANDS)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/construction/full_barbed_wire(new_human), WEAR_R_STORE)
	//flamer in hand
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/flamer(new_human), WEAR_L_HAND)
	if(SSmapping.configs[GROUND_MAP].environment_traits[MAP_COLD])
		new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/rebreather/scarf, WEAR_FACE)

//*****************************************************************************************************/

/datum/equipment_preset/uscm/engineer_equipped/eva_sadar
	name = "USCM Squad Combat Engineer (Equipped, EVA, SADAR)"


/datum/equipment_preset/uscm/engineer_equipped/eva_sadar/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "Marine Undershirt"
	new_human.underwear = "Marine Boxers"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/engineerpack/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/prop/folded_anti_tank_sadar(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/defenses/handheld/sentry(new_human), WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils/foxtrot(new_human), WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/pressure/uscm(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/canteen(new_human), WEAR_IN_HELMET)
	add_uscm_cover(new_human)
	//uniform
	add_uscm_uniform(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/sapper, WEAR_ACCESSORY)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/space/pressure/uscm/armband_engie(new_human), WEAR_JACKET)
	add_eva_suit_accessory(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/small/space(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1/preloaded(new_human), WEAR_J_STORE)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/utility/full, WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/cell/high(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/circuitboard/apc(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/plastic/breaching_charge(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/folded(new_human), WEAR_IN_BELT)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/jungle/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine(new_human), WEAR_HANDS)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/construction/full_barbed_wire(new_human), WEAR_R_STORE)
	//SADAR in hand
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/launcher/rocket/anti_tank/disposable(new_human), WEAR_L_HAND)
	if(SSmapping.configs[GROUND_MAP].environment_traits[MAP_COLD])
		new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/rebreather/scarf, WEAR_FACE)

//*****************************************************************************************************/
/datum/equipment_preset/uscm/mortar_operator_equipped
	name = "USCM Mortar Operator (Equipped)"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE

	access = list(ACCESS_MARINE_PREP, ACCESS_MARINE_ENGPREP, ACCESS_CIVILIAN_ENGINEERING)
	assignment = JOB_WO_PILOT
	rank = JOB_WO_PILOT
	paygrades = list(PAY_SHORT_ME3 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "MC"
	skills = /datum/skills/combat_engineer

	minimap_icon = "vc"

/datum/equipment_preset/uscm/mortar_operator_equipped/load_status(mob/living/carbon/human/new_human)
	new_human.nutrition = NUTRITION_NORMAL

/datum/equipment_preset/uscm/mortar_operator_equipped/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "Marine Undershirt"
	new_human.underwear = "Marine Boxers"
	//back
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils(new_human), WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap(new_human), WEAR_HEAD)
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/officer/cargo(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/sapper, WEAR_ACCESSORY)
	//jacket
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/m4a3/vp70, WEAR_WAIST)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	add_combat_gloves(new_human)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/large, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/device/flashlight, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/tool/screwdriver, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/tools/mortar, WEAR_L_STORE)

//*****************************************************************************************************/

/datum/equipment_preset/uscm/specialist_equipped
	name = "USCM Specialized Weapons Operator, M5 RPG (Equipped)"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE
	access = list(ACCESS_MARINE_PREP, ACCESS_MARINE_SPECPREP)
	assignment = "Rocketeer"
	rank = JOB_SQUAD_SPECIALIST
	paygrades = list(PAY_SHORT_ME3 = JOB_PLAYTIME_TIER_0) //Gives them reason as to why they'll have a loader to boss about without impinging on overall rank structure of a section
	role_comm_title = "Spc"
	skills = /datum/skills/pfc

	minimap_icon = "spec"
	dress_under = list(/obj/item/clothing/under/marine/dress/blues)
	dress_over = list(/obj/item/clothing/suit/storage/jacket/marine/dress/blues)

/datum/equipment_preset/uscm/specialist_equipped/load_status(mob/living/carbon/human/new_human)
	new_human.nutrition = NUTRITION_NORMAL

/datum/equipment_preset/uscm/specialist_equipped/load_gear(mob/living/carbon/human/new_human)
	new_human.underwear = "Marine Boxers"
	new_human.undershirt = "Marine Undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/launcher/rocket/marine(new_human), WEAR_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils(new_human), WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/M3T(new_human), WEAR_HEAD)
	add_uscm_cover(new_human)
	add_uscm_goggles(new_human)
	//uniform
	add_uscm_uniform(new_human)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/smooth(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/pads/greaves(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/pads/kneepads(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/pads/neckguard(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/mag/mk1(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1/preloaded(new_human), WEAR_J_STORE)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/general_belt(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range/designator(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BELT)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/jungle/knife(new_human), WEAR_FEET)
	add_combat_gloves(new_human)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare/full(new_human), WEAR_R_STORE)

	if(SSmapping.configs[GROUND_MAP].environment_traits[MAP_COLD])
		new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/rebreather/scarf, WEAR_FACE)

//*****************************************************************************************************/

/datum/equipment_preset/uscm/specialist_equipped/eva
	name = "USCM Specialized Weapons Operator, M5 RPG (Equipped, EVA)"

/datum/equipment_preset/uscm/specialist_equipped/eva/load_gear(mob/living/carbon/human/new_human)
	new_human.underwear = "Marine Boxers"
	new_human.undershirt = "Marine Undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/launcher/rocket/marine(new_human), WEAR_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils(new_human), WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/pressure/uscm(new_human), WEAR_HEAD)
	add_uscm_cover(new_human)
	add_eva_suit_accessory(new_human)
	//uniform
	add_uscm_uniform(new_human)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/space/pressure/uscm/armband_engie(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/small/space(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1/preloaded(new_human), WEAR_J_STORE)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/general_belt(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range/designator(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_BELT)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/jungle/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/brown, WEAR_HANDS)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare/full(new_human), WEAR_R_STORE)

	if(SSmapping.configs[GROUND_MAP].environment_traits[MAP_COLD])
		new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/rebreather/scarf, WEAR_FACE)

//*****************************************************************************************************/

/datum/equipment_preset/uscm/specialist_equipped/loader
	name = "USCM Specialized Weapons Operator, M5 RPG Loader(Equipped)"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE
	access = list(ACCESS_MARINE_PREP, ACCESS_MARINE_SPECPREP)
	assignment = "Rocketeer"
	rank = JOB_SQUAD_LOADER
	paygrades = list(PAY_SHORT_ME2 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "Spc"
	skills = /datum/skills/pfc

	minimap_icon = "spec"
	dress_under = list(/obj/item/clothing/under/marine/dress/blues)
	dress_over = list(/obj/item/clothing/suit/storage/jacket/marine/dress/blues)

/datum/equipment_preset/uscm/specialist_equipped/loader/load_status(mob/living/carbon/human/new_human)
	new_human.nutrition = NUTRITION_NORMAL

/datum/equipment_preset/uscm/specialist_equipped/loader/load_gear(mob/living/carbon/human/new_human)
	new_human.underwear = "Marine Boxers"
	new_human.undershirt = "Marine Undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/rocketpack(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rocket(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rocket(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rocket/ap(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rocket/ap(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rocket/wp(new_human), WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils(new_human), WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/M3T(new_human), WEAR_HEAD)
	add_uscm_cover(new_human)
	add_uscm_goggles(new_human)
	//uniform
	add_uscm_uniform(new_human)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/smooth(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/pads/greaves(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/pads/kneepads(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/pads/neckguard(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/recon(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1/preloaded(new_human), WEAR_J_STORE)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/general_belt(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range/designator(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1, WEAR_IN_BELT)

	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/jungle/knife(new_human), WEAR_FEET)
	add_combat_gloves(new_human)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare/full(new_human), WEAR_R_STORE)
	GLOB.character_traits[/datum/character_trait/skills/loader].apply_trait(new_human)

	if(SSmapping.configs[GROUND_MAP].environment_traits[MAP_COLD])
		new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/rebreather/scarf, WEAR_FACE)
//*****************************************************************************************************/

/datum/equipment_preset/uscm/specialist_equipped/loader_eva
	name = "USCM Specialized Weapons Operator, M5 RPG Loader(EVA, Equipped)"

/datum/equipment_preset/uscm/specialist_equipped/loader_eva/load_gear(mob/living/carbon/human/new_human)
	new_human.underwear = "Marine Boxers"
	new_human.undershirt = "Marine Undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/rocketpack(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rocket(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rocket(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rocket/ap(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rocket/ap(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rocket/wp(new_human), WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils(new_human), WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/pressure/uscm(new_human), WEAR_HEAD)
	add_uscm_cover(new_human)
	add_eva_suit_accessory(new_human)
	//uniform
	add_uscm_uniform(new_human)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/space/pressure/uscm/armband_engie(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/pads/greaves(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/pads/kneepads(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/pads/neckguard(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/small/space(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1/preloaded(new_human), WEAR_J_STORE)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/general_belt(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range/designator(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1, WEAR_IN_BELT)

	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/jungle/knife(new_human), WEAR_FEET)
	add_combat_gloves(new_human)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare/full(new_human), WEAR_R_STORE)
	GLOB.character_traits[/datum/character_trait/skills/loader].apply_trait(new_human)

	if(SSmapping.configs[GROUND_MAP].environment_traits[MAP_COLD])
		new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/rebreather/scarf, WEAR_FACE)
//*****************************************************************************************************/

/datum/equipment_preset/uscm/specialist_equipped/b18
	name = "USCM Specialized Weapons Operator, B18 (Equipped)"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE
	assignment = "Experimental Heavy Rifleman"
	rank = JOB_SQUAD_SPECIALIST
	paygrades = list(PAY_SHORT_ME2 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "B18"
	skills = /datum/skills/pfc
/datum/equipment_preset/uscm/specialist_equipped/b18/load_gear(mob/living/carbon/human/new_human)
	new_human.underwear = "Marine Boxers"
	new_human.undershirt = "Marine Undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel/tech(new_human), WEAR_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils(new_human), WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/specialist(new_human), WEAR_HEAD)
	//uniform
	add_uscm_uniform(new_human)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/specialist(new_human), WEAR_JACKET)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1/preloaded(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_BELT)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/jungle/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/specialist(new_human), WEAR_HANDS)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare/full(new_human), WEAR_R_STORE)

	if(SSmapping.configs[GROUND_MAP].environment_traits[MAP_COLD])
		new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/rebreather/scarf, WEAR_FACE)
//*****************************************************************************************************/

/datum/equipment_preset/uscm/specialist_equipped/sniper
	name = "USCM Scout Sniper, Shooter (Equipped)"
	assignment = "Scout Sniper"
	role_comm_title = "SctSnpr"
	skills = /datum/skills/tl/recon
	paygrades = list(PAY_SHORT_ME4 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uscm/specialist_equipped/sniper/load_gear(mob/living/carbon/human/new_human)
	new_human.underwear = "Marine Boxers"
	new_human.undershirt = "Marine Undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/weldingtool(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/wirecutters(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/folded(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/canteen, WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/rebreather/scarf/tacticalmask/green(new_human), WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/boonie(new_human), WEAR_HEAD)
	add_uscm_goggles(new_human)
	//uniform
	add_uscm_uniform(new_human)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/rto/forecon(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/pads/kneepads(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/recon(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/sniper/M42A(new_human), WEAR_J_STORE)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/general_belt(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range/designator/spotter(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/sniper(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/sniper(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/sniper(new_human), WEAR_IN_BELT)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/jungle/knife(new_human), WEAR_FEET)
	add_combat_gloves(new_human)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare/full(new_human), WEAR_R_STORE)
	GLOB.character_traits[/datum/character_trait/skills/spotter].apply_trait(new_human)

	if(SSmapping.configs[GROUND_MAP].environment_traits[MAP_COLD])
		new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/rebreather/scarf, WEAR_FACE)

//*****************************************************************************************************/

/datum/equipment_preset/uscm/specialist_equipped/spotter
	name = "USCM Scout Sniper, Spotter (Equipped)"
	assignment = "Scout Sniper"
	role_comm_title = "SctSnpr"
	rank = JOB_SQUAD_SPOTTER
	skills = /datum/skills/tl/recon
	paygrades = list(PAY_SHORT_ME4 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uscm/specialist_equipped/spotter/load_gear(mob/living/carbon/human/new_human)
	new_human.underwear = "Marine Boxers"
	new_human.undershirt = "Marine Undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/weldingtool(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/wirecutters(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/folded(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/canteen, WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/rebreather/scarf/tacticalmask/green(new_human), WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/boonie(new_human), WEAR_HEAD)
	add_uscm_goggles(new_human)
	//uniform
	add_uscm_uniform(new_human)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/rto/forecon(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/pads/kneepads(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/recon/mk1(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1/forecon/preloaded(new_human), WEAR_J_STORE)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/general_belt(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range/designator/spotter(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/sniper(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/sniper(new_human), WEAR_IN_BELT)

	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/jungle/knife(new_human), WEAR_FEET)
	add_combat_gloves(new_human)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare/full(new_human), WEAR_R_STORE)
	GLOB.character_traits[/datum/character_trait/skills/spotter].apply_trait(new_human)

	if(SSmapping.configs[GROUND_MAP].environment_traits[MAP_COLD])
		new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/rebreather/scarf, WEAR_FACE)
//*****************************************************************************************************/

/datum/equipment_preset/uscm/tank
	name = "USCM Vehicle Crewman (Equipped)"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE
	access = list(
		ACCESS_MARINE_PREP,
		ACCESS_MARINE_CREWMAN,
		ACCESS_MARINE_ALPHA,
		ACCESS_MARINE_BRAVO,
		ACCESS_MARINE_CHARLIE,
		ACCESS_MARINE_DELTA,
	)
	assignment = "Vehicle Crewmember"
	rank = JOB_TANK_CREW
	paygrades = list(PAY_SHORT_ME4 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "CRMN"
	skills = /datum/skills/tank_crew
	minimap_icon = "vc"

/datum/equipment_preset/uscm/tank/load_gear(mob/living/carbon/human/new_human)
	new_human.underwear = "Marine Boxers"
	new_human.undershirt = "Marine Undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/folded(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils(new_human), WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/M3T(new_human), WEAR_HEAD)
	add_uscm_cover(new_human)
	add_uscm_goggles(new_human)
	//uniform
	add_uscm_uniform(new_human)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/vest/pilot(new_human), WEAR_JACKET)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/utility/full(new_human), WEAR_WAIST)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	add_combat_gloves(new_human)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/pistol/alt(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/vp70(new_human), WEAR_IN_R_STORE)

	if(SSmapping.configs[GROUND_MAP].environment_traits[MAP_COLD])
		new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/rebreather/scarf, WEAR_FACE)


/datum/equipment_preset/uscm/marsoc
	name = "USCM Marine Raider"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = "Raider"
	rank = JOB_MARINE_RAIDER
	role_comm_title = "CSO"
	languages = list(LANGUAGE_ENGLISH, LANGUAGE_TSL)
	skills = /datum/skills/commando/deathsquad
	auto_squad_name = SQUAD_SOF
	ert_squad = TRUE
	paygrades = list(PAY_SHORT_ME4 = JOB_PLAYTIME_TIER_0)

	minimap_icon = "sof_sg"

/datum/equipment_preset/uscm/marsoc/load_status(mob/living/carbon/human/new_human)
	new_human.nutrition = NUTRITION_NORMAL

/datum/equipment_preset/uscm/marsoc/New()
	. = ..()
	access = get_access(ACCESS_LIST_GLOBAL)

/datum/equipment_preset/uscm/marsoc/load_gear(mob/living/carbon/human/new_human)
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel/intel, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/motiondetector, WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/sof, WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/leader, WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/prop/helmetgarb/raincover, WEAR_IN_HELMET)
	//uniform
	var/obj/item/clothing/under/marine/veteran/marsoc/M = new()
	var/obj/item/clothing/accessory/storage/smallpouch/W = new()
	M.attach_accessory(new_human, W)
	new_human.equip_to_slot_or_del(M, WEAR_BODY)
	for(var/i in 1 to W.hold.storage_slots)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/buckshot, WEAR_IN_ACCESSORY)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/leader, WEAR_JACKET)
	add_marsoc_weapon(new_human)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/shotgun/combat/marsoc, WEAR_WAIST)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/jungle/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine, WEAR_HANDS)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1, WEAR_IN_R_STORE)

/datum/equipment_preset/uscm/marsoclead
	name = "USCM Marine Raider Team Lead"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = "Raider Team Lead"
	rank = JOB_MARINE_RAIDER_SL
	role_comm_title = "RTL"
	languages = list(LANGUAGE_ENGLISH, LANGUAGE_TSL)
	skills = /datum/skills/commando/deathsquad
	auto_squad_name = SQUAD_SOF
	ert_squad = TRUE
	paygrades = list(PAY_SHORT_ME6 = JOB_PLAYTIME_TIER_0)

	minimap_icon = "sof_sg"

/datum/equipment_preset/uscm/marsoclead/load_status(mob/living/carbon/human/new_human)
	new_human.nutrition = NUTRITION_NORMAL

/datum/equipment_preset/uscm/marsoclead/New()
	. = ..()
	access = get_access(ACCESS_LIST_GLOBAL)

/datum/equipment_preset/uscm/marsoclead/load_gear(mob/living/carbon/human/new_human)
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel/intel, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/motiondetector, WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/sof, WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/leader, WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/prop/helmetgarb/raincover, WEAR_IN_HELMET)
	//uniform
	var/obj/item/clothing/under/marine/veteran/marsoc/M = new()
	var/obj/item/clothing/accessory/storage/smallpouch/W = new()
	M.attach_accessory(new_human, W)
	new_human.equip_to_slot_or_del(M, WEAR_BODY)
	for(var/i in 1 to W.hold.storage_slots)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/buckshot, WEAR_IN_ACCESSORY)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/leader, WEAR_JACKET)
	add_marsoc_weapon(new_human)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/shotgun/combat/marsoc, WEAR_WAIST)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/jungle/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine, WEAR_HANDS)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1, WEAR_IN_R_STORE)
