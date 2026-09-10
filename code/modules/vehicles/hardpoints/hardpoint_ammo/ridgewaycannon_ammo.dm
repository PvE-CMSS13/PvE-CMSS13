/obj/item/ammo_magazine/hardpoint/ridgewaycannon
	name = "115mm magazine"
	desc = "  Magazine for the Ridgeway Heavy Tank's 115mm smoothbore cannon, feeding 6 shells into the autoloader. Lacking integrated propellant and relying on an internal hypergolic tank within the turret, these magazines benefit from high space efficiency and overall safety."
	caliber = "115mm" //Making this unique on purpose
	icon_state = "ridgewaycannon_6"
	w_class = SIZE_LARGE //Heavy fucker
	default_ammo = /datum/ammo/rocket/ltb/ridgeway
	max_rounds = 6
	gun_type = /obj/item/hardpoint/primary/cannon/ridgeway

/obj/item/ammo_magazine/hardpoint/ridgewaycannon/update_icon()
	icon_state = "ridgewaycannon_[current_rounds]"
