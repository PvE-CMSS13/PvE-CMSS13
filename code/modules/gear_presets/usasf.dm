/datum/equipment_preset/usasf
	name = "USASF"
	faction = FACTION_NAVY
	faction_group = FACTION_LIST_UA
	minimum_age = 20
	languages = list(LANGUAGE_ENGLISH, LANGUAGE_SPANISH)
	///Gives the sailors their radios
	var/headset_type = /obj/item/device/radio/headset/distress/USASF
	var/rankpin_type = /obj/item/clothing/accessory/ranks/navy/e3
	idtype = /obj/item/card/id/ //Shipboard duties & loose-hanging items do NOT mix

/datum/equipment_preset/usasf/load_name(mob/living/carbon/human/new_human, randomise)
	new_human.gender = pick(60;MALE,40;FEMALE)
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
		new_human.h_style = pick("Undercut", "Partly Shaved", "Side Undercut", "Side Hang Undercut (Reverse)", "Undercut, Top", "Medium Fade", "High Fade", "Coffee House Cut", "Crewcut", "Shaved Head", "Buzzcut", "Pvt. Joker", "Marine Fade", "Low Fade", "Medium Fade", "High Fade",)
		new_human.f_style = pick("Shaved", "Shaved", "Shaved", "Shaved", "Shaved", "Shaved", "3 O'clock Shadow", "3 O'clock Moustache", "5 O'clock Shadow", "5 O'clock Moustache", "7 O'clock Shadow", "7 O'clock Moustache",)
	else
		new_human.h_style = pick("Side Undercut", "Side Hang Undercut (Reverse)", "Undercut, Top", "CIA", "Mulder", "Pvt. Redding", "Pixie Cut Left", "Pixie Cut Right", "Bun", "Ponytail 1", "Ponytail 2", "Ponytail 3", "Ponytail 4", "Pvt. Clarison", "Cpl. Dietrich", "Pvt. Vasquez", "Marine Bun", "Marine Bun 2", "Marine Flat Top",)
	new_human.change_real_name(new_human, random_name)
	new_human.age = rand(20,35)

//*****************************************************************************************************/

/datum/equipment_preset/usasf/crew
	name = "USASF Crewman"
	rank = JOB_NAVY_CREWMAN
	assignment = JOB_NAVY_CREWMAN
	paygrades = list(PAY_SHORT_NE3 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "CR"
	flags = EQUIPMENT_PRESET_EXTRA
	skills = /datum/skills/ship_crew

/datum/equipment_preset/usasf/crew/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new headset_type, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/officer/engi(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new rankpin_type(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/brown/fingerless(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/army/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/usasf(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/medium(new_human), WEAR_L_STORE)

/datum/equipment_preset/usasf/crew/snipe
	name = "USASF Damage-Control Crewman"
	paygrades = list(PAY_SHORT_NE4 = JOB_PLAYTIME_TIER_0)
	rankpin_type = /obj/item/clothing/accessory/ranks/navy/e4

/datum/equipment_preset/usasf/crew/snipe/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/officer/engi(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/armband/engine(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/droppouch(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/tool/extinguisher(new_human), WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/yellow(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/welding(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/tools/tank(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full(new_human), WEAR_L_STORE)
	..()

/datum/equipment_preset/usasf/crew/armsman
	name = "USASF Master-At-Arms"
	rank = JOB_NAVY_MP
	assignment = JOB_NAVY_MP
	role_comm_title = "MAA"
	paygrades = list(PAY_SHORT_NE5 = JOB_PLAYTIME_TIER_0)
	rankpin_type = /obj/item/clothing/accessory/ranks/navy/e5

/datum/equipment_preset/usasf/crew/armsman/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/officer/engi(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new rankpin_type(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/armband/mpsec(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/MP/navy(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/security/usasf/full(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/pistol/alt(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/m4a3(new_human), WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full(new_human), WEAR_L_STORE)
	..()

/datum/equipment_preset/usasf/crew/armsman/armed
	name = "USASF Master-At-Arms (Armed, Rifle)"
	role_comm_title = "MAA"
	paygrades = list(PAY_SHORT_NE5 = JOB_PLAYTIME_TIER_0)
	flags = EQUIPMENT_PRESET_EXTRA

/datum/equipment_preset/usasf/crew/armsman/armed/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/tear/marine(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/tear/marine(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/military(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/armband/mpsec(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/medium/rto/navy(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1/navy/(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/security/usasf/heavy(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/pistol/alt(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/m4a3(new_human), WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full(new_human), WEAR_L_STORE)
	..()

/datum/equipment_preset/usasf/crew/armsman/armed_shotgun
	name = "USASF Master-At-Arms (Armed, Shotgun)"
	role_comm_title = "MAA"
	paygrades = list(PAY_SHORT_NE5 = JOB_PLAYTIME_TIER_0)
	flags = EQUIPMENT_PRESET_EXTRA

/datum/equipment_preset/usasf/crew/armsman/armed_shotgun/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/restraint/handcuffs(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/restraint/handcuffs(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/baton(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/tear/marine(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/spray/pepper(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/military(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/officer/engi(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new rankpin_type(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/armband/mpsec(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/medium/rto/navy(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/xm51(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/xm51/military(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/xm51(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/xm51(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/xm51(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/xm51(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/pistol/alt(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/m4a3(new_human), WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full(new_human), WEAR_L_STORE)
	..()

/datum/equipment_preset/usasf/crew/infantry/
	name = "USASF Rifleman"
	rank = JOB_NAVY_SF
	assignment = JOB_NAVY_SF
	paygrades = list(PAY_SHORT_NE3 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "SF"
	flags = EQUIPMENT_PRESET_EXTRA
	idtype = /obj/item/card/id/dogtag
	skills = /datum/skills/pfc

/datum/equipment_preset/usasf/crew/infantry/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new headset_type, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/weldingtool(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/wirecutters(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/folded(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/smokebomb/green(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/smokebomb/red(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/canteen, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/standard/navy(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new rankpin_type(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/usasf(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/holster/waist(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/m4a3, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/medium/rto/navy(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1/navy(new_human), WEAR_J_STORE)
	var/random_usasf_infantry_helmet = rand(1,3)
	switch(random_usasf_infantry_helmet)
		if(1 to 2)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/rto/navy, WEAR_HEAD)
		if(3)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/corrections, WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/army/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare/full(new_human), WEAR_R_STORE)

/datum/equipment_preset/usasf/crew/infantry/nco
	name = parent_type::name + " (Team Lead)"
	rank = JOB_NAVY_SFL
	assignment = JOB_NAVY_SFL
	paygrades = list(PAY_SHORT_NE4 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "SF-TL"
	rankpin_type = /obj/item/clothing/accessory/ranks/navy/e4

/datum/equipment_preset/usasf/crew/infantry/nco/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range/designator/monocular(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/medium/rto/navy/heavy(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/recon/mk1(new_human), WEAR_ACCESSORY)
	..()

/datum/equipment_preset/usasf/crew/infantry/eva
	name = parent_type::name + " (EVA)"
	paygrades = list(PAY_SHORT_NE5 = JOB_PLAYTIME_TIER_0)
	assignment = "USASF Security Forces EVA Specialist"
	role_comm_title = "SF-EVA"
	rankpin_type = /obj/item/clothing/accessory/ranks/navy/e5

/datum/equipment_preset/usasf/crew/infantry/eva/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/tank/oxygen/red(new_human), WEAR_BACK) //placeholder until the spacesuits projects adds back the jetpacks
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/space/pressure/uscm(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/space/pressure/uscm(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/swat/navy(new_human), WEAR_FACE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/magboots(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1/navy/tactical(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/large, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/tank/emergency_oxygen/double, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/device/analyzer, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/device/flashlight/combat, WEAR_IN_R_STORE)
	..()

/datum/equipment_preset/usasf/crew/flight
	name = "USASF Flight-Deck Crewman"
	assignment = JOB_NAVY_SKITTLE
	rank = JOB_NAVY_SKITTLE
	paygrades = list(PAY_SHORT_NE5 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "FltCR"
	flags = EQUIPMENT_PRESET_EXTRA
	skills = /datum/skills/flight_crew
	rankpin_type = /obj/item/clothing/accessory/ranks/navy/e5

/datum/equipment_preset/usasf/crew/flight/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/upp/marinepilot(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/mgoggles(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/botanic_leather/generic(new_human), WEAR_HANDS)
	var/flight_deck_vest = rand(1, 5)
	switch(flight_deck_vest)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/hazardvest/usasf(new_human), WEAR_JACKET)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/hazardvest/usasf/green(new_human), WEAR_JACKET)
		if(3)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/hazardvest/usasf/purple(new_human), WEAR_JACKET)
		if(4)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/hazardvest/usasf/white(new_human), WEAR_JACKET)
		if(5)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/hazardvest/usasf/blue(new_human), WEAR_JACKET)
	..()


//*****************************************************************************************************/

/datum/equipment_preset/usasf/corpsman
	name = "USASF Hospital Corpsman"
	assignment = JOB_NAVY_MEDIC
	rank = JOB_NAVY_MEDIC
	paygrades = list(PAY_SHORT_ME4 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "HM"
	skills = /datum/skills/corpsman

/datum/equipment_preset/uscm_ship/corpsman/nurse/load_gear(mob/living/carbon/human/new_human)
	var/back_item = /obj/item/storage/backpack/marine/satchel
	if (new_human.client && new_human.client.prefs && (new_human.client.prefs.backbag == 1))
		back_item = /obj/item/storage/backpack/marine

	new_human.equip_to_slot_or_del(new back_item(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/rank/medical/lightblue(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/ranks/navy/e4(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/armband/medgreen(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/latex(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/white(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/health(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/medical/lifesaver/full(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/softpack/adv(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/healthanalyzer/soul(new_human), WEAR_IN_BACK)

//*****************************************************************************************************/

/datum/equipment_preset/usasf/engi
	name = "USASF Engineering Technician"
	assignment = JOB_NAVY_ENGI
	rank = JOB_NAVY_ENGI
	paygrades = list(PAY_SHORT_NE6 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "Tech"
	flags = EQUIPMENT_PRESET_EXTRA
	skills = /datum/skills/eng_tech
	rankpin_type = /obj/item/clothing/accessory/ranks/navy/e6

/datum/equipment_preset/usasf/engi/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new headset_type, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/navy/tech(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new rankpin_type(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/yellow(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/army/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/welding(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/usasf(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/armband/engine(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/tool_webbing/equipped(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/medium(new_human), WEAR_L_STORE)

//*****************************************************************************************************/

/datum/equipment_preset/usasf/helljumper
	name = "USASF Para-Rescue Support Technician"
	assignment = JOB_NAVY_PARA_TECH
	rank = JOB_NAVY_PARA_TECH
	paygrades = list(PAY_SHORT_NE8 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "PJ"
	flags = null
	skills = /datum/skills/para_tech
	idtype = /obj/item/card/id/dogtag

/datum/equipment_preset/usasf/helljumper/load_gear(mob/living/carbon/human/new_human)
//Head
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/USASF/command/attache(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/tech/tanker/para(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/swat/navy(new_human), WEAR_FACE)
//Shoes & gloves
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/army/knife(new_human), WEAR_FEET)
//Back
	new_human.equip_to_slot_or_del(new /obj/item/parachute(new_human), WEAR_BACK)

/datum/equipment_preset/usasf/helljumper/squadlead
	name = "USASF Para-Rescue Team Leader"
	paygrades = list(PAY_SHORT_NE9 = JOB_PLAYTIME_TIER_0)
	assignment = JOB_NAVY_PARA_LEAD
	rank = JOB_NAVY_PARA_LEAD
	role_comm_title = "PJ-SL"
	flags = EQUIPMENT_PRESET_EXTRA
	rankpin_type = /obj/item/clothing/accessory/ranks/navy/e9

/datum/equipment_preset/usasf/helljumper/squadlead/load_gear(mob/living/carbon/human/new_human)

//Uniform & accessories
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/officer/pilot/flight/para(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new rankpin_type(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/usasf(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/usasf/helljumper(new_human), WEAR_ACCESSORY)
//Armor, webbing & weapon
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/medium/rto/navy(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/mag/mk1(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1/navy/tactical(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/general_belt(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range/designator/sergeant(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/fsr(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/fsr(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/fsr(new_human), WEAR_IN_BELT)	//RMC MRE Rifleman, is that you in spirit?
	new_human.equip_to_slot_or_del(new /obj/item/explosive/plastic/breaching_charge(new_human), WEAR_IN_BELT)
//Role specific
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/tool_webbing/equipped(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/tools/tactical/parajumper(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/medical/socmed/not_op(new_human), WEAR_L_STORE)
	..()

/datum/equipment_preset/usasf/helljumper/technical
	name = "USASF Para-Rescue Support Technician"
	role_comm_title = "PJ-ENGR"
	flags = EQUIPMENT_PRESET_EXTRA
	rankpin_type = /obj/item/clothing/accessory/ranks/navy/e8

/datum/equipment_preset/usasf/helljumper/technical/load_gear(mob/living/carbon/human/new_human)

//Uniform & accessories
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/officer/pilot/flight/para(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new rankpin_type(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/usasf(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/usasf/helljumper(new_human), WEAR_ACCESSORY)
//Armor, webbing & weapon
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/medium/rto/navy(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/mag/mk1(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1/navy/tactical(new_human), WEAR_J_STORE)
//Role specific
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/armband/engine(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/tool_webbing/tactical(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/utility/construction/full(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/construction/full_barbed_wire(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/tools/tactical/parajumper(new_human), WEAR_R_STORE)
	..()

/datum/equipment_preset/usasf/helljumper/medical
	name = "USASF Para-Rescue Medical Technician"
	assignment = JOB_NAVY_PARA_MED
	rank = JOB_NAVY_PARA_MED
	role_comm_title = "PJ-MED"
	flags = EQUIPMENT_PRESET_EXTRA
	rankpin_type = /obj/item/clothing/accessory/ranks/navy/e8

/datum/equipment_preset/usasf/helljumper/medical/load_gear(mob/living/carbon/human/new_human) //Redefined between the subtypes due to weirdness, only way for it to apply

//Uniform & accessories
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/officer/pilot/flight/para(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new rankpin_type(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/usasf(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/usasf/helljumper(new_human), WEAR_ACCESSORY)
//Armor, webbing & weapon
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/medium/rto/navy(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/mag/mk1(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1/navy/tactical(new_human), WEAR_J_STORE)
//Role specific
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/armband/medgreen(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/surg_vest/drop_green/equipped(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/medical/parajumper(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/sling(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/device/healthanalyzer/soul(new_human), WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/medkit/full/socmed(new_human), WEAR_R_STORE)
	..()

//*****************************************************************************************************/

/datum/equipment_preset/usasf/jtac
	name = "USASF Orbital Fire-Support Liason Officer"
	assignment = JOB_NAVY_JTAC
	rank = JOB_NAVY_JTAC
	paygrades = list(PAY_SHORT_NO2)
	role_comm_title = "JFO"
	flags = EQUIPMENT_PRESET_EXTRA
	skills = /datum/skills/jtac
	idtype = /obj/item/card/id/dogtag
	rankpin_type = /obj/item/clothing/accessory/ranks/navy/o2

/datum/equipment_preset/usasf/jtac/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/USASF/command/attache(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/officer/intel/navy(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/rto/navy(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new rankpin_type(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/usasf(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/black_vest(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range/designator(new_human), WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/canteen(new_human), WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/tool/pen(new_human), WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/notepad(new_human), WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/army/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/m4a3/commander(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/ert(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/tools/full(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/medium/rto/navy(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/recon/mk1(new_human), WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1/navy/tactical(new_human), WEAR_J_STORE)

	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel/rto/navy(new_human), WEAR_BACK)

/datum/equipment_preset/usasf/jtac/lesser_rank
	name = parent_type::name + " (Lesser Rank)"
	paygrades = list(PAY_SHORT_NE9 = JOB_PLAYTIME_TIER_0)
	rankpin_type = /obj/item/clothing/accessory/ranks/navy/e9

//*****************************************************************************************************/

/datum/equipment_preset/usasf/pilot
	name = "USASF Pilot"
	assignment = JOB_NAVY_PILOT
	rank = JOB_NAVY_PILOT
	paygrades = list(PAY_SHORT_NO1)
	role_comm_title = "PLT"
	flags = EQUIPMENT_PRESET_EXTRA
	skills = /datum/skills/navypilot
	idtype = /obj/item/card/id/dogtag
	rankpin_type = /obj/item/clothing/accessory/ranks/navy/o1

/datum/equipment_preset/usasf/pilot/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/USASF/command(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/officer/pilot/flight(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new rankpin_type(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/upp/marinepilot(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/swat/navy(new_human), WEAR_FACE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/usasf(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/army/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine(new_human), WEAR_HANDS)

	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/general_belt(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range/designator(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/canteen(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/tool/pen(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/notepad(new_human), WEAR_IN_BELT)

	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/pistol/alt(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/m4a3(new_human), WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/parachute(new_human), WEAR_BACK)

/datum/equipment_preset/usasf/pilot/lesser_rank
	name = parent_type::name + " (Lesser Rank)"
	paygrades = list(PAY_SHORT_NW1 = JOB_PLAYTIME_TIER_0)
	rankpin_type = /obj/item/clothing/accessory/ranks/navy/w1

//*****************************************************************************************************/

/datum/equipment_preset/usasf/officer
	name = "USASF Duty Officer"
	assignment = JOB_NAVY_SO
	rank = JOB_NAVY_SO
	paygrades = list(PAY_SHORT_NO3)
	role_comm_title = "DtyO"
	flags = EQUIPMENT_PRESET_EXTRA
	skills = /datum/skills/officer
	idtype = /obj/item/card/id/silver
	rankpin_type = /obj/item/clothing/accessory/ranks/navy/o3

/datum/equipment_preset/usasf/officer/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/USASF/command(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/navy/officer(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new rankpin_type(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beret/marine/techofficer(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/usasf(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/army/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/m4a3/full(new_human), WEAR_WAIST)

/datum/equipment_preset/usasf/officer/lesser_rank
	name = parent_type::name + " (Lesser Rank)"
	paygrades = list(PAY_SHORT_NO2 = JOB_PLAYTIME_TIER_0)
	rankpin_type = /obj/item/clothing/accessory/ranks/navy/o2

//*****************************************************************************************************/

/datum/equipment_preset/usasf/flightboss
	name = "USASF Flight Boss"
	assignment = JOB_NAVY_FLIGHT_BOSS
	rank = JOB_NAVY_FLIGHT_BOSS
	paygrades = list(PAY_SHORT_NO2)
	role_comm_title = "FB"
	flags = EQUIPMENT_PRESET_EXTRA
	skills = /datum/skills/flightboss
	rankpin_type = /obj/item/clothing/accessory/ranks/navy/o2

/datum/equipment_preset/usasf/flightboss/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/USASF/command(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/navy/officer(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new rankpin_type(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/usasf(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/hazardvest/usasf/yellow(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/upp/marinepilot(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/mgoggles(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/botanic_leather/generic(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/army/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/m4a3/full(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/medium(new_human), WEAR_L_STORE)

//*****************************************************************************************************/

/datum/equipment_preset/usasf/chief_engineer
	name = "USASF Engineering Duty Officer"
	assignment = JOB_NAVY_CHIEF_ENGINEER
	rank = JOB_NAVY_CHIEF_ENGINEER
	paygrades = list(PAY_SHORT_NO4)
	role_comm_title = "EngDtyO"
	flags = EQUIPMENT_PRESET_EXTRA
	skills = /datum/skills/navycengi
	idtype = /obj/item/card/id/silver
	rankpin_type = /obj/item/clothing/accessory/ranks/navy/o4

/datum/equipment_preset/usasf/chief_engineer/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/USASF/command(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/welding(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/navy/officer(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new rankpin_type(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/armband/engine(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beret/marine/chiefofficer(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/yellow(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/army/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/hazardvest/black(new_human), WEAR_JACKET)

	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/m4a3/full(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/utility/full(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/medium(new_human), WEAR_L_STORE)

//*****************************************************************************************************/

/datum/equipment_preset/usasf/CO
	name = "USASF Commanding Officer"
	assignment = JOB_NAVY_CO
	rank = JOB_NAVY_CO
	paygrades = list(PAY_SHORT_NO6)
	role_comm_title = "CAPT"
	flags = EQUIPMENT_PRESET_EXTRA
	skills = /datum/skills/navycommander
	idtype = /obj/item/card/id/gold
	rankpin_type = /obj/item/clothing/accessory/ranks/navy/o6

/datum/equipment_preset/usasf/CO/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/USASF/command(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/big(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/navy/officer(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/usasf(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/marine/peaked/captain/black(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/army/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/dress/officer/bomber(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new rankpin_type(new_human), WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range/designator(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/m4a3/m1911(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/medium(new_human), WEAR_L_STORE)

/datum/equipment_preset/usasf/CO/lesser_rank
	name = parent_type::name + " (Lesser Rank)"
	paygrades = list(PAY_SHORT_NO5 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "CDR"
	rankpin_type = /obj/item/clothing/accessory/ranks/navy/o5

