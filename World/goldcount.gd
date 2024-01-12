extends Label

@onready var player = get_node("/root/World/Player")
func _process(delta):
	var goldcount = player.gold
	self.text = str(int(goldcount))
