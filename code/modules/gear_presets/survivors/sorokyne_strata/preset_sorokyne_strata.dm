/datum/equipment_preset/survivor/engineer/soro
	name = "Survivor - Sorokyne Strata Political Prisioner"
	assignment = "Sorokyne Strata Political Prisioner"
	languages = list(LANGUAGE_ENGLISH, LANGUAGE_RUSSIAN)

/datum/equipment_preset/survivor/engineer/soro/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/UPP(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/upp(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/snow_suit/soviet(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/ushanka(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/rebreather/scarf(new_human), WEAR_FACE)
	..()

/datum/equipment_preset/survivor/security/soro
	name = "Survivor - Sorokyne Strata Security"
	assignment = "Sorokyne Strata Security"
	languages = list(LANGUAGE_ENGLISH, LANGUAGE_RUSSIAN)

/datum/equipment_preset/survivor/security/soro/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/faction/UPP/mp(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/snow_suit/soviet(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/lightpack/upp(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/upp(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/rebreather/scarf(new_human), WEAR_FACE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/uppcap/ushanka(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran/upp(new_human), WEAR_HANDS)
	..()

/datum/equipment_preset/survivor/doctor/soro
	name = "Survivor - Sorokyne Strata Doctor"
	assignment = "Sorokyne Strata Doctor"
	languages = list(LANGUAGE_ENGLISH, LANGUAGE_RUSSIAN)

/datum/equipment_preset/survivor/doctor/soro/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/rank/veteran/soviet_uniform_01(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/snow_suit/survivor(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/ushanka(new_human), WEAR_HEAD)
	..()

/datum/equipment_preset/survivor/scientist/soro
	name = "Survivor - Sorokyne Strata Researcher"
	assignment = "Sorokyne Strata Researcher"
	languages = list(LANGUAGE_ENGLISH, LANGUAGE_RUSSIAN)

/datum/equipment_preset/survivor/scientist/soro/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/rank/medical/blue(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/latex(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/regular(new_human), WEAR_FACE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/tox(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/ushanka(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/black(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/snow_suit/survivor(new_human), WEAR_JACKET)
	..()

/datum/equipment_preset/survivor/interstellar_human_rights_observer/soro
	name = "Survivor - Sorokyne Interstellar Human Rights Observer"
	assignment = "Interstellar Human Rights Observer(Sorokyne)"
	languages = list(LANGUAGE_ENGLISH, LANGUAGE_RUSSIAN, LANGUAGE_CHINESE)


/datum/equipment_preset/survivor/interstellar_human_rights_observer/soro/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/snow_suit/survivor(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/ushanka(new_human), WEAR_HEAD)
	..()
