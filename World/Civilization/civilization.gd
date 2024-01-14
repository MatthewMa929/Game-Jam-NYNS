extends Node2D

const CIV_WIDTH = 1828
const CIV_HEIGHT = 1235

@onready var rng = RandomNumberGenerator.new()
@onready var workshop = $Workshop
@onready var qtmole = $SurpriseMole


# 450px tall, 750px wide
# Called when the node enters the scene tree for the first time.

func _ready():
	# set the x and y to a random val   // x clamped (600, 2200), y every 3500
	
	var civ_position = Vector2i(0,0)
	
	var bg_variant = randi_range(0,8)
	_set_civ_variant(bg_variant)
	 
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_tile_delete_area_entered(area):
	pass
	#if area is TileMap:
		#var tilemap := area.get_collider() as TileMap
		#tilemap.erase_cell(0, area.position)


func _set_civ_variant(bg_var):
	
	# chooses the workshop location
	var ws_variant = randi_range(0,3)
	if (bg_var <=2):
		ws_variant = randi_range(0,2)
	workshop.region_rect = Rect2(CIV_WIDTH*ws_variant, 0, CIV_WIDTH, CIV_HEIGHT)
	
	# qtmole ;P <3
	if (rng.randf() < 0.9):
		qtmole.visible = true
	else:
		qtmole.visible = false
	
	
	


	





