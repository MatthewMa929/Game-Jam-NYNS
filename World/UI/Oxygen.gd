@tool
extends Range


func _enter_tree():
	value_changed.connect(_on_value_changed)
	changed.connect(_on_changed)


func _on_value_changed(value : float):
	pass


func _on_changed(value : float):
	pass