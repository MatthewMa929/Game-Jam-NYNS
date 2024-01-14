extends CharacterBody2D

#worm hovers the player around a circle, tries to go through the player to attack, then goes back into its travel or hover state
const SPEED = 320.0

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
var max = 4
var curr = 0
var angle = 0
var randomnum = 0
var hp = 300
var radius = 700
var circle_angle = 0
var pos = Vector2(0, 0)
var worm_pos = Vector2(0, 0)
var in_area = false
var taking_dmg = false

func _ready():
	body.part = head
	while curr < max:
		var dup = body.duplicate()
		add_child(dup)
		dup.part = body
		body = dup
	tail.part = body
	rng = RandomNumberGenerator.new()
	rng.randomize()
	randomnum = rng.randf()
	hover_timer.one_shot = true
	travel_timer.one_shot = true
	Wwise.register_game_obj(self, "WormSFX")
	Wwise.post_event("wormTunnel", self)

func _physics_process(delta):
	if Input.is_action_just_released('mouse_left'):
		print(state)
		print(head.global_position)
	if taking_dmg:
		hp += -1
		Wwise.post_event("Play_WormHit", self)
		print('hit')
	if hp == 0:
		queue_free()
	match state:
		TRAVEL:
			if in_area:
				move(get_circle_position(player.global_position, radius + 800), head, delta)
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
	Wwise.set_state("Worm_in_Range", "true")
		
	
func _on_sense_area_exited(area):
	in_area = false
	Wwise.set_state("Worm_in_Range", "false")
func _on_hover_timer_timeout():
	pos = 2*player.global_position - Vector2(head.global_position.x, head.global_position.y)
	state = ATTACK

func _on_travel_timer_timeout():
	pos = 2*player.global_position - Vector2(head.global_position.x, head.global_position.y)
	state = ATTACK

func _on_hitbox_area_entered(area):
	taking_dmg = true

func _on_hitbox_area_exited(area):
	taking_dmg = false
