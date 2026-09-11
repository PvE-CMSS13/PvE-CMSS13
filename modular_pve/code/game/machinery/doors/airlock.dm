/obj/structure/machinery/door/airlock/proc/break_or_seal(deconstruct_probability = 50)
	if(prob(deconstruct_probability)) //Maybe it starts out disassembled instead.
		deconstruct(TRUE)
	else
		if(prob(55))
			cut(AIRLOCK_WIRE_DOOR_BOLTS)
		if(prob(35))
			welded = TRUE
			update_icon()
