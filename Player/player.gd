extends CharacterBody2D


const SPEED = 100

func _physics_process(delta):
	var direction_x = Input.get_axis("Left", "Right")
	var direction_y = Input.get_axis("Up", "Down")
	if direction_x:
		velocity.x = direction_x * SPEED
		velocity.y = 0
	elif direction_y:
		velocity.y = direction_y * SPEED
		velocity.x = 0
	if !direction_x:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if !direction_y:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	var collision = move_and_collide(velocity * delta)
	if collision and collision.get_collider() is TileMap:
		var tilemap = collision.get_collider()
		var pos = tilemap.local_to_map(collision.get_position())
		tilemap.erase_cell(0,pos)
		
		
