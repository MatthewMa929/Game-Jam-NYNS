extends Node


@export var tether_placer : Node
@export var o2_meter : Range
@export var o2_low_vignette : CanvasItem
@export var o2_low_fullscreen : CanvasItem

@export var o2_current = 1.0
@export var o2_max = 1.0
@export var o2_depletion = 1.0
@export var o2_recovery = 4.0

var checkpoint_pos = Vector2()


func _ready():
	o2_current = o2_max
	checkpoint_pos = get_parent().global_position


func _process(delta):
	if tether_placer.nearby_tethers.size() > 0:
		o2_current += o2_recovery * delta

	else:
		o2_current -= o2_depletion * delta

	if o2_current > o2_max:
		o2_current = o2_max

	if o2_current < -1.0:
		get_parent().global_position = checkpoint_pos
		o2_current = o2_max

	o2_low_vignette.self_modulate.a = smoothstep(30, 10, o2_current)
	o2_low_fullscreen.self_modulate.a = smoothstep(5, 0, o2_current)

	o2_meter.max_value = o2_max
	o2_meter.value = o2_current
