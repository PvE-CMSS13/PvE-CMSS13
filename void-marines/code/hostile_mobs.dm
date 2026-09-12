// shitcode

/mob/living/simple_animal/hostile/roach
	name = "roach"
	desc = "A monstrous, dog-sized cockroach. These huge mutants can be everywhere where humans are, on ships, planets and stations."
	icon = 'void-marines/icons/roach.dmi'
	icon_state = "roach"
	icon_living = "roach"
	icon_dead = "roach_dead"
	speak_emote = list("chirps loudly")
	emote_hear = list("chirps loudly.", "cleans its whiskers with forelegs.")
	speak_chance = 5
	turns_per_move = 4
	see_in_dark = 10
	meat_type = /obj/item/reagent_container/food/snacks/bearmeat
	response_help  = "pets the"
	response_disarm = "gently pushes aside the"
	response_harm   = "pokes the"
	stop_automated_movement_when_pulled = 0
	maxHealth = 100
	health = 100
	melee_damage_lower = 5
	melee_damage_upper = 15
	heat_damage_per_tick = 20
	cold_damage_per_tick = 20
	faction = "roaches"
	move_to_delay = 8
	speed = 2
	density = 0

/mob/living/simple_animal/hostile/roach/FindTarget()
	. = ..()
	if(.)
		manual_emote("chirps loudly at [.]")

/mob/living/simple_animal/hostile/roach/AttackingTarget()
	. =..()
	var/mob/living/L = .
	if(istype(L))
		if(prob(10))
			L.apply_effect(3, EYE_BLUR)


/mob/living/simple_animal/hostile/roach/panzer
	name = "Panzer Roach"
	desc = "A monstrous, dog-sized cockroach. This one looks more robust than others."
	icon_state = "panzer"
	icon_living = "panzer"
	icon_dead = "panzer_dead"
	maxHealth = 300
	health = 300
	melee_damage_lower = 10
	melee_damage_upper = 25
	speed = 5
	density = 1

/mob/living/simple_animal/hostile/roach/benzin
	name = "Benzin Roach"
	desc = "A monstrous, dog-sized cockroach. This one smells like welding fuel."
	icon_state = "boomroach"
	icon_living = "boomroach"
	icon_dead = "boomroach_dead"
	turns_per_move = 4
	maxHealth = 50
	health = 50
	melee_damage_lower = 5
	melee_damage_upper = 10
	speed = 2
	density = 0

/mob/living/simple_animal/hostile/roach/benzin/bullet_act(obj/projectile/P)
	if(stat != DEAD)
		explosion(get_turf(src), -1, -1, 2, 3)
