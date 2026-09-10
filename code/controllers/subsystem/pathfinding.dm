SUBSYSTEM_DEF(pathfinding)
	name = "Pathfinding"
	priority = SS_PRIORITY_PATHFINDING
	flags = SS_NO_INIT|SS_TICKER|SS_BACKGROUND
	wait = 1
	/// A list of mobs scheduled to process
	var/list/datum/xeno_pathinfo/current_processing = list()
	/// A list of paths to calculate
	var/list/datum/xeno_pathinfo/paths_to_calculate = list()

	/// Tracks how many times pathfinding has been overtick aborted
	var/tick_overtime_count = 0	// as well as how many shots you need to take

	var/list/hash_path = list()
	var/current_position = 1

/datum/controller/subsystem/pathfinding/stat_entry(msg)
	msg = "P:[length(paths_to_calculate)]"
	return ..()

/datum/controller/subsystem/pathfinding/fire(resumed = FALSE)
	if(!resumed)
		current_processing = paths_to_calculate.Copy()

	while(length(current_processing))
		// A* Pathfinding. Uses priority queue
		if(current_position < 1 || current_position > length(current_processing))
			current_position = length(current_processing)

		var/datum/xeno_pathinfo/current_run = current_processing[current_position]
		current_position++

		var/turf/target = current_run.finish

		/// list of tiles already processed by pathfinding indexed by [tile] = distance
		var/list/visited_nodes = current_run.visited_nodes
		/// stores the precursor node for all tiles added to the path, indexed by [tile] = precursor
		var/list/previous_node_link = current_run.previous_node_link
		/// list of tiles to be processed by pathfinding to be added to the route. Stored as index = list("node", "f_distance")
		var/list/expansion_nodes = current_run.expansion_nodes

		while(length(expansion_nodes))
			var/list/unpacked_node = expansion_nodes[1]
			current_run.current_node = unpacked_node["node"]
			expansion_nodes.Cut(1, 2)
			if(!current_run.current_node)
				current_run.to_return.Invoke()
				log_debug("PATHFINDING FAULT! Unable to identify current node in expansion list ([length(expansion_nodes)] contained nodes) for [current_run.agent].")
				QDEL_NULL(current_run)
				return

			for(var/direction in GLOB.cardinals)
				var/turf/neighbor = get_step(current_run.current_node, direction)
				if(neighbor == listgetindex(previous_node_link, current_run.current_node))
					continue
				if(neighbor == target)	// bingo!
					previous_node_link[neighbor] = current_run.current_node
					expansion_nodes.Cut()
					break
				if(listgetindex(visited_nodes, neighbor))
					continue
				if(get_dist(neighbor, current_run.agent) > current_run.path_range)
					continue
				var/distance_between = listgetindex(visited_nodes, current_run.current_node) + DISTANCE_PENALTY
				if(!distance_between)
					visited_nodes[neighbor] = INFINITY
					continue
				if(isclosedturf(neighbor))
					visited_nodes[neighbor] = INFINITY
					continue
				if(direction != get_dir(previous_node_link[current_run.current_node], neighbor))
					distance_between += DIRECTION_CHANGE_PENALTY
				if(isxeno(current_run.agent) && !neighbor.weeds)
					distance_between += NO_WEED_PENALTY
				var/list/blockers = LinkBlocked(current_run.agent, current_run.current_node, neighbor, current_run.ignore, TRUE)
				blockers |= check_special_blockers(current_run.agent, neighbor)
				if(length(blockers))
					if(isxeno(current_run.agent))
						for(var/atom/A as anything in blockers)
							distance_between += A.xeno_ai_obstacle(current_run.agent, direction, target)
					else
						var/datum/component/human_ai/ai_component = current_run.agent.GetComponent(/datum/component/human_ai)
						var/datum/human_ai_brain/brain = ai_component.ai_brain
						for(var/atom/A as anything in blockers)
							distance_between += A.human_ai_obstacle(current_run.agent, brain, direction, target)
				if(distance_between == INFINITY)
					continue	// woah dude, you wont fit
				for(var/blocker_direction in GLOB.cardinals - get_dir(neighbor, current_run.current_node))	// lets see who your friends are
					var/turf/adjacent_blocker = get_step(neighbor, blocker_direction)
					if(!isclosedturf(adjacent_blocker))
						continue
					visited_nodes[adjacent_blocker] = INFINITY
					distance_between += ADJACENT_WALL_PENALTY
				var/f_distance = distance_between + ASTAR_COST_FUNCTION(neighbor) * DISTANCE_PENALTY
				for(var/index in 1 to length(expansion_nodes) + 1)	// fine, you're on the list
					var/list/indexed_node = listgetindex(expansion_nodes, index)
					var/indexed_f_distance = indexed_node ? indexed_node["f_distance"] : INFINITY	// protects against null references
					//neighbor.maptext = "<h3>[f_distance]</h3>"
					if(indexed_f_distance >= f_distance)
						expansion_nodes.Insert(index, list(list("node" = neighbor, "f_distance" = f_distance)))
						visited_nodes[neighbor] = distance_between
						previous_node_link[neighbor] = current_run.current_node
						break

			if(MC_TICK_CHECK)	// take a shot for every time this returns true
				tick_overtime_count++
				return

		if(!previous_node_link[target])	// we never made it
			current_run.to_return.Invoke()
			QDEL_NULL(current_run)
			return

		var/list/path = list()
		var/turf/current_node = target
		while(current_node)
			if(current_node == current_run.start)
				break
			path |= current_node
			if(!listgetindex(previous_node_link, current_node))
				current_run.to_return.Invoke()
				log_debug("PATHFINDING FAULT! Discontinuous node encountered at ([current_node.x], [current_node.y]) when attempting to pathfind [current_run.agent] to [target] after [length(path)] indexed tiles!")
				QDEL_NULL(current_run)
				return
			current_node = previous_node_link[current_node]

		current_run.to_return.Invoke(path)
		QDEL_NULL(current_run)

/datum/controller/subsystem/pathfinding/proc/check_special_blockers(mob/agent, turf/checking_turf)
	var/list/pass_back = list()

	if(checking_turf.check_ai_special_blockers())
		pass_back |= checking_turf
		return pass_back	// if you cant even enter the turf, the rest doesnt really matter

	for(var/atom/blocker as anything in checking_turf.contents)
		if(blocker.check_ai_special_blockers())
			pass_back |= blocker
			continue

	return pass_back

/datum/controller/subsystem/pathfinding/proc/stop_calculating_path(mob/agent)
	var/datum/xeno_pathinfo/data = hash_path[agent]
	qdel(data)

/datum/controller/subsystem/pathfinding/proc/calculate_path(atom/start, atom/finish, path_range, mob/agent, datum/callback/CB, list/ignore)
	if(!get_turf(start) || !get_turf(finish))
		return

	var/datum/xeno_pathinfo/data = hash_path[agent]
	SSpathfinding.current_processing -= data


	if(!data)
		data = new()
		data.RegisterSignal(agent, COMSIG_PARENT_QDELETING, TYPE_PROC_REF(/datum/xeno_pathinfo, qdel_wrapper))

		hash_path[agent] = data
		paths_to_calculate += data

	data.current_node = get_turf(start)
	data.start = data.current_node

	var/turf/target = get_turf(finish)

	data.finish = target
	data.agent = agent
	data.to_return = CB
	data.path_range = path_range
	data.ignore = ignore

	data.visited_nodes[data.current_node] = 1
	data.expansion_nodes |= list(list("node" = data.current_node, "f_distance" = ASTAR_COST_FUNCTION(data.current_node) * DISTANCE_PENALTY))

	data.visited_nodes += data.current_node

/datum/xeno_pathinfo
	var/turf/start
	var/turf/finish
	var/mob/agent
	var/datum/callback/to_return
	var/path_range

	var/turf/current_node
	var/list/ignore
	/// list of tiles already processed by pathfinding indexed by [tile] = distance
	var/list/visited_nodes = list()
	/// stores the precursor node for all tiles added to the path, indexed by [tile] = precursor
	var/list/previous_node_link = list()
	/// list of tiles to be processed by pathfinding to be added to the route. Stored as index = list("node", "f_distance")
	var/list/expansion_nodes = list()

/datum/xeno_pathinfo/proc/qdel_wrapper()
	SIGNAL_HANDLER
	qdel(src)

/datum/xeno_pathinfo/New()
	. = ..()
	visited_nodes = list()
	previous_node_link = list()
	expansion_nodes = list()

/datum/xeno_pathinfo/Destroy(force)
	SSpathfinding.hash_path -= agent
	SSpathfinding.paths_to_calculate -= src
	SSpathfinding.current_processing -= src

	start = null
	finish = null
	agent = null
	to_return = null
	visited_nodes = null
	expansion_nodes = null
	previous_node_link = null
	return ..()
