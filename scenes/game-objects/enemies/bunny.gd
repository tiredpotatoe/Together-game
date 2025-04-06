extends CharacterBody2D

class_name bunnyEnemy


const speed = 15
var is_bunny_chasing: bool

var health = 1

var dead: bool
var taking_damage: bool = false
var damage_to_deal = 1
var is_dealing_damage: bool = false

var dir: Vector2
const gravity= 900
var knockback_force = 200
var is_roaming: bool = true


func _process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += gravity * delta
		velocity.x = 0
	move(delta)
	move_and_slide()

func move(delta):
	if !dead:
		if !is_bunny_chasing:
			velocity += dir * speed * delta
		is_roaming = true
	elif dead:
		velocity.x = 0



func _ready():
	_on_direction_timer_timeout()


func _on_direction_timer_timeout() -> void:
	$DirectionTimer.wait_time = choose([1.5,2.0, 2.5])
	while !is_bunny_chasing:
		dir = choose([Vector2.RIGHT, Vector2.LEFT])
		velocity.x = 0


func choose(array):
	array.shuffle()
	return array.front()
