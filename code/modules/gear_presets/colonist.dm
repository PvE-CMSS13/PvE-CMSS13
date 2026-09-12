/datum/equipment_preset/colonist
	name = "US Colonist"
	languages = list(LANGUAGE_ENGLISH)
	faction = FACTION_COLONIST
	skills = /datum/skills/civilian
	idtype = /obj/item/card/id/lanyard
	origin_override = ORIGIN_CIVILIAN

/datum/equipment_preset/colonist/bluecollar

	name = "US Civilian Colonist, Blue-Collar"
	flags = EQUIPMENT_PRESET_EXTRA
	faction = FACTION_COLONIST
	paygrades = list(PAY_SHORT_CIV = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/civilian
	access = list(ACCESS_CIVILIAN_PUBLIC)

/datum/equipment_preset/colonist/bluecollar/get_assignment(mob/living/carbon/human/new_human)
	if(prob(50))
		return "Class D Inhabitant"

	return "Class C Inhabitant"

/datum/equipment_preset/colonist/bluecollar/load_gear(mob/living/carbon/human/new_human)

	new_human.undershirt = "undershirt"
	//back
	add_random_satchel(new_human)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress, WEAR_L_EAR)
	//uniform
	add_civilian_uniform(new_human)
	//jacket
	add_civilian_jacket(new_human)
	//limbs
	add_civilian_shoe(new_human)

/datum/equipment_preset/colonist/bluecollar/spanish
	name = "LatAm Civilian Colonist, Blue-Collar"
	ethnicity = LATIN_AMERICAN_ETHNICITY
	languages = list(LANGUAGE_SPANISH)

/datum/equipment_preset/colonist/bluecollar/brazilian
	name = "Brazilian Civilian Colonist, Blue-Collar"
	ethnicity = BRAZILIAN_ETHNICITY
	languages = list(LANGUAGE_PORTUGUESE)


/datum/equipment_preset/colonist/bluecollar/japanese
	name = "TWE Civilian Colonist, Blue-Collar"
	ethnicity = JAPANESE_ETHNICITY
	languages = list(LANGUAGE_JAPANESE)

/datum/equipment_preset/colonist/miner

	name = "US Civilian Colonist, Blue-Collar (Miner)"
	assignment = "Miner"
	flags = EQUIPMENT_PRESET_EXTRA
	faction = FACTION_COLONIST
	paygrades = list(PAY_SHORT_CIV = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/civilian
	access = list(ACCESS_CIVILIAN_PUBLIC)

/datum/equipment_preset/colonist/miner/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"

	//back
	add_random_satchel(new_human)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress, WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/hardhat(new_human), WEAR_HEAD)
	//uniform
	add_worker_uniform(new_human)
	//jacket
	add_worker_jacket(new_human)
	//limbs
	add_worker_shoe(new_human)

/datum/equipment_preset/colonist/miner/spanish
	name = "LatAm Civilian Colonist, Blue-Collar (Miner)"
	languages = list(LANGUAGE_SPANISH)
	ethnicity = LATIN_AMERICAN_ETHNICITY

/datum/equipment_preset/colonist/miner/brazilian
	name = "Brazilian Civilian Colonist, Blue-Collar (Miner)"
	ethnicity = BRAZILIAN_ETHNICITY
	languages = list(LANGUAGE_PORTUGUESE)

/datum/equipment_preset/colonist/miner/japanese
	name = "TWE Civilian Colonist, Blue-Collar (Miner)"
	languages = list(LANGUAGE_JAPANESE)
	ethnicity = JAPANESE_ETHNICITY

/datum/equipment_preset/colonist/construction
	name = "US Civilian Colonist, Blue-Collar (Construction)"
	assignment = "Construction Worker"
	flags = EQUIPMENT_PRESET_EXTRA
	faction = FACTION_COLONIST
	paygrades = list(PAY_SHORT_CIV = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/civilian
	access = list(ACCESS_CIVILIAN_PUBLIC)

/datum/equipment_preset/colonist/construction/load_gear(mob/living/carbon/human/new_human)

	new_human.undershirt = "undershirt"
	//back
	add_random_satchel(new_human)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress, WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/hardhat(new_human), WEAR_HEAD)
	//uniform
	add_worker_uniform(new_human)
	//jacket
	add_worker_jacket(new_human)
	//limbs
	add_worker_shoe(new_human)

/datum/equipment_preset/colonist/construction/spanish
	name = "LatAm Colonist, Blue-Collar (Construction)"
	ethnicity = LATIN_AMERICAN_ETHNICITY
	languages = list(LANGUAGE_SPANISH)

/datum/equipment_preset/colonist/construction/brazilian
	name = "Brazilian Colonist, Blue-Collar (Construction)"
	ethnicity = BRAZILIAN_ETHNICITY
	languages = list(LANGUAGE_PORTUGUESE)

/datum/equipment_preset/colonist/construction/japanese
	name = "TWE Colonist, Blue-Collar (Construction)"
	ethnicity = JAPANESE_ETHNICITY
	languages = list(LANGUAGE_JAPANESE)

/datum/equipment_preset/colonist/roughneck
	name = "US Civilian Colonist, Blue-Collar (Roughneck)"
	flags = EQUIPMENT_PRESET_EXTRA
	faction = FACTION_COLONIST
	paygrades = list(PAY_SHORT_CIV = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/civilian
	access = list(ACCESS_CIVILIAN_PUBLIC)

/datum/equipment_preset/colonist/roughneck/get_assignment(mob/living/carbon/human/new_human)
	if(prob(50))
		return "Driller"
	if(prob(50))
		return "Derrickhand"
	if(prob(50))
		return "Chainhand"
	return "Floorhand"

/datum/equipment_preset/colonist/roughneck/load_gear(mob/living/carbon/human/new_human)

	new_human.undershirt = "undershirt"
	//back
	add_random_satchel(new_human)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress, WEAR_L_EAR)
	add_facewrap(new_human)
	//head
	var/random_roughneck_hardhat = rand(1,2)
	switch(random_roughneck_hardhat)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/hardhat/white(new_human), WEAR_HEAD)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/hardhat/dblue(new_human), WEAR_HEAD)
	//uniform
	add_worker_uniform(new_human)
	//jacket
	add_worker_jacket(new_human)
	//limbs
	add_worker_gloves(new_human)
	add_worker_shoe(new_human)

/datum/equipment_preset/colonist/roughneck/spanish
	name = "LatAm Colonist, Blue-Collar (Roughneck)"
	ethnicity = LATIN_AMERICAN_ETHNICITY
	languages = list(LANGUAGE_SPANISH)

/datum/equipment_preset/colonist/roughneck/brazilian
	name = "Brazilian Colonist, Blue-Collar (Roughneck)"
	ethnicity = BRAZILIAN_ETHNICITY
	languages = list(LANGUAGE_PORTUGUESE)

/datum/equipment_preset/colonist/roughneck/japanese
	name = "TWE Colonist, Blue-Collar (Roughneck)"
	ethnicity = JAPANESE_ETHNICITY
	languages = list(LANGUAGE_JAPANESE)

/datum/equipment_preset/colonist/cook
	name = "US Civilian Colonist, Blue-Collar (Cook)"
	assignment = "Cook"
	flags = EQUIPMENT_PRESET_EXTRA
	faction = FACTION_COLONIST
	paygrades = list(PAY_SHORT_CIV = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/civilian
	access = list(ACCESS_CIVILIAN_PUBLIC)

/datum/equipment_preset/colonist/cook/load_gear(mob/living/carbon/human/new_human)

	new_human.undershirt = "undershirt"
	//back
	add_random_satchel(new_human)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress, WEAR_L_EAR)
	//uniform
	var/obj/item/clothing/under/colonist/workwear/khaki/uniform = new()
	uniform.roll_suit_jacket(new_human)
	new_human.equip_to_slot_or_del(uniform, WEAR_BODY)
	//jacket
	new_human.equip_to_slot_or_del(new/obj/item/clothing/suit/chef/classic, WEAR_JACKET)
	//limbs
	add_worker_shoe(new_human)

/datum/equipment_preset/colonist/cook/spanish
	name = "LatAm Colonist, Blue-Collar (Cook)"
	ethnicity = LATIN_AMERICAN_ETHNICITY
	languages = list(LANGUAGE_SPANISH)

/datum/equipment_preset/colonist/cook/brazilian
	name = "Brazilian Colonist, Blue-Collar (Cook)"
	ethnicity = BRAZILIAN_ETHNICITY
	languages = list(LANGUAGE_PORTUGUESE)

/datum/equipment_preset/colonist/cook/japanese
	name = "TWE Colonist, Blue-Collar (Cook)"
	ethnicity = JAPANESE_ETHNICITY
	languages = list(LANGUAGE_JAPANESE)

/datum/equipment_preset/colonist/chef
	name = "US Civilian Colonist, Blue-Collar (Chef)"
	assignment = "Chef"
	flags = EQUIPMENT_PRESET_EXTRA
	faction = FACTION_COLONIST
	paygrades = list(PAY_SHORT_CIV = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/civilian
	access = list(ACCESS_CIVILIAN_PUBLIC)

/datum/equipment_preset/colonist/chef/load_gear(mob/living/carbon/human/new_human)

	new_human.undershirt = "undershirt"
	//back
	add_random_satchel(new_human)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress, WEAR_L_EAR)
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/liaison_suit/black(new_human), WEAR_BODY)
	//jacket
	new_human.equip_to_slot_or_del(new/obj/item/clothing/suit/chef, WEAR_JACKET)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(new_human), WEAR_FEET)

/datum/equipment_preset/colonist/chef/spanish
	name = "LatAm Colonist, Blue-Collar (Chef)"
	ethnicity = LATIN_AMERICAN_ETHNICITY
	languages = list(LANGUAGE_SPANISH)

/datum/equipment_preset/colonist/chef/brazilian
	name = "Brazilian Colonist, Blue-Collar (Chef)"
	ethnicity = BRAZILIAN_ETHNICITY
	languages = list(LANGUAGE_PORTUGUESE)

/datum/equipment_preset/colonist/chef/japanese
	name = "TWE Colonist, Blue-Collar (Chef)"
	ethnicity = JAPANESE_ETHNICITY
	languages = list(LANGUAGE_JAPANESE)

/datum/equipment_preset/colonist/priest
	name = "US Civilian Colonist, Priest"
	assignment = "Spiritual Guidance Counselor"
	flags = EQUIPMENT_PRESET_EXTRA
	faction = FACTION_COLONIST
	paygrades = list(PAY_SHORT_CIV = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/civilian
	access = list(ACCESS_CIVILIAN_PUBLIC)

/datum/equipment_preset/colonist/priest/load_gear(mob/living/carbon/human/new_human)

	new_human.undershirt = "undershirt"
	//back
	add_random_satchel(new_human)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress, WEAR_L_EAR)
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/rank/chaplain(new_human), WEAR_BODY)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/corporate/black(new_human), WEAR_JACKET)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(new_human), WEAR_FEET)

/datum/equipment_preset/colonist/priest/spanish
	name = "LatAm Colonist, Priest"
	ethnicity = LATIN_AMERICAN_ETHNICITY
	languages = list(LANGUAGE_SPANISH)

/datum/equipment_preset/colonist/priest/brazilian
	name = "Brazilian Colonist, Priest"
	ethnicity = BRAZILIAN_ETHNICITY
	languages = list(LANGUAGE_PORTUGUESE)

/datum/equipment_preset/colonist/priest/japanese
	name = "TWE Colonist, Priest"
	ethnicity = LATIN_AMERICAN_ETHNICITY
	languages = list(LANGUAGE_SPANISH)

/datum/equipment_preset/colonist/whitecollar
	name = "US Civilian Colonist, White-Collar"
	flags = EQUIPMENT_PRESET_EXTRA
	faction = FACTION_COLONIST
	paygrades = list(PAY_SHORT_CIV = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/civilian
	access = list(ACCESS_CIVILIAN_PUBLIC)

/datum/equipment_preset/colonist/whitecollar/get_assignment(mob/living/carbon/human/new_human)
	if(prob(50))
		return "Class B Inhabitant"

	return "Class A Inhabitant"

/datum/equipment_preset/colonist/whitecollar/load_gear(mob/living/carbon/human/new_human)

	new_human.undershirt = "undershirt"
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress, WEAR_L_EAR)
	//back
	add_random_satchel(new_human)
	//outfit
	add_business_outfit(new_human)
	var/random_tie = rand(1,2)
	switch(random_tie)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/black(new_human), WEAR_ACCESSORY)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/blue(new_human), WEAR_ACCESSORY)
	//limb
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(new_human), WEAR_FEET)


/datum/equipment_preset/colonist/whitecollar/spanish
	name = "LatAm Civilian Colonist, White-Collar"
	ethnicity = LATIN_AMERICAN_ETHNICITY
	languages = list(LANGUAGE_SPANISH)

/datum/equipment_preset/colonist/whitecollar/brazilian
	name = "Brazilian Civilian Colonist, White-Collar"
	ethnicity = BRAZILIAN_ETHNICITY
	languages = list(LANGUAGE_PORTUGUESE)

/datum/equipment_preset/colonist/whitecollar/japanese
	name = "TWE Civilian Colonist, White-Collar"
	ethnicity = JAPANESE_ETHNICITY
	languages = list(LANGUAGE_JAPANESE)

/datum/equipment_preset/colonist/whitecollar/exec
	name = "US Civilian Colonist, White-Collar (Corporate Exec)"
	flags = EQUIPMENT_PRESET_EXTRA
	faction = FACTION_COLONIST
	paygrades = list(PAY_SHORT_CIV = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/civilian
	access = list(ACCESS_CIVILIAN_PUBLIC)
	idtype = /obj/item/card/id/silver

/datum/equipment_preset/colonist/whitecollar/exec/get_assignment(mob/living/carbon/human/new_human)
	if(prob(25))
		return "Senior Executive"

	return "Executive"

/datum/equipment_preset/colonist/whitecollar/exec/load_gear(mob/living/carbon/human/new_human)

	new_human.undershirt = "undershirt"
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress, WEAR_L_EAR)
	//back
	add_random_satchel(new_human)
	//outfit
	add_business_outfit(new_human)
	var/random_tie = rand(1,2)
	switch(random_tie)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/black(new_human), WEAR_ACCESSORY)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/blue(new_human), WEAR_ACCESSORY)
	//limb
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/briefcase(new_human), WEAR_L_HAND)

/datum/equipment_preset/colonist/whitecollar/exec/spanish
	name = "LatAm Civilian Colonist, White-Collar (Corporate Exec)"
	ethnicity = LATIN_AMERICAN_ETHNICITY
	languages = list(LANGUAGE_SPANISH,LANGUAGE_ENGLISH, LANGUAGE_PORTUGUESE)

/datum/equipment_preset/colonist/whitecollar/exec/spanish
	name = "Brazilian Civilian Colonist, White-Collar (Corporate Exec)"
	ethnicity = BRAZILIAN_ETHNICITY
	languages = list(LANGUAGE_PORTUGUESE, LANGUAGE_ENGLISH, LANGUAGE_SPANISH)

/datum/equipment_preset/colonist/whitecollar/exec/japanese
	name = "TWE Civilian Colonist, White-Collar (Corporate Exec)"
	ethnicity = JAPANESE_ETHNICITY
	languages = list(LANGUAGE_JAPANESE)

/datum/equipment_preset/colonist/researcher
	name = "US Civilian Researcher"
	flags = EQUIPMENT_PRESET_EXTRA
	faction = FACTION_COLONIST
	assignment = "Research Associate"
	paygrades = list(PAY_SHORT_CCMO = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/researcher
	access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_CIVILIAN_RESEARCH, ACCESS_WY_GENERAL, ACCESS_WY_COLONIAL, ACCESS_WY_RESEARCH)
	idtype = /obj/item/card/id/silver

/datum/equipment_preset/colonist/researcher/load_gear(mob/living/carbon/human/new_human)

	new_human.undershirt = "undershirt"
	//back
	add_random_satchel(new_human)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress, WEAR_L_EAR)
	//uniform
	add_professionalwear(new_human)
	var/random_tie= rand(1,5)
	switch(random_tie)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/black(new_human), WEAR_ACCESSORY)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/blue(new_human), WEAR_ACCESSORY)
		if(3)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/green(new_human), WEAR_ACCESSORY)
		if(4)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/purple(new_human), WEAR_ACCESSORY)
		if(5)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/red(new_human), WEAR_ACCESSORY)
	//jacket
	var/random_researcher_suit = rand(1,5)
	switch(random_researcher_suit)
		if(1 to 2)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/labcoat(new_human), WEAR_JACKET)
		if(3)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/vest/tan(new_human), WEAR_JACKET)
		if(4)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/vest(new_human), WEAR_JACKET)
		if(5)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/vest/grey(new_human), WEAR_JACKET)
	//limb
	add_dress_shoes(new_human)

/datum/equipment_preset/colonist/researcher/spanish
	name = "LatAm Civilian Researcher"
	ethnicity = LATIN_AMERICAN_ETHNICITY
	languages = list(LANGUAGE_SPANISH, LANGUAGE_ENGLISH)

/datum/equipment_preset/colonist/researcher/brazilian
	name = "Brazilian Civilian Researcher"
	ethnicity = BRAZILIAN_ETHNICITY
	languages = list(LANGUAGE_PORTUGUESE, LANGUAGE_ENGLISH, LANGUAGE_SPANISH)

/datum/equipment_preset/colonist/researcher/japanese
	name = "TWE Civilian Researcher"
	ethnicity = JAPANESE_ETHNICITY
	languages = list(LANGUAGE_JAPANESE, LANGUAGE_ENGLISH)

/datum/equipment_preset/colonist/doctor
	name = "US Civilian Doctor"
	flags = EQUIPMENT_PRESET_EXTRA
	faction = FACTION_COLONIST
	assignment = "Medical Doctor"
	paygrades = list(PAY_SHORT_CDOC = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/civilian/survivor/doctor
	access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_CIVILIAN_MEDBAY)
	idtype = /obj/item/card/id/silver

/datum/equipment_preset/colonist/doctor/load_gear(mob/living/carbon/human/new_human)

	new_human.undershirt = "undershirt"
	//back
	add_random_satchel(new_human)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress, WEAR_L_EAR)
	//uniform
	add_professionalwear(new_human)
	add_tie(new_human)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/labcoat(new_human), WEAR_JACKET)
	//limb
	add_dress_shoes(new_human)

/datum/equipment_preset/colonist/doctor/spanish
	name = "LatAm Civilian Doctor"
	ethnicity = LATIN_AMERICAN_ETHNICITY
	languages = list(LANGUAGE_SPANISH)

/datum/equipment_preset/colonist/doctor/brazilian
	name = "Brazilian Civilian Doctor"
	ethnicity = BRAZILIAN_ETHNICITY
	languages = list(LANGUAGE_PORTUGUESE)

/datum/equipment_preset/colonist/doctor/japanese
	name = "TWE Civilian Doctor"
	ethnicity = JAPANESE_ETHNICITY
	languages = list(LANGUAGE_JAPANESE)

/datum/equipment_preset/colonist/doctor/scrubs
	name = "US Civilian Doctor, Scrubs"

/datum/equipment_preset/colonist/doctor/scrubs/load_gear(mob/living/carbon/human/new_human)

	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/blue(new_human), WEAR_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress, WEAR_L_EAR)
	//uniform
	var/random_scrubs= rand(1,4)
	switch(random_scrubs)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/under/rank/medical/green(new_human), WEAR_BODY)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/under/rank/medical/blue(new_human), WEAR_BODY)
		if(3)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/under/rank/medical/purple(new_human), WEAR_BODY)
		if(4)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/under/rank/medical/lightblue(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/stethoscope(new_human), WEAR_ACCESSORY)
	//limb
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/white(new_human), WEAR_FEET)

/datum/equipment_preset/colonist/doctor/scrubs/spanish
	name = "LatAm Civilian Doctor, Scrubs"
	ethnicity = LATIN_AMERICAN_ETHNICITY
	languages = list(LANGUAGE_SPANISH)

/datum/equipment_preset/colonist/doctor/scrubs/brazilian
	name = "Brazilian Civilian Doctor, Scrubs"
	ethnicity = BRAZILIAN_ETHNICITY
	languages = list(LANGUAGE_PORTUGUESE)

/datum/equipment_preset/colonist/doctor/scrubs/japanese
	name = "TWE Civilian Doctor, Scrubs"
	ethnicity = JAPANESE_ETHNICITY
	languages = list(LANGUAGE_JAPANESE)

/datum/equipment_preset/colonist/admin
	name = "US Civilian Administrator"
	flags = EQUIPMENT_PRESET_EXTRA
	faction = FACTION_COLONIST
	assignment = "Administrator"
	role_comm_title = "ADMIN"
	paygrades = list(PAY_SHORT_CIV = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/civilian
	access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_CIVILIAN_LOGISTICS, ACCESS_CIVILIAN_ENGINEERING, ACCESS_CIVILIAN_BRIG, ACCESS_CIVILIAN_MEDBAY, ACCESS_CIVILIAN_COMMAND)
	idtype = /obj/item/card/id/silver

/datum/equipment_preset/colonist/admin/load_gear(mob/living/carbon/human/new_human)

	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black(new_human), WEAR_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress, WEAR_L_EAR)
	//outfit
	add_business_outfit(new_human)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(new_human), WEAR_FEET)

/datum/equipment_preset/colonist/admin/spanish
	name = "LatAm Civilian Administrator"
	ethnicity = LATIN_AMERICAN_ETHNICITY
	languages = list(LANGUAGE_SPANISH)

/datum/equipment_preset/colonist/admin/brazilian
	name = "Brazilian Civilian Administrator"
	ethnicity = BRAZILIAN_ETHNICITY
	languages = list(LANGUAGE_PORTUGUESE)

/datum/equipment_preset/colonist/admin/japanese
	name = "TWE Civilian Administrator"
	ethnicity = JAPANESE_ETHNICITY
	languages = list(LANGUAGE_JAPANESE)

/datum/equipment_preset/colonist/cargo
	name = "US Civilian Logistics Worker"
	flags = EQUIPMENT_PRESET_EXTRA
	faction = FACTION_COLONIST
	assignment = "Logistical Technician"
	paygrades = list(PAY_SHORT_CIV = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/civilian
	access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_CIVILIAN_LOGISTICS)

/datum/equipment_preset/colonist/cargo/load_gear(mob/living/carbon/human/new_human)

	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress, WEAR_L_EAR)
	//uniform
	add_boilersuit(new_human)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/hazardvest(new_human), WEAR_JACKET)
	//limb
	var/random_cargo_shoe = rand(1,5)
	switch(random_cargo_shoe)
		if(1 to 2)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/civilian(new_human), WEAR_FEET)
		if(3 to 4)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/civilian/brown(new_human), WEAR_FEET)
		if(5)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/white(new_human), WEAR_FEET)
	add_worker_gloves(new_human)

/datum/equipment_preset/colonist/cargo/spanish
	name = "LatAm Logistics Worker"
	ethnicity = LATIN_AMERICAN_ETHNICITY
	languages = list(LANGUAGE_SPANISH)

/datum/equipment_preset/colonist/cargo/brazilian
	name = "Brazilian Logistics Worker"
	ethnicity = BRAZILIAN_ETHNICITY
	languages = list(LANGUAGE_PORTUGUESE)

/datum/equipment_preset/colonist/cargo/japanese
	name = "TWE Logistics Worker"
	ethnicity = JAPANESE_ETHNICITY
	languages = list(LANGUAGE_JAPANESE)

/datum/equipment_preset/colonist/technician
	name = "US Civilian Maintenance Technician"
	flags = EQUIPMENT_PRESET_EXTRA
	faction = FACTION_COLONIST
	assignment = "Maintenance Technician"
	paygrades = list(PAY_SHORT_CIV = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/MT
	access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_CIVILIAN_ENGINEERING)

/datum/equipment_preset/colonist/technician/load_gear(mob/living/carbon/human/new_human)

	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress, WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/hardhat/dblue(new_human), WEAR_HEAD)
	//uniform
	add_worker_uniform(new_human)
	//jacket
	add_worker_jacket(new_human)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/utility/full, WEAR_WAIST)
	//limb
	add_worker_shoe(new_human)
	add_worker_gloves(new_human)

/datum/equipment_preset/colonist/technician/spanish
	name = "LatAm Maintenance Technician"
	ethnicity = LATIN_AMERICAN_ETHNICITY
	languages = list(LANGUAGE_SPANISH)

/datum/equipment_preset/colonist/technician/brazilian
	name = "Brazilian Maintenance Technician"
	ethnicity = BRAZILIAN_ETHNICITY
	languages = list(LANGUAGE_PORTUGUESE)

/datum/equipment_preset/colonist/technician/japanese
	name = "TWE Maintenance Technician"
	ethnicity = JAPANESE_ETHNICITY
	languages = list(LANGUAGE_JAPANESE)


/datum/equipment_preset/colonist/engineer
	name = "US Civilian Engineer"
	flags = EQUIPMENT_PRESET_EXTRA
	faction = FACTION_COLONIST
	paygrades = list(PAY_SHORT_CIV = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/MT
	access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_CIVILIAN_ENGINEERING)

/datum/equipment_preset/colonist/engineer/get_assignment(mob/living/carbon/human/new_human)
	if(prob(85))
		return "Engineer"
	return "Foreman"

/datum/equipment_preset/colonist/engineer/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress, WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/hardhat/white(new_human), WEAR_HEAD)
	//uniform
	add_civilian_uniform(new_human)
	//jacket
	var/random_foreman_jacket= rand(1,4)
	switch(random_foreman_jacket)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/apron/overalls(new_human), WEAR_JACKET)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/apron/overalls/tan(new_human), WEAR_JACKET)
		if(3)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/windbreaker/windbreaker_yellow(new_human), WEAR_JACKET)
		if(4)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/hazardvest/blue(new_human), WEAR_JACKET)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/utility/full, WEAR_WAIST)
	//limb
	add_worker_shoe(new_human)
	add_worker_gloves(new_human)

/datum/equipment_preset/colonist/engineer/spanish
	name = "LatAm Civilian Engineer"
	ethnicity = LATIN_AMERICAN_ETHNICITY
	languages = list(LANGUAGE_SPANISH)


/datum/equipment_preset/colonist/engineer/brazilian
	name = "Brazilian Civilian Engineer"
	ethnicity = BRAZILIAN_ETHNICITY
	languages = list(LANGUAGE_PORTUGUESE)

/datum/equipment_preset/colonist/engineer/japanese
	name = "TWE Civilian Engineer"
	ethnicity = JAPANESE_ETHNICITY
	languages = list(LANGUAGE_JAPANESE)

/datum/equipment_preset/colonist/operations
	name = "US Civilian Operations Technician"
	flags = EQUIPMENT_PRESET_EXTRA
	faction = FACTION_COLONIST
	assignment = "Operations Technician"
	paygrades = list(PAY_SHORT_CIV = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/civilian
	access = list(ACCESS_UPP_GENERAL, ACCESS_CIVILIAN_PUBLIC, ACCESS_CIVILIAN_COMMAND)

/datum/equipment_preset/colonist/operations/load_gear(mob/living/carbon/human/new_human)

	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black(new_human), WEAR_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress, WEAR_L_EAR)
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/workwear(new_human), WEAR_BODY)
	//limb
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(new_human), WEAR_FEET)

/datum/equipment_preset/colonist/operations/spanish
	name = "LatAm Civilian Operations Technician"
	ethnicity = LATIN_AMERICAN_ETHNICITY
	languages = list(LANGUAGE_SPANISH)

/datum/equipment_preset/colonist/operations/brazilian
	name = "Brazilian Civilian Operations Technician"
	ethnicity = BRAZILIAN_ETHNICITY
	languages = list(LANGUAGE_PORTUGUESE)

/datum/equipment_preset/colonist/operations/japanese
	name = "TWE Civilian Operations Technician"
	ethnicity = JAPANESE_ETHNICITY
	languages = list(LANGUAGE_JAPANESE)

/datum/equipment_preset/colonist/prisoner
	name = "Prisoner"
	flags = EQUIPMENT_PRESET_EXTRA
	faction = FACTION_COLONIST
	assignment = "Inmate"
	paygrades = list(PAY_SHORT_CIV = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/civilian
	access = list(null)
	idtype = /obj/item/card/id

/datum/equipment_preset/colonist/prisoner/load_gear(mob/living/carbon/human/new_human)

	new_human.undershirt = "undershirt"
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/prison_boiler(new_human), WEAR_BODY)
	//limb
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/white(new_human), WEAR_FEET)

/datum/equipment_preset/colonist/prisoner/spanish
	name = "LatAm Prisoner"
	ethnicity = LATIN_AMERICAN_ETHNICITY
	languages = list(LANGUAGE_SPANISH)

/datum/equipment_preset/colonist/prisoner/brazilian
	name = "Brazilian Prisoner"
	ethnicity = BRAZILIAN_ETHNICITY
	languages = list(LANGUAGE_PORTUGUESE)

/datum/equipment_preset/colonist/prisoner/japanese
	name = "TWE Prisoner"
	ethnicity = JAPANESE_ETHNICITY
	languages = list(LANGUAGE_JAPANESE)

/datum/equipment_preset/colonist/security
	name = "US Civilian Security Guard, Generic"
	flags = EQUIPMENT_PRESET_EXTRA
	faction = FACTION_COLONIST
	assignment = "Security Officer"
	paygrades = list(PAY_SHORT_CPO = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/civilian/survivor/marshal
	access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_CIVILIAN_BRIG, ACCESS_CIVILIAN_COMMAND)

/datum/equipment_preset/colonist/security/load_gear(mob/living/carbon/human/new_human)

	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black, WEAR_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress, WEAR_L_EAR)
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/liaison_suit/grey(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/black(new_human), WEAR_ACCESSORY)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/vest/ballistic, WEAR_JACKET)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/security/MP/colonist, WEAR_WAIST)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol, WEAR_IN_BELT)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup, WEAR_FEET)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/pistol/alt, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/m4a3, WEAR_IN_R_STORE)

/datum/equipment_preset/colonist/security/spanish
	name = "LatAm Civilian Security Guard, Generic"
	ethnicity = LATIN_AMERICAN_ETHNICITY
	languages = list(LANGUAGE_SPANISH)

/datum/equipment_preset/colonist/security/brazilian
	name = "Brazilian Civilian Security Guard, Generic"
	ethnicity = BRAZILIAN_ETHNICITY
	languages = list(LANGUAGE_PORTUGUESE)

/datum/equipment_preset/colonist/security/brazilian/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/liaison_suit/grey(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/brazil, WEAR_ACCESSORY)
	..()

/datum/equipment_preset/colonist/security/weyland
	name = "US Civilian Security Guard, Wey-Yu"
	flags = EQUIPMENT_PRESET_EXTRA
	faction = FACTION_WY
	faction_group = FACTION_LIST_WY_COLONY
	assignment = "Weyland-Yutani Corporate Security Officer"
	access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_CIVILIAN_BRIG, ACCESS_CIVILIAN_COMMAND, ACCESS_WY_GENERAL, ACCESS_WY_COLONIAL, ACCESS_WY_SECURITY)

/datum/equipment_preset/colonist/security/weyland/load_gear(mob/living/carbon/human/new_human)

	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black, WEAR_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/WY, WEAR_L_EAR)
	//head
	if(prob(85))
		new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/weyyu, WEAR_HEAD)
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/liaison_suit/black(new_human), WEAR_BODY)
	var/obj/item/clothing/under/liaison_suit/black/uniform = new()
	var/random_uniform = rand(1,2)
	switch(random_uniform)
		if(1)
			uniform.roll_suit_sleeves(new_human)
	new_human.equip_to_slot_or_del(uniform, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/blue(new_human), WEAR_ACCESSORY)
	//jacket
	if(prob(75))
		new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/vest, WEAR_JACKET)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/security/MP/colonist, WEAR_WAIST)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol/vp70, WEAR_IN_BELT)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup, WEAR_FEET)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/pistol/alt, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/vp70, WEAR_IN_R_STORE)

/datum/equipment_preset/colonist/security/weyland/japanese
	name = "TWE Civilian Security Guard, Wey-Yu"
	ethnicity = JAPANESE_ETHNICITY
	languages = list(LANGUAGE_JAPANESE)

/datum/equipment_preset/colonist/security/weyland/tactical
	name = "US Civilian Security Guard, Wey-Yu (Tactical SMG)"
	assignment = "Weyland-Yutani Corporate Tactical Response Officer"

/datum/equipment_preset/colonist/security/weyland/tactical/load_gear(mob/living/carbon/human/new_human)
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39, WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/WY, WEAR_L_EAR)
	//head
	if(prob(25))
		new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/weyyu, WEAR_HEAD)
	else
		new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/pmc/corporate, WEAR_HEAD)
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/boilersuit/cyan, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/droppouch, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39, WEAR_IN_ACCESSORY)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/vest/ballistic, WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/smg/m39/solidstock, WEAR_J_STORE)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/security/MP/colonist, WEAR_WAIST)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol/vp70, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol/vp70, WEAR_IN_BELT)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/civilian, WEAR_FEET)
	add_worker_gloves(new_human)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/pistol/alt, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/vp70, WEAR_IN_R_STORE)

/datum/equipment_preset/colonist/security/weyland/tactical/japanese
	name = "TWE Civilian Security Guard, Wey-Yu (Tactical SMG)"
	ethnicity = JAPANESE_ETHNICITY
	languages = list(LANGUAGE_JAPANESE)

/datum/equipment_preset/colonist/security/weyland/tactical/lead
	name = "US Civilian Security Guard, Wey-Yu (Tactical Shotgun)"

/datum/equipment_preset/colonist/security/weyland/tactical/lead/load_gear(mob/living/carbon/human/new_human)
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/buckshot, WEAR_IN_ACCESSORY)

	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/WY, WEAR_L_EAR)
	//head
	if(prob(25))
		new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/weyyu, WEAR_HEAD)
	else
		new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/pmc/corporate, WEAR_HEAD)
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/boilersuit/cyan, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/armband/nurse, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/droppouch, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/buckshot, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/buckshot, WEAR_IN_ACCESSORY)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/vest/ballistic, WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/shotgun/pump/dual_tube/cmb, WEAR_J_STORE)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/security/MP/colonist, WEAR_WAIST)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol/vp70, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol/vp70, WEAR_IN_BELT)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/civilian, WEAR_FEET)
	add_worker_gloves(new_human)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/pistol/alt, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/vp70, WEAR_IN_R_STORE)

/datum/equipment_preset/colonist/security/weyland/tactical/lead/japanese
	name = "TWE Civilian Security Guard, Wey-Yu (Tactical Shotgun)"
	ethnicity = JAPANESE_ETHNICITY
	languages = list(LANGUAGE_JAPANESE)

/datum/equipment_preset/colonist/security/trijent
	name = "US Civilian Security Guard, Trijent Corp"
	languages = list(LANGUAGE_JAPANESE, LANGUAGE_ENGLISH)
	flags = EQUIPMENT_PRESET_EXTRA
	faction = FACTION_COLONIST
	assignment = "Trijent Corporate Security Officer"
	paygrades = list(PAY_SHORT_CPO = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/civilian/survivor/marshal
	access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_CIVILIAN_BRIG, ACCESS_CIVILIAN_COMMAND, ACCESS_WY_SECURITY)

/datum/equipment_preset/colonist/security/trijent/load_gear(mob/living/carbon/human/new_human)

	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black, WEAR_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress, WEAR_L_EAR)
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/liaison_suit/blue(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/blue(new_human), WEAR_ACCESSORY)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/vest, WEAR_JACKET)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/security/MP/colonist, WEAR_WAIST)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup, WEAR_FEET)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/pistol/alt, WEAR_R_STORE)

/datum/equipment_preset/colonist/security/trijent/japanese
	name = "TWE Civilian Security Guard, Trijent Corp"
	ethnicity = JAPANESE_ETHNICITY
	languages = list(LANGUAGE_JAPANESE)

/datum/equipment_preset/colonist/security/prison
	name = "US Federal Prison Guard"
	flags = EQUIPMENT_PRESET_EXTRA
	faction = FACTION_COLONIST
	faction_group = FACTION_LIST_UA_COLONY
	assignment = "Corrections Officer"
	paygrades = list(PAY_SHORT_CPO = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/civilian/survivor/marshal
	access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_CIVILIAN_BRIG, ACCESS_CIVILIAN_COMMAND)
	idtype = /obj/item/card/id/silver

/datum/equipment_preset/colonist/security/prison/load_gear(mob/living/carbon/human/new_human)

	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress, WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/corrections, WEAR_HEAD)
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/boilersuit/darkblue, WEAR_BODY)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/vest/ballistic, WEAR_JACKET)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/security/MP/colonist, WEAR_WAIST)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol, WEAR_IN_BELT)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup, WEAR_FEET)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/pistol/alt, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/m4a3, WEAR_IN_R_STORE)

/datum/equipment_preset/colonist/security/prison/spanish
	name = "LatAm Federal Prison Guard"
	ethnicity = LATIN_AMERICAN_ETHNICITY
	languages = list(LANGUAGE_SPANISH)

/datum/equipment_preset/colonist/security/prison/brazilian
	name = "Brazilian Federal Prison Guard"
	ethnicity = BRAZILIAN_ETHNICITY
	languages = list(LANGUAGE_PORTUGUESE)

/datum/equipment_preset/colonist/security/prison/brazilian/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/boilersuit/darkblue(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/brazil, WEAR_ACCESSORY)
	..()


//UACG

/datum/equipment_preset/colonist/security/guard
	name = "US Colonial Guard"
	flags = EQUIPMENT_PRESET_EXTRA
	faction = FACTION_UACG
	faction_group = FACTION_LIST_UA_COLONY
	assignment = "Colonial Militiaman"
	role_comm_title = "UACG"
	paygrades = list(PAY_SHORT_AE2 = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/trooper
	access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_CIVILIAN_BRIG, ACCESS_CIVILIAN_COMMAND, ACCESS_MARINE_PREP)
	idtype = /obj/item/card/id/dogtag

/datum/equipment_preset/colonist/security/guard/load_gear(mob/living/carbon/human/new_human)

	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/guard, WEAR_L_EAR)
	//head
	var/maybecap = rand(1,3)
	switch(maybecap)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/ua_riot, WEAR_HEAD)
			new_human.equip_to_slot_or_del(new /obj/item/prop/helmetgarb/riot_shield, WEAR_IN_HELMET)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/khaki, WEAR_IN_BACK)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/khaki, WEAR_HEAD)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/ua_riot, WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/prop/helmetgarb/riot_shield, WEAR_IN_BACK)
		if(3)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/ua_riot, WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/prop/helmetgarb/riot_shield, WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/khaki, WEAR_IN_BACK)
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/boilersuit/khaki, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/ranks/army/e2, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/ua, WEAR_ACCESSORY)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/guard, WEAR_JACKET)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/security/MP/colonist, WEAR_WAIST)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/civilian/knife, WEAR_FEET)
	add_worker_gloves(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m20a, WEAR_J_STORE)

	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m20a, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m20a, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m20a, WEAR_IN_R_STORE)

/datum/equipment_preset/colonist/security/guard/spanish
	name = "LatAm Colonial Guard"
	ethnicity = LATIN_AMERICAN_ETHNICITY
	languages = list(LANGUAGE_SPANISH)

/datum/equipment_preset/colonist/security/guard/brazilian
	name = "Brazilian Colonial Guard"
	ethnicity = BRAZILIAN_ETHNICITY
	languages = list(LANGUAGE_PORTUGUESE)

/datum/equipment_preset/colonist/security/guard/brazilian/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/boilersuit/khaki, WEAR_BODY)
	new_human.equip_to_slot(new /obj/item/clothing/accessory/patch/cmb/brazil_police, WEAR_ACCESSORY)
	..()

/datum/equipment_preset/colonist/security/guard/marksman
	name = "US Colonial Guard (Marksman)"

/datum/equipment_preset/colonist/security/guard/marksman/load_gear(mob/living/carbon/human/new_human)

	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/guard, WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/khaki, WEAR_HEAD)
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/boilersuit/khaki, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/ranks/army/e2, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/ua, WEAR_ACCESSORY)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/guard, WEAR_JACKET)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/security/MP/colonist, WEAR_WAIST)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/civilian/knife, WEAR_FEET)
	add_worker_gloves(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/l42a, WEAR_J_STORE)
	//storage
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/packet/smoke, WEAR_IN_BACK)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/l42a/ap, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/l42a/ap, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/l42a/ap, WEAR_IN_R_STORE)

/datum/equipment_preset/colonist/security/guard/marksman/spanish
	name = "LatAm Colonial Guard Marksman"
	ethnicity = LATIN_AMERICAN_ETHNICITY
	languages = list(LANGUAGE_SPANISH)

/datum/equipment_preset/colonist/security/guard/marksman/brazilian
	name = "Brazilian Colonial Guard Marksman"
	ethnicity = BRAZILIAN_ETHNICITY
	languages = list(LANGUAGE_PORTUGUESE)

/datum/equipment_preset/colonist/security/guard/marksman/brazilian/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/boilersuit/khaki, WEAR_BODY)
	new_human.equip_to_slot(new /obj/item/clothing/accessory/patch/cmb/brazil_police, WEAR_ACCESSORY)
	..()

/datum/equipment_preset/colonist/security/guard/medic
	name = "US Colonial Guard Medic"
	assignment = "Colonial Militiaman Medic"
	paygrades = list(PAY_SHORT_AE4E = JOB_PLAYTIME_TIER_0)
	role_comm_title = "UACG-M"
	skills = /datum/skills/medic
	access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_CIVILIAN_BRIG, ACCESS_CIVILIAN_COMMAND, ACCESS_MARINE_PREP, ACCESS_MARINE_MEDPREP, ACCESS_CIVILIAN_MEDBAY)

/datum/equipment_preset/colonist/security/guard/medic/load_gear(mob/living/carbon/human/new_human)

	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/healthanalyzer/soul, WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/guard, WEAR_L_EAR)
	//head
	var/maybecap = rand(1,3)
	switch(maybecap)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/medic/white, WEAR_HEAD)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/khaki, WEAR_IN_BACK)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/khaki, WEAR_HEAD)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/medic/white, WEAR_IN_BACK)
		if(3)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/medic/white, WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/khaki, WEAR_IN_BACK)
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/boilersuit/khaki, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/ranks/army/e4e, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/ua, WEAR_ACCESSORY)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/guard, WEAR_JACKET)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/medical/full, WEAR_WAIST)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/civilian/knife, WEAR_FEET)
	add_worker_gloves(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m20a, WEAR_J_STORE)
	//storage
	new_human.equip_to_slot_or_del(new /obj/item/storage/surgical_case/regular, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/extinguisher/mini, WEAR_IN_BACK)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/medical/full/surgery, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m20a, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m20a, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m20a, WEAR_IN_R_STORE)

/datum/equipment_preset/colonist/security/guard/medic/spanish
	name = "LatAm Colonial Guard Medic"
	ethnicity = LATIN_AMERICAN_ETHNICITY
	languages = list(LANGUAGE_SPANISH)

/datum/equipment_preset/colonist/security/guard/medic/brazilian
	name = "Brazilian Colonial Guard Medic"
	ethnicity = BRAZILIAN_ETHNICITY
	languages = list(LANGUAGE_PORTUGUESE)

/datum/equipment_preset/colonist/security/guard/medic/brazilian/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/boilersuit/khaki, WEAR_BODY)
	new_human.equip_to_slot(new /obj/item/clothing/accessory/patch/cmb/brazil_police, WEAR_ACCESSORY)
	..()

/datum/equipment_preset/colonist/security/guard/tech
	name = "US Colonial Guard Technician"
	assignment = "Colonial Militiaman Technician"
	paygrades = list(PAY_SHORT_AE4 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "UACG-T"
	skills = /datum/skills/sapper
	access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_CIVILIAN_BRIG, ACCESS_CIVILIAN_COMMAND, ACCESS_MARINE_PREP, ACCESS_MARINE_ENGPREP, ACCESS_CIVILIAN_ENGINEERING)

/datum/equipment_preset/colonist/security/guard/tech/load_gear(mob/living/carbon/human/new_human)

	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/guard, WEAR_L_EAR)
	//head
	var/maybecap = rand(1,3)
	switch(maybecap)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/ua_riot, WEAR_HEAD)
			new_human.equip_to_slot_or_del(new /obj/item/prop/helmetgarb/riot_shield, WEAR_IN_HELMET)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/khaki, WEAR_IN_BACK)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/khaki, WEAR_HEAD)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/ua_riot, WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/prop/helmetgarb/riot_shield, WEAR_IN_BACK)
		if(3)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/ua_riot, WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/prop/helmetgarb/riot_shield, WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/khaki, WEAR_IN_BACK)
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/boilersuit/khaki, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/ranks/army/e4, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/ua, WEAR_ACCESSORY)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/guard, WEAR_JACKET)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/utility/full, WEAR_WAIST)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/civilian/knife, WEAR_FEET)
	add_worker_gloves(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m20a, WEAR_J_STORE)
	//storage
	new_human.equip_to_slot_or_del(new /obj/item/stack/sheet/metal/medium_stack, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/stack/sheet/metal/large_stack, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/plastic/breaching_charge, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/folded, WEAR_IN_BACK)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m20a, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m20a, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m20a, WEAR_IN_R_STORE)

/datum/equipment_preset/colonist/security/guard/tech/spanish
	name = "LatAm Colonial Guard Technician"
	ethnicity = LATIN_AMERICAN_ETHNICITY
	languages = list(LANGUAGE_SPANISH)

/datum/equipment_preset/colonist/security/guard/tech/brazilian
	name = "Brazilian Colonial Guard Technician"
	ethnicity = BRAZILIAN_ETHNICITY
	languages = list(LANGUAGE_PORTUGUESE)

/datum/equipment_preset/colonist/security/guard/tech/brazilian/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/boilersuit/khaki, WEAR_BODY)
	new_human.equip_to_slot(new /obj/item/clothing/accessory/patch/cmb/brazil_police, WEAR_ACCESSORY)
	..()

/datum/equipment_preset/colonist/security/guard/nco
	name = "US Colonial Guard Unit Leader (Security)"
	assignment = "Colonial Militiaman Unit Leader"
	paygrades = list(PAY_SHORT_AE7 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "UACG-L"


/datum/equipment_preset/colonist/security/guard/nco/load_gear(mob/living/carbon/human/new_human)

	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/guard, WEAR_L_EAR)
	//head
	var/maybecap = rand(1,3)
	switch(maybecap)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/ua_riot, WEAR_HEAD)
			new_human.equip_to_slot_or_del(new /obj/item/prop/helmetgarb/riot_shield, WEAR_IN_HELMET)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/khaki, WEAR_IN_BACK)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/khaki, WEAR_HEAD)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/ua_riot, WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/prop/helmetgarb/riot_shield, WEAR_IN_BACK)
		if(3)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/ua_riot, WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/prop/helmetgarb/riot_shield, WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/khaki, WEAR_IN_BACK)
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/boilersuit/khaki, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/ranks/army/e7, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/ua, WEAR_ACCESSORY)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/guard, WEAR_JACKET)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/security/MP/colonist, WEAR_WAIST)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/civilian/knife, WEAR_FEET)
	add_worker_gloves(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m20a, WEAR_J_STORE)
	//storage
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/packet/smoke, WEAR_IN_BACK)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m20a, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m20a, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m20a, WEAR_IN_R_STORE)

/datum/equipment_preset/colonist/security/guard/nco/spanish
	name = "LatAm Colonial Guard Unit Leader"
	ethnicity = LATIN_AMERICAN_ETHNICITY
	languages = list(LANGUAGE_SPANISH)

/datum/equipment_preset/colonist/security/guard/nco/brazilian
	name = "Brazilian Colonial Guard Unit Leader"
	ethnicity = BRAZILIAN_ETHNICITY
	languages = list(LANGUAGE_PORTUGUESE)

/datum/equipment_preset/colonist/security/guard/nco/brazilian/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/boilersuit/khaki, WEAR_BODY)
	new_human.equip_to_slot(new /obj/item/clothing/accessory/patch/cmb/brazil_police, WEAR_ACCESSORY)
	..()

/datum/equipment_preset/colonist/security/guard/co
	name = "US Colonial Guard Officer (Security)"
	assignment = "Colonial Militiaman Officer"
	paygrades = list(PAY_SHORT_AO1 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "UACG-CO"
	skills = /datum/skills/nco
	access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_CIVILIAN_BRIG, ACCESS_CIVILIAN_COMMAND, ACCESS_MARINE_PREP, ACCESS_MARINE_COMMAND)

/datum/equipment_preset/colonist/security/guard/co/load_gear(mob/living/carbon/human/new_human)

	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel/rto, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/guard, WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beret/marine, WEAR_HEAD)
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/boilersuit/khaki, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/ranks/marine/o1, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/ua, WEAR_ACCESSORY)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/guard, WEAR_JACKET)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/m4a3/full, WEAR_WAIST)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/civilian/knife, WEAR_FEET)
	add_worker_gloves(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m20a, WEAR_J_STORE)
	//storage
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars, WEAR_IN_BACK)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m20a, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m20a, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m20a, WEAR_IN_R_STORE)

/datum/equipment_preset/colonist/security/guard/co/spanish
	name = "LatAm Colonial Guard Officer"
	ethnicity = LATIN_AMERICAN_ETHNICITY
	languages = list(LANGUAGE_SPANISH)

/datum/equipment_preset/colonist/security/guard/co/brazilian
	name = "Brazilian Colonial Guard Officer"
	ethnicity = BRAZILIAN_ETHNICITY
	languages = list(LANGUAGE_PORTUGUESE)

/datum/equipment_preset/colonist/security/guard/co/brazilian/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/boilersuit/khaki, WEAR_BODY)
	new_human.equip_to_slot(new /obj/item/clothing/accessory/patch/cmb/brazil_police, WEAR_ACCESSORY)
	..()

#undef AMERICAN_ETHNICITY
#undef LATIN_AMERICAN_ETHNICITY
#undef JAPANESE_ETHNICITY
#undef BRAZILIAN_ETHNICITY
