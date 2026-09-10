//DOG WAR USCM MRE
//Most descriptions invented by Ivan_The_Red
/obj/item/mre_food_packet/dog_war
	icon = 'icons/obj/items/food/mre_food/dog_war.dmi'


/obj/item/reagent_container/food/snacks/mre_food/dog_war
	icon = 'icons/obj/items/food/mre_food/dog_war.dmi'
///ENTREE

/obj/item/mre_food_packet/entree/dog_war
	name = "\improper S-Ration main dish"
	desc = "An MRE entree component. Contains a dense, highly nutritious component."
	icon = 'icons/obj/items/food/mre_food/dog_war.dmi'
	icon_state = "entree"
	food_list = list(
		/obj/item/reagent_container/food/snacks/mre_food/dog_war/entree/beefsteak,
		/obj/item/reagent_container/food/snacks/mre_food/dog_war/entree/chickenpatty,
		/obj/item/reagent_container/food/snacks/mre_food/dog_war/entree/jalapenopizza,
	)

/obj/item/reagent_container/food/snacks/mre_food/dog_war/entree/beefsteak
	name = "beef steak protein loaf"
	icon_state = "beef steak loaf"
	desc = "A thick and weighty pale-brown block of carbohydrates and protein with several clear break lines. It contains a marines daily intake of protein and critical carbohydrates. Will not break along lines, best to smash this with your fighting knife and boil it."

/obj/item/reagent_container/food/snacks/mre_food/dog_war/entree/beefsteak/Initialize()
	. = ..()
	reagents.add_reagent("meatprotein", 28)
	reagents.add_reagent("sodiumchloride", 4)
	reagents.add_reagent("blackpepper", 4)

/obj/item/reagent_container/food/snacks/mre_food/dog_war/entree/chickenpatty
	name = "chicken patty protein loaf"
	icon_state = "chicken patty"
	desc = "Moist, stringy block of carbs and proteins with a few break lines. It contains a marines daily intake of protein and critical carbohydrates. Will not break along lines, best to smash this with your fighting knife and boil it."

/obj/item/reagent_container/food/snacks/mre_food/dog_war/entree/chickenpatty/Initialize()
	. = ..()
	reagents.add_reagent("meatprotein", 30)
	reagents.add_reagent("blackpepper", 4)

/obj/item/reagent_container/food/snacks/mre_food/dog_war/entree/jalapenopizza
	name = "jalapeno pizza protein loaf"
	icon_state = "jalapeno pizza"
	desc = "An exceedingly rare main-menu item, jalapeno pizza is an almost tasteless block of protein and carbs with some artificial flavoring on top, which makes it look like a poorly made home pizza. It contains a marines daily intake of protein and critical carbohydrates."

/obj/item/reagent_container/food/snacks/mre_food/dog_war/entree/jalapenopizza/Initialize()
	. = ..()
	reagents.add_reagent("cheese", 5)
	reagents.add_reagent("meatprotein", 10)
	reagents.add_reagent("bread", 10)
	reagents.add_reagent("vegetable", 5)
	reagents.add_reagent("tomatojuice", 5)

// PASTE

/obj/item/reagent_container/food/drinks/cans/tube/banana
	name = "S-Ration vitamin paste (banana)"
	icon = 'icons/obj/items/food/mre_food/dog_war.dmi'
	desc = "A vaguely banana flavoured tube of paste with screw off cap. It is an offensively neon-yellow colour, smells like old peels. Goes surprisingly well with milk!"
	flavor = "paste_banana"

/obj/item/reagent_container/food/drinks/cans/tube/banana/Initialize()
	. = ..()
	reagents.add_reagent("banana", 10)
	reagents.add_reagent("nutriment", 10)

/obj/item/reagent_container/food/drinks/cans/tube/ketchup
	name = "S-Ration vitamin paste (tomato condiment)"
	desc = "They called it Don't-Ketch, on the fact it's one of the least palletable things in the whole range of menus. Rumour says trying to make it taste not so bad will get your foot blown off by a mine, or a tripwire. Comes in a tube with screw-on cap, paste is a concerning red."
	flavor = "paste_tomato"

/obj/item/reagent_container/food/drinks/cans/tube/ketchup/Initialize()
	. = ..()
	reagents.add_reagent("ketchup", 15)
	reagents.add_reagent("nutriment", 5)

/obj/item/reagent_container/food/drinks/cans/tube/orange
	name = "S-Ration vitamin paste (orange)"
	desc = "Leave this one out in the sun for about an hour and it becomes fairly tasty to drink in water. Turns green when you do this though. Held inside a tube with screw-on cap, nominally orange adjacent in colour."
	flavor = "paste_orange"

/obj/item/reagent_container/food/drinks/cans/tube/orange/Initialize()
	. = ..()
	reagents.add_reagent("orangejuice", 10)
	reagents.add_reagent("nutriment", 10)

// DRINK

/obj/item/reagent_container/food/drinks/cans/water_ration
	name = "S-ration potable water"
	icon = 'icons/obj/items/food/mre_food/dog_war.dmi'
	icon_state = "water"
	desc = "A small rectangular 350ml soft-body packet of potable water, complete with a specialized purification tablet inside. Simply press the tablet with both fingers in order to break it into the water, then shake thorougly. Troops during the Dog War called this \"Devil's Milk\" thanks to the cloudy, chalky result of the purification process."
	open_sound = "rip"
	open_message = "You tear the packet open."
	volume = 35
	food_interactable = TRUE
	possible_transfer_amounts = list(5, 10)
	crushable = FALSE
	gulp_size = 5
	object_fluff = "packet"

/obj/item/reagent_container/food/drinks/cans/water_ration/Initialize()
	. = ..()
	reagents.add_reagent("water", 35)

/obj/item/reagent_container/food/drinks/cans/water_ration/attack_self(mob/user)
	. = ..()
	update_icon()

/obj/item/reagent_container/food/drinks/cans/water_ration/update_icon()
	overlays.Cut()
	if(open)
		icon_state = "water_open"
	else
		icon_state = "water"

// PARTY POPPERS

/obj/item/storage/pill_bottle/packet/partypoppers
	name = "\improper S-ration marching tablets"
	desc = "Also called \"Party-Poppers\". Caffeine-Amphetamine tablets designed for troops in extended operations or heavy combat, commonly stolen by logistics personnel who found themselves under significant stress. Discontinued after the Pang Ho treaty of 2163 in relation to serious reports of concerns over addiction among troops."
	icon = 'icons/obj/items/food/mre_food/dog_war.dmi'
	icon_state = "pills"
	w_class = 1
	storage_slots = 3
	max_w_class = 0
	max_storage_space = 3
	skilllock = SKILL_MEDICAL_DEFAULT
	storage_flags = STORAGE_FLAGS_BOX
	display_maptext = FALSE
	pill_type_to_fill = /obj/item/reagent_container/pill/partypopper
	bottle_lid = TRUE

/obj/item/storage/pill_bottle/packet/partypoppers/gum
	pill_type_to_fill = /obj/item/reagent_container/pill/partypopper/gum

/obj/item/reagent_container/pill/partypopper
	name = "marching tablet"
	icon = 'icons/obj/items/food/mre_food/dog_war.dmi'
	desc = "Chocolate-flavored marching tablet, also known as a party-popper."
	icon_state = "chocolate_pill"
	reagent_desc_override = FALSE
	volume = 31
	pill_initial_reagents = list("adrenaline_concentrated" = 1, "sugar" = 5, "coco" = 10, "coffee" = 15)

/obj/item/reagent_container/pill/partypopper/gum
	desc = "Gum-flavored marching tablet, also known as a party-popper. It's disturbingly pink."
	icon_state = "gum_pill"
	reagent_desc_override = FALSE
	volume = 31
	pill_initial_reagents = list("adrenaline_concentrated" = 1, "sugar" = 5, "berryjuice" = 10, "coffee" = 15)
