extends Node

# Add section trigger
# TODO: Create different sections
var platform_scene = preload("res://scenes/platform.tscn")
var trigger_area_scene = load("res://scenes/trigger_area.tscn")
var basic_section = preload("res://scenes/platform_sections/basic/basic.tscn")
var straight_section = preload("res://scenes/platform_sections/straight/straight.tscn")

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
	var section = get_section()
	var section_instance = section.instantiate()
	add_child(section_instance)
	placed_sections.append(section_instance)
	
	section_instance.position.y -= current_y
	current_y += section_instance.height

var sections = [basic_section, straight_section]

func get_section():
	return sections.pick_random()
	# TODO: As height raises, increase difficulty
	
func _on_Area2D_body_entered(body):
	add_section()
	trigger_area.position.y = -current_y
	add_section()
	if (len(placed_sections) > 3):
		placed_sections[0].queue_free()
		placed_sections.remove_at(0)
	
