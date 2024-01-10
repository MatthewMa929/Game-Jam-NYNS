extends Node2D

const WIDTH = 1000
const HEIGHT = 5000

const TILES = {
	'emerald': 0,
	'gold': 1,
	'coal': 2,
	'diamond': 3
}

var noise = FastNoiseLite.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	noise.seed = randi()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
