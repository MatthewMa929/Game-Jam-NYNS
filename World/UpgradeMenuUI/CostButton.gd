@tool
extends Button

@export_group("Resources")
@export var resource_atlas : Texture2D:
	set(v):
		resource_atlas = v
		_update_view()
@export var resource_frame_size := Vector2(16, 16):
	set(v):
		resource_frame_size = v
		_update_view()
@export var resource1_index := 0:
	set(v):
		resource1_index = v
		_update_view()
@export var resource2_index := 0:
	set(v):
		resource2_index = v
		_update_view()
@export var resource1_amount := 0:
	set(v):
		resource1_amount = v
		_update_view()
@export var resource2_amount := 0:
	set(v):
		resource2_amount = v
		_update_view()


func _update_view():
	if !is_inside_tree(): await ready

	$"Box/Res1Icon".texture = AtlasTexture.new()
	$"Box/Res2Icon".texture = AtlasTexture.new()

	$"Box/Res1Icon".texture.atlas = resource_atlas
	$"Box/Res1Icon".texture.region.position = Vector2(0.0, resource_frame_size.x * resource1_index)
	$"Box/Res1Icon".texture.region.size = resource_frame_size
	$"Box/Res2Icon".texture.atlas = resource_atlas
	$"Box/Res2Icon".texture.region.position = Vector2(0.0, resource_frame_size.x * resource2_index)
	$"Box/Res2Icon".texture.region.size = resource_frame_size
	$"Box/Res1Amount".text = str(resource1_amount)
	$"Box/Res2Amount".text = str(resource2_amount)
	$"Box/Res2Icon".visible = resource2_amount > 0
	$"Box/Res2Amount".visible = resource2_amount > 0
