// Plasma cannon for ridgeway tank
/obj/item/hardpoint/primary/cannon/plasmacannon
	name = "\improper Boyars PARS 177 PDW"
	desc = "The Boyars PARS 177 Point-Defence-Weapon is a 20kW phased plasma directed energy weapon used to defend the M40 Ridgeway from aerospace craft, missiles, and unofficially, visible hostile infantry. A welcome improvement over older laser based systems employed by the M22 Jackson and M34 Longstreet, providing hard-kill ability capable of downing aircraft and flash-vaporizing infantry."

	icon = 'icons/obj/vehicles/hardpoints/tank.dmi'
	icon_state = "plasma_cannon"
	disp_icon = "ridgeway"
	disp_icon_state = "plasma_cannon"
	activation_sounds = list('sound/weapons/gun_xm99.ogg')

	health = 2300
	firing_arc = 60

	ammo = new /obj/item/ammo_magazine/hardpoint/plasmacannon
	max_clips = 3

	px_offsets = list(
		"1" = list(0, 46),
		"2" = list(0, -43),
		"4" = list(35, 2),
		"8" = list(-35, 2)
	)

	use_muzzle_flash = FALSE
	muzzleflash_icon_state = "muzzle_flash_blue"

	muzzle_flash_pos = list(
		"1" = list(0, 67),
		"2" = list(-1, -88),
		"4" = list(86, -6),
		"8" = list(-86, -6)
	)

	scatter = 0
	fire_delay = 10.0 SECONDS

	var/obj/effect/ebeam/plasma_beam_type = /obj/effect/ebeam/laser/plasma
	///world.time value, to prevent a lightshow without actually firing
	var/beam_cooldown = 0
	///Delay before another beam can start again, in tenths of seconds
	var/beam_delay = 20

/obj/item/hardpoint/primary/cannon/plasmacannon/handle_fire(atom/target, mob/living/user, /obj/vehicle/multitile/owner, params)

    var/datum/beam/plasma_beam
    if(!ammo.current_rounds)
        click_empty(owner)
        return
    plasma_beam = target.beam(owner, "light_beam", 'icons/effects/beam.dmi', time = 0.7 SECONDS, maxdistance = 30, beam_type = plasma_beam_type, always_turn = TRUE)
    animate(plasma_beam.visuals, alpha = 255, time = 0.7 SECONDS, color = COLOR_PURPLE, luminosity = 3 , easing = SINE_EASING|EASE_OUT)
    . = ..()

