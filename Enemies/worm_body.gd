extends Sprite2D

const SPEED = 280.0

@onready var body_timer = $BodyTimer

signal follow_part(position, rotation)

var pos = Vector2(0, 0)
var rotate = 0

func _ready():
	pass 

func _process(delta):
	pass
	
func follow(part, new_part):
	body_timer.start()

func _on_body_timer_timeout():
	position = pos
	rotation = rotate
