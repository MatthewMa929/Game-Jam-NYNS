extends CharacterBody2D


var SPEED = 100
var direction = Vector2.ZERO

func _physics_process(delta):
	direction.x = Input.get_axis("Left", "Right")
	direction.y = Input.get_axis("Up", "Down")
	direction = direction.normalized()
	velocity = direction * SPEED
	var collision = move_and_collide(velocity * delta)
	if collision and collision.get_collider() is TileMap:
		var tilemap = collision.get_collider()
		var pos = tilemap.local_to_map(collision.get_position())
		#coordinates for ores
		var coords = tilemap.get_cell_atlas_coords(0,pos)
		if coords != Vector2i(0,0):
			#Mining Ores does what (Coords for Ores on Atlas TileMap)
			print(coords)
		tilemap.erase_cell(0,pos)
		
		
