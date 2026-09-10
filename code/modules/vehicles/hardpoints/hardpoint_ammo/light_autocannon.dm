/obj/item/ammo_magazine/hardpoint/light_autocannon
	name = "L29A2 75mm Light Autocannon Magazine"
	desc = "A 150 round magazine holding 70mm telescoped shells for the L29A2 light autocannon."
	caliber = "75mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/twe_ammo.dmi'
	icon_state = "light_autocannon_1"
	w_class = SIZE_LARGE
	default_ammo = /datum/ammo/bullet/tank/flak/light
	max_rounds = 150
	gun_type = /obj/item/hardpoint/primary/autocannon/twe_tank

/obj/item/ammo_magazine/hardpoint/light_autocannon/update_icon()
	if(current_rounds > 0)
		icon_state = "light_autocannon_1"
	else
		icon_state = "light_autocannon_0"
