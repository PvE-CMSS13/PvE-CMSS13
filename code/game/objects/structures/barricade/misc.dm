/*----------------------*/
// SNOW
/*----------------------*/

/obj/structure/barricade/snow
	name = "snow barricade"
	desc = "A mound of snow shaped into a sloped wall. Statistically better than thin air as cover."
	icon_state = "snow_0"
	barricade_type = "snow"
	health = 75 //Actual health depends on snow layer
	maxhealth = 75
	stack_type = /obj/item/stack/snow
	debris = list(/obj/item/stack/snow)
	stack_amount = 3
	destroyed_stack_amount = 0
	can_wire = FALSE
	metallic = FALSE

/obj/structure/barricade/snow/New(loc, mob/user, direction)
	if(direction)
		setDir(direction)
	..(loc, user)



//Item Attack
/obj/structure/barricade/snow/attackby(obj/item/W, mob/user)
	for(var/obj/effect/xenomorph/acid/A in src.loc)
		if(A.acid_t == src)
			to_chat(user, "You can't get near that, it's melting!")
			return
	//Removing the barricades
	if(istype(W, /obj/item/tool/shovel) && user.a_intent != INTENT_HARM)
		var/obj/item/tool/shovel/ET = W
		if(ET.folded)
			return
		if(user.action_busy)
			to_chat(user, SPAN_WARNING("You are already shoveling!"))
			return
		user.visible_message("[user.name] starts clearing out \the [src].","You start removing \the [src].")
		if(!do_after(user, ET.shovelspeed * user.get_skill_duration_multiplier(SKILL_CONSTRUCTION), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD, src))
			return
		if(!ET.folded)
			user.visible_message(SPAN_NOTICE("\The [user] removes \the [src]."))
			deconstruct(TRUE)
		return

	return ..()

/obj/structure/barricade/snow/hit_barricade(obj/item/I)
	switch(I.damtype)
		if("fire")
			take_damage( I.force * I.demolition_mod * 0.6 )
		if("brute")
			take_damage( I.force * I.demolition_mod * 0.3 )

	return


/*----------------------*/
// WOOD
/*----------------------*/

/obj/structure/barricade/wooden
	name = "wooden barricade"
	desc = "A wall made out of wooden planks nailed together. Not very sturdy, but can provide some concealment."
	icon_state = "wooden"
	health = 100
	maxhealth = 100
	layer = OBJ_LAYER
	stack_type = /obj/item/stack/sheet/wood
	debris = list(/obj/item/stack/sheet/wood)
	stack_amount = 5
	destroyed_stack_amount = 3
	barricade_hitsound = 'sound/effects/woodhit.ogg'
	can_change_dmg_state = 0
	barricade_type = "wooden"
	can_wire = FALSE
	repair_materials = list("wood" = 1)
	metallic = FALSE

/obj/structure/barricade/wooden/attackby(obj/item/W as obj, mob/user as mob)
	for(var/obj/effect/xenomorph/acid/A in src.loc)
		if(A.acid_t == src)
			to_chat(user, "You can't get near that, it's melting!")
			return
	if(istype(W, /obj/item/stack/sheet/wood))
		var/obj/item/stack/sheet/wood/D = W
		if(health < maxhealth)
			if(D.get_amount() < 1)
				to_chat(user, SPAN_WARNING("You need one plank of wood to repair [src]."))
				return
			visible_message(SPAN_NOTICE("[user] begins to repair [src]."))
			if(do_after(user, 2 SECONDS, INTERRUPT_ALL, BUSY_ICON_FRIENDLY, src) && health < maxhealth)
				if (D.use(1))
					update_health(-0.5*maxhealth)
					update_damage_state()
					visible_message(SPAN_NOTICE("[user] clumsily repairs [src]."))
		return

	if(try_nailgun_usage(W, user))
		return

	return ..()

/obj/structure/barricade/wooden/hit_barricade(obj/item/I)
	switch(I.damtype)
		if("fire")
			take_damage( I.force * I.demolition_mod * 1.5 )
		if("brute")
			take_damage( I.force * I.demolition_mod * 0.75 )

// Prop flipped tables

/obj/structure/barricade/table
	name = "table barricade"
	desc = "A square metal surface resting on four legs. Useful to put stuff on. Can be flipped in emergencies to act as cover."
	icon = 'icons/obj/structures/barricades.dmi'
	icon_state = "metalflip"
	health = 100
	maxhealth = 100
	can_change_dmg_state = 0
	can_wire = FALSE
	stack_type = /obj/item/stack/sheet/metal
	stack_amount = 1
	destroyed_stack_amount = 1
	debris = list(/obj/item/stack/sheet/metal)
	layer = OBJ_LAYER
	barricade_type = "metalflip"
	barricade_hitsound = 'sound/effects/metalhit.ogg'

/obj/structure/barricade/table/attackby(obj/item/W, mob/user)
	if(HAS_TRAIT(W, TRAIT_TOOL_WRENCH) && !(user.a_intent == INTENT_HELP))
		user.visible_message(SPAN_NOTICE("[user] starts disassembling [src]."),
		SPAN_NOTICE("You start disassembling [src]."))
		playsound(src.loc, 'sound/items/Ratchet.ogg', 25, 1)
		if(do_after(user, 50 * user.get_skill_duration_multiplier(SKILL_CONSTRUCTION), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
			user.visible_message(SPAN_NOTICE("[user] disassembles [src]."),
			SPAN_NOTICE("You disassemble [src]."))
			deconstruct(TRUE)
		return

/obj/structure/barricade/table/wood
	name = "wooden table barricade"
	desc = "A square wood surface resting on four legs. Useful to put stuff on. Can be flipped in emergencies to act as cover."
	icon_state = "woodflip"
	barricade_hitsound = 'sound/effects/woodhit.ogg'
	barricade_type = "woodflip"
	repair_materials = list("wood" = 1)
	stack_type = /obj/item/stack/sheet/wood
	debris = list(/obj/item/stack/sheet/wood)

/obj/structure/barricade/table/wood/poor
	name = "poor wooden table barricade"
	desc = "A semi-poorly constructed wood surface resting on four legs. Useful to put stuff on. Can be flipped in emergencies to act as cover."
	icon_state = "pwoodflip"
	barricade_type = "pwoodflip"

/obj/structure/barricade/table/wood/gambling
	name = "gambling table barricade"
	desc = "A curved wood and carpet surface resting on four legs. Used for gambling games. Can be flipped in emergencies to act as cover."
	icon_state = "gambleflip"
	barricade_type = "gambleflip"

/obj/structure/barricade/table/reinforced
	name = "reinforced table barricade"
	desc = "A square metal surface resting on four legs. This one has side panels, making it useful as a desk, but impossible to flip."
	icon_state = "reinfflip"
	barricade_type = "reinfflip"

/obj/structure/barricade/table/almayer
	desc = "A square metal surface resting on its fat metal bottom. You can't flip something that doesn't have legs."
	icon_state = "almflip"
	barricade_type = "almflip"

/obj/structure/barricade/table/prison
	desc = "A square metal surface resting on four legs. This one has side panels, making it useful as a desk, but impossible to flip."
	icon_state = "prisonflip"
	barricade_type = "prisonflip"
/*----------------------*/
// HESCO
/*----------------------*/

/obj/structure/barricade/hesco
	name = "HESCO barricade"
	desc = "A sandbag wall. Provides better protection than a makeshift sandbag barricade, but requires specialized equipment to setup."
	icon_state = "sand_wall"
	health = 500
	maxhealth = 500
	layer = OBJ_LAYER
	stack_type = /obj/item/stack/sandbags
	debris = list(/obj/item/stack/sandbags)
	stack_amount = 5
	color = "#a98c7c"
	destroyed_stack_amount = 1
	barricade_hitsound = 'sound/weapons/Genhit.ogg'
	can_change_dmg_state = 0
	barricade_type = "sand_wall"
	can_wire = FALSE
	repair_materials = list("sandbag" = 1)
	metallic = FALSE

/obj/structure/barricade/hesco/attackby(obj/item/W as obj, mob/user as mob)
	for(var/obj/effect/xenomorph/acid/A in src.loc)
		if(A.acid_t == src)
			to_chat(user, "You can't get near that, it's melting!")
			return
	if(istype(W, /obj/item/stack/sandbags))
		var/obj/item/stack/sandbags/D = W
		if(health < maxhealth)
			if(D.get_amount() < 1)
				to_chat(user, SPAN_WARNING("You need one sandbag to repair [src]."))
				return
			visible_message(SPAN_NOTICE("[user] begins to repair [src]."))
			if(do_after(user, 2 SECONDS, INTERRUPT_ALL, BUSY_ICON_FRIENDLY, src) && health < maxhealth)
				if (D.use(1))
					update_health(-0.5*maxhealth)
					update_damage_state()
					visible_message(SPAN_NOTICE("[user] clumsily repairs [src]."))
		return

	if(try_nailgun_usage(W, user))
		return

	return ..()

/obj/structure/barricade/hesco/hit_barricade(obj/item/I)
	switch(I.damtype)
		if("fire")
			take_damage( I.force * I.demolition_mod * 1.5 )
		if("brute")
			take_damage( I.force * I.demolition_mod * 1.0 )
