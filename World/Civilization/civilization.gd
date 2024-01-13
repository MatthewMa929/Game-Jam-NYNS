extends Node2D

#450px tall, 750px wide
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_tile_delete_area_entered(area):
	pass
	#if area is TileMap:
		#var tilemap := area.get_collider() as TileMap
		#tilemap.erase_cell(0, area.position)
