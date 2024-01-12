extends Label

# Assuming the player node is a sibling of this label node
@onready var player = get_node("/root/World/Player")

func _process(delta):
	# Get the y position of the player
	var y_position = -player.position.y

	# Convert the y position to string and display it in the label
	self.text = str(int(y_position)) + "m"
