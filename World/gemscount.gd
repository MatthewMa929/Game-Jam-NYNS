extends Label

@onready var player = get_node("/root/World/Player")
func _process(delta):
	var gemscount = player.gems
	self.text = str(int(gemscount))
