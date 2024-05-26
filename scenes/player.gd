extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -270.0
@onready var animated_sprite = $AnimatedSprite2D
@onready var raycast = $RayCast2D
var onWall = false
var jumpDirection = 1
const RAY_RIGHT = Vector2(6,0)
const RAY_LEFT = Vector2(-7,0)
const MAX_JUMPS = 2
var jumps_left = MAX_JUMPS
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = 1 # Move right by default.  Input.get_axis("move_left", "move_right")
var previousDirection = null

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

			else:
				animated_sprite.play("jump")
			velocity.x = jumpDirection * SPEED
			# set visual direction
			if direction == -1:
				animated_sprite.flip_h = true
				raycast.target_position = RAY_LEFT
				
			else:
				animated_sprite.flip_h = false
				raycast.target_position = RAY_RIGHT

		# Idle
		#elif is_on_floor():
		#	animated_sprite.play("idle")
		#	jumps_left = MAX_JUMPS
		#	velocity.x = move_toward(velocity.x, 0, SPEED)
			
			
	if Input.is_action_just_pressed("ui_accept"):


			if jumps_left > 0:
				if is_on_floor() == false:
					jumpDirection = jumpDirection * -1
					direction = direction  * -1
				
				animated_sprite.play("jump")
				var lookRight = jumpDirection == 1
	
				velocity.x = jumpDirection * SPEED
 
				velocity.y = JUMP_VELOCITY
				velocity.y += gravity * delta
				animated_sprite.flip_h = !lookRight
				raycast.target_position = RAY_RIGHT if lookRight  else RAY_LEFT
			
		

			jumps_left -= 1

	move_and_slide()
	

