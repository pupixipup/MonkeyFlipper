extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -250.0
@onready var animated_sprite = $AnimatedSprite2D
@onready var raycast = $RayCast2D
var onWall = false
var lookDirection = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	var direction = Input.get_axis("move_left", "move_right")
	var collider = raycast.get_collider()
	onWall = collider != null
	if not is_on_floor():
		if onWall:
			velocity.y = 0
		else:
			velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		if onWall == true:
			velocity.x = (lookDirection * -1) * SPEED
			velocity.y = JUMP_VELOCITY
			velocity.y += gravity * delta
			print( "onwall"+  str(velocity.x))
		elif is_on_floor():
			velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

	if onWall == false:
		if direction:
			animated_sprite.play("move")
			velocity.x = direction * SPEED
			if direction == -1:
				animated_sprite.flip_h = true
				lookDirection = -1
				raycast.target_position = Vector2(-7, 0)
				
			else:
				animated_sprite.flip_h = false
				lookDirection = 1
				raycast.target_position = Vector2(6, 0)
		elif is_on_floor():
			animated_sprite.play("idle")
			print("petruha")
			velocity.x = move_toward(velocity.x, 0, SPEED)
	print(velocity.x)


	move_and_slide()
