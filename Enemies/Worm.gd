extends CharacterBody2D

#worm hovers the player around a circle, tries to go through the player to attack, then goes back into its travel or hover state
const SPEED = 280.0

@onready var player = $"../Player"
@onready var head = $Head
@onready var body = $WormBody
@onready var tail = $Tail

@onready var hover_timer = $HoverTimer
@onready var travel_timer = $TravelTimer

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
var part_list = []

signal follow_head(position, rotation)

func _ready():
	#create_worm()
	rng = RandomNumberGenerator.new()
	rng.randomize()
	randomnum = rng.randf()
	hover_timer.one_shot = true
	travel_timer.one_shot = true
	self.follow_head.connect(body.follow)

func _physics_process(delta):
	if Input.is_action_just_released('mouse_left'):
		print(state)
	match state:
		TRAVEL:
			if in_area:
				move(get_circle_position(player.position, radius + 600), delta)
			else:
				move(get_circle_position(player.position, radius), delta)
				if travel_timer.time_left <= 0:
					travel_timer.start()
		HOVER:
			if hover_timer.time_left <= 0:
				hover_timer.start()
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
				else:
					state = HOVER
		HIT:
			pass
		
func get_circle_position(player_pos, rad):
	var x = player_pos.x + cos(angle) * rad
	var y = player_pos.y + sin(angle) * rad

	return Vector2(x, y)
	
func move(target, delta):
	var direction = (target - global_position).normalized() 
	var desired_velocity =  direction * SPEED
	var steering = (desired_velocity - velocity) * delta * 3
	velocity += steering
	rotate_part(head, target, delta)
	move_and_slide()
	follow_head.emit(position, rotation)
	
func rotate_part(part, target, delta):
	var direction = (target - global_position).normalized() 
	var angleTo = part.transform.x.angle_to(direction)
	part.rotate(sign(angleTo) * min(delta * 3, abs(angleTo)))
	
func create_worm():
	for i in range(3):
		var push = body.duplicate()
		part_list.append(push)
	
func _on_sense_area_entered(area):
	if state != ATTACK:
		in_area = true
		state = HOVER
		pos = player.position
		print('sense')
	
func _on_sense_area_exited(area):
	in_area = false
	
func _on_hover_timer_timeout():
	pos = 2*player.global_position - Vector2(position.x, position.y)
	state = ATTACK

func _on_travel_timer_timeout():
	pos = 2*player.global_position - Vector2(position.x, position.y)
	state = ATTACK
