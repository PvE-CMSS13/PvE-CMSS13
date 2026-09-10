
/obj/item/clothing/gloves/marine
	name = "combat gloves"
	desc = "A pair of black combat gloves. Both insulated from electrical currents and capable of shrugging off shrapnel, the only downside is how sweaty your hands'll be from wearing them all the time."
	icon_state = "black"
	item_state = "black"
	siemens_coefficient = 0
	permeability_coefficient = 0.05
	flags_cold_protection = BODY_FLAG_HANDS
	flags_heat_protection = BODY_FLAG_HANDS
	min_cold_protection_temperature = GLOVES_MIN_COLD_PROT
	max_heat_protection_temperature = GLOVES_MAX_HEAT_PROT
	flags_armor_protection = BODY_FLAG_HANDS
	armor_melee = CLOTHING_ARMOR_MEDIUM
	armor_bullet = CLOTHING_ARMOR_MEDIUM
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_MEDIUM

/obj/item/clothing/gloves/marine/fingerless
	name = "fingerless combat gloves"
	desc = "A pair of black combat gloves with the finger coverings cut off. No longer insulated from electrical shocks, nor wholly capable of protecting from shrapnel, at least your hands won't be quiet as sweaty all the time now though."
	icon_state = "black_fingerless"
	item_state = "black_fingerless"
	siemens_coefficient = 1
	permeability_coefficient = 1

/obj/item/clothing/gloves/marine/brown
	name = "combat gloves"
	desc = "A pair of brown combat gloves. Both insulated from electrical currents and capable of shrugging off shrapnel, the only downside is how sweaty your hands'll be from wearing them all the time."
	icon_state = "brown"
	item_state = "brown"

/obj/item/clothing/gloves/marine/brown/fingerless
	name = "fingerless combat gloves"
	desc = "A pair of brown combat gloves with the finger coverings cut off. No longer insulated from electrical shocks, nor wholly capable of protecting from shrapnel, at least your hands won't be quiet as sweaty all the time now though."
	icon_state = "brown_fingerless"
	item_state = "brown_fingerless"
	siemens_coefficient = 1
	permeability_coefficient = 1

/obj/item/clothing/gloves/marine/specialist
	name = "\improper B18 defensive gauntlets"
	desc = "A pair of heavily armored gloves."
	icon_state = "black"
	item_state = "bgloves"
	armor_melee = CLOTHING_ARMOR_VERYHIGH
	armor_bullet = CLOTHING_ARMOR_ULTRAHIGH
	armor_laser = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bomb = CLOTHING_ARMOR_ULTRAHIGH
	armor_rad = CLOTHING_ARMOR_ULTRAHIGH
	armor_internaldamage = CLOTHING_ARMOR_ULTRAHIGH
	unacidable = TRUE

/obj/item/clothing/gloves/marine/M3G
	name = "\improper M3-G4 Grenadier gloves"
	desc = "A pair of plated, but nimble, gloves."
	icon_state = "grenadier"
	item_state = "grenadier"
	armor_melee = CLOTHING_ARMOR_VERYHIGH
	armor_bullet = CLOTHING_ARMOR_VERYHIGH
	armor_laser = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bomb = CLOTHING_ARMOR_ULTRAHIGH
	armor_rad = CLOTHING_ARMOR_VERYHIGH
	armor_internaldamage = CLOTHING_ARMOR_VERYHIGH
	unacidable = TRUE
	flags_item = NO_CRYO_STORE

/obj/item/clothing/gloves/marine/pve_mopp
	name = "\improper M2 MOPP gloves"
	desc = "M2 MOPP gloves to protect your insides from nerve gas and deadly chemicals. You'd probably feel safer if there was duct tape wrapped around these."
	icon_state = "cbrn"
	item_state = "cbrn"

/obj/item/clothing/gloves/marine/veteran/pmc/commando
	name = "\improper M5X gauntlets"
	desc = "A pair of heavily armored gloves made to complete the M5X exoskeleton armor"
	icon_state = "gauntlets"
	item_state = "bgloves"
	siemens_coefficient = 0
	armor_melee = CLOTHING_ARMOR_VERYHIGH
	armor_bullet = CLOTHING_ARMOR_ULTRAHIGH
	armor_laser = CLOTHING_ARMOR_MEDIUMHIGH
	armor_energy = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bomb = CLOTHING_ARMOR_ULTRAHIGH
	armor_rad = CLOTHING_ARMOR_ULTRAHIGH
	armor_internaldamage = CLOTHING_ARMOR_ULTRAHIGH
	unacidable = TRUE

/obj/item/clothing/gloves/marine/dress
	name = "dress gloves"
	desc = "A pair of fashionable white gloves, worn by marines in dress."
	icon_state = "white"
	item_state = "marine_white"

/obj/item/clothing/gloves/marine/veteran/souto
	name = "\improper Souto Man gloves"
	desc = "The gloves worn by Souto Man. A grip stronger than the taste of Souto Cherry!"
	icon_state = "souto_man"
	item_state = "souto_man"
	flags_inventory = CANTSTRIP
	armor_melee = CLOTHING_ARMOR_HARDCORE
	armor_bullet = CLOTHING_ARMOR_HARDCORE
	armor_laser = CLOTHING_ARMOR_HARDCORE
	armor_energy = CLOTHING_ARMOR_HARDCORE
	armor_bomb = CLOTHING_ARMOR_HARDCORE
	armor_bio = CLOTHING_ARMOR_HARDCORE
	armor_rad = CLOTHING_ARMOR_HARDCORE
	armor_internaldamage = CLOTHING_ARMOR_HARDCORE
	unacidable = TRUE

/obj/item/clothing/gloves/marine/veteran/insulated/van_bandolier
	name = "custom shooting gloves"
	desc = "Highly protective against injury, temperature, and electric shock. Cool in the summer, warm in the winter, and a secure grip on any surface. You could buy a lot for the price of these, and they're worth every penny."

/obj/item/clothing/gloves/marine/joe
	name = "Seegson hazardous gloves"
	desc = "Special Synthetic gloves made for touching and interacting with extremely hazardous materials. Resistant to biohazard liquids, corrosive materials and more. SEEGSON is proudly displayed on the back, along with a biohazard symbol. Tomorrow, Together."
	icon_state = "working_joe"
	item_state = "working_joe"
	siemens_coefficient = 0
	armor_melee = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_MEDIUM
	armor_bomb = CLOTHING_ARMOR_MEDIUM
	armor_bio = CLOTHING_ARMOR_VERYHIGH
	armor_rad = CLOTHING_ARMOR_VERYHIGH
	armor_internaldamage = CLOTHING_ARMOR_MEDIUM
	unacidable = TRUE

/obj/item/clothing/gloves/marine/veteran/cbrn
	name = "\improper M3 MOPP gloves"
	desc = "M3 MOPP gloves are made of treated venlar designed to protect the user’s hands against contamination whilst working in CBRN environments. Special care has been taken to give the user’s hands enough dexterity to fully service a rifle or utilize most handheld tools, while circular adhesive patterns on the fingers provide the user with enhanced grips. Standard CBRN protocol dictates that the gloves are expected to have a lifespan of maximum effectiveness of around twenty-four hours once exposed to moderate levels of contamination and that users are recommended to discard and replace them afterwards."
	icon_state = "cbrn"
	item_state = "cbrn"
	armor_bio = CLOTHING_ARMOR_GIGAHIGHPLUS
	armor_rad = CLOTHING_ARMOR_GIGAHIGHPLUS
