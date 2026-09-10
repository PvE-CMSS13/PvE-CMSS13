//**********************Marine Gear**************************/

//MARINE COMBAT LIGHT

/obj/item/device/flashlight/combat
	name = "combat flashlight"
	desc = "A Flashlight designed to be held in the hand, or attached to a rifle, has better bulb compared to a normal flashlight."
	icon_state = "combat_flashlight"
	item_state = "flashlight"
	light_range = 5 //Pretty luminous, but still a flashlight that fits in a pocket

//MARINE SNIPER TARPS

/obj/item/bodybag/tarp
	name = "\improper V1 thermal-dapening tarp (folded)"
	desc = "A tarp carried by USCM Snipers. When laying underneath the tarp, the sniper is almost indistinguishable from the landscape if utilized correctly. The tarp contains a thermal-dampening weave to hide the wearer's heat signatures, optical camouflage, and smell dampening."
	icon = 'icons/obj/bodybag.dmi'
	icon_state = "jungletarp_folded"
	w_class = SIZE_MEDIUM
	unfolded_path = /obj/structure/closet/bodybag/tarp
	unacidable = TRUE

/obj/item/bodybag/tarp/snow
	icon = 'icons/obj/bodybag.dmi'
	icon_state = "snowtarp_folded"
	unfolded_path = /obj/structure/closet/bodybag/tarp/snow

/obj/item/bodybag/tarp/reactive
	name = "\improper V2 reactive thermal tarp (folded)"
	desc = "A tarp carried by some USCM infantry. This updated tarp is capable of blending into its environment nearly flawlessly, given that it can properly collate data once deployed. The tarp is able to hide the wearer's heat signature."
	icon = 'icons/obj/bodybag.dmi'
	icon_state = "reactivetarp_folded"
	unfolded_path = /obj/structure/closet/bodybag/tarp/reactive

/obj/item/bodybag/tarp/reactive/scout
	name = "\improper V3 reactive thermal tarp (folded)"
	desc = "A more compact and improved version of the V2 thermal tarp, intended primarily for the transportation of deceased or wounded marines. It has improved cloaking technology than earlier models, allowing it to cloak to a greater degree and faster."
	icon_state = "scouttarp_folded"
	w_class = SIZE_SMALL
	unfolded_path = /obj/structure/closet/bodybag/tarp/reactive/scout

/obj/structure/closet/bodybag/tarp
	name = "\improper V1 thermal-dampening tarp"
	bag_name = "\improper V1 thermal-dampening tarp"
	desc = "A tarp carried by USCM Snipers. When laying underneath the tarp, the sniper is almost indistinguishable from the landscape if utilized correctly. The tarp contains a thermal-dampening weave to hide the wearer's heat signatures, optical camouflage, and smell dampening."
	icon = 'icons/obj/bodybag.dmi'
	icon_state = "jungletarp_closed"
	icon_closed = "jungletarp_closed"
	icon_opened = "jungletarp_open"
	open_sound = 'sound/effects/vegetation_walk_1.ogg'
	close_sound = 'sound/effects/vegetation_walk_2.ogg'
	item_path = /obj/item/bodybag/tarp
	anchored = FALSE
	var/uncloak_time = 3 //in SECONDS, this is how long it takes for the tarp to become fully visible again once it's opened from an invisible state
	var/cloak_time = 15 //ditto for cloaking
	var/closed_alpha = 60 //how much ALPHA the tarp has once it's fully cloaked.
	var/can_store_dead = FALSE
	var/is_animating = FALSE
	var/first_open = TRUE
	exit_stun = 0
	/// used to implement a delay before tarp can be entered again after opened (anti-exploit)
	COOLDOWN_DECLARE(toggle_delay)

/obj/structure/closet/bodybag/tarp/snow
	icon_state = "snowtarp_closed"
	icon_closed = "snowtarp_closed"
	icon_opened = "snowtarp_open"
	item_path = /obj/item/bodybag/tarp/snow

/obj/structure/closet/bodybag/tarp/reactive
	name = "\improper V2 reactive thermal tarp"
	bag_name = "\improper V2 reactive thermal tarp"
	desc = "A tarp carried by some USCM infantry. This updated tarp is capable of blending into its environment nearly flawlessly, given that it can properly collate data once deployed. The tarp is able to hide the wearer's heat signature."
	icon_state = "reactivetarp_closed"
	icon_closed = "reactivetarp_closed"
	icon_opened = "reactivetarp_open"
	open_sound = 'sound/effects/vegetation_walk_1.ogg'
	close_sound = 'sound/effects/vegetation_walk_2.ogg'

	item_path = /obj/item/bodybag/tarp/reactive
	anchored = FALSE

/obj/structure/closet/bodybag/tarp/reactive/scout
	name = "\improper V3 reactive thermal tarp (folded)"
	bag_name = "\improper V3 reactive thermal tarp"
	desc = "A more compact and improved version of the V2 thermal tarp, intended primarily for the transportation of deceased or wounded marines. It has improved cloaking technology than earlier models, allowing it to cloak to a greater degree and faster.\nUse this item in-hand or click somewhere on the floor adjacent to you to deploy it, then click it again to close it, which automatically cloaks the bag. Click again to open and uncloak it. If you lose it, right click to check tile contents around you to find it."
	icon_state = "scouttarp_closed"
	icon_closed = "scouttarp_closed"
	icon_opened = "scouttarp_open"
	item_path = /obj/item/bodybag/tarp/reactive/scout
	cloak_time = 5
	closed_alpha = 10 //Between scout & ghillie camo alphas
	exit_stun = 1
	can_store_dead = TRUE

/obj/structure/closet/bodybag/tarp/store_mobs(stored_units)//same as stasis bag proc
	var/list/mobs_can_store = list()
	for(var/mob/living/carbon/human/H in loc)
		if(H.buckled)
			continue
		if(H.stat == DEAD && !can_store_dead) // dead, nope
			continue
		mobs_can_store += H
	var/mob/living/carbon/human/mob_to_store
	if(length(mobs_can_store))
		mob_to_store = pick(mobs_can_store)
		mob_to_store.forceMove(src)
		mob_to_store.unset_interaction()
		stored_units += mob_size
	return stored_units

/obj/structure/closet/bodybag/tarp/proc/handle_cloaking()
	if(opened) //if we are OPENING the bag. It checks for opened because the handle_cloaking proc triggers AFTER the parent open() is called
		if(first_open) //if this is the first time we are opening it (ie not animated because the open proc is being triggered by putting it on the ground)
			alpha = 255
			first_open = FALSE
			return
		if(is_animating) //if it's not fully cloaked we don't want to do the whole animation from a fully cloaked state.
			alpha = 255
			is_animating = FALSE
			return
		else //not animating and not the first time we're opening it, therefore play the full animation from a fully cloaked state
			is_animating = TRUE
			animate(src, alpha = 255, time = uncloak_time SECONDS, easing = QUAD_EASING)
			spawn(uncloak_time SECONDS)
				is_animating = FALSE
				return
	else //if we are CLOSING the bag, animate as usual.
		is_animating = TRUE
		animate(src, alpha = closed_alpha, time = cloak_time SECONDS, easing = QUAD_EASING)
		spawn(cloak_time SECONDS)
			is_animating = FALSE //animation finished
			return

/obj/structure/closet/bodybag/tarp/open()
	COOLDOWN_START(src, toggle_delay, 3 SECONDS) //3 seconds must pass before tarp can be closed
	. = ..()
	handle_cloaking()

/obj/structure/closet/bodybag/tarp/close(mob/user)
	if(!COOLDOWN_FINISHED(src, toggle_delay))
		to_chat(user, SPAN_WARNING("It is too soon to close [src]!"))
		return FALSE
	. = ..()
	handle_cloaking()

/obj/structure/broken_apc
	name = "\improper M577 armored personnel carrier"
	desc = "A large, armored behemoth capable of ferrying marines around. \nThis one is sitting nonfunctional."
	anchored = TRUE
	opacity = TRUE
	density = TRUE
	unslashable = TRUE
	icon = 'icons/obj/apc.dmi'
	icon_state = "apc"


/obj/item/reagent_container/food/snacks/protein_pack
	name = "chocolate Preemptive Action nutrition bar"
	desc = "A flaky, crunchy military nutrition bar. It's an American armed forces classic, for better or worse. The chocolate tastes a bit artificial and the vitamins are barely covered up by the stevia sweetener."
	icon_state = "yummers"
	icon = 'icons/obj/items/food/mre_food/uscm.dmi'
	filling_color = "#ED1169"
	w_class = SIZE_TINY

/obj/item/reagent_container/food/snacks/protein_pack/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 8)
	reagents.add_reagent("coco", 8)
	bitesize = 4

/obj/item/reagent_container/food/snacks/protein_pack2
	name = "strawberry Preemptive Action nutrition bar"
	desc = "A flaky, crunchy military nutrition bar. It's an American armed forces classic, for better or worse. The strawberry coating is definitely oversweetened."
	//TODO: ACTUAL SPRITES
	icon_state = "yummers2"
	filling_color = "#ff00cc"
	w_class = SIZE_TINY

/obj/item/reagent_container/food/snacks/protein_pack2/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 8)
	reagents.add_reagent("strawberrypowder", 8)
	bitesize = 4

/obj/item/reagent_container/food/snacks/protein_pack3
	name = "vanilla Preemptive Action nutrition bar"
	desc = "A flaky, crunchy military nutrition bar. It's an American armed forces classic, for better or worse. The vanilla is overpoweringly strong, but there's not enough sweetener to cover the bitter aftertaste of the filling."
	//TODO: ACTUAL SPRITES
	icon_state = "yummers3"
	filling_color = "#e6e6e6"
	w_class = SIZE_TINY

/obj/item/reagent_container/food/snacks/protein_pack3/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 8)
	reagents.add_reagent("vanilla", 8)
	bitesize = 4

/obj/item/reagent_container/food/snacks/mre_pack
	name = "\improper generic MRE pack"
	icon = 'icons/obj/items/food_canteen.dmi'
	icon_state = "mar_tray_empty"
	trash = /obj/item/trash/USCMtray
	w_class = SIZE_SMALL

/obj/item/reagent_container/food/snacks/mre_pack/meal1
	name = "\improper mechanically prepared meal (chili and cornbread)"
	desc = "An autochef prepared meal meant to imitate 'Southern' cuisine, whatever that means. Contains aggressively overseasoned chili with reconstituted beans, dry crumbly cornbread, and something that might've been gazpacho once."
	icon_state = "mar_tray_menu1"
	filling_color = "#ED1169"

/obj/item/reagent_container/food/snacks/mre_pack/meal1/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 9)
	bitesize = 3

/obj/item/reagent_container/food/snacks/mre_pack/meal2
	name = "\improper mechanically prepared meal (ham and potatoes)"
	desc = "An autochef prepared meal of slightly undercooked ham, surprisingly good reconstituted potato wedges made with real potato powder, artificial fruit puree, and stale crackers."
	icon_state = "mar_tray_menu2"

/obj/item/reagent_container/food/snacks/mre_pack/meal2/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 9)
	bitesize = 2

/obj/item/reagent_container/food/snacks/mre_pack/meal3
	name = "\improper mechanically prepared meal (spaghetti)"
	desc = "An autochef prepared meal of oversalted spaghetti in sauce and square 'beef meatballs'. On the side are perfectly baked breadsticks, an unevenly warmed hotdog, and some bland applesauce."
	icon_state = "mar_tray_menu3"

/obj/item/reagent_container/food/snacks/mre_pack/meal3/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 9)
	bitesize = 3

/obj/item/reagent_container/food/snacks/mre_pack/meal4
	name = "\improper mechanically prepared meal (pizza)"
	desc = "An autochef prepared meal of underseasoned cheese pizza dotted with little bits of sausage. On the side are some concerningly wet scrambled reconstituted eggs and sautee'd broccoli with a little freezer burn."
	icon_state = "mar_tray_menu4"

/obj/item/reagent_container/food/snacks/mre_pack/meal4/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 9)
	bitesize = 3

/obj/item/reagent_container/food/snacks/mre_pack/meal5
	name = "\improper mechanically prepared meal (chicken)"
	desc = "An autochef prepared meal of some potentially undercooked apparently halal roast chicken slices, an unidentified dubious sauce, mixed nuts trail mix, overcooked brown rice, and a tube of cherry-flavored halal jelly that tastes pretty heavily of vitamins."
	icon_state = "mar_tray_menu5"

/obj/item/reagent_container/food/snacks/mre_pack/meal5/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 9)
	bitesize = 3

/obj/item/reagent_container/food/snacks/mre_pack/meal6
	name = "\improper mechanically prepared meal (vegetarian tofu)"
	desc = "An autochef prepared meal of some surprisingly well fried tofu, stale crackers, and underseasoned breadsticks. On the side is a protein bar in mediocre strawberry."
	icon_state = "mar_tray_menu6"

/obj/item/reagent_container/food/snacks/mre_pack/meal6/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 9)
	bitesize = 3

/obj/item/reagent_container/food/snacks/mre_pack/meal7
	name = "\improper mechanically prepared meal (macaroni and cheese)"
	desc = "An autochef prepared meal of concerningly viscous macaroni and cheese. On the side is sautee'd broccoli with some freezer burn, a tube of cherry-and-vitamin flavor jelly, and a packet of mixed nuts trail mix."
	icon_state = "mar_tray_menu7"

/obj/item/reagent_container/food/snacks/mre_pack/meal7/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 9)
	bitesize = 3

/obj/item/reagent_container/food/snacks/mre_pack/xmas1
	name = "\improper mechanically prepared meal (sugar cookies)"
	desc = "An autochef prepared meal of overbaked sugar cookies, a packet of what claims to be cherry cobbler, and a spiced dipping sauce that's divisive as to whether or not it goes with the cookies. On the side is a moist fruit-swirl bread roll."
	icon_state = "mar_tray_menuSC"
	black_market_value = 10

/obj/item/reagent_container/food/snacks/mre_pack/xmas1/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 15)
	reagents.add_reagent("sugar", 9)
	bitesize = 8

/obj/item/reagent_container/food/snacks/mre_pack/xmas2
	name = "\improper mechanically prepared meal (gingerbread and vanilla cake)"
	desc = "An autochef prepared meal of some oddly soft gingerbread cookies and a fairly undersweetened vanilla cake. There's a protein bar on the side and a tube of cherry flavored vitamin filled jelly."
	icon_state = "mar_tray_menuGV"
	black_market_value = 10

/obj/item/reagent_container/food/snacks/mre_pack/xmas2/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 15)
	reagents.add_reagent("sugar", 9)
	bitesize = 8

/obj/item/reagent_container/food/snacks/mre_pack/xmas3
	name = "\improper mechanically prepared meal (fruitcake)"
	desc = "An autochef prepared meal of a fruitcake and applesauce. The fruitcake tastes of vitamins but is shockingly palatable even still, while the applesauce is... there?"
	icon_state = "mar_tray_menuFC"
	black_market_value = 10

/obj/item/reagent_container/food/snacks/mre_pack/xmas3/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 15)
	reagents.add_reagent("sugar", 9)
	bitesize = 8

/obj/item/reagent_container/food/snacks/mre_pack/thanksgiving
	name = "\improper mechanically prepared meal (turkey and potato)"
	desc = "An autochef prepared meal of roast turkey slices and reconstituted potato wedges made from real potato powder. Cherry cobbler in a tube on the side and some bland applesauce in a sealed cup."
	icon_state = "mar_tray_menuTP"

/obj/item/reagent_container/food/snacks/mre_pack/thanksgiving/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 10)
	bitesize = 3

/obj/item/reagent_container/food/snacks/mre_pack/thanksgiving2
	name = "\improper mechanically prepared meal (steak and potato)"
	desc = "An autochef prepared meal of rare steak slices and reconstituted potato wedges made from real potato powder. Cherry cobbler in a tube on the side and some bland applesauce in a sealed cup."
	icon_state = "mar_tray_menuSP"

/obj/item/reagent_container/food/snacks/mre_pack/thanksgiving2/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 10)
	bitesize = 3

/obj/item/reagent_container/food/snacks/mre_pack/thanksgiving3
	name = "\improper mechanically prepared meal (shrimp and rice)"
	desc = "An autochef prepared meal of stir fried imitation shrimp and overcooked brown rice. Some mixed nuts trail mix and an unidentified sauce are on the side."
	icon_state = "mar_tray_menuSR"

/obj/item/reagent_container/food/snacks/mre_pack/thanksgiving3/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 10)
	bitesize = 3

//UPP Tray Food

/obj/item/reagent_container/food/snacks/mre_pack/upp
	name = "\improper generic MRE pack"
	icon = 'icons/obj/items/food.dmi'
	icon_state = "upp_lid"
	trash = /obj/item/trash/UPPtray
	w_class = SIZE_SMALL
	bitesize = 5

/obj/item/reagent_container/food/snacks/mre_pack/upp/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 15)

/obj/item/reagent_container/food/snacks/mre_pack/upp/meal1
	name = "\improper UPP Prepared Meal (Chow mein)"
	desc = "Chow mein with imitation shrimp, two slightly overcooked spring rolls, some type of porridge and a small tofu cube."
	icon_state = "upp_chowmein"

/obj/item/reagent_container/food/snacks/mre_pack/upp/meal2
	name = "\improper UPP Prepared Meal (Banush)"
	desc = "Ukrainian style Banush cornmeal stew, dried apricots, and a couple vienna sausages."
	icon_state = "upp_banush"

/obj/item/reagent_container/food/snacks/mre_pack/upp/meal3
	name = "\improper UPP Prepared Meal (Frankfurter)"
	desc = "A large, juicy frankfurter with mashed potato, crispy potato pancakes and saurkraut."
	icon_state = "upp_frankfurter"

/obj/item/reagent_container/food/snacks/mre_pack/upp/meal4
	name = "\improper UPP Prepared Meal (Jiaozi)"
	desc = "Four boiled dumplings, soy-vinegar dipping sauce, pickled red cucumbers and two rye biscuits."
	icon_state = "upp_jiaozi"

/obj/item/reagent_container/food/snacks/mre_pack/upp/meal5
	name = "\improper UPP Prepared Meal (Wursts)"
	desc = "Two scoops of rice, two Weiner wursts, a tortilla with tomato sauce and a small bowl of Mungbean soup fill this tray."
	icon_state = "upp_wursts"

/obj/item/reagent_container/food/snacks/mre_pack/upp/meal6
	name = "\improper UPP Prepared Meal (Luncheon)"
	desc = "A prepackaged meal for UPP troops with two scoops of slightly dried out rice, a square of some kind of luncheon meat, two carrot sticks, and a 'fruit' bar."
	icon_state = "upp_luncheon"

/obj/item/reagent_container/food/snacks/mre_pack/upp/meal7
	name = "\improper UPP Prepared Meal (Shrimp)"
	desc = "A prepackaged meal for UPP troops that sports a greasy rice patty with bits of fake imitation shrimp and egg flavoring. Smells quite off. On the side there's a slightly soggy spring roll."
	icon_state = "upp_shrimp"

/obj/item/reagent_container/food/snacks/mre_pack/upp/meal8
	name = "\improper UPP Prepared Meal (Cuban)"
	desc = "A prepackaged meal for UPP troops containing Cuban rice with bland-ish eggs pieces, tomato sauce, potato salad, and a dry biscuit."
	icon_state = "upp_cuban"

/obj/item/reagent_container/food/snacks/mre_pack/upp/meal9
	name = "\improper UPP Prepared Meal (Meatballs)"
	desc = "A prepackaged meal for UPP troops containing marinated Königsberger Klopse meatballs, a creamy sauce, some spinach, and a scoop of rice. One of the better options out of the pre-packaged meals and is rarely ever in stock."
	icon_state = "upp_meatballs"

//RMC Tray Food

/obj/item/reagent_container/food/snacks/protein_pack/rmc
	name = "Biscuits Brown snack bar"
	desc = "The devil in disguise. Quick to eat, with a fairly pleasant taste and texture, but consuming more than one in a short span of time will ensure you won't be digging latrine holes out in the field for at least two weeks."
	icon_state = "muesli"
	filling_color = "#ED1169"

/obj/item/reagent_container/food/snacks/mre_pack/rmc
	name = "\improper generic MRE pack"
	icon = 'icons/obj/items/food_canteen.dmi'
	icon_state = "rmc_tray_empty"
	trash = /obj/item/trash/RMCtray
	w_class = SIZE_SMALL
	bitesize = 5

/obj/item/reagent_container/food/snacks/mre_pack/rmc/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 15)

/obj/item/reagent_container/food/snacks/mre_pack/rmc/meal1
	name = "\improper RMC Prepared Meal (Roast Beef)"
	desc = "A slab of imitation beef drenched in too-salty gravy, with a portion of undercooked peas, soggy carrots and oddly dry mashed potatoes."
	icon_state = "rmc_meat"

/obj/item/reagent_container/food/snacks/mre_pack/rmc/meal2
	name = "\improper RMC Prepared Meal (Tikka Curry)"
	desc = "Chunks of pork and potato submerged in a mass of mild Indian curry sauce, with a side of fluffy rice and a lukewarm bit of naan flatbread."
	icon_state = "rmc_tikka"

/obj/item/reagent_container/food/snacks/mre_pack/rmc/meal3
	name = "\improper RMC Prepared Meal (Katsu Curry)"
	desc = "Breaded chicken strips slathered in a Japanese style curry sauce. Comes with a helping of fluffy rice and an unidentifiable mound of overcooked veg as the side components."
	icon_state = "rmc_katsu"

/obj/item/reagent_container/food/snacks/mre_pack/rmc/meal4
	name = "\improper RMC Prepared Meal (Sausage & Eggs)"
	desc = "Several overdone sausages, a wodge of scrambled eggs, and a load of sweet potato fries & green beans fill this tray."
	icon_state = "rmc_sausage"

/obj/item/reagent_container/food/snacks/mre_pack/rmc/meal5
	name = "\improper RMC Prepared Meal (Seafood Platter)"
	desc = "Numerous kinds of sushi occupy the side-component slots of this tray, with the main component being several slices of salmon sashimi atop cold, boiled rice."
	icon_state = "rmc_fish"

/obj/item/reagent_container/food/snacks/mre_pack/dog_war
	name = "\improper some old space food"
	desc = "How did this get here?"
	icon_state = "tofu"
	bitesize = 5
	var/wrapper_state = "dog_war_wrapper_wide"
	var/has_package = TRUE
	trash = null

/obj/item/reagent_container/food/snacks/mre_pack/dog_war/Initialize()
	. = ..()
	if(has_package)
		overlays += image(icon, wrapper_state)

/obj/item/reagent_container/food/snacks/mre_pack/dog_war/attack_self(mob/user)
	if(has_package)
		playsound(src.loc,'sound/effects/pageturn2.ogg', 15, 1)
		to_chat(user, SPAN_NOTICE("You pull and tear the vacum-sealed packaging easily."))
		package = FALSE
		overlays.Cut()
		has_package = FALSE
		return
	..()

/obj/item/reagent_container/food/snacks/mre_pack/dog_war/main
	wrapper_state = "dog_war_wrapper_thin"

/obj/item/reagent_container/food/snacks/mre_pack/dog_war/main/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 15)

/obj/item/reagent_container/food/snacks/mre_pack/dog_war/main/pork
	name = "shunt-stable pork"
	desc = "Two chunks of pork, moist and unpleasant."
	icon_state = "space_pork"

/obj/item/reagent_container/food/snacks/mre_pack/dog_war/main/beef
	name = "shunt-stable beef"
	desc = "Two beef patties, dry and chewy."
	icon_state = "space_beef"

/obj/item/reagent_container/food/snacks/mre_pack/dog_war/main/chicken
	name = "shunt-stable chicken"
	desc = "Two chicken patties, stringy and crumbling for some reason."
	icon_state = "space_chicken"

/obj/item/reagent_container/food/snacks/mre_pack/dog_war/side
	wrapper_state = "dog_war_wrapper_wide"

/obj/item/reagent_container/food/snacks/mre_pack/dog_war/side/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 10)

/obj/item/reagent_container/food/snacks/mre_pack/dog_war/side/cornbread
	name = "shunt-stable cornbread"
	desc = "Large piece of cornbread with deep break lines. Extremely dry. You get a feeling the vacuum-seal and special storage conditions are redundant for this bread."
	icon_state = "space_cornbread"

/obj/item/reagent_container/food/snacks/mre_pack/dog_war/side/fries
	name = "shunt-stable fries"
	desc = "Bunch of french fries, stuck together. Over- or undersalted more often than not."
	icon_state = "space_fries"

/obj/item/reagent_container/food/snacks/mre_pack/dog_war/side/dinner_rolls
	name = "shunt-stable dinner rolls"
	desc = "Four dinner rolls. They look very pale and unnatural."
	icon_state = "space_dinner_rolls"

/obj/item/storage/box/pizza
	name = "food delivery box"
	desc = "A space-age food storage device, capable of keeping food extra fresh. Actually, it's just a box."

/obj/item/storage/box/pizza/Initialize()
	. = ..()
	pixel_y = rand(-3,3)
	pixel_x = rand(-3,3)
	new /obj/item/reagent_container/food/snacks/microwavable/donkpocket(src)
	new /obj/item/reagent_container/food/snacks/microwavable/donkpocket(src)
	var/randsnack
	for(var/i = 1 to 3)
		randsnack = rand(0,5)
		switch(randsnack)
			if(0)
				new /obj/item/reagent_container/food/snacks/fries(src)
			if(1)
				new /obj/item/reagent_container/food/snacks/cheesyfries(src)
			if(2)
				new /obj/item/reagent_container/food/snacks/bigbiteburger(src)
			if(4)
				new /obj/item/reagent_container/food/snacks/taco(src)
			if(5)
				new /obj/item/reagent_container/food/snacks/hotdog(src)

/obj/item/paper/janitor
	name = "crumbled paper"
	icon_state = "pamphlet"
	info = "In loving memory of Cub Johnson."


/obj/item/device/overwatch_camera
	name = "M5 Camera Gear"
	desc = "A camera and associated headgear designed to allow unit commanders to see what their troops can see, and those troops to see squad info via a HUD. A more robust version of this equipment is integrated into all standard combat helmets in use by UA forces."
	icon = 'icons/obj/items/clothing/glasses.dmi'
	icon_state = "overwatch_gear"
	item_state = "overwatch_gear"
	item_icons = list(
		WEAR_L_EAR = 'icons/mob/humans/onmob/ears.dmi',
		WEAR_R_EAR = 'icons/mob/humans/onmob/ears.dmi',
		)
	flags_equip_slot = SLOT_EAR
	var/obj/structure/machinery/camera/camera
	has_hud = TRUE
	hud_type = list(MOB_HUD_FACTION_MARINE, MOB_HUD_FACTION_ARMY, MOB_HUD_FACTION_NAVY)

/obj/item/device/overwatch_camera/Initialize(mapload, ...)
	. = ..()
	camera = new /obj/structure/machinery/camera/overwatch(src)

/obj/item/device/overwatch_camera/Destroy()
	QDEL_NULL(camera)
	return ..()

/obj/item/device/overwatch_camera/equipped(mob/living/carbon/human/mob, slot)
	if(mob.has_item_in_ears(src))
		camera.c_tag = mob.name
		for(var/type in hud_type)
			var/datum/mob_hud/MH = GLOB.huds[type]
			MH.add_hud_to(mob, src)
	..()

/obj/item/device/overwatch_camera/dropped(mob/user)
	if(camera)
		camera.c_tag = "Unknown"
	if(hud_type)
		for(var/type in hud_type)
			var/datum/mob_hud/MH = GLOB.huds[type]
			MH.remove_hud_from(user, src)
	..()

/obj/item/device/overwatch_camera/twe
	name = "OOCUHM Cam-Gear"
	desc = "Operational Oversight Camera Unit, Head-Mounted. Usually nicknamed \"Ooks\" or \"Big Brother\" by the marine commandos that wear them, the TWE-manufactured camera unit & eyepiece allows both command oversight of operations and display of an augmented reality 'Heads-Up-Display' to the wearer."
	hud_type = list(MOB_HUD_FACTION_TWE, MOB_HUD_FACTION_WY)
	icon_state = "rmc_overwatch_gear"
	item_state = "rmc_overwatch_gear"

/obj/item/device/overwatch_camera/pmc
	name = "Mk3 TOCU headcam"
	desc = "A modification & ruggedisation of the camera gear fielded by the RMC, the Tactical Overwatch Camera Unit is used by Weyland Yutani PMC forces that forgo a typical protective head-cover, allowing their handler to remain aware of the operatives current status."
	hud_type = list(MOB_HUD_FACTION_PMC, MOB_HUD_FACTION_WY, MOB_HUD_FACTION_TWE)
	icon_state = "rmc_overwatch_gear"
	item_state = "rmc_overwatch_gear"

/obj/item/device/overwatch_camera/upp
	name = "1PN77M \"Periskop\" camera unit"
	desc = "Replacing last generation head-mounted-sights, the \"Periskop\" brings several improvements over its' predecessors in the areas of ergonomics and technology. Thanks to its' superior camera systems and redesigned optical suite, which has improved both officer overwatch and personal combat capabilities, the unit has seen wide adoption among all UPP branches."
	hud_type = list(MOB_HUD_FACTION_UPP)
	icon_state = "upp_overwatch_gear"
	item_state = "upp_overwatch_gear"
