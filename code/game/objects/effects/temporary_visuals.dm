/obj/effect/temp_visual//ported (pasted) from TG13
	icon_state = null
	anchored = TRUE
	layer = ABOVE_MOB_LAYER
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	//time, in deciseconds of duration
	var/duration = 10
	///if true, will pick a random direction when created.
	var/randomdir = TRUE
	///id of the deletion timer
	var/timerid

/obj/effect/temp_visual/Initialize(mapload)
	. = ..()
	if(randomdir)
		setDir(pick(GLOB.cardinals))

	timerid = QDEL_IN(src, duration)

/obj/effect/temp_visual/Destroy()
	. = ..()
	deltimer(timerid)

//-----------------------------------------
//HEAVY IMPACT
//-----------------------------------------

/obj/effect/temp_visual/heavy_impact
	icon = 'icons/effects/heavyimpact.dmi'
	icon_state = "heavyimpact"
	duration = 1.3 SECONDS

/obj/effect/temp_visual/heavyimpact/Initialize(mapload)
	. = ..()
	flick("heavyimpact", src)

/obj/effect/temp_visual/dir_setting
	randomdir = FALSE

/obj/effect/temp_visual/dir_setting/Initialize(mapload, set_dir)
	if(set_dir)
		setDir(set_dir)
	. = ..()

//------------------------------------------
//BLOOD HITS
//------------------------------------------

/obj/effect/temp_visual/dir_setting/bloodsplatter
	icon = 'icons/effects/blood.dmi'
	duration = 5
	randomdir = FALSE
	layer = ABOVE_XENO_LAYER
	var/splatter_type = "splatter"

/obj/effect/temp_visual/dir_setting/bloodsplatter/Initialize(mapload, set_dir, fx_duration, color_override)
	if(color_override)
		color = color_override
	if(IS_DIAGONAL_DIR(set_dir))
		icon_state = "[splatter_type][pick(1, 2, 6)]"
	else
		icon_state = "[splatter_type][pick(3, 4, 5)]"
	. = ..()
	if(fx_duration)
		duration = fx_duration
	var/target_pixel_x = 0
	var/target_pixel_y = 0
	switch(set_dir)
		if(NORTH)
			target_pixel_y = 16
		if(SOUTH)
			target_pixel_y = -16
		if(EAST)
			target_pixel_x = 16
		if(WEST)
			target_pixel_x = -16
		if(NORTHEAST)
			target_pixel_x = 16
			target_pixel_y = 16
		if(NORTHWEST)
			target_pixel_x = -16
			target_pixel_y = 16
		if(SOUTHEAST)
			target_pixel_x = 16
			target_pixel_y = -16
		if(SOUTHWEST)
			target_pixel_x = -16
			target_pixel_y = -16
	animate(src, pixel_x = target_pixel_x, pixel_y = target_pixel_y, alpha = 0, time = duration)


/obj/effect/temp_visual/dir_setting/bloodsplatter/xenosplatter
	splatter_type = "csplatter"
	color = BLOOD_COLOR_XENO

/obj/effect/temp_visual/dir_setting/bloodsplatter/human
	splatter_type = "csplatter"
	color = BLOOD_COLOR_HUMAN

/obj/effect/temp_visual/dir_setting/bloodsplatter/hellhound
	splatter_type = "csplatter"
	color = BLOOD_COLOR_YAUTJA

/obj/effect/temp_visual/dir_setting/bloodsplatter/yautjasplatter
	splatter_type = "csplatter"
	color = BLOOD_COLOR_YAUTJA_DARK

/obj/effect/temp_visual/dir_setting/bloodsplatter/synthsplatter
	splatter_type = "csplatter"
	color = BLOOD_COLOR_SYNTHETIC

//------------------------------------------
//Shockwaves
//------------------------------------------

/obj/effect/shockwave
	icon = 'icons/effects/light_overlays/shockwave.dmi'
	icon_state = "shockwave"
	plane = DISPLACEMENT_PLATE_RENDER_LAYER
	pixel_x = -496
	pixel_y = -496
	vis_flags = 0

/obj/effect/shockwave/Initialize(mapload, radius, speed, easing_type = LINEAR_EASING, y_offset, x_offset)
	. = ..()
	if(!speed)
		speed = 1
	if(y_offset)
		pixel_y += y_offset
	if(x_offset)
		pixel_x += x_offset
	QDEL_IN(src, 0.5 * radius * speed)
	transform = matrix().Scale(32 / 1024, 32 / 1024)
	animate(src, time = 0.5 * radius * speed, transform=matrix().Scale((32 / 1024) * radius * 1.5, (32 / 1024) * radius * 1.5), easing = easing_type)

/obj/effect/temp_visual/dropship_flyby
	icon = 'icons/obj/structures/props/flyby_shadows.dmi'
	icon_state = "ud"
	layer = FLY_LAYER
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	duration = 3 SECONDS
	pixel_x = -134
	pixel_y = -134
	pixel_z = -480
	indestructible = TRUE

/obj/effect/temp_visual/dropship_flyby/Initialize()
	. = ..()
	animate(src, pixel_z = 960, time = 3 SECONDS)

/obj/effect/temp_visual/dropship_flyby/krokodil
	icon = 'icons/obj/structures/props/flyby_shadows.dmi'
	icon_state = "krokodil"

/particles/shuttle_dust_hover
	icon = 'icons/effects/effects.dmi'
	icon_state = "smoke"
	width = 750
	height = 750
	count = 1000
	spawning = 20
	lifespan = 8
	fade = 50
	grow = 0.3
	velocity = list(0, 0)
	position = generator(GEN_CIRCLE, 180, 170, NORMAL_RAND)
	gravity = list(0, 0)
	scale = generator(GEN_VECTOR, list(1, 1), list(2,2), NORMAL_RAND)
	rotation = 0
	spin = generator(GEN_NUM, -20, 20)

/obj/effect/temp_visual/dropship_hover
	icon = 'icons/obj/structures/props/flyby_shadows.dmi'
	icon_state = "ud"
	layer = FLY_LAYER
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	duration = 5 SECONDS
	pixel_x = -134
	pixel_y = -134
	alpha = 0
	indestructible = TRUE

/obj/effect/temp_visual/dropship_hover/Initialize()
	. = ..()
	particles = new /particles/shuttle_dust_hover
	animate(src, alpha = 255, time = 1 SECONDS)
	addtimer(CALLBACK(src, PROC_REF(fade_away)), 4 SECONDS)

/obj/effect/temp_visual/dropship_hover/proc/fade_away()
	animate(src, alpha = 0, time = 1 SECONDS)
	particles.spawning = 0

/obj/effect/temp_visual/dropship_hover/krokodil
	icon_state = "krokodil"

/obj/effect/temp_visual/heavyimpact_cas
	name = "heavy impact"
	icon = 'icons/effects/heavyimpact.dmi'
	icon_state = ""
	duration = 13
	indestructible = TRUE

/obj/effect/temp_visual/heavyimpact_cas/Initialize(mapload)
	. = ..()
	flick("heavyimpact", src)

/obj/effect/temp_visual/falling_obj
	icon = 'icons/obj/structures/mortar.dmi'
	icon_state = "mortar_ammo_he"
	appearance_flags = PIXEL_SCALE
	layer = FLY_LAYER
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	duration = 0.2 SECONDS
	pixel_z = 200
	pixel_x = 16
	indestructible = TRUE

/obj/effect/temp_visual/falling_obj/Initialize()
	. = ..()
	var/angle = -135
	add_filter("blur", 2, motion_blur_filter(-1, -1))
	pixel_x = cos(angle) * -400
	pixel_z = sin(angle) * -400
	transform = matrix().Turn(angle)
	animate(src, pixel_z = 0, pixel_x = -16, time = 0.2 SECONDS, , easing = LINEAR_EASING)

/obj/effect/temp_visual/falling_obj/incend
	icon_state = "mortar_ammo_inc"

/obj/effect/temp_visual/falling_obj/smoke
	icon_state = "mortar_ammo_smk"

/obj/effect/temp_visual/falling_obj/nerve
	icon_state = "mortar_ammo_smk"

/obj/effect/temp_visual/falling_obj/flare
	icon_state = "mortar_ammo_smk"
	duration = 0.1 SECONDS

/obj/effect/temp_visual/falling_obj/mlrs
	icon_state = "mlrs_rocket"

/obj/effect/temp_visual/falling_obj/mlrs_smoke
	icon_state = "mlrs_smoke_rocket"

/obj/effect/temp_visual/falling_obj/ob
	icon = 'icons/obj/structures/props/almayer_props.dmi'
	icon_state = "he_ob_upright"

/obj/effect/temp_visual/falling_obj/keeper
	icon = 'icons/obj/structures/props/almayer_props64.dmi'
	icon_state = "paveway_rackless"
	pixel_x = -64
	pixel_y = -64

/obj/effect/temp_visual/falling_obj/napalm
	icon = 'icons/obj/structures/props/almayer_props64.dmi'
	icon_state = "napalm_rackless"
	pixel_x = -64
	pixel_y = -64

/obj/effect/temp_visual/falling_obj/banshee
	icon = 'icons/obj/structures/props/almayer_props64.dmi'
	icon_state = "banshee_rackless"
	pixel_x = -64
	pixel_y = -64
