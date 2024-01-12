extends Label

@onready var player = get_node("/root/World/Player")
@onready var oxygen = 1000
func _process(delta):
	var depth = -player.position.y
	if depth < oxygen and oxygen > 0:
		oxygen -= 0.01
	self.text = str(int(oxygen))
