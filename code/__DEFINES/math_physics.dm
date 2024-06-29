#define PI 3.141592653

// The TRUE circle constant!
#define TAU (PI * 2)

//"fancy" math for calculating time in ms from tick_usage percentage and the length of ticks
//percent_of_tick_used * (ticklag * 100(to convert to ms)) / 100(percent ratio)
//collapsed to percent_of_tick_used * tick_lag
#define TICK_DELTA_TO_MS(percent_of_tick_used) ((percent_of_tick_used) * world.tick_lag)
#define TICK_USAGE_TO_MS(starting_tickusage) (TICK_DELTA_TO_MS(world.tick_usage-starting_tickusage))


#define MEGAWATT 1000000
#define TEN_MEGAWATTS 10000000
#define HUNDRED_MEGAWATTS 100000000
#define GIGAWATT 1000000000

/// K. The critical point temperature for air.
#define GAS_CRITICAL_TEMPERATURE 132.65

#define QUANTIZE(variable) (round(variable, 0.0001))

#define INFINITY 1.#INF

#define SPEED_OF_LIGHT 3e8 //not exact but hey!
#define SPEED_OF_LIGHT_SQ 9e+16

#define MELTPOINT_SNOW 304.15 //about 30°C
#define MELTPOINT_ICE T0C

#define MELTPOINT_BIOLOGICAL 573 //~300°C
#define MELTPOINT_ROCK 1300
#define MELTPOINT_SILVER	1234
#define MELTPOINT_GOLD	1336
#define MELTPOINT_IRON 1450
#define MELTPOINT_WOOD 1473 //Wood doesn't really melt, but you get the idea.
#define MELTPOINT_GLASS   (1500+T0C)
#define MELTPOINT_STEEL   1714
#define MELTPOINT_SILICON 1684 // KELVIN
#define MELTPOINT_PLASTIC (180+T0C)
#define MELTPOINT_BONE 1943 //Wow!
#define MELTPOINT_TITANIUM 1944
#define MELTPOINT_TUNGSTEN 3672

//Most of these are just guesses in terms of temperature.
#define MELTPOINT_NAPALM_G 630 //Green flame. 30 damage. Enough to burn biological but not much beyond that.
#define MELTPOINT_NAPALM 1273 //Standard flame. 60 damage. Enough to burn possibly gold and silver.
#define MELTPOINT_NAPALM_B 1684 //Blue flame. 80 damage. Could possible burn steel.
#define MELTPOINT_NAPALM_U 2050 //UPP flamer. 100 damage. Enough to damage most things, including titanium.
#define MELTPOINT_NAPALM_W 3336 //OB White flame. 160 damage. Could damage even very reinforced walls.

// The highest number supported is a signed 32-bit floating point number.
// Integers beyond the 24 bit range are represented as single-precision floating points, and thus will lose accuracy beyond the range of +/- 16777216
#define SHORT_REAL_LIMIT 16777216
