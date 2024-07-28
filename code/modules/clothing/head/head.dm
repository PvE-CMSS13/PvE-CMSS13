#define HAT_GARB_RELAY_ICON_STATE "icon_state"
/obj/item/clothing/head
	name = "head"
	icon = 'icons/obj/items/clothing/hats.dmi'
	flags_armor_protection = BODY_FLAG_HEAD
	flags_equip_slot = SLOT_HEAD
	w_class = SIZE_SMALL
	blood_overlay_type = "helmet"
	var/anti_hug = 0

/obj/item/clothing/head/update_clothing_icon()
	if (ismob(src.loc))
		var/mob/M = src.loc
		M.update_inv_head()

/obj/item/clothing/head/proc/has_garb_overlay()
	return FALSE

/obj/item/clothing/head/cmbandana
	name = "bandana"
	desc = "Typically worn by heavy-weapon operators, mercenaries and scouts, the bandana serves as a lightweight and comfortable hat. Comes in two stylish colors."
	icon = 'icons/obj/items/clothing/cm_hats.dmi'
	icon_state = "band"
	flags_inv_hide = HIDETOPHAIR
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/head_1.dmi'
	)

/obj/item/clothing/head/cmbandana/tan
	icon_state = "band2"


/obj/item/clothing/head/beanie
	name = "beanie"
	desc = "A standard military beanie, often worn by non-combat military personnel and support crews, though it is not uncommon to see combat personnel who no longer care about self-preservation wearing one of these as well. Popular due to being comfortable and snug."
	icon = 'icons/obj/items/clothing/cm_hats.dmi'
	icon_state = "beanie_cargo"
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/head_1.dmi'
	)

/obj/item/clothing/head/beanie/green
	icon_state = "beaniegreen"

/obj/item/clothing/head/beanie/gray
	icon_state = "beaniegray"

/obj/item/clothing/head/beanie/tan
	icon_state = "beanietan"

/obj/item/clothing/head/headband
	name = "headband"
	desc = "A rag typically worn by the less-orthodox weapons operators. While it offers no protection, it is certainly comfortable to wear compared to the standard helmet. Comes in two stylish colors."
	icon = 'icons/obj/items/clothing/cm_hats.dmi'
	icon_state = "headband"
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/head_1.dmi'
	)
	flags_obj = OBJ_NO_HELMET_BAND|OBJ_IS_HELMET_GARB

/obj/item/clothing/head/headband/Initialize(mapload, ...)
	. = ..()
	select_gamemode_skin(/obj/item/clothing/head/headband)

/obj/item/clothing/head/headband/red
	icon_state = "headbandred"

/obj/item/clothing/head/headband/tan
	icon_state = "headbandtan"

/obj/item/clothing/head/headband/brown
	icon_state = "headbandbrown"

/obj/item/clothing/head/headband/gray
	icon_state = "headbandgray"

/obj/item/clothing/head/headband/rebel
	desc = "A headband made from a simple strip of cloth. The words \"DOWN WITH TYRANTS\" are emblazoned on the front."
	icon_state = "rebelband"

/obj/item/clothing/head/headband/alpha
	desc = "A bright red headband made out of durable cloth. it seems brand new, yet to see any wear"
	icon_state = "headbandalpha"

/obj/item/clothing/head/headband/bravo
	desc = "An orangish yellow headband made out of durable cloth. this one stained with sweat and dust from manual labor"
	icon_state = "headbandbravo"

/obj/item/clothing/head/headband/charlie
	desc = "A purple headband made out of durable cloth. this one smells of jealousy and breakfast"
	icon_state = "headbandcharlie"

/obj/item/clothing/head/headband/delta
	desc = "A blue headband made out of durable cloth. just wearing it makes you want to recklessly charge the enemy"
	icon_state = "headbanddelta"

/obj/item/clothing/head/headband/echo
	desc = "A sea green headband made out of durable cloth. its color has been washed out from many long sneaking missions and raids behind enemy lines"
	icon_state = "headbandecho"

/obj/item/clothing/head/headband/foxtrot
	desc = "A brown headband made out of durable cloth. it is still cold to the touch from years of cryosleep"
	icon_state = "headbandfoxtrot"

/obj/item/clothing/head/headband/intel
	desc = "A black headband made out of durable cloth. wearing this makes you feel like a secret agent."
	icon_state = "headbandintel"

/obj/item/clothing/head/headband/rambo
	desc = "It flutters in the face of the wind, defiant and unrestrained, like the man who wears it."
	icon = 'icons/obj/items/clothing/hats.dmi'
	icon_state = "headband_rambo"
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/head-layer/head_0.dmi'
	)

/obj/item/clothing/head/headset
	name = "\improper USCM headset"
	desc = "A headset typically found in use by radio-operators and officers. This one appears to be malfunctioning."
	icon_state = "headset"
	icon = 'icons/obj/items/clothing/cm_hats.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/head_1.dmi'
	)

/obj/item/clothing/head/cmcap
	name = "patrol cap"
	desc = "A comfortable patrol cap. It offers no defensive properties."
	icon_state = "cap"
	icon = 'icons/obj/items/clothing/cm_hats.dmi'
	var/helmet_overlays[]
	var/flipped_cap = FALSE
	var/list/flipping_message = list(
		"flipped" = "You spin the hat backwards! You look like a tool.",
		"unflipped" = "You spin the hat back forwards. That's better."
		)
	var/base_cap_icon
	var/flags_marine_hat = HAT_GARB_OVERLAY|HAT_CAN_FLIP
	var/obj/item/storage/internal/headgear/pockets
	var/list/allowed_hat_items = list(
						/obj/item/storage/fancy/cigarettes/emeraldgreen = "hat_cig_cig",
						/obj/item/storage/fancy/cigarettes/kpack = "hat_cig_kpack",
						/obj/item/storage/fancy/cigarettes/lucky_strikes = "hat_cig_ls",
						/obj/item/storage/fancy/cigarettes/wypacket = "hat_cig_wypack",
						/obj/item/storage/fancy/cigarettes/lady_finger = "hat_cig_lf",
						/obj/item/storage/fancy/cigarettes/blackpack = "hat_cig_blackpack",
						/obj/item/storage/fancy/cigarettes/arcturian_ace = "hat_cig_aapack",
						/obj/item/tool/pen = "hat_pen_black",
						/obj/item/tool/pen/blue = "hat_pen_blue",
						/obj/item/tool/pen/red = "hat_pen_red",
						/obj/item/clothing/glasses/welding = "welding-c",
						/obj/item/clothing/glasses/mgoggles = HAT_GARB_RELAY_ICON_STATE,
						/obj/item/clothing/glasses/mgoggles/prescription = HAT_GARB_RELAY_ICON_STATE,
						/obj/item/clothing/glasses/mgoggles/black = HAT_GARB_RELAY_ICON_STATE,
						/obj/item/clothing/glasses/mgoggles/orange = HAT_GARB_RELAY_ICON_STATE,
						/obj/item/clothing/glasses/mgoggles/v2 = HAT_GARB_RELAY_ICON_STATE,
						/obj/item/prop/helmetgarb/helmet_nvg = HAT_GARB_RELAY_ICON_STATE,
						/obj/item/prop/helmetgarb/helmet_nvg/cosmetic = HAT_GARB_RELAY_ICON_STATE,
						/obj/item/prop/helmetgarb/helmet_nvg/marsoc = HAT_GARB_RELAY_ICON_STATE,
						/obj/item/clothing/head/headband = "hat_headbandgreen",
						/obj/item/clothing/head/headband/tan = "hat_headbandtan",
						/obj/item/clothing/head/headband/red = "hat_headbandred",
						/obj/item/clothing/head/headband/brown = "hat_headbandbrown",
						/obj/item/clothing/head/headband/gray = "hat_headbandgray",
						/obj/item/clothing/head/headband/alpha = "hat_headbandalpha",
						/obj/item/clothing/head/headband/bravo = "hat_headbandbravo",
						/obj/item/clothing/head/headband/charlie = "hat_headbandcharlie",
						/obj/item/clothing/head/headband/delta = "hat_headbanddelta",
						/obj/item/clothing/head/headband/echo = "hat_headbandecho",
						/obj/item/clothing/head/headband/foxtrot = "hat_headbandfoxtrot",
						/obj/item/clothing/head/headband/foxtrot = "hat_headbandintel",
						/obj/item/prop/helmetgarb/lucky_feather = "lucky_feather",
						/obj/item/prop/helmetgarb/lucky_feather/blue = "lucky_feather_blue",
						/obj/item/prop/helmetgarb/lucky_feather/purple = "lucky_feather_purple",
						/obj/item/prop/helmetgarb/lucky_feather/yellow = "lucky_feather_yellow",
						/obj/item/tool/pen/fountain = "fountainpen",
						)
	var/storage_slots = 1
	var/storage_slots_reserved_for_garb = 1
	var/storage_max_w_class = SIZE_TINY
	var/storage_max_storage_space = 4
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/head_1.dmi'
	)

/obj/item/clothing/head/cmcap/Initialize(mapload, ...)
	. = ..()
	if(!(flags_atom & NO_SNOW_TYPE))
		select_gamemode_skin(type)
	base_cap_icon = icon_state
	helmet_overlays = list("item") //To make things simple.

	pockets = new(src)
	pockets.storage_slots = storage_slots + storage_slots_reserved_for_garb
	pockets.slots_reserved_for_garb = storage_slots_reserved_for_garb
	pockets.max_w_class = storage_max_w_class
	pockets.bypass_w_limit = allowed_hat_items
	pockets.max_storage_space = storage_max_storage_space

/obj/item/clothing/head/cmcap/attack_hand(mob/user)
	if(loc != user)
		..(user)
		return
	if(pockets.handle_attack_hand(user))
		..()

/obj/item/clothing/head/cmcap/MouseDrop(over_object, src_location, over_location)
	if(pockets.handle_mousedrop(usr, over_object))
		..()

/obj/item/clothing/head/cmcap/attackby(obj/item/W, mob/user)
	..()
	return pockets.attackby(W, user)

/obj/item/clothing/head/cmcap/on_pocket_insertion()
	update_icon()

/obj/item/clothing/head/cmcap/on_pocket_removal()
	update_icon()

/obj/item/clothing/head/cmcap/update_icon()
	if(ismob(loc))
		var/mob/M = loc
		M.update_inv_head()

/obj/item/clothing/head/cmcap/get_mob_overlay(mob/user_mob, slot)
	var/image/return_image = ..()
	if(slot != WEAR_HEAD)
		return return_image

	if(length(pockets.contents) && (flags_marine_hat & HAT_GARB_OVERLAY))
		for(var/obj/garb_object in pockets.contents)
			if(garb_object.type in allowed_hat_items)
				var/garb_state = allowed_hat_items[garb_object.type]
				if(garb_state == HAT_GARB_RELAY_ICON_STATE)
					garb_state = "hat_[garb_object.icon_state]"
				var/image/garb_image = overlay_image('icons/mob/humans/onmob/helmet_garb.dmi', "[garb_state]", color, RESET_COLOR)
				return_image.overlays += garb_image

	return return_image

/obj/item/clothing/head/cmcap/has_garb_overlay()
	return flags_marine_hat & HAT_GARB_OVERLAY

/obj/item/clothing/head/cmcap/verb/fliphat()
	set name = "Flip hat"
	set category = "Object"
	set src in usr
	if(!isliving(usr))
		return
	if(usr.is_mob_incapacitated())
		return
	if(!(flags_marine_hat & HAT_CAN_FLIP))
		to_chat(usr, SPAN_WARNING("[src] can't be flipped!"))
		return

	flags_marine_hat ^= HAT_FLIPPED

	if(flags_marine_hat & HAT_FLIPPED)
		to_chat(usr, flipping_message["flipped"])
		icon_state = base_cap_icon + "_b"
	else
		to_chat(usr, flipping_message["unflipped"])
		icon_state = base_cap_icon

	update_clothing_icon()

/obj/item/clothing/head/cmcap/khaki
	name = "patrol cap"
	desc = "A comfortable khaki patrol cap. It offers no defensive properties."
	icon_state = "rocap"
	flags_atom = NO_SNOW_TYPE

/obj/item/clothing/head/cmcap/bridge
	name = "\improper USCM officer cap"
	desc = "A hat usually worn by officers in the USCM. While it provides no protection, some officers wear it in the field to make themselves more recognisable."
	icon_state = "cap_officer"

/obj/item/clothing/head/cmcap/flap
	name = "\improper USCM expedition cap"
	desc = "It's a cap, with flaps. A patch stitched across the front reads \"<b>USS ALMAYER</b>\"."
	icon = 'icons/obj/items/clothing/cm_hats.dmi'
	icon_state = "flapcap"
	flags_marine_hat = HAT_GARB_OVERLAY

/obj/item/clothing/head/cmcap/reporter
	name = "combat correspondent cap"
	desc = "A faithful cap for any terrain war correspondents may find themselves in."
	icon = 'icons/mob/humans/onmob/contained/war_correspondent.dmi'
	icon_state = "wc_flagcap"
	item_state = "wc_flagcap"
	contained_sprite = TRUE
	flags_atom = NO_SNOW_TYPE|NO_NAME_OVERRIDE
	flags_marine_hat = HAT_GARB_OVERLAY

/obj/item/clothing/head/cmcap/boonie
	name = "\improper USCM boonie hat"
	desc = "A floppy bush hat. Protects only from the sun and rain, but very comfortable."
	icon_state = "booniehat"
	flipping_message = list(
		"flipped" = "You tuck the hat's chinstrap away. Hopefully the wind doesn't nick it...",
		"unflipped" = "You hook the hat's chinstrap under your chin. Peace of mind is worth a little embarassment."
		)

/obj/item/clothing/head/cmcap/boonie/tan
	icon_state = "booniehattan"
	flags_atom = FPRINT|NO_SNOW_TYPE

/obj/item/clothing/head/marine/peaked
	name = "\improper USCM service cap"
	desc = "A USCM service uniform peaked cap."
	icon = 'icons/mob/humans/onmob/head-layer/head_marine.dmi'
	icon_state = "marine_service"
	item_icons = "marine_service"
//==========================//PROTECTIVE\\===============================\\
//=======================================================================\\

/obj/item/clothing/head/ushanka
	name = "ushanka"
	desc = "Perfect for winter in Siberia, da?"
	icon_state = "ushankadown"
	item_state = "ushankadown"
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_MEDIUMLOW
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_MEDIUMLOW
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW
	flags_cold_protection = BODY_FLAG_HEAD
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS

/obj/item/clothing/head/ushanka/attack_self(mob/user)
	..()

	if(src.icon_state == "ushankadown")
		src.icon_state = "ushankaup"
		src.item_state = "ushankaup"
		to_chat(user, "You raise the ear flaps on the ushanka.")
	else
		src.icon_state = "ushankadown"
		src.item_state = "ushankadown"
		to_chat(user, "You lower the ear flaps on the ushanka.")


/obj/item/clothing/head/bearpelt
	name = "bear pelt hat"
	desc = "Fuzzy."
	icon_state = "bearpelt"
	siemens_coefficient = 2
	flags_armor_protection = BODY_FLAG_HEAD|BODY_FLAG_CHEST|BODY_FLAG_ARMS
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_MEDIUMLOW
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_MEDIUMLOW
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW
	flags_cold_protection = BODY_FLAG_HEAD|BODY_FLAG_CHEST|BODY_FLAG_ARMS
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS|HIDETOPHAIR

/obj/item/clothing/head/ivanberet
	name = "\improper Black Beret"
	desc = "Worn by officers of special units."
	icon = 'icons/obj/items/clothing/cm_hats.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/head_1.dmi'
	)
	icon_state = "ivan_beret"
	item_state = "ivan_beret"
	siemens_coefficient = 2
	flags_armor_protection = BODY_FLAG_HEAD
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_MEDIUMLOW
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_MEDIUMLOW
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW
	flags_cold_protection = BODY_FLAG_HEAD
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	flags_inventory = COVEREYES|COVERMOUTH|BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS

/obj/item/clothing/head/CMB
	name = "\improper Colonial Marshal Bureau cap"
	desc = "A dark cap enscribed with the powerful letters of 'MARSHAL' representing justice, authority, and protection in the outer rim. The laws of the Earth stretch beyond the Sol."
	icon = 'icons/obj/items/clothing/cm_hats.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/head_1.dmi'
	)
	icon_state = "cmbcap"
	flags_armor_protection = BODY_FLAG_HEAD
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_MEDIUMLOW
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW
	flags_cold_protection = BODY_FLAG_HEAD
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = NO_FLAGS

/obj/item/clothing/head/freelancer
	name = "\improper armored Freelancer cap"
	desc = "A sturdy freelancer's cap. More protective than it seems."
	icon = 'icons/obj/items/clothing/cm_hats.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/head_1.dmi'
	)
	icon_state = "freelancer_cap"
	siemens_coefficient = 2
	flags_armor_protection = BODY_FLAG_HEAD
	armor_melee = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bullet = CLOTHING_ARMOR_MEDIUMHIGH
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUM
	flags_cold_protection = BODY_FLAG_HEAD
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS

/obj/item/clothing/head/freelancer/beret
	name = "\improper armored Freelancer beret"
	icon_state = "freelancer_beret"

/obj/item/clothing/head/militia
	name = "\improper armored militia cowl"
	desc = "A large hood in service with some militias, meant for obscurity on the frontier. Offers some head protection due to the study fibers utilized in production."
	icon = 'icons/obj/items/clothing/cm_hats.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/head_1.dmi'
	)
	icon_state = "rebel_hood"
	siemens_coefficient = 2
	flags_armor_protection = BODY_FLAG_HEAD|BODY_FLAG_CHEST
	armor_melee = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bullet = CLOTHING_ARMOR_MEDIUMLOW
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUM
	flags_cold_protection = BODY_FLAG_HEAD
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS|HIDETOPHAIR

/obj/item/clothing/head/militia/bucket
	name = "bucket"
	desc = "This metal bucket appears to have been modified with padding and chin-straps, plus an eye-slit carved into the \"front\". Presumably, it is intended to be worn on the head, possibly for protection."
	icon_state = "bucket"

/obj/item/clothing/head/general
	name = "\improper armored General cap"
	desc = "A sturdy general officer's cap. More protective than it seems. Please don't ditch this for a helmet like a punk."
	icon_state = "general_helmet"
	siemens_coefficient = 2
	flags_armor_protection = BODY_FLAG_HEAD
	armor_melee = CLOTHING_ARMOR_HIGH
	armor_bullet = CLOTHING_ARMOR_HIGH
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_MEDIUM
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_HIGH
	flags_cold_protection = BODY_FLAG_HEAD
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS

/obj/item/clothing/head/durag
	name = "durag"
	desc = "An improvised head wrap made out of a standard issue neckerchief. Great for keeping the sweat out of your eyes and protecting your hair."
	icon_state = "durag"
	icon = 'icons/obj/items/clothing/cm_hats.dmi'
	flags_inv_hide = HIDETOPHAIR
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/head_1.dmi'
	)

/obj/item/clothing/head/durag/black
	icon_state = "duragblack"
	desc = "An improvised head wrap made out of a black neckerchief. Great for keeping the sweat out of your eyes and protecting your hair."
	icon = 'icons/obj/items/clothing/cm_hats.dmi'
	flags_atom = NO_SNOW_TYPE

/obj/item/clothing/head/durag/Initialize(mapload, ...)
	. = ..()
	select_gamemode_skin(/obj/item/clothing/head/durag)

/obj/item/clothing/head/drillhat
	name = "\improper USCM drill hat"
	desc = "A formal hat worn by drill instructors. Police that moustache."
	icon_state = "drillhat"
	icon = 'icons/obj/items/clothing/cm_hats.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/head_1.dmi'
	)

#undef HAT_GARB_RELAY_ICON_STATE

//==========================//DRESS BLUES\\===============================\\
//=======================================================================\\

/obj/item/clothing/head/marine/dress_cover
	name = "marine dress blues cover"
	desc = "The combination cover of the legendary Marine dress blues, virtually unchanged since the 19th century. The polished logo sits proudly on the white cloth."
	icon = 'icons/mob/humans/onmob/head-layer/head_marine.dmi'
	icon_state = "e_cap"
	item_state = "e_cap"
	contained_sprite = TRUE

/obj/item/clothing/head/marine/dress_cover/officer
	name = "marine dress blues officer cover"
	desc = "The combination cover of the legendary Marine dress blues, virtually unchanged since the 19th century. Features a gold stripe and silvered logo, emblematic of an officer."
	icon_state = "o_cap"
	item_state = "o_cap"

/obj/item/clothing/head/owlf_hood
	name = "\improper OWLF thermal hood"
	desc = "This hood is attached to a high-tech suit with built-in thermal cloaking technology."
	icon = 'icons/obj/items/clothing/cm_hats.dmi'
	icon_state = "owlf_hood"
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/head-layer/head_marine.dmi'
	)
	item_state = "owlf_hood"


//=ROYAL MARINES=\\

/obj/item/clothing/head/beanie/royal_marine
	name = "royal marine beanie"
	desc = "A standard military beanie."
	icon_state = "rmc_beanie"
	item_state = "rmc_beanie"
	icon = 'icons/obj/items/clothing/cm_hats.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/head_1.dmi'
	)

/obj/item/clothing/head/beanie/royal_marine/turban
	name = "royal marine turban"
	desc = "A standard military turban found in the royal marines. Considered a rare item, these kind of turbans are prized by collectors in the UA."
	icon_state = "rmc_turban"
	item_state = "rmc_turban"

/obj/item/clothing/head/beret/royal_marine
	name = "royal marine beret"
	desc = "A green beret belonging to the royal marines commando. This beret symbolizes a royal marines ability to fight in any environment, desert, sea, artic or space a royal marine will always be ready."
	icon_state = "rmc_beret"
	item_state = "rmc_beret"
	icon = 'icons/obj/items/clothing/cm_hats.dmi'
	flags_atom = NO_NAME_OVERRIDE|NO_SNOW_TYPE
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/head_1.dmi'
	)

/obj/item/clothing/head/beret/royal_marine/team_leader
	icon_state = "rmc_beret_tl"
	item_state = "rmc_beret_tl"
