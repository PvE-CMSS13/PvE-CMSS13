/obj/item/map
	name = "map"
	icon = 'icons/obj/items/marine-items.dmi'
	icon_state = "map"
	item_state = "map"
	throw_speed = SPEED_FAST
	throw_range = 5
	w_class = SIZE_TINY
	// color = ... (Colors can be names - "red, green, grey, cyan" or a HEX color code "#FF0000")
	var/dat // Page content
	var/html_link = ""
	/*
	Since we are not on the wiki, need this to properly display added maps. In the future we'd need to host the maps somewhere centralized.
	This is a hack and shouldn't be used unless there is no proper solution in place.
	*/
	var/html_override = FALSE
	var/window_size = "1280x720"

/obj/item/map/attack_self(mob/user) //Open the map
	..()
	user.visible_message(SPAN_NOTICE("[user] opens the [src.name]. "))
	initialize_map()

/obj/item/map/attack()
	return

/obj/item/map/proc/initialize_map()
	var/wikiurl = CONFIG_GET(string/wikiurl)
	if(wikiurl || html_override)
		dat = {"
				<!DOCTYPE html>
				<html>
				<head>
					<meta http-equiv="X-UA-Compatible" content="IE=edge">
					<meta charset="utf-8">
					<style>
						img {
							display: none;
							position: absolute;
							top: 30;
							left: 0;
							max-width: 100%;
							height: auto;
							overflow: hidden;
							border: 0;
						}
					</style>
				</head>
				<body>
				<script type="text/javascript">
					function pageloaded(obj) {
						document.getElementById("loading").style.display = "none";
						obj.style.display = "inline";
					}
				</script>
				<p id='loading'>You start unfolding the map...</p>
					<img onload="pageloaded(this)" src="[html_override ? html_link : "[wikiurl]/[html_link]"]?printable=yes&remove_links=1" id="main_frame" alt=""></img>
				</body>

				</html>
			"}
	show_browser(usr, dat, name, "papermap", "size=[window_size]")

/obj/item/map/lazarus_landing_map
	name = "\improper Lazarus Landing Map"
	desc = "A satellite printout of the Lazarus Landing colony on LV-624."
	html_link = "images/6/6f/LV624.png"

/obj/item/map/ice_colony_map
	name = "\improper Ice Colony map"
	desc = "A satellite printout of the Ice Colony."
	html_link = "images/1/18/Map_icecolony.png"
	color = "cyan"

/obj/item/map/ice_colony_map/v1
	html_link = "https://cm-ss13.com/w/images/8/88/Ice_V1.png"

/obj/item/map/ice_colony_map/v2
	html_link = "https://cm-ss13.com/w/images/c/cf/Ice_Colony_v2.png"

/obj/item/map/ice_colony_map_v3
	name = "\improper Shivas Snowball map"
	desc = "A labelled print out of the anterior scan of the UA colony Shivas Snowball."
	html_link = "images/1/18/Map_icecolony.png"
	color = "cyan"

/obj/item/map/whiskey_outpost_map
	name = "\improper Whiskey Outpost map"
	desc = "A tactical printout of the Whiskey Outpost defensive positions and locations."
	html_link = "images/7/78/Whiskey_outpost.png"
	color = "grey"

/obj/item/map/big_red_map
	name = "\improper Solaris Ridge Map"
	desc = "A censored blueprint of the Solaris Ridge facility"
	html_link = "images/9/9e/Solaris_Ridge.png"
	color = "#e88a10"

/obj/item/map/FOP_map
	name = "\improper Fiorina Orbital Penitentiary Map"
	desc = "A labelled interior scan of Fiorina Orbital Penitentiary"
	html_link = "images/4/4c/Map_Prison.png"
	color = "#e88a10"

/obj/item/map/FOP_map_v3
	name = "\improper Fiorina Orbital Civilian Annex Map"
	desc = "A scan produced by the Almayer's sensor array of the Fiorina Orbital Penitentiary Civilian Annex. It appears to have broken off from the rest of the station and is now in free geo-sync orbit around the planet."
	html_link = "images/e/e0/Prison_Station_Science_Annex.png"
	color = "#e88a10"

/obj/item/map/desert_dam
	name = "\improper Trijent Dam map"
	desc = "An orbital scan printout of the Trijent Dam colony."
	html_link = "images/9/92/Trijent_Dam.png"
	color = "#ad8d0e"

/obj/item/map/sorokyne_map
	name = "\improper Sorokyne Strata map"
	desc = "A map of the Weyland-Yutani colony Sorokyne Outpost, commonly known as Sorokyne Strata."
	html_link = "images/2/21/Sorokyne_Wiki_Map.jpg" //The fact that this is just a wiki-link makes me sad and amused.
	color = "cyan"

/obj/item/map/corsat
	name = "\improper CORSAT map"
	desc = "A blueprint of CORSAT station"
	html_link = "images/8/8e/CORSAT_Satellite.png"
	color = "red"

/obj/item/map/kutjevo_map
	name = "\improper Kutjevo Refinery map"
	desc = "An orbital scan of Kutjevo Refinery"
	html_link = "images/0/0d/Kutjevo_a1.jpg"
	color = "red"

/obj/item/map/lv522_map
	name = "\improper LV-522 Map"
	desc = "An overview of LV-522 schematics."
	html_link = "images/b/bb/C_claim.png"
	color = "cyan"

/obj/item/map/new_varadero
	name = "\improper New Varadero map"
	desc = "A labeled blueprint of the UA outpost New Varadero."
	html_link = "images/9/94/New_Varadero.png"
	color = "red"

/obj/item/map/almayer
	name = "\improper USS Almayer map"
	desc = "A labeled blueprint of the USS Almayer"
	html_link = "images/5/54/USS_Almayer.png"
	color = "cyan"

/obj/item/map/blackstone_bridge
	name = "\improper Blackstone Bridge map"
	desc = "A labeled blueprint of USCM Outpost 29. This outpost was specifically created to oversee travel and trade along the Blackstone Bridge, the only reliable means of traversing through the nearby mountain range."
	html_link = "https://i.postimg.cc/mRCKvNxG/Blackstone-Brdige-Blueprint-Game-Resize.png"
	html_override = TRUE
	color = "#1177b0"

GLOBAL_LIST_INIT_TYPED(map_type_list, /obj/item/map, setup_all_maps())


//This was set up incorrectly before. You can reference complile variables of something without having to instance it. Observe:
/proc/setup_all_maps()
	return list(
		MAP_LV_624 = /obj/item/map/lazarus_landing_map,
		MAP_LV_624_REPAIRED = /obj/item/map/lazarus_landing_map,
		MAP_ICE_COLONY = /obj/item/map/ice_colony_map,
		MAP_ICE_COLONY_V1 = /obj/item/map/ice_colony_map/v1,
		MAP_ICE_COLONY_V2 = /obj/item/map/ice_colony_map/v2,
		MAP_ICE_COLONY_V3 = /obj/item/map/ice_colony_map_v3,
		MAP_WHISKEY_OUTPOST = /obj/item/map/whiskey_outpost_map,
		MAP_BLACKSTONE_BRIDGE = /obj/item/map/blackstone_bridge,
		MAP_BIG_RED = /obj/item/map/big_red_map,
		MAP_PRISON_STATION = /obj/item/map/FOP_map,
		MAP_PRISON_STATION_V3 = /obj/item/map/FOP_map_v3,
		MAP_DESERT_DAM = /obj/item/map/desert_dam,
		MAP_SOROKYNE_STRATA = /obj/item/map/sorokyne_map,
		MAP_CORSAT = /obj/item/map/corsat,
		MAP_KUTJEVO = /obj/item/map/kutjevo_map,
		MAP_LV522_CHANCES_CLAIM = /obj/item/map/lv522_map,
		MAP_NEW_VARADERO = /obj/item/map/new_varadero,
		MAP_NEW_VARADERO_REPAIRED = new /obj/item/map/new_varadero(),
		MAP_DERELICT_ALMAYER = /obj/item/map/almayer,
	)

//used by marine equipment machines to spawn the correct map.
/obj/item/map/current_map

/obj/item/map/current_map/Initialize(mapload, ...)
	. = ..()

	var/obj/item/map/ground_map = PATH_TO_GROUND_MAP_OBJ
	if(!ground_map) return FALSE //If it doesn't find anything in the referenced list, nothing else to do here. Cya.

	name = initial(ground_map.name)
	desc = initial(ground_map.desc)
	html_link = initial(ground_map.html_link)
	html_override = initial(ground_map.html_override)
	color = initial(ground_map.color)

// Landmark - Used for mapping. Will spawn the appropriate map for each gamemode (LV map items will spawn when LV is the gamemode, etc)
/obj/effect/landmark/map_item
	name = "map item"
	icon_state = "ipool"

/obj/effect/landmark/map_item/Initialize(mapload, ...)
	. = ..()
	GLOB.map_items += src

/obj/effect/landmark/map_item/Destroy()
	GLOB.map_items -= src
	return ..()
