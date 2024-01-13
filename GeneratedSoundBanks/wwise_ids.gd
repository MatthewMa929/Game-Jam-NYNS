class_name AK

class EVENTS:

	const PLAY_CAVE_OST = 1479112770
	const STOP_DRILL_MINING = 2118051910
	const STOP_COLONY_OST = 2414364521
	const STOP_CAVE_OST = 2296272484
	const PLAY_COLONY_OST = 3238935255
	const DRILL_MINING = 737866587
	const UICLICK = 3164408517
	const WORMTUNNEL = 4256651350
	const OXYGENREFILL = 30680937
	const LOWOXYGEN = 534520757
	const CRYSTAL_BREAK = 756738409

	const _dict = {
		"Play_Cave_OST": PLAY_CAVE_OST,
		"Stop_Drill_Mining": STOP_DRILL_MINING,
		"Stop_Colony_OST": STOP_COLONY_OST,
		"Stop_Cave_OST": STOP_CAVE_OST,
		"Play_Colony_OST": PLAY_COLONY_OST,
		"Drill_Mining": DRILL_MINING,
		"uiClick": UICLICK,
		"wormTunnel": WORMTUNNEL,
		"oxygenRefill": OXYGENREFILL,
		"lowOxygen": LOWOXYGEN,
		"Crystal_Break": CRYSTAL_BREAK
	}

class STATES:

	class LOW_OXYGEN:
		const GROUP = 1860436912

		class STATE:
			const NONE = 748895195

	class WORM_IN_RANGE:
		const GROUP = 1865816856

		class STATE:
			const NONE = 748895195
			const FALSE = 2452206122
			const TRUE = 3053630529

	const _dict = {
		"Low_Oxygen": {
			"GROUP": 1860436912,
			"STATE": {
				"None": 748895195,
			}
		},
		"Worm_in_Range": {
			"GROUP": 1865816856,
			"STATE": {
				"None": 748895195,
				"false": 2452206122,
				"true": 3053630529
			}
		}
	}

class SWITCHES:

	const _dict = {}

class GAME_PARAMETERS:

	const MUSIC_VOLUME = 1006694123
	const SFX_VOLUME = 1564184899
	const PLAYEROXYGEN = 2603805318
	const WORM_DISTANCE_PITCH = 3649139729

	const _dict = {
		"Music_Volume": MUSIC_VOLUME,
		"SFX_Volume": SFX_VOLUME,
		"PlayerOxygen": PLAYEROXYGEN,
		"Worm_Distance_Pitch": WORM_DISTANCE_PITCH
	}

class TRIGGERS:

	const _dict = {}

class BANKS:

	const INIT = 1355168291
	const MAIN = 3161908922

	const _dict = {
		"Init": INIT,
		"Main": MAIN
	}

class BUSSES:

	const ENVIRONMENTAL = 1973600711
	const MUSIC = 3991942870
	const MASTER_AUDIO_BUS = 3803692087
	const SOUND_EFFECTS = 978636652

	const _dict = {
		"Environmental": ENVIRONMENTAL,
		"Music": MUSIC,
		"Master Audio Bus": MASTER_AUDIO_BUS,
		"Sound Effects": SOUND_EFFECTS
	}

class AUX_BUSSES:

	const _dict = {}

class AUDIO_DEVICES:

	const NO_OUTPUT = 2317455096
	const SYSTEM = 3859886410

	const _dict = {
		"No_Output": NO_OUTPUT,
		"System": SYSTEM
	}

class EXTERNAL_SOURCES:

	const _dict = {}

