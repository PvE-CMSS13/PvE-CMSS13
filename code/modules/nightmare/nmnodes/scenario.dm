/datum/nmnode/scenario_def
	id = "def"
	var/list/values

/datum/nmnode/scenario_def/New(list/spec)
	. = ..()
	values = spec["values"]

/datum/nmnode/scenario_def/Destroy()
	values = null
	return ..()

/datum/nmnode/scenario_def/resolve(datum/nmcontext/context)
	. = ..()
	if(.)
		for(var/value in values)
			context.scenario[value] = values[value]

/**
 * Populates the context with all possible values for a frontend interface.
 *
 * Called from /datum/nmnode/picker/resolve(datum/nmcontext/context).
 * Populates context with entries for scenarios so that it is possible to
 * use them for a front end interface.
 */
/datum/nmnode/scenario_def/proc/catalogue(datum/nmcontext/context)
	for(var/value in values)
		//We want to add to a list of all potential values here.
		if(!(value in context.directory)) //It isn't present in the directory at all.
			context.directory[value] = list(values[value]) //Instance a new list with just our new variable.
		else if(!(values[value] in context.directory[value]) ) //If it is present in the directory, but the associated value isn't in the list of possible values,
			context.directory[value] += values[value] //we need to add it.
