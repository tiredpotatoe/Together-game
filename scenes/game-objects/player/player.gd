extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -420.0
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
var jumped = 0 # Track the number of jumps

func jump():
	velocity.y= JUMP_VELOCITY

func _physics_process(delta: float) -> void:
	# Handle animations for movement
	if velocity.x > 1 or velocity.x < -1:
		sprite_2d.animation = "running"
	else:
		sprite_2d.animation = "default"
	
	# Handle gravity and jumping animations
	if not is_on_floor():
		velocity += get_gravity() * delta

		# Falling animation
		if velocity.y > 0 :
			sprite_2d.animation = "fall"  # Character is falling

		# Jumping or double jump animation
		elif velocity.y < 0 :
			sprite_2d.animation = "jumping"
		


	# Handle the jump logic
	if Input.is_action_just_pressed("jump") and jumped < 1:  #
		velocity.y = JUMP_VELOCITY  # Apply the jump force
		jumped += 1  # Increment jump count
	
	# Reset jumps when touching the floor
	if is_on_floor():
		jumped = 0
		# Reset to idle or default animation when on the ground
		if velocity.x == 0:
			sprite_2d.animation = "default"  # Idle animation (or any other default animation you want)

	# Handle movement and flipping of the character
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		sprite_2d.flip_h = direction < 0  # Flip based on direction
	else:
		velocity.x = move_toward(velocity.x, 0, 12)

	move_and_slide()
