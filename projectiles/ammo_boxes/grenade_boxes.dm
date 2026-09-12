/obj/item/ammo_box/magazine/nade_box
	name = "\improper M40 HEDP grenade box"
	desc = "A secure box holding 25 M40 High-Explosive Dual-Purpose grenades. Highly explosive, don't store near the flamer fuel."
	icon = 'icons/obj/items/weapons/guns/ammo_boxes/boxes_and_lids.dmi'
	icon_state = "base_uscm_nade"
	w_class = SIZE_LARGE
	holds_ammo = FALSE
	holds_grenades = TRUE
	num_of_magazines = 25	//Scuffed, but it saves making new examination procs
	magazine_type = /obj/item/explosive/grenade/high_explosive
	allowed_magazines = list(/obj/item/explosive/grenade/high_explosive)
	var/overlay_model_type = "model_m40" //Used for the on-box text
	var/overlay_icon_type = "hedp" //For the on-box color stripe, if any
	var/overlay_grenade_type = "hedp" //For the deployed state, showing grenades inside
	overlay_ammo_type = null
	overlay_gun_type = null
	overlay_content = null
	icon_state_deployed = null
	empty = FALSE
	can_explode = TRUE
	burning = FALSE
	limit_per_tile = 1 //how many you can deploy per tile

	var/grenade_text_markings_icon = 'icons/obj/items/weapons/guns/ammo_boxes/grenade_markings.dmi'
	flames_icon = 'icons/obj/items/weapons/guns/ammo_boxes/misc.dmi'

//---------------------GENERAL PROCS

/obj/item/ammo_box/magazine/nade_box/update_icon()
	if(overlays)
		overlays.Cut()
	if(!icon_state_deployed) // The lid is on the sprite already.
		overlays += image(icon, icon_state = "[icon_state]_lid") //adding lid
	if(overlay_model_type)
		overlays += image(grenade_text_markings_icon, icon_state = "[overlay_model_type]") //adding text
	if(overlay_icon_type)
		overlays += image(grenade_text_markings_icon, icon_state = "[overlay_icon_type]") //adding color stripes

//---------------------INTERACTION PROCS

/obj/item/ammo_box/magazine/nade_box/deploy_ammo_box(mob/living/user, turf/T)
	if(burning)
		to_chat(user, SPAN_DANGER("It's on fire and the grenades inside might explode at any time!"))
		return

	var/obj/structure/magazine_box/nade_box/M = new /obj/structure/magazine_box/nade_box(T)
	M.icon_state = icon_state_deployed ? icon_state_deployed : icon_state
	M.name = name
	M.desc = desc
	M.boom_box = src
	M.update_icon()
	user.drop_inv_item_on_ground(src)
	Move(M)

/obj/item/ammo_box/magazine/nade_box/afterattack(atom/target, mob/living/user, proximity)
	if(burning)
		to_chat(user, SPAN_DANGER("It's on fire and the grenades inside might explode at any time!"))
		return
	if(!proximity)
		return
	if(isturf(target))
		var/turf/T = target
		if(!T.density)
			deploy_ammo_box(user, T)

//---------------------FIRE HANDLING PROCS

/obj/item/ammo_box/magazine/nade_box/flamer_fire_act(damage, datum/cause_data/flame_cause_data)
	if(burning)
		return
	burning = TRUE
	process_burning(flame_cause_data)
	return

/obj/item/ammo_box/magazine/nade_box/apply_fire_overlay(will_explode = FALSE)
	. = ..()
	var/fire_overlay = image(flames_icon, icon_state = "on_fire_grenade_overlay")
	overlays.Add(fire_overlay)

//--------------------GRENADE BOXES

/obj/item/ammo_box/magazine/nade_box/bfab
	name = "\improper M51A BFAB grenade box"
	desc = "A secure box holding 25 M51A Bounding Fragmentation, Air-Burst grenades. Highly explosive, don't store near the flamer fuel."
	magazine_type = /obj/item/explosive/grenade/high_explosive/impact/tmfrag
	allowed_magazines = list(/obj/item/explosive/grenade/high_explosive/impact/tmfrag)
	overlay_model_type = "model_m51a"
	overlay_icon_type = "bfab"
	overlay_grenade_type = "bfab"

/obj/item/ammo_box/magazine/nade_box/heap
	name = "\improper M38 HEAP grenade box"
	desc = "A secure box holding 25 M38 High-Explosive, Armour-Piercing grenades. Highly explosive, don't store near the flamer fuel."
	magazine_type = /obj/item/explosive/grenade/high_explosive/impact/heap
	allowed_magazines = list(/obj/item/explosive/grenade/high_explosive/impact/heap)
	overlay_model_type = "model_m38"
	overlay_icon_type = "heap"
	overlay_grenade_type = "heap"

/obj/item/ammo_box/magazine/nade_box/smoke
	name = "\improper M47 HSDP grenade box"
	desc = "A secure box holding 25 M47 High-density Smoke, Dual-Purpose grenades. Flammable, don't store near the flamer fuel."
	magazine_type = /obj/item/explosive/grenade/smokebomb
	allowed_magazines = list(/obj/item/explosive/grenade/smokebomb)
	overlay_model_type = "model_m47"
	overlay_icon_type = "smoke"
	overlay_grenade_type = "smoke"

/obj/item/ammo_box/magazine/nade_box/smoke/green
	name = "\improper M47-G HSDP grenade box"
	desc = "A secure box holding 25 M47-G HSDP green smoke grenades. Flammable, don't store near the flamer fuel."
	magazine_type = /obj/item/explosive/grenade/smokebomb/green
	allowed_magazines = list(/obj/item/explosive/grenade/smokebomb/green)
	overlay_icon_type = "gsmoke"
	overlay_grenade_type = "gsmoke"

/obj/item/ammo_box/magazine/nade_box/smoke/red
	name = "\improper M47-R HSDP grenade box"
	desc = "A secure box holding 25 M47-R HSDP red smoke grenades. Flammable, don't store near the flamer fuel."
	magazine_type = /obj/item/explosive/grenade/smokebomb/red
	allowed_magazines = list(/obj/item/explosive/grenade/smokebomb/red)
	overlay_icon_type = "rsmoke"
	overlay_grenade_type = "rsmoke"

/obj/item/ammo_box/magazine/nade_box/flare
	name = "\improper M72A2 HIPF starshell grenade box"
	desc = "A secure box holding 25 M72A2 High-Intensity Parachute-Flare starshell grenades. Flammable, don't store near the flamer fuel."
	magazine_type = /obj/item/explosive/grenade/high_explosive/impact/flare
	allowed_magazines = list(/obj/item/explosive/grenade/high_explosive/impact/flare)
	overlay_model_type = "model_m72"
	overlay_icon_type = "hipf"
	overlay_grenade_type = "hipf"

/obj/item/ammo_box/magazine/nade_box/phophorus
	name = "\improper M60 WPSI grenade box"
	desc = "A secure box holding 25 M60 White-Phosphorus, Smoke/Incendiary chemical compound grenades. Highly flammable and explosive, don't store near the flamer fuel."
	magazine_type = /obj/item/explosive/grenade/phosphorus
	allowed_magazines = list(/obj/item/explosive/grenade/phosphorus)
	overlay_model_type = "model_m60"
	overlay_icon_type = "phos"
	overlay_grenade_type = "phos"

/obj/item/ammo_box/magazine/nade_box/incen
	name = "\improper M77 HIAM grenade box"
	desc = "A secure box holding 25 M77 High-explosive-Incendiary, Anti-Mobility grenades. Highly flammable, don't store near the flamer fuel."
	magazine_type = /obj/item/explosive/grenade/incendiary
	allowed_magazines = list(/obj/item/explosive/grenade/incendiary)
	overlay_model_type = "model_m77"
	overlay_icon_type = "hiam"
	overlay_grenade_type = "hiam"

/obj/item/ammo_box/magazine/nade_box/canister
	name = "\improper M108 canister grenade box"
	desc = "A secure box holding 25 M108 canister grenades. Flammable, don't store near the flamer fuel."
	magazine_type = /obj/item/explosive/grenade/high_explosive/airburst/canister
	allowed_magazines = list(/obj/item/explosive/grenade/high_explosive/airburst/canister)
	overlay_model_type = "model_m108"
	overlay_icon_type = "buck"
	overlay_grenade_type = "buck"

/obj/item/ammo_box/magazine/nade_box/foam
	name = "\improper M42 MFHS grenade box"
	desc = "A secure box holding 25 M42 Metal-Foam Hull-Sealant grenades. Flammable, don't store near the flamer fuel."
	magazine_type = /obj/item/explosive/grenade/metal_foam
	allowed_magazines = list(/obj/item/explosive/grenade/metal_foam)
	overlay_model_type = "model_m42"
	overlay_icon_type = "foam"
	overlay_grenade_type = "foam"

/obj/item/ammo_box/magazine/nade_box/m15
	name = "\improper M15 frag grenade box"
	desc = "A secure box holding 25 older M15-model fragmentation grenades. Highly explosive, don't store near the flamer fuel."
	magazine_type = /obj/item/explosive/grenade/high_explosive/m15
	allowed_magazines = list(/obj/item/explosive/grenade/high_explosive/m15)
	overlay_model_type = "model_m15"
	overlay_icon_type = "m15"
	overlay_grenade_type = "m15"

/obj/item/ammo_box/magazine/nade_box/super
	name = "\improper M40-2 \"super\" HEDP grenade box"
	desc = "A secure box holding 25 modified M40-2 High-Explosive Dual-Purpose grenades. Highly explosive, don't store near the flamer fuel."
	magazine_type = /obj/item/explosive/grenade/high_explosive/super
	allowed_magazines = list(/obj/item/explosive/grenade/high_explosive/super)
	icon_state = "base_training_nade"
	overlay_model_type = "model_m40"
	overlay_icon_type = "hedp"
	overlay_grenade_type = "m40_2"

//--------------------LTL GRENADE BOXES

/obj/item/ammo_box/magazine/nade_box/training
	name = "\improper M07 training grenade box"
	desc = "A secure box holding 25 M07 training grenades. Harmless and reusable."
	magazine_type = /obj/item/explosive/grenade/high_explosive/training
	allowed_magazines = list(/obj/item/explosive/grenade/high_explosive/training)
	icon_state = "base_training_nade"
	overlay_model_type = "model_mo7"
	overlay_icon_type = "training"
	overlay_grenade_type = "training"

/obj/item/ammo_box/magazine/nade_box/ltl
	name = "\improper M230 LLRB baton grenade box"
	desc = "A secure box holding 25 M230 Less-than-Lethal Rubber Baton grenades. Used for riot control."
	magazine_type = /obj/item/explosive/grenade/slug/baton
	allowed_magazines = list(/obj/item/explosive/grenade/slug/baton)
	icon_state = "base_uscm_ltl"
	overlay_model_type = "model_m230"
	overlay_icon_type = "ltl"
	overlay_grenade_type = "ltl"

/obj/item/ammo_box/magazine/nade_box/ltl/tear_gas
	name = "\improper M66 tear gas grenade box"
	desc = "A secure box holding 25 M66 tear gas grenades. Used for riot control."
	magazine_type = /obj/item/explosive/grenade/tear/marine
	allowed_magazines = list(/obj/item/explosive/grenade/tear/marine)
	overlay_model_type = "model_m66"
	overlay_icon_type = "tgas"
	overlay_grenade_type = "tgas"

//Ostensibly a less-than-lethal grenade
/obj/item/ammo_box/magazine/nade_box/ltl/sebb
	name = "\improper G-2 Electroshock grenade box"
	desc = "A secure box holding 25 G-2 SEBB eletroshock grenades. Don't store near sensitive electronics or under your CO's bed."
	magazine_type = /obj/item/explosive/grenade/sebb
	allowed_magazines = list(/obj/item/explosive/grenade/sebb)
	overlay_model_type = "model_sebb"
	overlay_icon_type = "sebb"
	overlay_grenade_type = "sebb"

//--------------------40MM GRENADE BOXES

/obj/item/ammo_box/magazine/nade_box/fourtymil
	name = "\improper 40mm HEDP grenade box"
	desc = "A secure box holding 25 old-style 40mm High-Explosive, Dual-Purpose grenades."
	magazine_type = /obj/item/explosive/grenade/high_explosive/impact
	allowed_magazines = list(/obj/item/explosive/grenade/high_explosive/impact)
	icon_state = "base_uscm_40mm"
	overlay_model_type = "model_40mm"
	overlay_icon_type = "hedp"
	overlay_grenade_type = "40mm_hedp"

/obj/item/ammo_box/magazine/nade_box/fourtymil/frag
	name = "\improper 40mm HEFA grenade box"
	desc = "A secure box holding 25 old-style 40mm High-Explosive, Fragmenting-Antipersonnel grenades."
	magazine_type = /obj/item/explosive/grenade/high_explosive/impact/frag
	allowed_magazines = list(/obj/item/explosive/grenade/high_explosive/impact/frag)
	overlay_icon_type = "hefa"
	overlay_grenade_type = "40mm_hefa"

/obj/item/ammo_box/magazine/nade_box/fourtymil/incen
	name = "\improper 40mm incendiary grenade box"
	desc = "A secure box holding 25 old-style 40mm incendiary grenades."
	magazine_type = /obj/item/explosive/grenade/incendiary/impact
	allowed_magazines = list(/obj/item/explosive/grenade/incendiary/impact)
	overlay_icon_type = "hiam"
	overlay_grenade_type = "40mm_hiam"

/obj/item/ammo_box/magazine/nade_box/fourtymil/canister
	name = "\improper 40mm canister grenade box"
	desc = "A secure box holding 25 old-style 40mm canister grenades."
	magazine_type = /obj/item/explosive/grenade/high_explosive/airburst/buckshot
	allowed_magazines = list(/obj/item/explosive/grenade/high_explosive/airburst/buckshot)
	overlay_icon_type = "buck"
	overlay_grenade_type = "40mm_buck"

/obj/item/ammo_box/magazine/nade_box/fourtymil/baton
	name = "\improper 40mm rubber-baton grenade box"
	desc = "A secure box holding 25 40mm rubber-baton grenades."
	magazine_type = /obj/item/explosive/grenade/slug/baton/m79
	allowed_magazines = list(/obj/item/explosive/grenade/slug/baton/m79)
	icon_state = "base_uscm_ltl"
	overlay_icon_type = "agms"
	overlay_grenade_type = "40mm_ltl"

//--------------------M74 GRENADE BOXES

/obj/item/ammo_box/magazine/nade_box/fourtymil/airburst
	name = "\improper M74 AGM-F grenade box"
	desc = "A secure box holding 25 M74 AGM Fragmentation grenades. Explosive, don't store near the flamer fuel."
	magazine_type = /obj/item/explosive/grenade/high_explosive/airburst
	allowed_magazines = list(/obj/item/explosive/grenade/high_explosive/airburst)
	overlay_model_type = "model_m74"
	overlay_icon_type = "agmf"
	overlay_grenade_type = "40mm_agmf"

/obj/item/ammo_box/magazine/nade_box/fourtymil/airburst/incen
	name = "\improper M74 AGM-I grenade box"
	desc = "A secure box holding 25 M74 AGM Incendiary grenades. Highly flammable, don't store near the flamer fuel."
	magazine_type = /obj/item/explosive/grenade/incendiary/airburst
	allowed_magazines = list(/obj/item/explosive/grenade/incendiary/airburst)
	overlay_icon_type = "agmi"
	overlay_grenade_type = "40mm_agmi"

/obj/item/ammo_box/magazine/nade_box/fourtymil/airburst/smoke
	name = "\improper M74 AGM-S grenade box"
	desc = "A secure box holding 25 M74 AGM Smoke grenades. Explosive, don't store near the flamer fuel."
	magazine_type = /obj/item/explosive/grenade/smokebomb/airburst
	allowed_magazines = list(/obj/item/explosive/grenade/smokebomb/airburst)
	overlay_icon_type = "agms"
	overlay_grenade_type = "40mm_agms"

//--------------------UPP GRENADE BOXES

/obj/item/ammo_box/magazine/nade_box/upp
	name = "\improper Type 6 grenade box"
	desc = "A secure box holding 12 type 6 fragmentation grenades. Ensure pins are in place before removing from the box."
	num_of_magazines = 12
	magazine_type = /obj/item/explosive/grenade/high_explosive/upp
	allowed_magazines = list(/obj/item/explosive/grenade/high_explosive/upp)
	icon_state = "base_upp_nade"
	overlay_model_type = "model_type6"
	overlay_icon_type = "type6"
	overlay_grenade_type = "type6"

/obj/item/ammo_box/magazine/nade_box/upp/smoke
	name = "\improper RDG-17 smoke grenade box"
	desc = "A secure box holding 12 RDG-17 smoke grenades. Ensure pins are in place before removing from the box."
	magazine_type = /obj/item/explosive/grenade/smokebomb/upp
	allowed_magazines = list(/obj/item/explosive/grenade/smokebomb/upp)
	overlay_model_type = "model_typesmoke"
	overlay_icon_type = "typesmoke"
	overlay_grenade_type = "typesmoke"

/obj/item/ammo_box/magazine/nade_box/upp/wp
	name = "\improper Type 8 WP grenade box"
	desc = "A secure box holding 12 type 8 WP grenades. Ensure pins are in place before removing from the box."
	magazine_type = /obj/item/explosive/grenade/phosphorus/upp
	allowed_magazines = list(/obj/item/explosive/grenade/phosphorus/upp)
	overlay_model_type = "model_typewp"
	overlay_icon_type = "typewp"
	overlay_grenade_type = "typewp"

/obj/item/ammo_box/magazine/nade_box/upp/ugl
	name = "\improper VOG-73 HE grenade box"
	desc = "A secure box holding 15 VOG-73 HE grenades. Don't store near open flames."
	num_of_magazines = 15
	magazine_type = /obj/item/explosive/grenade/high_explosive/impact/upp
	allowed_magazines = list(/obj/item/explosive/grenade/high_explosive/impact/upp)
	overlay_model_type = "model_vog"
	overlay_icon_type = "40mmhe"
	overlay_grenade_type = "upp_40mm_he"

/obj/item/ammo_box/magazine/nade_box/upp/ugl/ap
	name = "\improper VPG-77 AP grenade box"
	desc = "A secure box holding 15 VPG-77 AP grenades. Don't store near open flames."
	magazine_type = /obj/item/explosive/grenade/high_explosive/impact/upp/ap
	allowed_magazines = list(/obj/item/explosive/grenade/high_explosive/impact/upp/ap)
	overlay_model_type = "model_vpg"
	overlay_icon_type = "40mmap"
	overlay_grenade_type = "upp_40mm_ap"

/obj/item/ammo_box/magazine/nade_box/upp/ugl/canister
	name = "\improper VShG-80 Assault-Grenade grenade box"
	desc = "A secure box holding 15 VShG-80 grenades. Don't store near open flames."
	magazine_type = /obj/item/explosive/grenade/high_explosive/airburst/upp
	allowed_magazines = list(/obj/item/explosive/grenade/high_explosive/airburst/upp)
	overlay_model_type = "model_vsgh"
	overlay_icon_type = "40mmbuck"
	overlay_grenade_type = "upp_40mm_buck"

/obj/item/ammo_box/magazine/nade_box/upp/ugl/incen
	name = "\improper VTBG-44 Thermobaric grenade box"
	desc = "A secure box holding 15 VTBG-44 grenades. Don't store near open flames."
	magazine_type = /obj/item/explosive/grenade/incendiary/impact/upp
	allowed_magazines = list( /obj/item/explosive/grenade/incendiary/impact/upp)
	overlay_model_type = "model_vtbg"
	overlay_icon_type = "40mmincend"
	overlay_grenade_type = "upp_40mm_hiam"

//--------------------RMC GRENADE BOXES

/obj/item/ammo_box/magazine/nade_box/rmc
	name = "\improper R2175/A HEDP grenade box"
	desc = "A secure box holding 18 R2175/A HEDP grenades. Highly explosive, don't store near open flames."
	num_of_magazines = 18
	magazine_type = /obj/item/explosive/grenade/high_explosive/rmc
	allowed_magazines = list(/obj/item/explosive/grenade/high_explosive/rmc)
	icon_state = "base_rmc_nade"
	overlay_model_type = "model_r2175"
	overlay_icon_type = "rmchedp"
	overlay_grenade_type = "rmc_hedp"

/obj/item/ammo_box/magazine/nade_box/rmc/incen
	name = "\improper R2175/B HIDP grenade box"
	desc = "A secure box holding 18 R2175/B HIDP grenades. Highly flammable, don't store near open flames."
	magazine_type = /obj/item/explosive/grenade/incendiary/rmc
	allowed_magazines = list(/obj/item/explosive/grenade/incendiary/rmc)
	overlay_icon_type = "rmchidp"
	overlay_grenade_type = "rmc_hidp"

/obj/item/ammo_box/magazine/nade_box/rmc/cn20
	name = "\improper R2175/CN20 gas grenade box"
	desc = "A secure box holding 18 R2175/CN20 nerve-gas grenades. Highly lethal, ensure caps are fitted securely before storage."
	magazine_type = /obj/item/explosive/grenade/nerve_gas/xeno/rmc
	allowed_magazines = list(/obj/item/explosive/grenade/nerve_gas/xeno/rmc)
	overlay_icon_type = "rmcgas"
	overlay_grenade_type = "rmc_cn20"
