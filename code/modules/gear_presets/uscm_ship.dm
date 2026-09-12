/datum/equipment_preset/uscm_ship
	name = "USCM (ship roles)"
	faction = FACTION_MARINE
	faction_group = FACTION_LIST_UA
	minimum_age = 20
	languages = list(LANGUAGE_ENGLISH)
	idtype = /obj/item/card/id/dogtag

/datum/equipment_preset/uscm_ship/load_name(mob/living/carbon/human/new_human, randomise)
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

	utility_under = list(/obj/item/clothing/under/marine/officer/command)
	utility_hat = list(/obj/item/clothing/head/cmcap)
	utility_gloves = list(/obj/item/clothing/gloves/marine)
	utility_shoes = list(/obj/item/clothing/shoes/marine/knife)
	utility_extra = list(/obj/item/clothing/head/beret/cm, /obj/item/clothing/head/beret/cm/tan)

	service_under = list(/obj/item/clothing/under/marine/officer/bridge)
	service_over = list(/obj/item/clothing/suit/storage/jacket/marine/service, /obj/item/clothing/suit/storage/jacket/marine/service/mp)
	service_hat = list(/obj/item/clothing/head/cmcap)
	service_shoes = list(/obj/item/clothing/shoes/laceup)

	dress_under = list(/obj/item/clothing/under/marine/dress/blues/senior)
	dress_over = list(/obj/item/clothing/suit/storage/jacket/marine/dress/blues/officer)
	dress_hat = list(/obj/item/clothing/head/marine/dress_cover/officer)
	dress_gloves = list(/obj/item/clothing/gloves/marine/dress)
	dress_shoes = list(/obj/item/clothing/shoes/laceup)

//*****************************************************************************************************/

/datum/equipment_preset/uscm_ship/liaison
	name = "USCM Corporate Liaison (CL)"
	faction_group =	FACTION_LIST_MARINE_WY
	flags = EQUIPMENT_PRESET_START_OF_ROUND

	idtype = /obj/item/card/id/silver/cl
	access = list(
		ACCESS_WY_GENERAL,
		ACCESS_MARINE_COMMAND,
		ACCESS_MARINE_RESEARCH,
		ACCESS_MARINE_MEDBAY,
		ACCESS_CIVILIAN_PUBLIC,
		ACCESS_CIVILIAN_RESEARCH,
		ACCESS_CIVILIAN_ENGINEERING,
		ACCESS_CIVILIAN_LOGISTICS,
		ACCESS_CIVILIAN_BRIG,
		ACCESS_CIVILIAN_MEDBAY,
		ACCESS_WY_FLIGHT,
		ACCESS_CIVILIAN_COMMAND,
	)
	assignment = JOB_CORPORATE_LIAISON
	rank = JOB_CORPORATE_LIAISON
	paygrades = list(PAY_SHORT_WYC2 = JOB_PLAYTIME_TIER_0, PAY_SHORT_WYC3 = JOB_PLAYTIME_TIER_2, PAY_SHORT_WYC4 = JOB_PLAYTIME_TIER_3, PAY_SHORT_WYC5 = JOB_PLAYTIME_TIER_4)
	role_comm_title = "CL"
	skills = /datum/skills/civilian

	minimap_icon = "cl"
	minimap_background = MINIMAP_ICON_BACKGROUND_CIVILIAN

	dress_under = list(
		/obj/item/clothing/under/liaison_suit/black,
		/obj/item/clothing/under/liaison_suit/blue,
		/obj/item/clothing/under/liaison_suit/brown,
		/obj/item/clothing/under/liaison_suit/corporate_formal,
		/obj/item/clothing/under/liaison_suit,
		/obj/item/clothing/under/liaison_suit/charcoal,
		/obj/item/clothing/under/liaison_suit/formal,
		/obj/item/clothing/under/liaison_suit/blazer,
		/obj/item/clothing/under/liaison_suit/suspenders,
		/obj/item/clothing/under/blackskirt,
		/obj/item/clothing/under/suit_jacket/trainee,
		/obj/item/clothing/under/liaison_suit/ivy,
		/obj/item/clothing/under/liaison_suit/orange,
		/obj/item/clothing/under/liaison_suit/field,
		/obj/item/clothing/under/colonist/workwear,
		/obj/item/clothing/under/colonist/workwear/khaki,
		/obj/item/clothing/under/colonist/workwear/pink,
		/obj/item/clothing/under/colonist/workwear/green,
	)
	dress_over = list(
		/obj/item/clothing/suit/storage/jacket/marine/corporate/black,
		/obj/item/clothing/suit/storage/jacket/marine/corporate,
		/obj/item/clothing/suit/storage/jacket/marine/corporate/brown,
		/obj/item/clothing/suit/storage/jacket/marine/corporate/blue,
		/obj/item/clothing/suit/storage/jacket/marine/corporate/black,
		/obj/item/clothing/suit/storage/jacket/marine/bomber/grey,
		/obj/item/clothing/suit/storage/jacket/marine/bomber/red,
		/obj/item/clothing/suit/storage/jacket/marine/bomber,
		/obj/item/clothing/suit/storage/bomber,
		/obj/item/clothing/suit/storage/bomber/alt,
		/obj/item/clothing/suit/storage/snow_suit/liaison,
		/obj/item/clothing/suit/storage/labcoat,
		/obj/item/clothing/suit/storage/jacket/marine/vest/grey,
		/obj/item/clothing/suit/storage/jacket/marine/vest,
		/obj/item/clothing/suit/storage/jacket/marine/vest/tan,
		/obj/item/clothing/suit/storage/webbing,
	)
	dress_extra = list(
		/obj/item/clothing/accessory/black,
		/obj/item/clothing/accessory/red,
		/obj/item/clothing/accessory/purple,
		/obj/item/clothing/accessory/blue,
		/obj/item/clothing/accessory/green,
		/obj/item/clothing/accessory/gold,
		/obj/item/clothing/accessory/horrible,
		/obj/item/clothing/glasses/sunglasses/big,
		/obj/item/clothing/glasses/sunglasses/aviator,
		/obj/item/clothing/glasses/sunglasses,
		/obj/item/clothing/glasses/sunglasses/prescription,
		/obj/item/clothing/glasses/regular/hipster,
	)
	dress_gloves = list(
		/obj/item/clothing/gloves/black,
		/obj/item/clothing/gloves/marine/dress,
	)
	dress_shoes = list(
		/obj/item/clothing/shoes/laceup,
		/obj/item/clothing/shoes/laceup/brown,
		/obj/item/clothing/shoes/black,
		/obj/item/clothing/shoes/marine/civilian,
	)
	dress_hat = list(
		/obj/item/clothing/head/fedora,
		/obj/item/clothing/head/beret/cm/black/civilian,
		/obj/item/clothing/head/beret/cm/white/civilian,
	)

/datum/equipment_preset/uscm_ship/liaison/New()
	. = ..()
	access = get_access(ACCESS_LIST_MARINE_LIAISON)

/datum/equipment_preset/uscm_ship/liaison/load_gear(mob/living/carbon/human/new_human)
	var/back_item = /obj/item/storage/backpack/satchel/lockable/liaison
	//There is no suitable backpack for a CL really...
	//if (new_human.client && new_human.client.prefs && (new_human.client.prefs.backbag == 1))
		//back_item = /obj/item/storage/backpack

	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/mcl(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/liaison_suit/ivy(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new back_item(new_human), WEAR_BACK)

//*****************************************************************************************************/

/datum/equipment_preset/uscm_ship/reporter
	name = "Combat Correspondent (Press)"
	flags = EQUIPMENT_PRESET_START_OF_ROUND

	access = list(
		ACCESS_MARINE_COMMAND,
		ACCESS_MARINE_RESEARCH,
		ACCESS_MARINE_MEDBAY,
		ACCESS_CIVILIAN_PUBLIC,
		ACCESS_CIVILIAN_RESEARCH,
		ACCESS_CIVILIAN_ENGINEERING,
		ACCESS_CIVILIAN_LOGISTICS,
		ACCESS_CIVILIAN_BRIG,
		ACCESS_CIVILIAN_MEDBAY,
		ACCESS_CIVILIAN_COMMAND,
		ACCESS_PRESS,
	)
	assignment = JOB_COMBAT_REPORTER
	rank = JOB_COMBAT_REPORTER
	paygrades = list(PAY_SHORT_CIV = JOB_PLAYTIME_TIER_0)
	role_comm_title = "PRESS"
	skills = /datum/skills/civilian
	idtype = /obj/item/card/id/silver/cl

	minimap_icon = "correspondent"
	minimap_background = MINIMAP_ICON_BACKGROUND_CIVILIAN

	dress_under = list()
	dress_over = list()
	dress_hat = list()

/datum/equipment_preset/uscm_ship/reporter/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/reporter(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/reporter(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/reporter(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/large(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/device/camera(new_human), WEAR_WAIST)

/datum/equipment_preset/uscm_ship/reporter/load_preset(mob/living/carbon/human/new_human, randomise, count_participant, client/mob_client, show_job_gear)
	. = ..()
	new_human.marine_buyable_categories[CIVILIAN_CAN_BUY_BACKPACK] = 1
	new_human.marine_buyable_categories[CIVILIAN_CAN_BUY_UTILITY] = 1

/datum/equipment_preset/uscm_ship/reporter_uscm
	name = "Combat Correspondent (USCM)"
	flags = EQUIPMENT_PRESET_START_OF_ROUND|EQUIPMENT_PRESET_MARINE
	access = list(
		ACCESS_MARINE_COMMAND,
		ACCESS_PRESS,
		ACCESS_MARINE_PREP,
	)
	assignment = JOB_COMBAT_REPORTER
	rank = JOB_COMBAT_REPORTER
	paygrades = list(PAY_SHORT_ME4 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "CC"
	skills = /datum/skills/pfc
	idtype = /obj/item/card/id/dogtag

	minimap_icon = "correspondent"
	minimap_background = MINIMAP_ICON_BACKGROUND_CIC

/datum/equipment_preset/uscm_ship/reporter_uscm/load_gear(mob/living/carbon/human/new_human)
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/folded(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/camera_film(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/camera_film(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/photo_album(new_human), WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils/foxtrot(new_human), WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine(new_human), WEAR_HEAD)
	add_uscm_cover(new_human)
	//uniform
	add_uscm_uniform(new_human)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/small(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1(new_human), WEAR_J_STORE)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_BELT)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/jungle/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/device/camera(new_human), WEAR_L_HAND)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare/full(new_human), WEAR_R_STORE)

//*****************************************************************************************************/

/datum/equipment_preset/uscm_ship/chief_engineer
	name = "USCM Chief Engineer (CE)"
	flags = EQUIPMENT_PRESET_START_OF_ROUND|EQUIPMENT_PRESET_MARINE

	idtype = /obj/item/card/id/dogtag
	access = list(
		ACCESS_MARINE_CE,
		ACCESS_MARINE_ENGINEERING,
		ACCESS_MARINE_COMMAND,
		ACCESS_CIVILIAN_ENGINEERING,
		ACCESS_MARINE_DATABASE,
		ACCESS_MARINE_MAINT,
		ACCESS_MARINE_OT,
		ACCESS_MARINE_SYNTH,
		ACCESS_MARINE_AI,
	)
	assignment = JOB_CHIEF_ENGINEER
	rank = JOB_CHIEF_ENGINEER
	paygrades = list(PAY_SHORT_MO1 = JOB_PLAYTIME_TIER_0, PAY_SHORT_MO2 = JOB_PLAYTIME_TIER_3)
	role_comm_title = "CE"
	minimum_age = 27
	skills = /datum/skills/CE

	minimap_icon = list("engi" = MINIMAP_ICON_COLOR_HEAD)
	minimap_background = MINIMAP_ICON_BACKGROUND_CIC

/datum/equipment_preset/uscm_ship/chief_engineer/load_gear(mob/living/carbon/human/new_human)
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/folded(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils(new_human), WEAR_L_EAR)
	//head
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/boilersuit/darkblue(new_human), WEAR_BODY)
	//jacket
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/utility/full(new_human), WEAR_WAIST)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/pistol/alt(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/vp70(new_human), WEAR_IN_R_STORE)

//*****************************************************************************************************/

/datum/equipment_preset/uscm_ship/maint
	name = "USCM Maintenance Technician (MT)"
	flags = EQUIPMENT_PRESET_START_OF_ROUND|EQUIPMENT_PRESET_MARINE
	idtype = /obj/item/card/id/dogtag

	access = list(
		ACCESS_MARINE_ENGINEERING,
		ACCESS_CIVILIAN_ENGINEERING,
		ACCESS_MARINE_MAINT,
	)
	assignment = JOB_MAINT_TECH
	rank = JOB_MAINT_TECH
	paygrades = list(PAY_SHORT_ME1 = JOB_PLAYTIME_TIER_0, PAY_SHORT_ME2 = JOB_PLAYTIME_TIER_1, PAY_SHORT_ME3 = JOB_PLAYTIME_TIER_3)
	role_comm_title = "MT"
	skills = /datum/skills/MT

	minimap_icon = "engi"

/datum/equipment_preset/uscm_ship/maint/load_gear(mob/living/carbon/human/new_human)
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/folded(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils(new_human), WEAR_L_EAR)
	//head
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/boilersuit/darkblue(new_human), WEAR_BODY)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/hazardvest(new_human), WEAR_JACKET)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/utility/full(new_human), WEAR_WAIST)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/pistol/alt(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/vp70(new_human), WEAR_IN_R_STORE)

//*****************************************************************************************************/

/datum/equipment_preset/uscm_ship/ordn
	name = "USCM Ordnance Technician (OT)"
	flags = EQUIPMENT_PRESET_START_OF_ROUND|EQUIPMENT_PRESET_MARINE
	idtype = /obj/item/card/id/dogtag

	access = list(
		ACCESS_MARINE_ENGINEERING,
		ACCESS_CIVILIAN_ENGINEERING,
		ACCESS_MARINE_MAINT,
		ACCESS_MARINE_OT,

	)
	assignment = JOB_ORDNANCE_TECH
	rank = JOB_ORDNANCE_TECH
	paygrades = list(PAY_SHORT_ME1 = JOB_PLAYTIME_TIER_0, PAY_SHORT_ME2 = JOB_PLAYTIME_TIER_1, PAY_SHORT_ME3 = JOB_PLAYTIME_TIER_3)
	role_comm_title = "OT"
	skills = /datum/skills/OT

	minimap_icon = "ot"

	utility_under = list(/obj/item/clothing/under/marine/officer/engi)
	dress_under = list(/obj/item/clothing/under/marine/dress/blues)
	dress_over = list(/obj/item/clothing/suit/storage/jacket/marine/dress/blues)
	dress_hat = list(/obj/item/clothing/head/marine/dress_cover)

/datum/equipment_preset/uscm_ship/ordn/load_gear(mob/living/carbon/human/new_human)
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/folded(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/demo_scanner(new_human), WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils(new_human), WEAR_L_EAR)
	//head
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/boilersuit/darkblue(new_human), WEAR_BODY)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/hazardvest(new_human), WEAR_JACKET)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/utility/full(new_human), WEAR_WAIST)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/pistol/alt(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/vp70(new_human), WEAR_IN_R_STORE)

//*****************************************************************************************************/

/datum/equipment_preset/uscm_ship/qm
	name = "USCM Logistics Officer"
	flags = EQUIPMENT_PRESET_START_OF_ROUND|EQUIPMENT_PRESET_MARINE

	idtype = /obj/item/card/id/dogtag
	access = list(
		ACCESS_MARINE_CARGO,
		ACCESS_MARINE_RO,
		ACCESS_MARINE_COMMAND,
		ACCESS_MARINE_ALPHA,
		ACCESS_MARINE_BRAVO,
		ACCESS_MARINE_CHARLIE,
		ACCESS_MARINE_DELTA,
		ACCESS_MARINE_PREP,
	)
	assignment = JOB_CHIEF_REQUISITION
	rank = JOB_CHIEF_REQUISITION
	paygrades = list(PAY_SHORT_MO1 = JOB_PLAYTIME_TIER_0, PAY_SHORT_MO2 = JOB_PLAYTIME_TIER_1)
	role_comm_title = "LO"
	skills = /datum/skills/RO

	minimap_background = MINIMAP_ICON_BACKGROUND_CIC
	minimap_icon = list("ct" = MINIMAP_ICON_COLOR_HEAD)

/datum/equipment_preset/uscm_ship/qm/load_gear(mob/living/carbon/human/new_human)
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/folded(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils(new_human), WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap(new_human), WEAR_HEAD)
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/officer/qm_suit(new_human), WEAR_BODY)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/RO(new_human), WEAR_JACKET)
	//waist
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/fingerless(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/pistol/alt(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/vp70(new_human), WEAR_IN_R_STORE)

/datum/equipment_preset/uscm_ship/qm/lesser_rank
	name = "USCM Logistics Chief"
	paygrades = list(PAY_SHORT_MW2 = JOB_PLAYTIME_TIER_0)
	assignment = JOB_CARGO_CHIEF
	rank = JOB_CARGO_CHIEF
	role_comm_title = "LC"

/datum/equipment_preset/uscm_ship/qm/lesser_rank/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/officer/cargo(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/service(new_human), WEAR_JACKET)
	..()

//*****************************************************************************************************/

/datum/equipment_preset/uscm_ship/cargo
	name = "USCM Logistics Specialist"
	flags = EQUIPMENT_PRESET_START_OF_ROUND|EQUIPMENT_PRESET_MARINE
	idtype = /obj/item/card/id/dogtag

	access = list(ACCESS_MARINE_CARGO)
	assignment = JOB_CARGO_TECH
	rank = JOB_CARGO_TECH
	paygrades = list(PAY_SHORT_ME3 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "LogiSpc"
	skills = /datum/skills/CT

	minimap_icon = "ct"

/datum/equipment_preset/uscm_ship/cargo/load_gear(mob/living/carbon/human/new_human)
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/folded(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils(new_human), WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap(new_human), WEAR_HEAD)
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/officer/cargo(new_human), WEAR_BODY)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/hazardvest(new_human), WEAR_JACKET)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/utility/full(new_human), WEAR_WAIST)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/fingerless(new_human), WEAR_HANDS)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/pistol/alt(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/vp70(new_human), WEAR_IN_R_STORE)

//*****************************************************************************************************/

/datum/equipment_preset/uscm_ship/armorer
	name = "USCM Armorer"
	flags = EQUIPMENT_PRESET_START_OF_ROUND|EQUIPMENT_PRESET_MARINE
	idtype = /obj/item/card/id/dogtag

	access = list(ACCESS_MARINE_CARGO)
	assignment = JOB_ARMORER
	rank = JOB_ARMORER
	paygrades = list(PAY_SHORT_MW1 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "ARM"
	skills = /datum/skills/armorer

/datum/equipment_preset/uscm_ship/armorer/load_gear(mob/living/carbon/human/new_human)
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/folded(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils(new_human), WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap(new_human), WEAR_HEAD)
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/officer/cargo(new_human), WEAR_BODY)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/utility/full(new_human), WEAR_WAIST)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/fingerless(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/pistol/alt(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/m4a3/custom(new_human), WEAR_IN_R_STORE)

//*****************************************************************************************************/

/datum/equipment_preset/uscm_ship/commander
	name = "USCM Commanding Officer (CO)"
	flags = EQUIPMENT_PRESET_START_OF_ROUND|EQUIPMENT_PRESET_MARINE

	idtype = /obj/item/card/id/dogtag
	assignment = JOB_CO
	rank = JOB_CO
	paygrades = list(PAY_SHORT_MO4 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "CO"
	minimum_age = 30
	skills = /datum/skills/commander

	minimap_icon = list("cic" = MINIMAP_ICON_COLOR_COMMANDER)
	minimap_background = MINIMAP_ICON_BACKGROUND_CIC

	utility_under = list(/obj/item/clothing/under/marine, /obj/item/clothing/under/marine/officer/command, /obj/item/clothing/under/marine/officer/boiler)
	utility_hat = list(/obj/item/clothing/head/cmcap,/obj/item/clothing/head/beret/cm/tan)
	utility_extra = list(/obj/item/clothing/glasses/sunglasses,/obj/item/clothing/glasses/sunglasses/big,/obj/item/clothing/glasses/sunglasses/aviator,/obj/item/clothing/glasses/mbcg)

	service_under = list(/obj/item/clothing/under/marine/officer/formal/white, /obj/item/clothing/under/marine/officer/formal/black)
	service_shoes = list(/obj/item/clothing/shoes/laceup)
	service_extra = list(/obj/item/clothing/suit/storage/jacket/marine/dress/officer/bomber)
	service_hat = list(/obj/item/clothing/head/beret/cm, /obj/item/clothing/head/beret/marine/commander/dress, /obj/item/clothing/head/beret/marine/commander/black, /obj/item/clothing/head/marine/peaked/service)

	dress_under = list(/obj/item/clothing/under/marine/dress/blues/senior)
	dress_over = list(/obj/item/clothing/suit/storage/jacket/marine/dress/blues/officer)
	dress_hat = list(/obj/item/clothing/head/marine/dress_cover/officer)
	dress_shoes = list(/obj/item/clothing/shoes/laceup)
	dress_extra = list(/obj/item/storage/large_holster/ceremonial_sword/full)

/datum/equipment_preset/uscm_ship/commander/New()
	. = ..()
	access = get_access(ACCESS_LIST_MARINE_ALL)

/datum/equipment_preset/uscm_ship/commander/load_race(mob/living/carbon/human/new_human, client/mob_client)
	..()
	ADD_TRAIT(new_human, TRAIT_EMOTE_CD_EXEMPT, TRAIT_SOURCE_JOB)

/datum/equipment_preset/uscm_ship/commander/load_gear(mob/living/carbon/human/new_human)
	var/sidearm = "Mateba"
	var/kit = null
	var/sidearmpath = /obj/item/storage/belt/gun/mateba/cmateba/full
	var/back_item = /obj/item/storage/backpack/satchel/lockable

	if(new_human.client && new_human.client.prefs)
		sidearm = new_human.client.prefs.commander_sidearm
		switch(sidearm)
			if(CO_GUN_MATEBA)
				sidearmpath = /obj/item/storage/belt/gun/mateba/cmateba/full
				kit = /obj/item/storage/mateba_case/captain
			if(CO_GUN_MATEBA_SPECIAL)
				sidearmpath = /obj/item/storage/belt/gun/mateba/cmateba/special
			if(CO_GUN_MATEBA_COUNCIL)
				sidearmpath = /obj/item/storage/belt/gun/mateba/council/full
				kit = /obj/item/storage/mateba_case/captain/council
			if(CO_GUN_DEAGLE)
				sidearmpath = /obj/item/storage/belt/gun/m4a3/heavy/co
			if(CO_GUN_DEAGLE_COUNCIL)
				sidearmpath = /obj/item/storage/belt/gun/m4a3/heavy/co_golden

	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/mcom/cdrcom(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/officer/bridge(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/service(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/marine/peaked/service(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new sidearmpath(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new back_item(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/large(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/pistol/command(new_human), WEAR_L_STORE)
	if(kit)
		new_human.equip_to_slot_or_del(new kit(new_human), WEAR_IN_BACK)

//*****************************************************************************************************/

/datum/equipment_preset/uscm_ship/xo
	name = "USCM Executive Officer (XO)"
	flags = EQUIPMENT_PRESET_START_OF_ROUND|EQUIPMENT_PRESET_MARINE

	idtype = /obj/item/card/id/dogtag
	assignment = JOB_XO
	rank = JOB_XO
	paygrades = list(PAY_SHORT_MO3 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "XO"
	minimum_age = 35
	skills = /datum/skills/XO

	minimap_icon = list("cic" = MINIMAP_ICON_COLOR_HEAD)
	minimap_background = MINIMAP_ICON_BACKGROUND_CIC

	dress_extra = list(/obj/item/storage/large_holster/ceremonial_sword/full)

/datum/equipment_preset/uscm_ship/xo/New()
	. = ..()
	access = get_access(ACCESS_LIST_MARINE_MAIN)

/datum/equipment_preset/uscm_ship/xo/load_gear(mob/living/carbon/human/new_human)
	var/back_item = /obj/item/storage/backpack/satchel
	if (new_human.client && new_human.client.prefs && (new_human.client.prefs.backbag == 1))
		back_item = /obj/item/storage/backpack/marine

	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/mcom/cdrcom(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/officer/bridge(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/service(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/marine/peaked/service(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new back_item(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/large(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/large(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range(new_human), WEAR_L_STORE)

//*****************************************************************************************************/

/datum/equipment_preset/uscm_ship/so
	name = "USCM Platoon Commander (PltCo)"
	idtype = /obj/item/card/id/dogtag
	flags = EQUIPMENT_PRESET_START_OF_ROUND|EQUIPMENT_PRESET_MARINE
	assignment = JOB_SO
	rank = JOB_SO
	paygrades = list(PAY_SHORT_MO2 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "PltCo"
	minimum_age = 25
	skills = /datum/skills/SO
	minimap_icon = list("cic" = COLOR_SILVER)
	minimap_background = MINIMAP_ICON_BACKGROUND_CIC
	var/access_list = ACCESS_LIST_MARINE_MAIN

/datum/equipment_preset/uscm_ship/so/New()
	. = ..()
	access = get_access(access_list)

/datum/equipment_preset/uscm_ship/so/load_status(mob/living/carbon/human/new_human, client/mob_client)
	. = ..()
	new_human.nutrition = NUTRITION_VERYLOW
	if(!new_human.client)
		return

	add_verb(new_human.client, /client/proc/commander_rename_platoon)
	give_action(new_human, /datum/action/innate/message_squad)

/datum/equipment_preset/uscm_ship/so/lesser_rank
	name = parent_type::name + " (Lesser Rank)"
	paygrades = list(PAY_SHORT_MO1 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uscm_ship/so/handle_late_join(mob/living/carbon/human/new_human, late_join)
	if(late_join)
		return

	add_verb(new_human.client, /client/proc/commander_rename_platoon)

	do_rename_platoon(new_human.client.prefs.platoon_name)
	change_dropship_camo(new_human.client.prefs.dropship_camo)
	change_dropship_name(new_human.client.prefs.dropship_name)

/datum/equipment_preset/uscm_ship/so/upp
	name = "UPP Platoon Commander (PltCo)"
	idtype = /obj/item/card/id/dogtag
	languages = list(LANGUAGE_RUSSIAN, LANGUAGE_CHINESE, LANGUAGE_ENGLISH)
	paygrades = list(PAY_SHORT_UO2 = JOB_PLAYTIME_TIER_0)
	faction_group = list(FACTION_UPP)
	faction = FACTION_UPP
	access_list = ACCESS_LIST_UPP_PLATOON

/datum/equipment_preset/uscm_ship/so/upp/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "Naval Infantry Telnyashka"

/datum/equipment_preset/uscm_ship/so/upp/lesser_rank
	name = parent_type::name + " (Lesser Rank)"
	paygrades = list(PAY_SHORT_UO1 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uscm_ship/so/upp/equipped
	name = "UPP Platoon Commander (Equipped)"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE

/datum/equipment_preset/uscm_ship/so/upp/equipped/load_status(mob/living/carbon/human/new_human)
	new_human.nutrition = NUTRITION_NORMAL

/datum/equipment_preset/uscm_ship/so/upp/equipped/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "Naval Infantry Telnyashka"
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/UPP/command(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/uppcap/beret/naval, WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/UPP/naval(new_human), WEAR_BODY)
	var/obj/item/clothing/under/marine/veteran/UPP/naval/uniform = new()

	new_human.equip_to_slot_or_del(uniform, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/upp/naval(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/upp, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/upp/naval, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/upp(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/type47/np92(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/lightpack/upp(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/medium(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/medium(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range/designator/upp(new_human), WEAR_L_HAND)

/datum/equipment_preset/uscm_ship/so/upp/handle_late_join(mob/living/carbon/human/new_human, late_join)
	if(!late_join)
		add_verb(new_human.client, /client/proc/commander_rename_platoon)

/datum/equipment_preset/uscm_ship/so/pmc
	name = "PMC Overwatch (PltCo)"
	paygrades = list("PMC-OW" = JOB_PLAYTIME_TIER_0)
	role_comm_title = "OW"
	assignment = JOB_PMCPLAT_OW
	idtype = /obj/item/card/id/pmc
	faction_group = FACTION_LIST_WY
	faction = FACTION_PMC
	access_list = ACCESS_LIST_WY_SENIOR

/datum/equipment_preset/uscm_ship/so/pmc/equipped
	name = "PMC Overwatch (PltCo) (Equipped)"

/datum/equipment_preset/uscm_ship/so/pmc/equipped/load_status(mob/living/carbon/human/new_human)
	new_human.nutrition = NUTRITION_NORMAL

/datum/equipment_preset/uscm_ship/so/pmc/equipped/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/pmc/platoon/cmd(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/liaison_suit/formal(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/m4a3/vp78(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/large(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/large(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range(new_human), WEAR_L_HAND)

/datum/equipment_preset/uscm_ship/so/rmc
	name = "Royal Marine Commando, Troop Commander"
	paygrades = list(PAY_SHORT_RMO1 = JOB_PLAYTIME_TIER_0)
	languages = list(LANGUAGE_ENGLISH, LANGUAGE_JAPANESE)
	role_comm_title = "RM TC"
	assignment = JOB_TWE_RMC_LIEUTENANT
	rank = JOB_TWE_RMC_LIEUTENANT
	skills = /datum/skills/rmc/officer
	faction_group = FACTION_LIST_TWE
	faction = FACTION_TWE
	access_list = ACCESS_LIST_TWE_TROOP

//*****************************************************************************************************/

/datum/equipment_preset/uscm_ship/so_equipped
	name = "USCM Platoon Commander (Equipped)"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE
	idtype = /obj/item/card/id/dogtag
	flags = EQUIPMENT_PRESET_START_OF_ROUND|EQUIPMENT_PRESET_MARINE
	assignment = JOB_SO
	rank = JOB_SO
	paygrades = list(PAY_SHORT_MO2 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "PltCo"
	minimum_age = 25
	skills = /datum/skills/SO
	minimap_icon = list("cic" = COLOR_SILVER)
	minimap_background = MINIMAP_ICON_BACKGROUND_CIC
	var/access_list = ACCESS_LIST_MARINE_MAIN

/datum/equipment_preset/uscm_ship/so_equipped/New()
	. = ..()
	access = get_access(access_list)

/datum/equipment_preset/uscm_ship/so_equipped/load_gear(mob/living/carbon/human/new_human)
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/weldingtool(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/wirecutters(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/folded(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/vp70(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/vp70(new_human), WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils/foxtrot(new_human), WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/bridge(new_human), WEAR_HEAD)
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/officer/boiler(new_human), WEAR_BODY)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/vest/pilot(new_human), WEAR_JACKET)
	//waist
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/jungle/knife(new_human), WEAR_FEET)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/pistol(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/vp70(new_human), WEAR_IN_R_STORE)

//*****************************************************************************************************/

/datum/equipment_preset/uscm_ship/io
	name = "USCM Intelligence Officer (Equipped)"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE
	idtype = /obj/item/card/id/dogtag
	assignment = JOB_INTEL
	rank = JOB_INTEL
	paygrades = list(PAY_SHORT_MO1 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "IO"
	minimum_age = 22
	skills = /datum/skills/SO
	minimap_icon = list("io" = COLOR_SILVER)
	minimap_background = MINIMAP_ICON_BACKGROUND_CIC
	var/access_list = ACCESS_LIST_MARINE_MAIN

/datum/equipment_preset/uscm_ship/io/load_status(mob/living/carbon/human/new_human)
	new_human.nutrition = NUTRITION_NORMAL

/datum/equipment_preset/uscm_ship/io/load_gear(mob/living/carbon/human/new_human)
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel/intel/chestrig(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/weldingtool(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/wirecutters(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/folded(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/canteen(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/notepad(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/pen/clicky(new_human), WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils(new_human), WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine(new_human), WEAR_HEAD)
	add_uscm_cover(new_human)
	add_uscm_goggles(new_human)
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/officer/boiler(new_human), WEAR_BODY)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/rto/forecon(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/pads/greaves(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/recon/mk1(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1/forecon(new_human), WEAR_J_STORE)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/general_belt(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range/designator(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/vp70(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/vp70(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/flare(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/plastic/breaching_charge(new_human), WEAR_IN_BELT)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/jungle/knife(new_human), WEAR_FEET)
	add_combat_gloves(new_human)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/pistol(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/vp70(new_human), WEAR_IN_R_STORE)

//*****************************************************************************************************/

/datum/equipment_preset/uscm_ship/di
	name = "USCM Drill Instructor"
	flags = EQUIPMENT_PRESET_START_OF_ROUND|EQUIPMENT_PRESET_MARINE

	idtype = /obj/item/card/id/dogtag
	assignment = JOB_DI
	rank = JOB_DI
	paygrades = list(PAY_SHORT_ME7 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "DI"
	skills = /datum/skills/DI

	minimap_icon = "sea"

	service_hat = list(/obj/item/clothing/head/cmcap, /obj/item/clothing/head/drillhat)
	dress_over = list(/obj/item/clothing/suit/storage/jacket/marine/dress/blues/nco)
	dress_hat = list(/obj/item/clothing/head/marine/dress_cover)

/datum/equipment_preset/uscm_ship/di/New()
	. = ..()
	access = get_access(ACCESS_LIST_MARINE_MAIN)

/datum/equipment_preset/uscm_ship/di/load_gear(mob/living/carbon/human/new_human)
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/folded(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/whistle(new_human), WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils(new_human), WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/drillhat(new_human), WEAR_HEAD)
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/officer/bridge(new_human), WEAR_BODY)
	//jacket
	//waist
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(new_human), WEAR_FEET)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/pistol/alt(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/vp70(new_human), WEAR_IN_R_STORE)

/datum/equipment_preset/uscm_ship/di/lesser_rank
	name = parent_type::name + " (Lesser Rank)"
	paygrades = list(PAY_SHORT_ME6 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uscm_ship/di/upper_rank
	name = parent_type::name + " (Upper Rank)"
	paygrades = list(PAY_SHORT_ME8 = JOB_PLAYTIME_TIER_0)

//*****************************************************************************************************/

/datum/equipment_preset/uscm_ship/dp
	name = "USCM Dropship Pilot (Baggies)"
	idtype = /obj/item/card/id/dogtag
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE
	access = list(ACCESS_MARINE_COMMAND, ACCESS_MARINE_DROPSHIP, ACCESS_MARINE_PREP)
	assignment = JOB_DROPSHIP_PILOT
	rank = JOB_DROPSHIP_PILOT
	paygrades = list(PAY_SHORT_MW1 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "PLT"
	skills = /datum/skills/pilot

	minimap_icon = "pilot"

	utility_under = list(/obj/item/clothing/under/marine/officer/pilot)

/datum/equipment_preset/uscm_ship/dp/load_gear(mob/living/carbon/human/new_human)
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/weldingtool(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/wirecutters(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/folded(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils(new_human), WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/upp/marinepilot(new_human), WEAR_HEAD)
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/officer/boiler(new_human), WEAR_BODY)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/vest/pilot(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/m4a3/vp70(new_human), WEAR_J_STORE)
	//waist
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare/full(new_human), WEAR_R_STORE)

/datum/equipment_preset/uscm_ship/dp/alt
	name = "USCM Dropship Pilot (Comp. Suit)"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE

/datum/equipment_preset/uscm_ship/dp/alt/load_gear(mob/living/carbon/human/new_human)
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/officer/pilot/flight(new_human), WEAR_BODY)
	..()

//*****************************************************************************************************/

/datum/equipment_preset/uscm_ship/dcc
	name = "USCM Dropship Crew Chief"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE
	idtype = /obj/item/card/id/dogtag
	access = list(ACCESS_MARINE_COMMAND, ACCESS_MARINE_DROPSHIP, ACCESS_MARINE_PREP)
	assignment = JOB_DROPSHIP_CREW_CHIEF
	rank = JOB_DROPSHIP_CREW_CHIEF
	paygrades = list(PAY_SHORT_ME6 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "WSO"
	skills = /datum/skills/crew_chief

	minimap_icon = "dcc"

/datum/equipment_preset/uscm_ship/dcc/load_gear(mob/living/carbon/human/new_human)
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/weldingtool(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/wirecutters(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/folded(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils(new_human), WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/upp/marinepilot(new_human), WEAR_HEAD)
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/officer/boiler(new_human), WEAR_BODY)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/vest/pilot(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/m4a3/vp70(new_human), WEAR_J_STORE)
	//waist
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare/full(new_human), WEAR_R_STORE)

//*****************************************************************************************************/

/datum/equipment_preset/uscm_ship/officer
	name = "USCM Officer (USCM Command)"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE

	idtype = /obj/item/card/id/general
	access = list(ACCESS_MARINE_MEDBAY, ACCESS_MARINE_CHEMISTRY, ACCESS_MARINE_MORGUE)
	assignment = "USCM Officer"
	rank = "USCM Officer"
	paygrades = list(PAY_SHORT_MO3 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "Cpt"
	minimum_age = 40
	skills = /datum/skills/commander

	utility_hat = list(/obj/item/clothing/head/beret/cm)
	utility_gloves = list(/obj/item/clothing/gloves/marine)
	utility_extra = list(/obj/item/clothing/head/cmcap, /obj/item/clothing/head/beret/cm/tan)

	service_hat = list(/obj/item/clothing/head/beret/cm)
	service_shoes = list(/obj/item/clothing/shoes/laceup)

	dress_extra = list(/obj/item/storage/large_holster/ceremonial_sword/full)

/datum/equipment_preset/uscm_ship/officer/New()
	. = ..()
	access = get_access(ACCESS_LIST_MARINE_ALL)

/datum/equipment_preset/uscm_ship/officer/load_gear(mob/living/carbon/human/new_human)
	//TODO: add backpacks and satchels
	new_human.equip_if_possible(new /obj/item/clothing/under/rank/centcom/officer(new_human), WEAR_BODY)
	new_human.equip_if_possible(new /obj/item/clothing/shoes/centcom(new_human), WEAR_FEET)
	new_human.equip_if_possible(new /obj/item/clothing/gloves/white(new_human), WEAR_HANDS)
	new_human.equip_if_possible(new /obj/item/clothing/head/beret/centcom/officer(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/mcom/cdrcom(new_human), WEAR_L_EAR)

	new_human.equip_if_possible(new /obj/item/clothing/glasses/sunglasses(new_human), WEAR_EYES)
	new_human.equip_if_possible(new /obj/item/storage/pouch/general/large(new_human), WEAR_R_STORE)

//*****************************************************************************************************/

/datum/equipment_preset/uscm_ship/chef
	name = "USCM Mess Technician (MST)"
	flags = EQUIPMENT_PRESET_START_OF_ROUND|EQUIPMENT_PRESET_MARINE

	access = list(ACCESS_MARINE_KITCHEN)
	assignment = JOB_MESS_SERGEANT
	rank = JOB_MESS_SERGEANT
	paygrades = list(PAY_SHORT_ME1 = JOB_PLAYTIME_TIER_0, PAY_SHORT_ME2 = JOB_PLAYTIME_TIER_1, PAY_SHORT_ME3 = JOB_PLAYTIME_TIER_3)
	role_comm_title = "MST"
	skills = /datum/skills/mess_technician

	minimap_icon = "mst"

	utility_under = list(/obj/item/clothing/under/marine/chef)
	dress_under = list(/obj/item/clothing/under/marine/dress/blues)
	dress_over = list(/obj/item/clothing/suit/storage/jacket/marine/dress/blues)
	dress_hat = list(/obj/item/clothing/head/marine/dress_cover)

/datum/equipment_preset/uscm_ship/chef/load_gear(mob/living/carbon/human/new_human)
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils(new_human), WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/chefhat(new_human), WEAR_HEAD)
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/chef(new_human), WEAR_BODY)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/chef(new_human), WEAR_JACKET)
	//waist
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(new_human), WEAR_FEET)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
