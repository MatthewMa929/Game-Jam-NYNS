@tool
extends Range

@export var tick_value_interval := 50.0:
	set(v):
		tick_value_interval = v
		queue_redraw()
@export var tick_radius := 0.0:
	set(v):
		tick_radius = v
		queue_redraw()
@export_range(-360, 360) var angle_full := 0.0:
	set(v):
		angle_full = v
		queue_redraw()
@export_range(-360, 360) var angle_empty := 360.0:
	set(v):
		angle_empty = v
		queue_redraw()

@export_group("Style")
@export var hand_tex : Texture2D:
	set(v):
		hand_tex = v
		queue_redraw()
@export var hand_tex_origin : Vector2:
	set(v):
		hand_tex_origin = v
		queue_redraw()
@export var tick_tex : Texture2D:
	set(v):
		tick_tex = v
		queue_redraw()


func _enter_tree():
	value_changed.connect(queue_redraw.unbind(1))
	changed.connect(queue_redraw)


func _draw():
	var tick_count := (max_value - min_value) / tick_value_interval
	var tick_interval := deg_to_rad(angle_full - angle_empty) / tick_count
	var tick_tex_half_size := tick_tex.get_size() * 0.5
	for i in ceili(tick_count + 0.0001):
		draw_set_transform(size * 0.5, deg_to_rad(angle_empty) + i * tick_interval)
		draw_texture(tick_tex, Vector2(tick_radius, 0.0) - tick_tex_half_size)

	var progress := inverse_lerp(min_value, max_value, value)
	draw_set_transform(size * 0.5, deg_to_rad(lerp(angle_empty, angle_full, progress)))
	draw_texture(hand_tex, hand_tex.get_size() * 0.5 + hand_tex_origin)
