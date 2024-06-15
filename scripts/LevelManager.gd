extends Node

# Add section trigger
# TODO: Create different sections
var platform_scene = preload("res://scenes/platform.tscn")
var trigger_area_scene = load("res://scenes/trigger_area.tscn")

var trigger_area = null;
var platform_height = 32
var current_y = 0

var start_x = 0
var start_y = 0

var platforms_gap_x = 50
var platforms_gap_y = 10

var platform_x = 0
var platform_y = 0
var placed_sections = []


# Called when the node enters the scene tree for the first time.
func _ready():
	
	trigger_area = trigger_area_scene.instantiate()
	trigger_area.body_entered.connect(_on_Area2D_body_entered)
	add_child(trigger_area)
	
	add_section()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_section():
	var sectionFunc = get_section()
	var section = sectionFunc.call()
	placed_sections.append(section)
	current_y -= platforms_gap_y



func basic_section():
	var new_section = Node2D.new()
	var platform = platform_scene.instantiate()
	var platform2 = platform_scene.instantiate()
	
	var y_distance = platforms_gap_y + platform_height
	platform2.rotation += PI
	platform.position.x = platforms_gap_x
	platform2.position.y = -y_distance	
	new_section.add_child(platform)
	new_section.add_child(platform2)
	
	new_section.position.y = current_y

	current_y -= y_distance
	current_y -= platform_height
	
	add_child(new_section)
	return new_section
	

var sections = [basic_section]

func get_section():
	return sections[0]
	# TODO: As height raises, increase difficulty
	
func _on_Area2D_body_entered(body):
	print("collide")
	add_section()
	trigger_area.position.y = current_y
	add_section()
	
