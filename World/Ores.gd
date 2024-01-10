extends TileMap


#LEFT CLICK TO GENERATE 1 LEVEL, 1300 current limit
var WIDTH = 100
var HEIGHT = 0

var gems = 0
var gold = 0
var iron = 0
var oxyore = 0

var ore_chance = 0.0015
var gem_chance = ore_chance/16.0
var gold_chance = ore_chance/10.0
var iron_chance = ore_chance/2.0
var oxyore_chance = ore_chance

@onready var rng = RandomNumberGenerator.new()

const TILES = {
	'gems': 0,
	'gold': 1,
	'iron': 2,
	'oxyore': 3
}

func _ready():
	create_ores(WIDTH, HEIGHT)
				
				
func _process(delta):
	ore_chance = 0.0015 + (HEIGHT/1000000.0)
	gem_chance = ore_chance/(16.0 - HEIGHT/100.0)
	gold_chance = ore_chance/(10.0 - HEIGHT/150.0)
	iron_chance = ore_chance/2.0
	oxyore_chance = ore_chance
		
func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				HEIGHT += 100
				print([HEIGHT, gems, gold, iron, oxyore])
				create_ores(WIDTH, HEIGHT)
	
func create_ores(width, height):
	for y in range(height, height + 100):
		for x in range(width):
			var rand_num = rng.randf_range(0.0, 1.0)
			if min(gem_chance, gold_chance) > rand_num: #gems
				gems += create_ore_chunk(0, x, y, 0.1)
			elif min(gold_chance, iron_chance) > rand_num: #gold
				gold += create_ore_chunk(1, x, y, 0.15)
			elif iron_chance > rand_num: #iron
				iron += create_ore_chunk(2, x, y, 0.3)
			elif oxyore_chance > rand_num: #oxyore
				oxyore += create_ore_chunk(3, x, y, 0.15)
			else: #dirt
				pass
	
func create_ore_chunk(ore, center_x, center_y, spawn_chance):
	var ore_amt = 0
	var rand_radius = rng.randf_range(2.0, 5.0)
	for x in range(rand_radius*2):
		for y in range(rand_radius*2):
			var rand_num = rng.randf_range(0.0, 1.0)
			if sqrt(((x-rand_radius)**2) + ((y-rand_radius)**2)) <= rand_radius and spawn_chance > rand_num:
				if get_cell_source_id(0, Vector2(x, y)) == -1:
					create_ore(ore, center_x + x, center_y + y)
					ore_amt += 1
	return ore_amt

func create_ore(ore, x, y):
	var ore_type = rng.randf_range(0.0, 3.0)
	if ore_type > 1.0:
		set_cell(0, Vector2i(x, y), 0, Vector2i(0, ore))
	elif ore_type > 2.0:
		set_cell(0, Vector2i(x, y), 0, Vector2i(1, ore))
	else:
		set_cell(0, Vector2i(x, y), 0, Vector2i(2, ore))
	
	
	
