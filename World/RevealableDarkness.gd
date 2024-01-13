extends TileMap

@onready var revealer = $"../Player"

var reveal_radius = 256.0

var pregenerate_depth = 2048.0

var revealer_last_pos = Vector2()
var revealer_nex_gen_threshold = 0.0


func _process(delta):
	if revealer_last_pos == revealer.position: return
	revealer_last_pos = revealer.position

	if revealer_last_pos.y > revealer_nex_gen_threshold - pregenerate_depth * 0.5:
		for x in $"../Ores".WIDTH * $"../Ores".tile_set.tile_size.x / tile_set.tile_size.x:
			var tile_start = revealer_nex_gen_threshold / tile_set.tile_size.y
			for y in pregenerate_depth / tile_set.tile_size.y:
				set_cell(0, Vector2i(x, tile_start + y), 0, Vector2i.ZERO)

		revealer_nex_gen_threshold += pregenerate_depth

	var erase_center = revealer_last_pos / Vector2(tile_set.tile_size)
	var reveal_radius_tiles = Vector2(reveal_radius, reveal_radius) / Vector2(tile_set.tile_size)
	for x in reveal_radius_tiles.x + reveal_radius_tiles.x:
		for y in reveal_radius_tiles.y + reveal_radius_tiles.y:
			if Vector2(x, y).distance_squared_to(reveal_radius_tiles) <= reveal_radius_tiles.x * reveal_radius_tiles.x:
				erase_cell(0, erase_center - reveal_radius_tiles + Vector2(x, y))

	erase_cell(0, erase_center)
