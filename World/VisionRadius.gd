extends Sprite2D

@export var light_radius = 512.0:
	set(v):
		var width = texture.get_width()
		if v < light_radius:
			texture.gradient.set_offset(1, (v - soft_ring - soft_ring) / width)
			texture.gradient.set_offset(2, (v - soft_ring) / width)
			texture.gradient.set_offset(3, (v) / width)
		else:
			texture.gradient.set_offset(3, (v) / width)
			texture.gradient.set_offset(2, (v - soft_ring) / width)
			texture.gradient.set_offset(1, (v - soft_ring - soft_ring) / width)
		light_radius = v

@export var soft_ring = 64.0