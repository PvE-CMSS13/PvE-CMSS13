/obj/structure/machinery/computer/cameras/uscm_ground
	desc = "A computer console linked to all outpost camera feeds."
	network = list(CAMERA_NET_USCM_GROUND, CAMERA_NET_USCM_GROUND_WEST, CAMERA_NET_USCM_GROUND_EAST)
	req_access = list(ACCESS_MARINE_COMMAND)
	colony_camera_mapload = FALSE

/obj/structure/machinery/computer/cameras/uscm_ground/checkpoint
	name = "checkpoint camera console"
	desc = "A computer console linked to a security checkpoint feed."
	dir = EAST
	network = list(CAMERA_NET_USCM_GROUND_WEST)
	req_access = list(ACCESS_MARINE_PREP)

/obj/structure/machinery/computer/cameras/uscm_ground/checkpoint/east
	network = list(CAMERA_NET_USCM_GROUND_EAST)
