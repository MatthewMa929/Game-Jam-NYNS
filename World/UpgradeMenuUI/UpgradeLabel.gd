@tool
extends BoxContainer

@export_group("Resources")
@export var text := "":
	set(v):
		text = v
		_update_view()
@export var current_value := 0:
	set(v):
		current_value = v
		_update_view()
@export var max_value := 0:
	set(v):
		max_value = v
		_update_view()
@export var progress_color := Color.DARK_GRAY:
	set(v):
		progress_color = v
		_update_view()
@export var progress_max_color := Color.GOLD:
	set(v):
		progress_max_color = v
		_update_view()


func _update_view():
	if !is_inside_tree(): await ready
	$"Label".text = text
	if max_value > 0:
		$"Progress".text = "%s/%s" % [current_value, max_value]
		$"Progress".self_modulate = progress_max_color if current_value >= max_value else progress_color

	else:
		$"Progress".text = "Have %s" % [current_value]
		$"Progress".self_modulate = progress_max_color
