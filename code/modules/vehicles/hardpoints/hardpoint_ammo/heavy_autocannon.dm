/obj/item/ammo_magazine/hardpoint/heavy_autocannon
	name = "L29A2 45mm Heavy Autocannon Magazine"
	desc = "An 80 round magazine holding 45mm telescoped shells for the L29A2 heavy autocannon."
	caliber = "45mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/twe_ammo.dmi'
	icon_state = "heavy_autocannon_1"
	w_class = SIZE_LARGE
	default_ammo = /datum/ammo/bullet/tank/flak/heavy
	max_rounds = 80
	gun_type = /obj/item/hardpoint/primary/autocannon/twe_tank

/obj/item/ammo_magazine/hardpoint/heavy_autocannon/update_icon()
	if(current_rounds > 0)
		icon_state = "heavy_autocannon_1"
	else
		icon_state = "heavy_autocannon_0"
