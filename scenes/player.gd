extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -250.0
@onready var animated_sprite = $AnimatedSprite2D
@onready var raycast = $RayCast2D
var onWall = false
var lookDirection = 1
const RAY_RIGHT = Vector2(6,0)
const RAY_LEFT = Vector2(-7,0)
const MAX_JUMPS = 2
var jumps_left = MAX_JUMPS
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var previousDirection = null

func _physics_process(delta):
	# Add the gravity.
	var direction = Input.get_axis("move_left", "move_right")

	var collider = raycast.get_collider()
	var reachedWall = collider and collider.get_class() == "StaticBody2D"
	if reachedWall:
		onWall = collider.get_collision_layer() == 5
	else:
		onWall = false	
	if not is_on_floor():
		if onWall:
			velocity.y = 0
		else:
			velocity.y += gravity * delta

	# Handle jump.
	
		#elif is_on_floor():
			#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	

	
	if onWall:
		jumps_left = MAX_JUMPS
		animated_sprite.play("idle")
	else:
		if direction:
			if is_on_floor():
				animated_sprite.play("move")
				if direction != 0:
					lookDirection = direction
					print("-->", lookDirection)
			else:
				animated_sprite.play("jump")
			velocity.x = direction * SPEED
			if direction == -1:
				animated_sprite.flip_h = true
				raycast.target_position = RAY_LEFT
				
			else:
				animated_sprite.flip_h = false
				raycast.target_position = RAY_RIGHT
		elif is_on_floor():
			animated_sprite.play("idle")
			jumps_left = MAX_JUMPS
			velocity.x = move_toward(velocity.x, 0, SPEED)
			
			
	if Input.is_action_just_pressed("ui_accept"):
			if jumps_left > 0:
				animated_sprite.play("jump")
				var lookRight = lookDirection == 1
				velocity.x = lookDirection * SPEED
				velocity.y = JUMP_VELOCITY
				velocity.y += gravity * delta
				animated_sprite.flip_h = !lookRight
				raycast.target_position = RAY_RIGHT if lookRight  else RAY_LEFT
				
				lookDirection = lookDirection * -1

			jumps_left -= 1

	move_and_slide()


func _on_ground_body_entered(body):
	pass # Replace with function body.
