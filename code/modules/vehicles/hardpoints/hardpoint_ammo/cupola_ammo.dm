/obj/item/ammo_magazine/hardpoint/m56_cupola
	name = "M56 Cupola Magazine"
	desc = "A box of 500, 10x28mm caseless rounds for the M56 heavy machine gun system."
	caliber = "10x28mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/uscm.dmi'
	icon_state = "cupola_1"
	w_class = SIZE_LARGE
	default_ammo = /datum/ammo/bullet/rifle/heavy/tracer
	max_rounds = 500
	gun_type = /obj/item/hardpoint/secondary/m56cupola

/obj/item/ammo_magazine/hardpoint/m56_cupola/update_icon()
	icon_state = "cupola_[current_rounds <= 0 ? "0" : "1"]"

/obj/item/ammo_magazine/hardpoint/m56_cupola/frontal_cannon
	name = "RE-RE700 Frontal Cannon magazine"
	desc = "A crate of belted caseless munitions for the RE-RE700 rotary cannon system. Lacks propellants, as it's to be used with the binary hypergolic principle."
	caliber = "20mm"
	max_rounds = 1700 //lore-compliant belt quantity
	gun_type = /obj/item/hardpoint/secondary/frontalcannon
	icon_state = "frontal_1"

/obj/item/ammo_magazine/hardpoint/m56_cupola/frontal_cannon/update_icon()
	icon_state = "frontal_[current_rounds <= 0 ? "0" : "1"]"

/obj/item/ammo_magazine/hardpoint/m56_cupola/quad_cannon
	name = "RE-RE965 Aerial-Defence System ammunition box"
	desc = "A crate of belted caseless munitions for the ever-hungry RE-RE965 Aerial-Defence System. Comes loaded with a mix of HEI-T and AP rounds for combating aerial threats of all shapes and sizes. Lacks propellants, as it's to be used with the binary hypergolic principle."
	caliber = "20mm"
	default_ammo = /datum/ammo/bullet/smartgun/aa
	gun_type = /obj/item/hardpoint/primary/aa_quadcannon
	max_rounds = 3400
	icon_state = "quad_1"

/obj/item/ammo_magazine/hardpoint/m56_cupola/quad_cannon/update_icon()
	icon_state = "quad_[current_rounds <= 0 ? "0" : "1"]"

/obj/item/ammo_magazine/hardpoint/m56_cupola/aev
	name = "M56 RWS Drum"
	desc = "An expanded drum of 700, 10x28mm caseless rounds for the M56 heavy machine gun system."
	icon_state = "m56d_drum"
	max_rounds = 700
	gun_type = /obj/item/hardpoint/secondary/m56cupola/aev

/obj/item/ammo_magazine/hardpoint/m56_cupola/aev/update_icon()
	if(current_rounds > 0)
		icon_state = "m56d_drum"
	else
		icon_state = "m56d_drum_empty"

/obj/item/ammo_magazine/hardpoint/m56_cupola/twe_tank
	name = "L98 Hull MG Magazine"
	desc = "An expanded box of 500, 10x28mm caseless rounds for the L98 hull machine gun."
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/twe_ammo.dmi'
	icon_state = "mounted_cupola_1"
	max_rounds = 500
	gun_type = /obj/item/hardpoint/secondary/m56cupola/twe_tank

/obj/item/ammo_magazine/hardpoint/m56_cupola/twe_tank/update_icon()
	if(current_rounds > 0)
		icon_state = "mounted_cupola_1"
	else
		icon_state = "mounted_cupola_0"
