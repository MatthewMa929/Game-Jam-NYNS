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
var max = 3
var curr = 0
var angle = 0
var randomnum = 0
var radius = 500
var circle_angle = 0
var pos = Vector2(0, 0)
var worm_pos = Vector2(0, 0)
var in_area = false
var part_list = []

func _ready():
	body.part = head
	rng = RandomNumberGenerator.new()
	rng.randomize()
	randomnum = rng.randf()
	hover_timer.one_shot = true
	travel_timer.one_shot = true

func _physics_process(delta):
	if Input.is_action_just_released('mouse_left'):
		print(state)
		print(head.global_position)
	match state:
		TRAVEL:
			if in_area:
				move(get_circle_position(player.global_position, radius + 600), head, delta)
			else:
				move(get_circle_position(player.global_position, radius), head, delta)
				if travel_timer.time_left <= 0:
					travel_timer.start()
		HOVER:
			if hover_timer.time_left <= 0:
				hover_timer.start()
			radius = rng.randf_range(350, 500)
			angle += 0.01
			worm_pos.x = pos.x + radius * cos(angle)
			worm_pos.y = pos.y + radius * sin(angle)
			move(Vector2(worm_pos.x, worm_pos.y), head, delta)
		ATTACK:
			move(pos, head, delta) 
			if abs(pos - head.global_position) < Vector2(3, 3):
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
	
func move(target, part, delta):
	var direction = (target - part.global_position).normalized() 
	var desired_velocity =  direction * SPEED
	var steering = (desired_velocity - part.velocity) * delta * 3
	part.velocity += steering
	rotate_part(part, target, delta)
	part.move_and_slide()
	
func rotate_part(part, target, delta):
	var direction = (target - part.global_position).normalized() 
	var angleTo = part.transform.x.angle_to(direction)
	part.rotate(sign(angleTo) * min(delta * 3, abs(angleTo)))

	
func _on_sense_area_entered(area):
	if state != ATTACK:
		in_area = true
		state = HOVER
		pos = player.global_position
		print('sense')
	
func _on_sense_area_exited(area):
	in_area = false
	
func _on_hover_timer_timeout():
	pos = 2*player.global_position - Vector2(head.global_position.x, head.global_position.y)
	state = ATTACK

func _on_travel_timer_timeout():
	pos = 2*player.global_position - Vector2(head.global_position.x, head.global_position.y)
	state = ATTACK


