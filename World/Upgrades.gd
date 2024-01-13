extends GridContainer

@export var player : Node

enum {
	RES_GEMS = 0,
	RES_GOLD = 1,
	RES_IRON = 2,
	RES_OXY = 3,
}

const upgrade_costs := [
	[ # 0 Oxygen Lines
		{
			"type1": RES_OXY, "amount1": 20,
			"effect": 1.0
		},
	],

	[ # 1 Oxygen Cap
		{
			"type1": RES_IRON, "amount1": 20,
			"effect": 20.0
		},
		{
			"type1": RES_IRON, "amount1": 30,
			"effect": 25.0
		},
		{
			"type1": RES_IRON, "amount1": 60,
			"effect": 30.0
		},
		{
			"type1": RES_IRON, "amount1": 70,
			"effect": 35.0
		},
		{
			"effect": 40.0
		},
	],
	[ # 2 Ground's Resistance when mining
		{
			"type1": RES_IRON, "amount1": 30,
			"type2": RES_GOLD, "amount2": 10,
			"effect": 100.0
		},
		{
			"type1": RES_IRON, "amount1": 30,
			"type2": RES_GOLD, "amount2": 10,
			"effect": 70.0
		},
		{
			"type1": RES_IRON, "amount1": 30,
			"type2": RES_GOLD, "amount2": 10,
			"effect": 40.0
		},
		{
			"effect": 10.0
		},
	],
	[ # 3 Motorclaw Mining Level
		{
			"type1": RES_IRON, "amount1": 10,
			"type2": RES_GOLD, "amount2": 5,
			"effect": 0
		},
		{
			"type1": RES_GOLD, "amount1": 30,
			"type2": RES_GEMS, "amount2": 40,
			"effect": 1
		},
		{
			"type1": RES_GEMS, "amount1": 40,
			"type2": RES_IRON, "amount2": 300,
			"effect": 2
		},
		{
			"effect": 3
		},
	],
	[ # 4 Ore Yield
		{
			"type1": RES_GEMS, "amount1": 40,
			"type2": RES_GOLD, "amount2": 40,
			"effect": 1
		},
		{
			"type1": RES_GEMS, "amount1": 60,
			"type2": RES_GOLD, "amount2": 60,
			"effect": 2
		},
		{
			"effect": 3
		},
	],
	[ # 5 Movement Speed
		{
			"type1": RES_IRON, "amount1": 10,
			"type2": RES_GOLD, "amount2": 5,
			"effect": 200.0
		},
		{
			"type1": RES_IRON, "amount1": 30,
			"type2": RES_GOLD, "amount2": 10,
			"effect": 250.0
		},
		{
			"effect": 350.0
		},
	],
	[ # 6 Vision Range
		{
			"type1": RES_IRON, "amount1": 10,
			"type2": RES_GOLD, "amount2": 5,
			"effect": Vector2(100.0, 192.0)
		},
		{
			"type1": RES_IRON, "amount1": 20,
			"type2": RES_GOLD, "amount2": 40,
			"effect": Vector2(175.0, 256.0)
		},
		{
			"effect": Vector2(250.0, 384.0)
		},
	],
]
var buttons := []
var level_displays := []



func _ready():
	var found_upgrades = 0
	for x in get_children():
		if x is Button:
			buttons.append(x)
			var level_display = get_child(x.get_index() - 1)
			level_displays.append(level_display)
			level_display.max_value = 0 if found_upgrades == 0 else upgrade_costs[found_upgrades].size() - 1
			level_display.current_value = -1
			buy_upgrade(found_upgrades, true)
			x.pressed.connect(buy_upgrade.bind(found_upgrades))
			found_upgrades += 1

	visibility_changed.connect(update_costs)
	update_costs()


func buy_upgrade(upgrade_index, test_only = false):
	level_displays[upgrade_index].current_value += 1
	var effect = 1 if upgrade_index == 0 else upgrade_costs[upgrade_index][level_displays[upgrade_index].current_value]["effect"]
	match upgrade_index:
		0: if not test_only: player.get_node("TetherPlacer").count_left += 1
		1: player.get_node("OxygenManager").o2_max = effect
		2: player.RESISTANCE = effect
		3: player.MINING_LEVEL = effect
		4: player.ORE_YIELD = effect
		5: player.ORI_SPEED = effect
		6:
			player.get_node("Darkness").light_radius = effect.x
			player.get_node("../RevealableDarkness").reveal_radius = effect.y

	if not test_only:
		spend_resource_by_index(buttons[upgrade_index].resource1_index,buttons[upgrade_index].resource1_amount)
		spend_resource_by_index(buttons[upgrade_index].resource2_index,buttons[upgrade_index].resource2_amount)
		update_costs()


func update_costs():
	level_displays[0].current_value = 0
	for i in buttons.size():	
		if i != 0 && level_displays[i].current_value == level_displays[i].max_value:
			buttons[i].hide()
			continue

		var upgrade_level = level_displays[i].current_value
		buttons[i].resource1_index = upgrade_costs[i][upgrade_level]["type1"]
		buttons[i].resource1_amount = upgrade_costs[i][upgrade_level]["amount1"]
		buttons[i].resource2_index = upgrade_costs[i][upgrade_level].get("type2", 0)
		buttons[i].resource2_amount = upgrade_costs[i][upgrade_level].get("amount2", 0)
		buttons[i].disabled = (
			get_resource_by_index(buttons[i].resource1_index) < buttons[i].resource1_amount
			|| get_resource_by_index(buttons[i].resource2_index) < buttons[i].resource2_amount
		)
	level_displays[0].current_value = player.get_node("TetherPlacer").count_left


func spend_resource_by_index(index, value):
	match index:
		0:
			player.gems -= value
		1:
			player.gold -= value
		2:
			player.iron -= value
		3:
			player.oxyore -= value


func get_resource_by_index(index):
	match index:
		0:
			return player.gems
		1:
			return player.gold
		2:
			return player.iron
		3:
			return player.oxyore
