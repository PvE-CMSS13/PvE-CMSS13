/datum/weather_ss_map_holder/lv522_lukes_landing
	name = "LV-522 Lukes Landing Map Holder"

	warn_time = 1 MINUTES
	min_time_between_events = 1 MINUTES
	min_time_between_checks = 0
	min_check_variance = 0

	no_weather_turf_icon_state = "strata_clearsky"

	potential_weather_events = list(
		/datum/weather_event/heavy_rain/lv522_lukes_landing,
	)

/datum/weather_ss_map_holder/lv522_lukes_landing/should_affect_area(area/A)
	return !CEILING_IS_PROTECTED(A.ceiling, CEILING_GLASS)

/datum/weather_ss_map_holder/lv522_lukes_landing/should_start_event()
	return TRUE
