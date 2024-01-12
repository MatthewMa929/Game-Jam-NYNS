extends Label

@onready var player = get_node("/root/World/Player")
func _process(delta):
	var oxyorecount = player.oxyore
	self.text = str(int(oxyorecount))
