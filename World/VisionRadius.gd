extends Sprite2D

@export var light_radius = 512.0:
	set(v):
		light_radius = v
		var width = texture.get_width()
		texture.gradient.set_offset(0, (v - soft_ring - soft_ring) / width)
		texture.gradient.set_offset(1, (v - soft_ring) / width)
		texture.gradient.set_offset(2, (v) / width)

@export var soft_ring = 64.0