/* Closets for specific jobs
 * Contains:
 * Bartender
 * Janitor
 * Lawyer
 */

/*
 * Bartender
 */
/obj/structure/closet/gmcloset
	name = "formal closet"
	desc = "It's a storage unit for formal clothing."
	icon_state = "black"
	icon_closed = "black"

/obj/structure/closet/gmcloset/Initialize()
	. = ..()
	new /obj/item/clothing/head/that(src)
	new /obj/item/clothing/head/that(src)
	new /obj/item/clothing/head/hairflower
	new /obj/item/clothing/under/sl_suit(src)
	new /obj/item/clothing/under/sl_suit(src)
	new /obj/item/clothing/under/rank/bartender(src)
	new /obj/item/clothing/under/rank/bartender(src)
	new /obj/item/clothing/suit/storage/wcoat(src)
	new /obj/item/clothing/suit/storage/wcoat(src)
	new /obj/item/clothing/shoes/black(src)
	new /obj/item/clothing/shoes/black(src)

/*
 * Janitor
 */
/obj/structure/closet/jcloset
	name = "custodial closet"
	desc = "It's a storage unit for janitorial clothes and gear."
	icon_state = "purple"
	icon_closed = "purple"
	icon_opened = "purple_open"

/obj/structure/closet/jcloset/Initialize()
	. = ..()
	new /obj/item/clothing/under/rank/janitor(src)
	new /obj/item/clothing/gloves/black(src)
	new /obj/item/clothing/head/soft/purple(src)
	new /obj/item/clothing/head/beret/jan(src)
	new /obj/item/device/flashlight(src)
	new /obj/item/tool/wet_sign(src)
	new /obj/item/tool/wet_sign(src)
	new /obj/item/tool/wet_sign(src)
	new /obj/item/tool/wet_sign(src)
	new /obj/item/device/lightreplacer(src)
	new /obj/item/storage/bag/trash(src)
	new /obj/item/clothing/shoes/galoshes(src)

/*
 * Lawyer
 */
/obj/structure/closet/lawcloset
	name = "legal closet"
	desc = "It's a storage unit for courtroom apparel and items."
	icon_state = "blue"
	icon_closed = "blue"
	icon_opened = "blue_open"

/obj/structure/closet/lawcloset/Initialize()
	. = ..()
	new /obj/item/clothing/under/lawyer/female(src)
	new /obj/item/clothing/under/lawyer/black(src)
	new /obj/item/clothing/under/lawyer/red(src)
	new /obj/item/clothing/under/lawyer/bluesuit(src)
	new /obj/item/clothing/suit/storage/lawyer/bluejacket(src)
	new /obj/item/clothing/under/lawyer/purpsuit(src)
	new /obj/item/clothing/suit/storage/lawyer/purpjacket(src)
	new /obj/item/clothing/shoes/brown(src)
	new /obj/item/clothing/shoes/black(src)

/obj/structure/closet/secure_closet/platoon_sergeant
	name = "platoon sergeant locker"
	desc = "A secure storage unit for the platoon sergeant."
	req_one_access = list(ACCESS_MARINE_LEADER)

/obj/structure/closet/secure_closet/platoon_sergeant/Initialize()
	. = ..()
	new /obj/item/weapon/gun/rifle/m41aMK1(src)
	new /obj/item/ammo_magazine/rifle/m41aMK1(src)
	new /obj/item/ammo_magazine/rifle/m41aMK1(src)
	new /obj/item/ammo_magazine/rifle/m41aMK1(src)
	new /obj/item/ammo_magazine/rifle/m41aMK1(src)
	new /obj/item/ammo_magazine/rifle/m41aMK1(src)
	new /obj/item/clothing/head/helmet/marine/leader(src)
	new /obj/item/device/binoculars/range/designator(src)
	new /obj/item/device/whistle(src)

/obj/structure/closet/secure_closet/platoon_sergeant_forecon
	name = "squad leader locker"
	desc = "A secure storage unit for the squad leader."
	req_one_access = list(ACCESS_MARINE_LEADER)

/obj/structure/closet/secure_closet/platoon_sergeant_forecon/Initialize()
	. = ..()
	new /obj/item/weapon/gun/rifle/m41aMK1(src)
	new /obj/item/ammo_magazine/rifle/m41aMK1(src)
	new /obj/item/ammo_magazine/rifle/m41aMK1(src)
	new /obj/item/ammo_magazine/rifle/m41aMK1(src)
	new /obj/item/ammo_magazine/rifle/m41aMK1(src)
	new /obj/item/ammo_magazine/rifle/m41aMK1(src)
	new /obj/item/device/binoculars/range/designator(src)
	new /obj/item/device/whistle(src)

/obj/structure/closet/secure_closet/squad_sergeant
	name = "squad sergeant locker"
	desc = "A secure storage unit for a squad sergeant."
	req_one_access = list(ACCESS_MARINE_LEADER, ACCESS_MARINE_TL_PREP)

/obj/structure/closet/secure_closet/squad_sergeant/Initialize()
	. = ..()
	new /obj/item/clothing/head/helmet/marine/rto(src)
	new /obj/item/device/binoculars/range/designator(src)
	new /obj/item/device/whistle(src)

/obj/structure/closet/secure_closet/squad_sergeant_forecon
	name = "assistant squad leader locker"
	desc = "A secure storage unit for an assistant squad leader."
	req_one_access = list(ACCESS_MARINE_LEADER, ACCESS_MARINE_TL_PREP)

/obj/structure/closet/secure_closet/squad_sergeant_forecon/Initialize()
	. = ..()
	new /obj/item/device/binoculars/range/designator(src)
	new /obj/item/device/whistle(src)

/obj/structure/closet/secure_closet/smartgunner
	name = "smartgunner locker"
	desc = "A secure storage unit for a smartgunner."
	req_one_access = list(ACCESS_MARINE_LEADER, ACCESS_MARINE_SMARTPREP)

/obj/structure/closet/secure_closet/smartgunner/Initialize()
	. = ..()
	new /obj/item/weapon/gun/smartgun(src)
	new /obj/item/smartgun_battery(src)
	new /obj/item/clothing/suit/storage/marine/smartgunner(src)
	new /obj/item/ammo_magazine/smartgun(src)
	new /obj/item/ammo_magazine/smartgun(src)
	new /obj/item/ammo_magazine/smartgun(src)
	new /obj/item/ammo_magazine/smartgun(src)
	new /obj/item/storage/belt/marine/smartgunner(src)
	new /obj/item/storage/belt/gun/smartgunner(src)
	new /obj/item/clothing/glasses/night/m56_goggles/no_nightvision(src)

/obj/structure/closet/secure_closet/smartgunner_forecon
	name = "smartgunner locker"
	desc = "A secure storage unit for a smartgunner."
	req_one_access = list(ACCESS_MARINE_LEADER, ACCESS_MARINE_SMARTPREP)

/obj/structure/closet/secure_closet/smartgunner_forecon/Initialize()
	. = ..()
	new /obj/item/weapon/gun/smartgun(src)
	new /obj/item/smartgun_battery(src)
	new /obj/item/clothing/suit/storage/marine/smartgunner/standard(src)
	new /obj/item/ammo_magazine/smartgun(src)
	new /obj/item/ammo_magazine/smartgun(src)
	new /obj/item/ammo_magazine/smartgun(src)
	new /obj/item/ammo_magazine/smartgun(src)
	new /obj/item/storage/belt/marine/smartgunner/standard(src)
	new /obj/item/storage/belt/gun/smartgunner/standard(src)
	new /obj/item/clothing/glasses/night/m56_goggles/no_nightvision(src)

/obj/structure/closet/cryo/Initialize()
	. = ..()
	new /obj/item/clothing/under/marine(src)
	new /obj/item/clothing/under/marine(src)
	new /obj/item/clothing/shoes/marine/knife(src)
	new /obj/item/clothing/shoes/marine/knife(src)
	new /obj/item/device/radio/headset/almayer/marine(src)
	new /obj/item/device/radio/headset/almayer/marine(src)
	new /obj/item/clothing/glasses/night/m56_goggles/no_nightvision(src)
