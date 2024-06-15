extends Node

# Add section trigger
# TODO: Create different sections
var platform_scene = preload("res://scenes/platform.tscn")
var platform_height = 32
var current_y = 0

var start_x = 0
var start_y = 0

var platforms_gap_x = 50
var platforms_gap_y = -40

var platform_x = 0
var platform_y = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	add_section()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_section():
	var section = get_section()
	section.call()
	var section2 = get_section()
	section2.call()
	var section3 = get_section()
	section3.call()
	var section4 = get_section()
	section4.call()
	
	

func basic_section():
	var new_section = Node2D.new()
	var platform = platform_scene.instantiate()
	var platform2 = platform_scene.instantiate()
	
	platform2.rotation += PI
	platform.position.x = platforms_gap_x
	platform2.position.y = platforms_gap_y
	new_section.add_child(platform)
	new_section.add_child(platform2)
	
	new_section.position.y = current_y
	
	current_y += platforms_gap_y / 2
	current_y -= platform_height * 2
	
	add_child(new_section)
	return new_section
	

var sections = [basic_section]

func get_section():
	return sections[0]
	# TODO: As height raises, increase difficulty
