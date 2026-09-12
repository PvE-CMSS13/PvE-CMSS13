/obj/item/hardpoint/locomotion/treads
	name = "\improper Treads"
	desc = "Integral to the movement of the vehicle. Light-steel alloy tracks with rubber pads for road & shipboard usage, they allow the tank to move faster but in turn are more easily damaged compared to other models."

	icon_state = "treads"
	disp_icon = "tank"
	disp_icon_state = "treads"

	slot = HDPT_TREADS

	health = 1500

	//with this settings, takes 3 tiles to reach top speed
	move_delay = VEHICLE_SPEED_FASTER
	move_max_momentum = 3
	move_momentum_build_factor = 1.5
	move_turn_momentum_loss_factor = 0.6

/obj/item/hardpoint/locomotion/treads/robust
	name = "\improper Reinforced Treads"
	desc = "These treads are made of a tougher steel-composite allow and are more durable. However, the extra weight slows the tank down slightly."

	health = 2500
	acid_resistant = TRUE

	move_max_momentum = 5 //same top speed, but takes 5 tiles to reach it

/obj/item/hardpoint/locomotion/treads/on_install(obj/vehicle/multitile/V)
	for(var/obj/item/hardpoint/support/overdrive_enhancer/OD in V.hardpoints)
		if(OD.health > 0)
			OD.apply_buff(V)
	if(move_delay)
		V.move_delay = move_delay
	if(move_max_momentum)
		V.move_max_momentum = move_max_momentum
	if(move_momentum_build_factor)
		V.move_momentum_build_factor = move_momentum_build_factor
	if(move_turn_momentum_loss_factor)
		V.move_turn_momentum_loss_factor = move_turn_momentum_loss_factor

/obj/item/hardpoint/locomotion/treads/deactivate()
	for(var/obj/item/hardpoint/support/overdrive_enhancer/OD in owner.hardpoints)
		if(OD.health > 0)
			OD.remove_buff(owner)
	owner.move_delay = initial(owner.move_delay)
	owner.move_max_momentum = initial(owner.move_max_momentum)
	owner.move_momentum_build_factor = initial(owner.move_momentum_build_factor)
	owner.move_turn_momentum_loss_factor = initial(owner.move_turn_momentum_loss_factor)

/obj/item/hardpoint/locomotion/treads/ridgeway
	name = "\improper M40 Ridgeway Treads"
	desc = "Treads for the M40 Ridgeway heavy tank. The least groundbreaking of the Ridgeway's advancements, though significant in their ability to tackle many of the problems faced by US forces in the colonies previous tanks couldn't. The tracks terrain adaptability and ease of maintenance design, makes it a favoured component for marine tankers"

	icon_state = "treads_ridgeway"
	disp_icon = "tank"
	disp_icon_state = "treads_ridgeway"

	health = 4500

	move_max_momentum = 5 //same top speed, but takes 5 tiles to reach it
