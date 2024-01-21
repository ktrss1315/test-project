extends State
class_name Player_state_idle


@onready var player = $"../.."
var player_data = Player.new()

@onready var animation_playback = $"../../AnimationTree".get("parameters/playback")
@onready var animation_tree = $"../../AnimationTree"


func _player_vector() -> Vector2:
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	return input_direction


func _animation_play() -> void:
	animation_tree.set("parameters/Idle/blend_position", $"../Move".previous_vector)


func _player_idle_velocity() -> void:
	player.velocity = player.velocity.move_toward(Vector2.ZERO, player_data.ACCELERATION * 1.2)


func Enter():
#	$"../Move".get_move_Vector.connect(get_previous_Vector)
	animation_playback.travel("Idle")
	_animation_play()
	_player_idle_velocity()


func Update(_delta):
	
	if _player_vector() != Vector2.ZERO:
		print("Idle changed to Move")
		Transitioned.emit(self, "move")
	
	if Input.is_action_just_pressed("attack"):
		Transitioned.emit(self, "attack")


func Physics_Update(_delta):
	if player:
		_player_idle_velocity()
