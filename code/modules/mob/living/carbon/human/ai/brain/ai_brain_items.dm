/datum/human_ai_brain
	/// If an AI takes out an item from their equipment_map, the place it was last stored is added to this dict
	var/list/equipped_items_original_loc = list()

	/// A list of items that the AI is trying to pick up
	var/list/obj/item/to_pickup = list()

	/// If TRUE, the AI won't try to pick up anything
	var/ignore_looting = FALSE

	/// list("object_type" = list(object_ref = "slot")
	var/list/equipment_map = list(
		HUMAN_AI_HEALTHITEMS = list(),
		HUMAN_AI_AMMUNITION = list(),
		HUMAN_AI_GRENADES = list(),
		HUMAN_AI_TOOLS = list(),
	)

	/// Dict of "storage type" : storage ref
	var/list/container_refs = list(
		"belt" = null,
		"backpack" = null,
		"left_pocket" = null,
		"right_pocket" = null,
		"armor" = null,
		"uniform" = null,
	)

	/// Static list of storage slots that the AI pays attention to for inventory appraisal
	var/static/list/important_storage_slots = list(
		WEAR_BACK,
		WEAR_WAIST,
		WEAR_L_STORE,
		WEAR_R_STORE,
		WEAR_JACKET,
		WEAR_BODY,
	)

	/// Bitflag equivalent of important_storage_slots
	var/static/important_storage_slots_bitflag = SLOT_BACK | SLOT_WAIST | SLOT_STORE | SLOT_OCLOTHING | SLOT_ICLOTHING

	/// If TRUE, the AI ignores darkness when it comes to determining vision
	var/has_nightvision = FALSE

/// Given a "storage type", returns the storage item
/datum/human_ai_brain/proc/get_object_from_loc(object_loc)
	RETURN_TYPE(/obj/item/storage)

	var/obj/item/storage/storage_object
	switch(object_loc)
		if("belt")
			storage_object = tied_human.belt
		if("backpack")
			storage_object = tied_human.back
		if("left_pocket")
			storage_object = tied_human.l_store
		if("right_pocket")
			storage_object = tied_human.r_store
		if("armor")
			if(istype(tied_human.wear_suit, /obj/item/clothing/suit/storage))
				var/obj/item/clothing/suit/storage/storage_suit = tied_human.wear_suit
				storage_object = storage_suit.pockets
		if("uniform")
			if(isclothing(tied_human.w_uniform))
				var/obj/item/clothing/accessory/storage/storage_accessory = locate(/obj/item/clothing/accessory/storage) in tied_human.w_uniform.accessories
				storage_object = storage_accessory.hold
	return storage_object

/// Given a location and a reference, puts a referenced object into the AI's hand if possible
/datum/human_ai_brain/proc/equip_item_from_equipment_map(object_type, obj/item/object_ref)
	if(!object_type || !object_ref)
		return

	var/object_loc = equipment_map[object_type][object_ref]
	var/obj/item/storage/storage_object = get_object_from_loc(object_loc)

	storage_object.remove_from_storage(object_ref, tied_human)
	equipped_items_original_loc[object_ref] = object_loc
	RegisterSignal(object_ref, COMSIG_ITEM_DROPPED, PROC_REF(on_equipment_dropped), override = TRUE)

	return tied_human.put_in_active_hand(object_ref)

/// Given an object path and where it may be stored, returns a ref to that object if it exists
/datum/human_ai_brain/proc/get_item_from_equipment_map_path(object_path, object_type)
	return (locate(object_path) in equipment_map[object_type])

/datum/human_ai_brain/proc/store_item(obj/item/object_ref, object_loc, slot_type)
	if(object_ref.loc != tied_human)
		return

	if(object_ref in equipped_items_original_loc)
		var/obj/item/storage/storage_object = get_object_from_loc(equipped_items_original_loc[object_ref])
		equipped_items_original_loc -= object_ref
		storage_object.attempt_item_insertion(object_ref, FALSE, tied_human)
		if(slot_type)
			equipment_map[slot_type][object_ref] = object_loc
	else if(object_loc) // we assume that we've already checked if something will fit or not
		var/obj/item/storage/storage_item = container_refs[object_loc]
		storage_item.attempt_item_insertion(object_ref, FALSE, tied_human)
		if(slot_type)
			equipment_map[slot_type][object_ref] = object_loc

	to_pickup -= object_ref

/// Whenever an item is deleted, purge it from anywhere it may be stored in here
/datum/human_ai_brain/proc/on_item_delete(obj/item/source, force)
	SIGNAL_HANDLER

	UnregisterSignal(source, COMSIG_PARENT_QDELETING)
	to_pickup -= source

	for(var/name in container_refs)
		if(source == container_refs[name])
			container_refs[name] = null
			return

	for(var/id in equipment_map)
		for(var/obj/item/item_ref as anything in equipment_map[id])
			if(source == item_ref)
				equipment_map[id] -= item_ref
				return

/datum/human_ai_brain/proc/on_item_equip(datum/source, obj/item/equipment, slot)
	SIGNAL_HANDLER
	to_pickup -= equipment

	if((slot in important_storage_slots) && istype(equipment, /obj/item/storage))
		recalculate_containers()
		appraise_inventory(slot == WEAR_WAIST, slot == WEAR_BACK, slot == WEAR_L_STORE, slot == WEAR_R_STORE, slot == WEAR_JACKET, slot == WEAR_BODY)

	if(!primary_weapon && isgun(equipment) && (slot == WEAR_J_STORE))
		set_primary_weapon(equipment)

	if(istype(equipment, /obj/item/clothing/glasses/night) && (slot == WEAR_EYES))
		has_nightvision = TRUE

/datum/human_ai_brain/proc/on_item_unequip(datum/source, obj/item/equipment, slot)
	SIGNAL_HANDLER

	if((important_storage_slots_bitflag & slot) && istype(equipment, /obj/item/storage))
		recalculate_containers()
		appraise_inventory(slot == SLOT_WAIST, slot == SLOT_BACK, slot == SLOT_STORE, slot == SLOT_STORE, slot == SLOT_OCLOTHING, slot == SLOT_ICLOTHING)

	if(isgun(equipment))
		appraise_inventory(FALSE, FALSE, FALSE, FALSE, FALSE, FALSE)

	if(istype(equipment, /obj/item/clothing/glasses/night) && (slot == WEAR_EYES))
		has_nightvision = FALSE

/// Reappraises what storage items the AI has
/datum/human_ai_brain/proc/recalculate_containers()
	container_refs = list()
	if(isstorage(tied_human.belt))
		container_refs["belt"] = tied_human.belt
	if(isstorage(tied_human.back))
		container_refs["backpack"] = tied_human.back
	if(isstorage(tied_human.l_store))
		container_refs["left_pocket"] = tied_human.l_store
	if(isstorage(tied_human.r_store))
		container_refs["right_pocket"] = tied_human.r_store
	if(istype(tied_human.wear_suit, /obj/item/clothing/suit/storage))
		var/obj/item/clothing/suit/storage/storage_suit = tied_human.wear_suit
		container_refs["armor"] = storage_suit.pockets
	if(isclothing(tied_human.w_uniform))
		var/obj/item/clothing/accessory/storage/storage_accessory = locate(/obj/item/clothing/accessory/storage) in tied_human.w_uniform.accessories
		if(storage_accessory)
			container_refs["uniform"] = storage_accessory.hold

/// Currently doesn't support recursive storage
/// Used to determine what the AI has in their inventory
/datum/human_ai_brain/proc/appraise_inventory(belt = TRUE, back = TRUE, pocket_l = TRUE, pocket_r = TRUE, armor = TRUE, uniform = TRUE)
	if(previous_faction != tied_human.faction)
		previous_faction = tied_human.faction
		var/datum/human_ai_faction/our_faction = SShuman_ai.human_ai_factions[tied_human.faction]
		our_faction?.apply_faction_data(src)

	/*if(tied_human.shoes && !primary_melee) // snowflake bootknife check
		var/obj/item/weapon/knife = locate() in tied_human.shoes
		if(knife)
			set_primary_melee(knife)*/

	// snowflake secondary weapon in suit storage check
	if(isgun(tied_human.s_store) && (tied_human.s_store != primary_weapon))
		add_secondary_weapon(tied_human.s_store)

	tried_reload = FALSE // We don't really need to do this in a smart way
	if(belt)
		appraise_belt()

	if(back)
		appraise_back()

	if(pocket_l)
		appraise_left_pocket()

	if(pocket_r)
		appraise_right_pocket()

	if(armor)
		appraise_armor()

	if(uniform && isclothing(tied_human.w_uniform))
		appraise_uniform()

/datum/human_ai_brain/proc/appraise_belt()
	if(isgun(tied_human.belt) && (tied_human.belt != primary_weapon))
		add_secondary_weapon(tied_human.belt)
		return

	if(!istype(tied_human.belt, /obj/item/storage)) // belts can be backpacks, don't ask
		return

	for(var/id in equipment_map)
		for(var/obj/item/item as anything in equipment_map[id])
			if(equipment_map[id][item] != "belt")
				continue

			equipment_map[id] -= item

	RegisterSignal(tied_human.belt, COMSIG_PARENT_QDELETING, PROC_REF(on_item_delete), TRUE)
	item_slot_appraisal_loop(tied_human.belt, "belt")

/datum/human_ai_brain/proc/appraise_back()
	if(isgun(tied_human.back) && (tied_human.back != primary_weapon))
		add_secondary_weapon(tied_human.back)
		return

	if(!istype(tied_human.back, /obj/item/storage/backpack))
		return

	for(var/id in equipment_map)
		for(var/obj/item/item as anything in equipment_map[id])
			if(equipment_map[id][item] != "backpack")
				continue

			equipment_map[id] -= item

	RegisterSignal(tied_human.back, COMSIG_PARENT_QDELETING, PROC_REF(on_item_delete), TRUE)
	item_slot_appraisal_loop(tied_human.back, "backpack")

/datum/human_ai_brain/proc/appraise_left_pocket()
	if(!istype(tied_human.l_store, /obj/item/storage/pouch))
		return

	for(var/id in equipment_map)
		for(var/obj/item/item as anything in equipment_map[id])
			if(equipment_map[id][item] != "left_pocket")
				continue

			equipment_map[id] -= item

	RegisterSignal(tied_human.l_store, COMSIG_PARENT_QDELETING, PROC_REF(on_item_delete), TRUE)
	item_slot_appraisal_loop(tied_human.l_store, "left_pocket")

/datum/human_ai_brain/proc/appraise_right_pocket()
	if(!istype(tied_human.r_store, /obj/item/storage/pouch))
		return

	for(var/id in equipment_map)
		for(var/obj/item/item as anything in equipment_map[id])
			if(equipment_map[id][item] != "right_pocket")
				continue

			equipment_map[id] -= item

	RegisterSignal(tied_human.r_store, COMSIG_PARENT_QDELETING, PROC_REF(on_item_delete), TRUE)
	item_slot_appraisal_loop(tied_human.r_store, "right_pocket")

/datum/human_ai_brain/proc/appraise_armor()
	if(!istype(tied_human.wear_suit, /obj/item/clothing/suit))
		return

	if(istype(tied_human.wear_suit, /obj/item/clothing/suit) && tied_human.loc) // being in nullspace makes lights play weirdly
		var/obj/item/clothing/suit/worn_armor = tied_human.wear_suit
		if(!worn_armor.has_light)
			return
		else if(!worn_armor.light_on)
			worn_armor.turn_light(tied_human, TRUE)

	var/obj/item/clothing/suit/storage/storage_suit = tied_human.wear_suit
	for(var/id in equipment_map)
		for(var/obj/item/item as anything in equipment_map[id])
			if(equipment_map[id][item] != "armor")
				continue

			equipment_map[id] -= item

	RegisterSignal(storage_suit, COMSIG_PARENT_QDELETING, PROC_REF(on_item_delete), TRUE)
	for(var/obj/item/clothing/accessory/storage/armour_webbing in storage_suit.accessories)
		item_slot_appraisal_loop(armour_webbing, "armor")
		return
	if(storage_suit.get_pockets())
		item_slot_appraisal_loop(storage_suit.pockets, "armor")

/datum/human_ai_brain/proc/appraise_uniform()
	var/obj/item/clothing/accessory/storage/located_storage = locate(/obj/item/clothing/accessory/storage) in tied_human.w_uniform.accessories
	if(!located_storage)
		return

	for(var/id in equipment_map)
		for(var/obj/item/item as anything in equipment_map[id])
			if(equipment_map[id][item] != "uniform")
				continue

			equipment_map[id] -= item

	RegisterSignal(located_storage, COMSIG_PARENT_QDELETING, PROC_REF(on_item_delete), TRUE)
	item_slot_appraisal_loop(located_storage.hold, "uniform")

/datum/human_ai_brain/proc/item_slot_appraisal_loop(obj/item/container_to_loop, slot_to_assign)
	for(var/obj/item/inv_item as anything in container_to_loop)
		RegisterSignal(inv_item, COMSIG_PARENT_QDELETING, PROC_REF(on_item_delete), TRUE)
		if(inv_item.flags_human_ai & HEALING_ITEM)
			equipment_map[HUMAN_AI_HEALTHITEMS][inv_item] = slot_to_assign
		else if(inv_item.flags_human_ai & AMMUNITION_ITEM)
			equipment_map[HUMAN_AI_AMMUNITION][inv_item] = slot_to_assign
		else if(inv_item.flags_human_ai & GRENADE_ITEM)
			equipment_map[HUMAN_AI_GRENADES][inv_item] = slot_to_assign
		else if(inv_item.flags_human_ai & TOOL_ITEM)
			equipment_map[HUMAN_AI_TOOLS][inv_item] = slot_to_assign
		else if(isgun(inv_item) && !(inv_item in secondary_weapons))
			add_secondary_weapon(inv_item)

		//else if((inv_item.flags_human_ai & MELEE_WEAPON_ITEM) && !primary_melee)
		//	set_primary_melee(inv_item)

/datum/human_ai_brain/proc/clear_main_hand()
	var/obj/item/active_hand = tied_human.get_active_hand()
	if(!active_hand)
		return

	if(primary_weapon == active_hand)
		if(!holster_primary())
			tied_human.drop_held_item(active_hand)
		return

	var/storage_id = storage_has_room(active_hand)
	if(!storage_id)
		tied_human.drop_held_item(active_hand)
		return

	store_item(active_hand, storage_id)

/datum/human_ai_brain/proc/storage_has_room(obj/item/inserting)
	for(var/container_id in container_refs)
		var/obj/item/storage/container = container_refs[container_id]
		if(container?.can_be_inserted(inserting, tied_human, TRUE))
			return container_id

/datum/human_ai_brain/proc/on_equipment_dropped(obj/item/source, mob/dropper)
	SIGNAL_HANDLER

	if(isturf(source.loc))
		equipped_items_original_loc -= source
		UnregisterSignal(source, COMSIG_ITEM_DROPPED)

/datum/human_ai_brain/proc/on_item_pickup(datum/source, obj/item/picked_up)
	SIGNAL_HANDLER

	if(!primary_weapon && isgun(picked_up))
		set_primary_weapon(picked_up)

	to_pickup -= picked_up

/datum/human_ai_brain/proc/on_item_drop(datum/source, obj/item/dropped)
	SIGNAL_HANDLER
	if(iszombie(tied_human))
		return

	if(dropped == primary_weapon)
		if(!(gun_data?.disposable && !primary_weapon.ai_can_use(tied_human, src)))
			to_pickup |= dropped
		set_primary_weapon(null)

	for(var/slot in container_refs)
		if(container_refs[slot] == dropped)
			appraise_inventory(slot == "belt", slot == "backpack", slot == "left_pocket", slot == "right_pocket", slot == "armor", slot == "uniform")
			break

	for(var/id in equipment_map)
		for(var/obj/item/item_ref as anything in equipment_map[id])
			if(item_ref == dropped)
				equipment_map[id] -= item_ref
				return

/datum/human_ai_brain/proc/set_primary_weapon(obj/item/weapon/gun/new_gun)
	if(primary_weapon)
		UnregisterSignal(primary_weapon, COMSIG_PARENT_QDELETING)
	primary_weapon = new_gun
	appraise_primary()
	if(primary_weapon)
		RegisterSignal(primary_weapon, COMSIG_PARENT_QDELETING, PROC_REF(on_primary_delete), TRUE)

/datum/human_ai_brain/proc/on_primary_delete(datum/source, force)
	SIGNAL_HANDLER

	set_primary_weapon(null)
	to_pickup -= source

/*datum/human_ai_brain/proc/set_primary_melee(obj/item/weapon/new_melee)
	if(primary_melee)
		UnregisterSignal(primary_melee, COMSIG_PARENT_QDELETING)
	primary_melee = new_melee
	appraise_primary()
	if(primary_melee)
		RegisterSignal(primary_melee, COMSIG_PARENT_QDELETING, PROC_REF(on_primary_melee_delete))

/datum/human_ai_brain/proc/on_primary_melee_delete(datum/source, force)
	SIGNAL_HANDLER

	set_primary_melee(null)*/

/datum/human_ai_brain/proc/appraise_primary()
	if(!primary_weapon)
		return
	var/static/datum/firearm_appraisal/default = new()
	for(var/datum/firearm_appraisal/appraisal as anything in GLOB.firearm_appraisals)
		if(is_type_in_list(primary_weapon, appraisal.gun_types))
			gun_data = appraisal
			break

	if(!gun_data)
		gun_data = default

/datum/human_ai_brain/proc/item_search(list/things_around)
	search_loop:
		for(var/obj/item/thing in things_around)
			if(!isturf(thing.loc))
				continue

			if(thing in to_pickup)
				continue

			if(thing.flags_human_ai & GRENADE_ITEM)
				var/obj/item/explosive/grenade/nade = thing
				if(nade.active && (nade.fuse_type == IMPACT_FUSE))
					return
				else if(nade.active && (nade.fuse_type == TIMED_FUSE))
					active_grenade_found = thing
					continue

			if(!primary_weapon && isgun(thing))
				var/obj/item/weapon/gun/thing_gun = thing
				for(var/item in to_pickup)
					if(isgun(item)) // One weapon at a time
						continue search_loop

				for(var/datum/firearm_appraisal/appraisal as anything in GLOB.firearm_appraisals)
					if(is_type_in_list(thing_gun, appraisal.gun_types))
						if(appraisal.disposable && thing_gun.current_mag?.current_rounds <= 0)
							continue search_loop
						break

				add_to_pickup(thing)

			if(istype(thing, /obj/item/storage/belt) && !container_refs["belt"])
				add_to_pickup(thing)

			if(istype(thing, /obj/item/storage/backpack) && !container_refs["backpack"])
				add_to_pickup(thing)

			if(istype(thing, /obj/item/storage/pouch) && (!container_refs["left_pocket"] || !container_refs["right_pocket"]))
				add_to_pickup(thing)

			var/storage_spot = storage_has_room(thing)
			if(!storage_spot || !thing.ai_can_use(tied_human, src, tied_human))
				continue

			if(thing.flags_human_ai & HEALING_ITEM)
				add_to_pickup(thing)

			if((thing.flags_human_ai & AMMUNITION_ITEM) && primary_weapon)
				var/obj/item/ammo_magazine/mag = thing
				if(istype(primary_weapon, mag.gun_type))
					add_to_pickup(thing)

			if(thing.flags_human_ai & GRENADE_ITEM)
				add_to_pickup(thing)

			if(thing.flags_human_ai & TOOL_ITEM)
				add_to_pickup(thing)

/datum/human_ai_brain/proc/add_to_pickup(obj/item/thing)
	RegisterSignal(thing, COMSIG_PARENT_QDELETING, PROC_REF(on_item_delete), TRUE)
	to_pickup += thing

/datum/human_ai_brain/proc/get_tool_from_equipment_map(tool_trait)
	RETURN_TYPE(/obj/item)
	for(var/obj/item/maybe_tool as anything in equipment_map[HUMAN_AI_TOOLS])
		if(!HAS_TRAIT(maybe_tool, tool_trait))
			continue
		return maybe_tool

/datum/human_ai_brain/proc/add_secondary_weapon(obj/item/weapon/gun/secondary)
	if(!secondary || (secondary in secondary_weapons))
		return

	secondary_weapons += secondary
	RegisterSignal(secondary, COMSIG_PARENT_QDELETING, PROC_REF(on_secondary_delete), TRUE)

/datum/human_ai_brain/proc/remove_secondary_weapon(obj/item/weapon/gun/secondary)
	UnregisterSignal(secondary, COMSIG_PARENT_QDELETING)
	secondary_weapons -= secondary

/datum/human_ai_brain/proc/on_secondary_delete(datum/source, force)
	SIGNAL_HANDLER

	remove_secondary_weapon(source)

/datum/human_ai_brain/proc/weapon_ammo_search(obj/item/weapon/gun/weapon)
	for(var/obj/item/ammo_magazine/mag as anything in equipment_map[HUMAN_AI_AMMUNITION])
		if(istype(weapon, mag.gun_type) && mag.ai_can_use(tied_human, src))
			return mag
