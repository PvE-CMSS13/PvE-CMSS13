/obj/item/ammo_magazine/hardpoint/plasmacannon
	name = "PARS 177 magazine"
	desc = "A shielded cylindrical magazine for the Ridgeway Heavy Tank's point-defence plasma cannon, carries 3 2.4g Cadmium-Telluride pellets. Power is provided by a 7mW hydrogen fuel cell within the turret allows for 2500 firings."
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/uscm.dmi'
	caliber = "93mm" //Making this unique on purpose
	icon_state = "plasmacannon_3"
	w_class = SIZE_LARGE //Heavy
	default_ammo = /datum/ammo/energy/plasma
	max_rounds = 3
	gun_type = /obj/item/hardpoint/primary/cannon/plasmacannon

/obj/item/ammo_magazine/hardpoint/plasmacannon/update_icon()
	icon_state = "plasmacannon_[current_rounds]"

