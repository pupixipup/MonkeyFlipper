extends Node2D

var x_gap = 60
var y_gap = 12
@export var height = y_gap + (Global.platform_size * 2)

# Called when the node enters the scene tree for the first time.
func _ready():
	$Platform.position.x = x_gap
	$Platform2.position.x = 0
	
	$Platform.position.y = 0
	$Platform2.position.y = -(Global.platform_size  + y_gap)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
