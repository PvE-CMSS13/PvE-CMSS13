/obj/item/clothing/under/vai
	contained_sprite = TRUE
	icon = 'icons/mob/humans/onmob/contained/vai.dmi'
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_MEDIUMLOW
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW
	flags_jumpsuit = UNIFORM_SLEEVE_ROLLABLE
	flags_atom = NO_SNOW_TYPE|NO_NAME_OVERRIDE

/obj/item/clothing/under/vai/plaid
	name = "\improper Plaid shirt and denim pants"
	desc = "A simple outfit composed of a plaid shirt and denim jeans, favored by lumberjacks and private contractors."
	flags_jumpsuit = UNIFORM_SLEEVE_ROLLABLE|UNIFORM_JACKET_REMOVABLE
	icon_state = "plaid"
	worn_state = "plaid"

/obj/item/clothing/under/vai/flower
	name = "\improper Blue Hawaiian shirt and khaki cargo pants"
	desc = "A simple outfit composed of a Blue Hawaiian shirt and khaki cargo pants, favored by dads and private contractors."
	icon_state = "blueflower"
	worn_state = "blueflower"

/obj/item/clothing/under/vai/flower/green
	name = "\improper Green Hawaiian shirt and denim pants"
	desc = "A simple outfit composed of a Green Hawaiian shirt which depicts palms and denim jeans, favored by tourists and private contractors."
	icon_state = "greenflower"
	worn_state = "greenflower"

/obj/item/clothing/head/helmet/marine/covert/vai
	name = "\improper M09 Custom Helmet"
	desc = "Partially due to old stocks, partially due to preference. USCM MARSOC commando ballistic helmet, customized and updated to mission requirements."
	icon_state = "marsoc_helmet"
	icon = 'icons/mob/humans/onmob/contained/vai.dmi'
	contained_sprite = TRUE
	armor_melee = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bullet = CLOTHING_ARMOR_HIGH
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_MEDIUMHIGH
	flags_atom = NO_NAME_OVERRIDE
	built_in_visors = list(new /obj/item/device/helmet_visor/night_vision/marine_raider, new /obj/item/device/helmet_visor/security)
	start_down_visor_type = /obj/item/device/helmet_visor/night_vision/marine_raider