extends Node2D

const WIDTH = 200
var DEPTH = 0
var civ_depth = 0
var inc = 100

#1600 pixels is 100 depth
@onready var rng = RandomNumberGenerator.new()
@onready var dirt = $Dirt
@onready var ores = $Ores
@onready var player = $Player
@onready var civilization = $Civilization

func _ready():
	ores.create_ores(WIDTH, inc*2)
	DEPTH += inc*2
	
func _process(delta):
	if DEPTH - (player.position.y)/16 < 200:
		ores.create_ores(WIDTH, inc*3)
		DEPTH += inc*3
		print('increased')
	if (DEPTH%200 == 0):
		create_civilization(DEPTH)
		print('civ created: ', DEPTH)

func create_civilization(depth):
	var civ = civilization.duplicate()
	add_child(civ)
	civ.position = Vector2(100, depth)
