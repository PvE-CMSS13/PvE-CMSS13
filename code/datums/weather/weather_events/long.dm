// Weather events for Big Red
/datum/weather_event/dust/infinite
	name = "Duststorm (Infinite)"
	length = INFINITY

/datum/weather_event/sand/infinite
	name = "Sandstorm (Infinite)"
	length = INFINITY

/datum/weather_event/rock/infinite
	name = "Rockstorm (Infinite)"
	length = INFINITY

// Weather events for Chances Claim
/datum/weather_event/light_rain/lv522/infinite
	name = "LV522 Light Rain (Infinite)"
	length = INFINITY

// Weather events for LV624
/datum/weather_event/light_rain/infinite
	name = "Light Rain (Infinite)"
	length = INFINITY

/datum/weather_event/heavy_rain/infinite
	name = "Heavy Rain (Infinite)"
	length = INFINITY

// Weather events for New Varadero
/datum/weather_event/light_rain/varadero/infinite
	name = "Tropical Storm (Infinite)"
	length = INFINITY

/datum/weather_event/monsoon/infinite
	name = "Monsoon Warning (Infinite)"
	length = INFINITY

// Weather events for Sorokyne
/datum/weather_event/snow/infinite
	name = "Snow (Infinite)"
	length = INFINITY

/datum/weather_event/snowstorm/infinite
	name = "Snowstorm (Infinite)"
	length = INFINITY

/datum/weather_event/blizzard/infinite
	name = "Blizzard (Infinite)"
	length = INFINITY

/datum/weather_event/blizzard/infinite/slow
	name = "GM slow snow"
	length = INFINITY
	turf_overlay_icon_state = "msnow"
	ambience = 'sound/ambience/strata/strata_snowstorm.ogg'
	lightning_chance = 0

/datum/weather_event/blizzard/infinite/medium
	name = "GM medium snow"
	length = INFINITY
	turf_overlay_icon_state = "fsnow"
	ambience = 'sound/ambience/strata/strata_snowstorm.ogg'
	lightning_chance = 5

/datum/weather_event/blizzard/infinite/fast
	name = "GM fast snow"
	length = INFINITY
	turf_overlay_icon_state = "bsnow"
	lightning_chance = 10

/datum/weather_event/blizzard/infinite/fog
	name = "GM fog"
	length = INFINITY
	turf_overlay_icon_state = "fog"
	ambience = 'sound/ambience/strata/strata_snowstorm.ogg'
	lightning_chance = 5
	turf_overlay_alpha = 200

/datum/weather_event/blizzard/infinite/rain
	name = "GM smooth rain"
	length = INFINITY
	turf_overlay_icon_state = "rain"
	ambience = 'sound/ambience/strata/strata_snowstorm.ogg'
	lightning_chance = 5

/datum/weather_event/blizzard/infinite/rain_drops
	name = "GM rain drops"
	length = INFINITY
	turf_overlay_icon_state = "splash"
	ambience = 'sound/ambience/strata/strata_snowstorm.ogg'
	lightning_chance = 5
