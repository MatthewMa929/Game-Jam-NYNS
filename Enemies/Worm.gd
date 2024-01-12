extends CharacterBody2D

#worm hovers the player around a circle, tries to go through the player to attack, then goes back into its travel or hover state
const SPEED = 280.0

@onready var player = $"../Player"
@onready var head = $Head
@onready var body = $Body
@onready var tail = $Tail
@onready var spikes = $Body/Spikes

enum {
	TRAVEL,
	HOVER,
	ATTACK,
	HIT
}

var state = TRAVEL
var rng
var angle = 0
var randomnum = 0
var radius = 500
var circle_angle = 0
var pos = Vector2(0, 0)
var worm_pos = Vector2(0, 0)
var in_area = false
var curr_part = head
@onready var hover_timer = $HoverTimer
@onready var travel_timer = $TravelTimer

func _ready():
	rng = RandomNumberGenerator.new()
	rng.randomize()
	randomnum = rng.randf()
	
func _physics_process(delta):
	if Input.is_action_just_released('mouse_left'):
		print(state)
	match state:
		TRAVEL:
			if in_area or travel_timer.time_left > 0:
				move(get_circle_position(pos, radius + 300), delta)
			else:
				move(get_circle_position(player.position, radius), delta)
		HOVER:
			radius = rng.randf_range(350, 500)
			angle += 0.01
			worm_pos.x = pos.x + radius * cos(angle)
			worm_pos.y = pos.y + radius * sin(angle)
			move(Vector2(worm_pos.x, worm_pos.y), delta)
		ATTACK:
			move(pos, delta) 
			if abs(pos - position) < Vector2(3, 3):
				randomnum = rng.randf()
				if randomnum > 0.5:
					state = TRAVEL
					print('travel')
				else:
					state = HOVER
					print('hover')
		HIT:
			pass
		
func get_circle_position(player_pos, rad):
	var x = player_pos.x + cos(angle) * rad
	var y = player_pos.y + sin(angle) * rad

	return Vector2(x, y)
	
func move(target, delta):
	var direction = (target - global_position).normalized() 
	var desired_velocity =  direction * SPEED
	#delta * 2.5 -> delta * 3
	var steering = (desired_velocity - velocity) * delta * 3
	velocity += steering
	rotate_part(head, target, delta)
	move_and_slide()
	
func rotate_part(part, target, delta):
	var direction = (target - global_position).normalized() 
	var angleTo = part.transform.x.angle_to(direction)
	part.rotate(sign(angleTo) * min(delta * 3, abs(angleTo)))
	
func _on_sense_area_entered(area):
	hover_timer.start()
	in_area = true
	state = HOVER
	pos = player.position
	print('sense')
	
func _on_sense_area_exited(area):
	in_area = false
	travel_timer.start()
	
func _on_hover_timer_timeout():
	pos = 2*player.global_position - Vector2(position.x, position.y)
	state = ATTACK

func _on_travel_timer_timeout():
	travel_timer.stop()

