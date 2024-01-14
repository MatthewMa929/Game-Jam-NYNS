extends CharacterBody2D

signal block_destroyed()

var ORI_SPEED = 200
var SPEED = ORI_SPEED
var RESISTANCE = 100
var MINING_LEVEL = 0
var ORE_YIELD = 1
var direction = Vector2.ZERO


var gems = 0
var gold = 0
var iron = 0
var oxyore = 0

@onready var dig_timer = $DigTimer

func _ready():
	Wwise.register_game_obj(self, "Break Crystal")

func _physics_process(delta):
	direction.x = Input.get_axis("Left", "Right")
	direction.y = Input.get_axis("Up", "Down")
	direction = direction.normalized()
	velocity = direction * SPEED
	var collision = move_and_collide(velocity * delta)
	while collision and collision.get_collider() is TileMap:
		var tilemap := collision.get_collider() as TileMap
		var pos = tilemap.local_to_map(collision.get_position() - collision.get_normal() * 1.0)

		#coordinates for ores
		var coords = tilemap.get_cell_atlas_coords(0,pos)
		#check mining level
		if tilemap.name == "Dirt":
			if MINING_LEVEL < coords.x / 16:
				break

		if tilemap.name == "Ores": 
			if coords.y == 0: #gems
				gems += ORE_YIELD
				Wwise.post_event("Crystal_Break", self)
			if coords.y == 1: #gold
				gold += ORE_YIELD
			if coords.y == 2: #iron
				iron += ORE_YIELD
			if coords.y == 3: #oxyore
				oxyore += ORE_YIELD
				Wwise.post_event("Crystal_Break", self)
		dig_timer.start()
		SPEED = ORI_SPEED - RESISTANCE
		tilemap.erase_cell(0, pos)
		if tilemap.name == "Dirt":
			tilemap.erase_cell(1, pos)
			for pos_offset in [
				pos + Vector2i.UP,
				pos + Vector2i.DOWN,
				pos + Vector2i.LEFT,
				pos + Vector2i.RIGHT,
			]:
				var dest_atlas_coords := tilemap.get_cell_atlas_coords(0, pos_offset)
				if dest_atlas_coords != Vector2i(-1, -1):
					tilemap.set_cell(1, pos_offset, 0, Vector2i(randi() % 3, dest_atlas_coords.x / 16))

		block_destroyed.emit()
		tilemap.update_internals()
		collision = move_and_collide(collision.get_remainder())

func _on_dig_timer_timeout():
	SPEED = ORI_SPEED
