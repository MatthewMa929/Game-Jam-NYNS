extends Node2D


func connect_tether(to_other):
	var tube = $Tube
	var beam = $Beam
	var diff_vec = to_other.global_position - global_position 
	beam.points = PackedVector2Array([Vector2.ZERO, diff_vec])
	var curved_count = ceil(diff_vec.length() / 64.0)
	var curving_down = diff_vec.length() * 0.25
	for i in curved_count + 1:
		var from_middle = absf(i / curved_count - 0.5) * 2.0
		from_middle = 1 - (from_middle * from_middle)
		tube.add_point(i / curved_count * diff_vec + Vector2(0.0, from_middle * curving_down))
