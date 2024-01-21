extends CharacterBody2D
class_name Player

const SPEED = 80.0
const ACCELERATION = SPEED / 12.0
#var input_direction: Vector2

@onready var animations = $AnimationTree

#func vector():
#	input_direction = Input.get_vector("move_right", "move_left", "move_up", "move_down")
#	return input_direction.normalized()

func _ready():
	animations.active = true

func _physics_process(_delta):
	move_and_slide()
