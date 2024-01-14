extends Node2D

const WIDTH = 200
var DEPTH = 0
var civ_depth = 0
var inc = 100
var civ_amt = 0
var civ_visited = true

#1600 pixels is 100 depth
@onready var rng = RandomNumberGenerator.new()
@onready var dirt = $Dirt
@onready var ores = $Ores
@onready var player = $Player
@onready var civilization = $Civilization

func _ready():
	connect("player_entered", check_civ)
	
func _process(delta):
	#print(player.position.y, ' ', DEPTH)
	if DEPTH - (player.position.y)/16.0 < 200 and civ_visited:
		civ_visited = false
		#print(player.position.y/16.0, ' ', DEPTH)
		ores.create_ores(WIDTH, inc*2)
		DEPTH += inc*2
		print('increased')
	if (DEPTH%200 == 0) and DEPTH != 200*civ_amt:
		print(civ_amt)
		civ_amt += 1
		create_civilization(DEPTH)
		print('civ created: ', DEPTH)

func create_civilization(depth):
	var civ = civilization.duplicate()
	add_child(civ)
	# in pixels: x clamped (600, 2200), y every 3500 
	civ.position = Vector2(200, depth)
	print(Vector2(100, depth))
	
func check_civ():
	print('yad')
