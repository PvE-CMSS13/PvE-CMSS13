/obj/structure/prop/talker
	name = "ill patient"
	desc = "A rather ill person tied to a hospital bed. They aren't responsive."
	icon = 'void-marines/icons/talking_prop.dmi'
	icon_state = "hospital1"
	layer = 4.0
	unslashable = FALSE
	wrenchable = TRUE
	density = TRUE
	anchored = FALSE
	health = 100

	var/quip_delay_minimum = 5
	COOLDOWN_DECLARE(quip_delay)
	COOLDOWN_DECLARE(damage_delay)

	var/list/talk_lines = list()
	var/list/damage_lines = list()
	var/list/click_lines = list()

/obj/structure/prop/talker/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)
	if(!talk_lines.len)
		talk_lines = list("Huaagh.", "Guaaah.", "H-Help...", "Ough...", "Hrnnn...", "Groaa...")
	if(!damage_lines.len)
		damage_lines = list("Guahh...", "P-Please...", "Huaghh...")
	if(!click_lines.len)
		click_lines = list("G-Get... Help...", "W-Water...", "W-Who..?", "D-Doctor..?", "Aaggh...", "W-Where am I..?", "M-My f-family...")

/obj/structure/prop/talker/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/structure/prop/talker/process()
	if(COOLDOWN_FINISHED(src, quip_delay) && prob(10))
		say_line(pick(talk_lines))
		var/delay = rand(3) + quip_delay_minimum
		COOLDOWN_START(src, quip_delay, delay MINUTES)

/obj/structure/prop/talker/attackby(obj/item/W, mob/user)
	apply_damage(W.force)
	return ..()

/obj/structure/prop/talker/bullet_act(obj/projectile/P)
	apply_damage(P.damage)
	return ..()

/obj/structure/prop/talker/attack_hand(mob/user)
	if(click_lines && click_lines.len)
		if(COOLDOWN_FINISHED(src, damage_delay))
			say_line(pick(click_lines))
			COOLDOWN_START(src, damage_delay, 8 SECONDS)
	return ..()

/obj/structure/prop/talker/proc/apply_damage(amount)
	health -= amount
	make_blood()
	if(health <= 0)
		die()
	else
		attacked()

/obj/structure/prop/talker/proc/make_blood()
	new /obj/effect/decal/cleanable/blood(get_turf(src))

/obj/structure/prop/talker/proc/attacked()
	if(COOLDOWN_FINISHED(src, damage_delay) && prob(25))
		say_line(pick(damage_lines))
		COOLDOWN_START(src, damage_delay, 8 SECONDS)

/obj/structure/prop/talker/proc/die()
	visible_message(SPAN_DANGER("[src] explodes into a pile of gore!"))
	playsound(loc, 'sound/effects/splat.ogg', 50, TRUE)

	for(var/i in 1 to 1)
		new /obj/structure/bed/roller/hospital_empty/bigrollerbloodempty(get_turf(src))
		new /obj/effect/decal/cleanable/blood/gibs(get_turf(src))

	qdel(src)

/obj/structure/prop/talker/proc/say_line(message)
	if (!message)
		return

	for(var/mob/mob in hearers(src, null))
		mob.show_message("<span class='game say'><span class='name'>[src]</span> says, \"[message]\"</span>", SHOW_MESSAGE_AUDIBLE)

	var/list/viewers = get_mobs_in_view(7, src)
	for(var/mob/current_mob in viewers)
		if(!(current_mob.client?.prefs.toggles_langchat & LANGCHAT_SEE_EMOTES))
			viewers -= current_mob

	langchat_speech(message, viewers, GLOB.all_languages, skip_language_check = TRUE)

