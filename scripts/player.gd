extends CharacterBody2D


const SPEED = 100.0 # Moving speed
const JUMP_VELOCITY = -210.0

@onready var animated_sprite = $AnimatedSprite2D
@onready var raycast = $RayCast2D
var onWall = false
var jumpDirection = 1
const RAY_RIGHT = Vector2(6,0)
const RAY_LEFT = Vector2(-7,0)
const MAX_JUMPS = 2
var jumps_left = MAX_JUMPS
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = 1 # Move right by default.  it is used to be: Input.get_axis("move_left", "move_right")
var jump_delta = 0
var MAX_VELOCITY = 1500
var accum_velocity = 0
func _physics_process(delta):

	var collider = raycast.get_collider()
	var onWall = collider and collider.get_class() == "StaticBody2D" and collider.get_collision_layer() == 5

	if not is_on_floor():
		if onWall:
			velocity.y = 2
		else:
			velocity.y += gravity * delta
	
	if onWall:
		jumps_left = MAX_JUMPS
		animated_sprite.play("idle")
	else:
		# Moving
		if direction:
			if is_on_floor():
				animated_sprite.play("move")
				jumps_left = MAX_JUMPS
				velocity.x = jumpDirection * SPEED

			else:
				animated_sprite.play("jump")
			
			# set visual direction
			if direction == -1:
				animated_sprite.flip_h = true
				raycast.target_position = RAY_LEFT
				
			else:
				animated_sprite.flip_h = false
				raycast.target_position = RAY_RIGHT

	if Input.is_action_just_pressed("ui_accept"):
			jump_delta = 0
			accum_velocity = 0
			if jumps_left > 0:
				if is_on_floor() == false:
					jumpDirection = jumpDirection * -1
					direction = direction  * -1

				animated_sprite.play("jump")
				var lookRight = jumpDirection == 1
	
				velocity.x = jumpDirection * SPEED * 1.3

				animated_sprite.flip_h = !lookRight
				raycast.target_position = RAY_RIGHT if lookRight  else RAY_LEFT
				
				
	if Input.is_action_pressed("ui_accept") and jumps_left > 0:
		# Add jump height when button is held
		if abs(accum_velocity) < abs(MAX_VELOCITY):
			velocity.y = JUMP_VELOCITY - jump_delta
			velocity.y += gravity * delta
			jump_delta += delta
			accum_velocity += velocity.y
	if Input.is_action_just_released("ui_accept"):
		jumps_left -= 1

	move_and_slide()
	

