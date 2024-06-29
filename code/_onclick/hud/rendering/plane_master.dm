/atom/movable/screen/plane_master
	screen_loc = "CENTER"
	icon_state = "blank"
	appearance_flags = PLANE_MASTER|NO_CLIENT_COLOR
	blend_mode = BLEND_OVERLAY
	plane = LOWEST_EVER_PLANE
	var/show_alpha = 255
	var/hide_alpha = 0

	//--rendering relay vars--
	///integer: what plane we will relay this planes render to
	var/render_relay_plane = RENDER_PLANE_GAME
	///bool: Whether this plane should get a render target automatically generated
	var/generate_render_target = TRUE
	/// A string to manually set the relay render target. By default it's not generated.
	var/set_relay_target
	/// A string to manually set the relay render source. Can be set to a dummy string to ignore render source. By default it links to the render target of the plane master.
	var/set_relay_source
	///integer: blend mode to apply to the render relay in case you dont want to use the plane_masters blend_mode
	var/blend_mode_override
	///reference: current relay this plane is utilizing to render
	var/obj/render_plane_relay/relay

/atom/movable/screen/plane_master/proc/Show(override)
	alpha = override || show_alpha

/atom/movable/screen/plane_master/proc/Hide(override)
	alpha = override || hide_alpha

//Why do plane masters need a backdrop sometimes? Read https://secure.byond.com/forum/?post=2141928
//Trust me, you need one. Period. If you don't think you do, you're doing something extremely wrong.
/atom/movable/screen/plane_master/proc/backdrop(mob/mymob)
	SHOULD_CALL_PARENT(TRUE)
	if(!isnull(render_relay_plane))
		relay_render_to_plane(mymob, render_relay_plane)

/atom/movable/screen/plane_master/floor
	name = "floor plane master"
	plane = FLOOR_PLANE
	appearance_flags = PLANE_MASTER
	blend_mode = BLEND_OVERLAY

///Contains most things in the game world
/atom/movable/screen/plane_master/game_world
	name = "game world plane master"
	plane = GAME_PLANE
	appearance_flags = PLANE_MASTER //should use client color
	render_relay_plane = RENDER_PLANE_FOREGROUND
	render_target = RENDER_TARGET_GAME_WORLD

/atom/movable/screen/plane_master/game_world/relay_render_to_plane(mob/mymob, relay_plane)
	. = ..()
	if(.)
		/// This creates a regular mask on this plane when the FOV knockout is active in buildings (shown to the player).
		relay.add_filter("building_mask", 1, alpha_mask_filter(render_source = RENDER_TARGET_BUILDING_MASK))

/// This layer mimics regular layering so that we get a similar effect for visible roofs, but also allow them to be manipulated via plane master.
/atom/movable/screen/plane_master/roof_visible
	name = "visible roof plane master"
	plane = ROOF_VISIBLE_PLANE
	appearance_flags = PLANE_MASTER
	render_relay_plane = GAME_PLANE /// We render this on to the game world, so as to layer it on top.
	render_target = RENDER_TARGET_ROOF_VISIBLE

/atom/movable/screen/plane_master/roof_visible/relay_render_to_plane(mob/mymob, relay_plane)
	. = ..()
	if(. && isobserver(mymob)) /// Simple check for observers here, as that cuts down on a lot of logic that needs to be done otherwise.
		relay.alpha = 40 /// Makes it less opaque.
		relay.mouse_opacity = MOUSE_OPACITY_TRANSPARENT /// Allows it to be completely click-through.

/atom/movable/screen/plane_master/building
	name = "building mask plane master"
	plane = BUILDING_MASK_PLANE
	appearance_flags = PLANE_MASTER
	render_relay_plane = RENDER_PLANE_FOREGROUND
	render_target = RENDER_TARGET_BUILDING_MASK
	set_relay_source = RENDER_TARGET_GAME_WORLD

/// FOV blocker/mask for tents. Works with the relay system for their effects to create a cool visual. The relay is the object we manipualate in-game.
/atom/movable/screen/plane_master/building/relay_render_to_plane(mob/mymob, relay_plane)
	. = ..()
	if(.)
		/// This creates an inverse mask when FOV knockout is active, getting a single image with the knockout.
		relay.add_filter("fov_color", 1, color_matrix_filter(list(1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1, 0,0,0,0)))
		relay.add_filter("motion_blur", 2, motion_blur_filter(0,0))
		relay.add_filter("building_mask", 3, alpha_mask_filter(render_source = RENDER_TARGET_BUILDING_MASK, flags = MASK_INVERSE))

/// Plane master handling display of building roofs that are normally only shown when entering a building. This entire plane is rendered off-screen and should not be manipulated directly.
/atom/movable/screen/plane_master/roof_hidden
	name = "hidden roof plane master"
	plane = ROOF_HIDDEN_PLANE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	appearance_flags = PLANE_MASTER
	render_relay_plane = RENDER_PLANE_FOREGROUND
	render_target = RENDER_TARGET_ROOF_HIDDEN

/*
* We need to create a custom relay that will do all of the heavy lifting for us.
* This is required because otherwise we cannot re-use the offscreen effects properly.
* This is not the same as a plane master; but it gets the desired effect.
*/
/atom/movable/screen/plane_master/roof_hidden/relay_render_to_plane(mob/mymob, relay_plane)
	. = ..()
	if(.)
		relay.add_filter("weather_overlay", 1, layering_filter(render_source = RENDER_TARGET_WEATHER)) /// This sets the weather overlay on top of it.
		relay.add_filter("hidden_roof_mask", 2, alpha_mask_filter(render_source = RENDER_TARGET_ROOF_HIDDEN)) /// The mask keeps it on the roof.

/// Plane for weather effects.
/atom/movable/screen/plane_master/weather
	name = "weather plane master"
	plane = WEATHER_PLANE
	appearance_flags = PLANE_MASTER
	render_relay_plane = RENDER_PLANE_FOREGROUND
	render_target = RENDER_TARGET_WEATHER

/atom/movable/screen/plane_master/weather/relay_render_to_plane(mob/mymob, relay_plane)
	. = ..()
	if(.)
		if(isobserver(mymob)) /// Observers get the basic masking effect for all roofs.
			relay.add_filter("visisble_roof_mask", 1, alpha_mask_filter(render_source = RENDER_TARGET_ROOF_VISIBLE, flags = MASK_INVERSE))
		else
			relay.add_filter("hidden_roof_mask", 1, alpha_mask_filter(render_source = RENDER_TARGET_ROOF_HIDDEN, flags = MASK_INVERSE))

/atom/movable/screen/plane_master/ghost
	name = "ghost plane master"
	plane = GHOST_PLANE
	appearance_flags = PLANE_MASTER //should use client color
	render_relay_plane = RENDER_PLANE_NON_GAME

/**
 * Plane master handling byond internal blackness
 * vars are set as to replicate behavior when rendering to other planes
 * do not touch this unless you know what you are doing
 */
/atom/movable/screen/plane_master/blackness
	name = "darkness plane master"
	plane = BLACKNESS_PLANE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	blend_mode = BLEND_MULTIPLY
	appearance_flags = PLANE_MASTER | NO_CLIENT_COLOR | PIXEL_SCALE
//byond internal end

/*!
 * This system works by exploiting BYONDs color matrix filter to use layers to handle emissive blockers.
 *
 * Emissive overlays are pasted with an atom color that converts them to be entirely some specific color.
 * Emissive blockers are pasted with an atom color that converts them to be entirely some different color.
 * Emissive overlays and emissive blockers are put onto the same plane.
 * The layers for the emissive overlays and emissive blockers cause them to mask eachother similar to normal BYOND objects.
 * A color matrix filter is applied to the emissive plane to mask out anything that isn't whatever the emissive color is.
 * This is then used to alpha mask the lighting plane.
 */

///Contains all lighting objects
/atom/movable/screen/plane_master/lighting
	name = "lighting plane master"
	plane = LIGHTING_PLANE
	blend_mode_override = BLEND_MULTIPLY
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/atom/movable/screen/plane_master/lighting/backdrop(mob/mymob)
	. = ..()
	mymob.overlay_fullscreen("lighting_backdrop", /atom/movable/screen/fullscreen/lighting_backdrop/backplane)
	mymob.overlay_fullscreen("lighting_backdrop_lit_secondary", /atom/movable/screen/fullscreen/lighting_backdrop/lit_secondary)

/atom/movable/screen/plane_master/lighting/Initialize()
	. = ..()
	add_filter("emissives", 1, alpha_mask_filter(render_source = EMISSIVE_RENDER_TARGET, flags = MASK_INVERSE))
	add_filter("object_lighting", 2, alpha_mask_filter(render_source = O_LIGHTING_VISUAL_RENDER_TARGET, flags = MASK_INVERSE))

/atom/movable/screen/plane_master/lighting/exterior
	name = "exterior lighting plane master"
	plane = EXTERIOR_LIGHTING_PLANE

/**
 * Handles emissive overlays and emissive blockers.
 */
/atom/movable/screen/plane_master/emissive
	name = "emissive plane master"
	plane = EMISSIVE_PLANE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	render_target = EMISSIVE_RENDER_TARGET
	render_relay_plane = null

/atom/movable/screen/plane_master/emissive/Initialize()
	. = ..()
	add_filter("em_block_masking", 1, color_matrix_filter(GLOB.em_mask_matrix))

/atom/movable/screen/plane_master/above_lighting
	name = "above lighting plane master"
	plane = ABOVE_LIGHTING_PLANE
	appearance_flags = PLANE_MASTER //should use client color
	render_relay_plane = RENDER_PLANE_GAME

/atom/movable/screen/plane_master/runechat
	name = "runechat plane master"
	plane = RUNECHAT_PLANE
	appearance_flags = PLANE_MASTER
	render_relay_plane = RENDER_PLANE_NON_GAME

/atom/movable/screen/plane_master/o_light_visual
	name = "overlight light visual plane master"
	plane = O_LIGHTING_VISUAL_PLANE
	render_target = O_LIGHTING_VISUAL_RENDER_TARGET
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	blend_mode = BLEND_MULTIPLY
	blend_mode_override = BLEND_MULTIPLY

/atom/movable/screen/plane_master/runechat/backdrop(mob/mymob)
	. = ..()
	remove_filter("AO")
	add_filter("AO", 1, drop_shadow_filter(x = 0, y = -2, size = 4, color = "#04080FAA"))

/atom/movable/screen/plane_master/fullscreen
	name = "fullscreen alert plane"
	plane = FULLSCREEN_PLANE
	render_relay_plane = RENDER_PLANE_NON_GAME
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/atom/movable/screen/plane_master/hud
	name = "HUD plane"
	plane = HUD_PLANE
	render_relay_plane = RENDER_PLANE_NON_GAME

/atom/movable/screen/plane_master/above_hud
	name = "above HUD plane"
	plane = ABOVE_HUD_PLANE
	render_relay_plane = RENDER_PLANE_NON_GAME

/atom/movable/screen/plane_master/cinematic
	name = "cinematic plane"
	plane = CINEMATIC_PLANE
	render_relay_plane = RENDER_PLANE_NON_GAME

/atom/movable/screen/plane_master/escape_menu
	name = "Escape Menu"
	plane = ESCAPE_MENU_PLANE
	appearance_flags = PLANE_MASTER|NO_CLIENT_COLOR
	render_relay_plane = RENDER_PLANE_MASTER

/atom/movable/screen/plane_master/displacement
	name = "displacement plane"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	plane = DISPLACEMENT_PLATE_RENDER_LAYER
	render_target = DISPLACEMENT_PLATE_RENDER_TARGET
	render_relay_plane = null
