extends TileMap

@onready var revealer = $"../Player"

var reveal_radius = 256.0

var pregenerate_depth = 256.0
var pregenerate_width = 1024.0

var revealer_last_pos = Vector2()
var revealer_nex_gen_threshold = 0.0


func _process(delta):
	if revealer_last_pos == revealer.position: return
	revealer_last_pos = revealer.position

	# if revealer_last_pos.y > revealer_nex_gen_threshold:
	# 	for x in $"../Ores".WIDTH * $"../Ores".tile_set.tile_size.x / tile_set.tile_size.x:

	# 	revealer_nex_gen_threshold += pregenerate_depth

	# pass