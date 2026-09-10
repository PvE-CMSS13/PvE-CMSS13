//A 'wound' system for space suits.
//Breaches make a process() in spacesuits.dm lower the temperature of the human wearing them
//A workaround for the bitflag, binary based temperature clothing system in handle_enviroment.dm
#define SPACESUIT_BREACH_SOFTSUIT 3
#define SPACESUIT_BREACH_CIVILIAN 2.5
#define SPACESUIT_BREACH_STANDARD 1.5
#define SPACESUIT_BREACH_COMBAT 1.1
#define SPACESUIT_BREACH_THRESHOLD_CONSTANT 6 // to be made smaller by breach_vulnerability, inversely
#define SPACESUIT_COOLING_WHEN_DAMAGED_MULTIPLIER 2

/datum/spacesuit_configuration
	var/breach_probabability_scale = 12 //Log scale based on damage after armour reduced it is used to prob if a breach should happen
	var/breach_magnitude_scale = 0.06 //Size of breach after above
	var/breach_prob_of_new_vs_widen = 30 //prob of making a new breach over widening an existing one
	var/oxygen_usage_multiplier = 1
	var/movement_delay_while_drifting = 3
GLOBAL_DATUM_INIT(spacesuit_config, /datum/spacesuit_configuration, new)

/datum/breach
	var/class = 0    // Size. Lower is smaller.
	var/descriptor   // 'gaping hole' etc.
	var/damtype = BURN   // Punctured or melted
	var/patched = FALSE
	var/obj/item/clothing/suit/space/holder // Suit containing the list of breaches holding this instance.

/obj/item/clothing/suit/space

	var/can_breach = 1   // Set to 0 to disregard all breaching.
	var/list/breaches = list()   // Breach datum container.
	var/breach_vulnerability = SPACESUIT_BREACH_CIVILIAN // Multiplier that turns damage into breach class. 1 is 100% of damage to breach, 0.1 is 10%. Influences breach-causing damage threshold
	var/damage = 0   // Current total damage, does not count patched breaches
	var/brute_damage = 0 // Specifically brute damage.
	var/burn_damage = 0  // Specifically burn damage.
	var/base_name    // Used to keep the original name safe while we apply modifiers.

//Some simple descriptors for breaches. Global because lazy, TODO: work out a better way to do this.

GLOBAL_LIST_INIT(breach_brute_descriptors, list(
	"tiny puncture",
	"ragged tear",
	"large split",
	"huge tear",
	"gaping wound"
	))

GLOBAL_LIST_INIT(breach_burn_descriptors, list(
	"small burn",
	"melted patch",
	"sizable burn",
	"large scorched area",
	"huge scorched area"
	))

/datum/breach/proc/update_descriptor()

	//Sanity...
	class = max(1,min(class,5))
	//Apply the correct descriptor.
	if(damtype == BURN)
		descriptor = GLOB.breach_burn_descriptors[class]
	else if(damtype == BRUTE)
		descriptor = GLOB.breach_brute_descriptors[class]
	if(patched)
		descriptor = "patched [descriptor]"

//Repair a certain amount of brute or burn damage to the suit.
/obj/item/clothing/suit/space/proc/repair_breaches(damtype, amount, mob/user)



/obj/item/clothing/suit/space/proc/create_breaches(damtype, amount)

	if(!can_breach || !amount || (amount < SPACESUIT_BREACH_THRESHOLD_CONSTANT/breach_vulnerability)) //fire is soul, and napalm is below threshold of combat suits
		return

	if(!breaches)
		breaches = list()

	if(damage > 35) return //We don't need to keep tracking it when it's so high.

	if(!loc) return
	var/turf/T = get_turf(src)
	if(!T) return
	var/sound_already_played = FALSE
	var/prob_chance = clamp(log(1 + amount) * GLOB.spacesuit_config.breach_probabability_scale, 1, 100)
	if (!prob(prob_chance))
		return // No hole created
	amount = (amount*breach_vulnerability)*GLOB.spacesuit_config.breach_magnitude_scale //0.1 is to get it within the 1-5 value at min(amount, 5)
	//Increase existing breaches.
	for(var/datum/breach/existing in breaches)
		if(prob(GLOB.spacesuit_config.breach_prob_of_new_vs_widen))
			break //Want mix of new and widening old breaches
		if(existing.damtype != damtype)
			continue

		if (existing.class < 5 || existing.patched)
			if(existing.patched)
				playsound(loc, 'sound/effects/hull_bang.ogg', 35+(amount*5), TRUE, falloff = 3)
				sound_already_played = TRUE
				if (existing.damtype == BRUTE)
					var/message = "\The [existing.descriptor] on \the [src] gapes wider[existing.patched ? ", tearing the patch" : ""]!"
					T.visible_message(SPAN_WARNING(message), max_distance = 1)
				else if (existing.damtype == BURN)
					var/message = "\The [existing.descriptor] on \the [src] widens[existing.patched ? ", ruining the patch" : ""]!"
					T.visible_message(SPAN_WARNING(message), max_distance = 1)
				existing.patched = FALSE
				existing.update_descriptor()
				amount -= existing.class/2
				break
			var/needs = 5 - existing.class
			if(amount < needs)
				existing.class += amount
				amount = 0
			else
				existing.class = 5
				amount -= needs
			var/old_descriptor = existing.descriptor
			existing.update_descriptor()

			if(existing.damtype == BRUTE)
				T.visible_message(SPAN_WARNING("\The [old_descriptor] on [src] gapes wider, turning to a [existing.descriptor][existing.patched ? ", tearing the patch" : ""]"))
			else if(existing.damtype == BURN)
				T.visible_message(SPAN_WARNING("\The [old_descriptor] on [src] widens, turning to a [existing.descriptor][existing.patched ? ", tearing the patch" : ""]"))
	if(!sound_already_played)
		playsound(loc, pick('sound/effects/hull_hit1.ogg', 'sound/effects/hull_hit2.ogg', 'sound/effects/hull_hit3.ogg'), 40+(amount*5), TRUE, falloff = 3)
	if (amount)
		//Spawn a new breach.
		var/datum/breach/B = new()
		breaches += B

		B.class = min(amount,5)

		B.damtype = damtype
		B.update_descriptor()
		B.holder = src

		if(B.damtype == BRUTE)
			T.visible_message(SPAN_WARNING("\A [B.descriptor] opens up on [src]!"), max_distance = 1)
		else if(B.damtype == BURN)
			T.visible_message(SPAN_WARNING("\A [B.descriptor] marks the surface of [src]!"), max_distance = 1)

	calc_breach_damage()


//Calculates the current extent of the damage to the suit.
/obj/item/clothing/suit/space/proc/calc_breach_damage()

	damage = 0
	brute_damage = 0
	burn_damage = 0

	if(!can_breach || !LAZYLEN(breaches))
		name = base_name
		return 0

	for(var/datum/breach/B in breaches)
		if(!B.class)
			src.breaches -= B
			qdel(B)
		else
			if(!B.patched)
				damage += B.class
			if(B.damtype == BRUTE)
				brute_damage += B.class
			else if(B.damtype == BURN)
				burn_damage += B.class

	if(damage >= 5)
		if(brute_damage >= 5 && brute_damage > burn_damage)
			name = "[(damage > 10) ? "heavily " : ""]punctured [base_name]"

		else if(burn_damage >= 5 && burn_damage > brute_damage)
			name = "[(damage > 10) ? "heavily " : ""]scorched [base_name]"
		else
			name = "[base_name]"
	var/patched_breach_tally = 0
	for(var/datum/breach/B in breaches)
		if(B.patched)
			patched_breach_tally++
	if(patched_breach_tally == breaches.len)
		name = "patched [base_name]"
	return damage

//Handles repairs.

/obj/item/clothing/suit/space/attackby(obj/item/W as obj, mob/user as mob)

	if(!(iswelder(W) || iswire(W) || istype(W,/obj/item/stack/sheet/mineral/plastic)))
		return ..()

	if(usr == user)
		if(!do_after(user, 20, INTERRUPT_ALL, BUSY_ICON_FRIENDLY))
			return

	if(!can_breach || !LAZYLEN(breaches) || !damage)
		to_chat(user, "There are no breaches to repair on \the [src].")
		return ..()

	if(iswelder(W))
		var/obj/item/tool/weldingtool/WT = W
		if(WT.isOn())
			if(!WT.remove_fuel(1))
				to_chat(user, SPAN_DANGER("You need more welding fuel to repair this suit."))
				return ..()
		else
			return ..()
	if(iswire(W) || istype(W,/obj/item/stack/sheet/mineral/plastic))
		var/obj/item/stack/repair_material = W
		if(!repair_material.use(2))
			to_chat(user, SPAN_DANGER("You need more material to repair this suit."))
			return ..()

	for(var/datum/breach/B in breaches)
		if(!B.patched)
			B.patched = TRUE
			user.visible_message(SPAN_HELPFUL("<b>[usr]</b> patches the [B.descriptor] using [W]."))
			B.update_descriptor()
			calc_breach_damage()
			return

	..()

/obj/item/clothing/suit/space/get_examine_text(mob/user)
	. = ..()
	if(ishuman(loc))
		var/mob/living/carbon/human/wearer = loc
		if(wearer.bodytemperature > wearer.species.cold_level_1)
			. += SPAN_NOTICE("The skin temperature sensor reads [round(wearer.bodytemperature-T0C, 0.1)]℃")
		else
			. += SPAN_HIGHDANGER("The skin temperature sensor reads [round(wearer.bodytemperature-T0C, 0.1)]℃ ([round(wearer.bodytemperature*1.8-459.67, 0.1)]℉")
	if(flags_inventory & BYPASSFORINJECTOR)
		. += SPAN_HELPFUL("This has an [SPAN_BOLD("injection port")]. This allows the use of [SPAN_BOLD("injectors, syringes, hyposprays and gauze")] while it is being worn.")
	else
		. += SPAN_DANGER("This does [SPAN_BOLD("not have an injection port")]. It is [SPAN_BOLD("impossible to give any medicine while it is being worn")]. This has to be breaking some regulations!")
	if(locate(/datum/action/item_action/spacesuit/toggle_motion_detector) in actions)
		. += SPAN_NOTICE("This has a built-in motion detector. It has a limited range and update frequency compared to the M314 or UDO-58.")
	if(can_breach && LAZYLEN(breaches))
		var/list/breach_counts = list()

		// Count occurrences of each breach flavour name
		for(var/datum/breach/B in breaches)
			breach_counts[B.descriptor] = (breach_counts[B.descriptor] || 0) + 1
		//tally
		for(var/descriptor in breach_counts)
			. += SPAN_DANGER("It has [(breach_counts[descriptor] > 1) ? breach_counts[descriptor] : "a"] [descriptor][(breach_counts[descriptor] > 1) ? "s" : ""].")

	if(supporting_limbs.len) //removing the temp splint and adding it gets handled in spacesuits.dm
		. += SPAN_HELPFUL("It's reactive membranes are supporting your [jointext(supporting_limbs, ", ")].")
// Called from human_damage
/mob/living/carbon/human/proc/handle_suit_punctures(damagetype, damage, def_zone)

	// Tox and oxy don't matter to suits.
	if (damagetype != BURN && damagetype != BRUTE)
		return

	// We may also be taking a suit breach.
	if(!wear_suit) return
	if(!istype(wear_suit,/obj/item/clothing/suit/space)) return
	var/obj/item/clothing/suit/space/SS = wear_suit
	SS.create_breaches(damagetype, damage, def_zone)
