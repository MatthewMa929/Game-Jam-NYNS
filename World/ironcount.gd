extends Label

@onready var player = get_node("/root/World/Player")
func _process(delta):
	var ironcount = player.iron
	self.text = str(int(ironcount))
