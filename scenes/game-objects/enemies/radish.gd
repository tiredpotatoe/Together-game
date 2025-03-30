extends RigidBody2D

@onready var game_manager: Node = %GameManager

var float_speed: float = 2.0  # Speed of floating
var float_amplitude: float = 10.0  # How much it moves (half of total range)
var start_y: float = 0.0  # Original Y position
var time_passed: float = 0.0  # Timer for sine wave

func _ready() -> void:
	start_y = position.y  # Store the initial position
	gravity_scale = 0  # Disable gravity so it doesn't fall

func _physics_process(delta: float) -> void:
	time_passed += delta * float_speed
	var target_y = start_y + sin(time_passed) * float_amplitude
	var velocity = Vector2(0, (target_y - position.y) / delta)  # Convert movement into velocity
	set_linear_velocity(velocity)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		var y_delta = position.y - body.position.y
		print(y_delta)
		if y_delta > 30:
			print("enemy destroyed")
			queue_free()
			body.jump()
		else:
			print("u died")
			game_manager.decrease_health()
