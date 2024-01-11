extends TileMap


#Creating the DirtDetail.png on Dirt Tilemap as each civilization is reached
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func create_dirt(width, depth):
	for y in range(depth, depth+100):
		for x in width:
			set_cell(0, Vector2i(x, y), 1, Vector2i(x%16, y%16))
