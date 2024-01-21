extends State
class_name Player_state_move

@onready var player = $"../.."

@onready var animation_playback = $"../../AnimationTree".get("parameters/playback")
@onready var animation_tree = $"../../AnimationTree"
@onready var animation_player = $"../../AnimationPlayer"

@onready var previous_vector := Vector2(0, 1).normalized()


func _player_vector() -> Vector2:
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	if input_direction != Vector2.ZERO:
		previous_vector = input_direction
	return input_direction


func _animation_play() -> void:
	animation_tree.set("parameters/Move/blend_position", _player_vector())


func _player_move_velocity() -> void:
	player.velocity = player.velocity.move_toward(_player_vector() * Player.SPEED, Player.ACCELERATION)
	print("Move physics updated: " + str(player.velocity) + "\t" + str(_player_vector()))


func Enter():
	animation_playback.travel("Move")
	_player_move_velocity()


func Update(_delta):
	
	if player:
		if _player_vector() != Vector2.ZERO:
			_animation_play()
	
	
	if  _player_vector() == Vector2.ZERO and player.velocity == Vector2.ZERO:
		print("Move change to Idle")
		Transitioned.emit(self, "idle")
	
	if Input.is_action_just_pressed("attack"):
		print("Move change to Attack")
		Transitioned.emit(self, "attack")
	
	if Input.is_action_just_pressed("roll"):
		print("Move change to Roll")
		Transitioned.emit(self, "roll")


func Physics_Update(_delta):
	
	if player:
		_player_move_velocity()
