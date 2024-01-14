extends TileMap

@onready var ores = $"../Ores"
var dirt_type = 0
#Creating the DirtDetail.png on Dirt Tilemap as each civilization is reached
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func create_dirt(width, depth, increase):
	if depth > 0:
		dirt_type = 1
	if depth > 400:
		dirt_type = 2
	if depth > 600:
		dirt_type = 3
	for y in range(depth, depth+increase):
		for x in width:
			set_cell(0, Vector2i(x, y), 1, Vector2i((x%16)+(16*dirt_type), y%16))
			
func delete_dirt(width, width_inc, depth, depth_inc):
	ores.delete_ore(width, width_inc, depth, depth_inc)
	for y in range(depth, depth+depth_inc):
		for x in range(width, width+width_inc):
			erase_cell(0, Vector2i(x, y))
