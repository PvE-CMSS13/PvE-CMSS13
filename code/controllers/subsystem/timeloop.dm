SUBSYSTEM_DEF(timeloop)
	name = "Timeloop"
	wait = 1 SECONDS
	flags = SS_KEEP_TIMING | SS_NO_INIT | SS_NO_FIRE

	var/mainloop_timer_id
	/// How often does the loop happen
	var/looptime = 8 MINUTES
	/// How long after loop ends that the nuke goes off
	var/nukepostloop = 2 MINUTES
	/// Force-stop the looping
	var/forcestop_loop = FALSE

/datum/controller/subsystem/timeloop/stat_entry(msg)
	if(mainloop_timer_id)
		msg = "TIME:[timeleft(mainloop_timer_id)]"
	return ..()

/datum/controller/subsystem/timeloop/proc/start_timeloop()
	var/time = looptime + 35 SECONDS
	mainloop_timer_id = addtimer(CALLBACK(src, PROC_REF(loop)), time, TIMER_UNIQUE|TIMER_OVERRIDE|TIMER_STOPPABLE)

/datum/controller/subsystem/timeloop/proc/loop()
	if(forcestop_loop)
		return

	revert_timeloop()
	mainloop_timer_id = addtimer(CALLBACK(src, PROC_REF(loop)), looptime + 35 SECONDS, TIMER_UNIQUE|TIMER_OVERRIDE|TIMER_STOPPABLE)
