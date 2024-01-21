extends State
class_name Player_state_attack


@onready var player: CharacterBody2D = $"../.."

@export var Attack_Animation_Duration: float
@onready var animation_tree: AnimationTree = $"../../AnimationTree"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var animation_playback: AnimationNodeStateMachinePlayback = $"../../AnimationTree".get("parameters/playback")


func _player_attack_velocity() -> void:
	player.velocity = player.velocity.move_toward(Vector2.ZERO, Player.ACCELERATION)


func _animation_play() -> void:
	animation_tree.set("parameters/Attack/blend_position", $"../Move".previous_vector)

func _animation_is_completed() -> bool:
	if animation_playback.get_current_play_position() > Attack_Animation_Duration:
		animation_playback.stop()
		return true
	else:
		return false


func Enter():
	animation_playback.travel("Attack")
	_animation_play()
	_player_attack_velocity()


func Exit():
	pass


func Update(_delta):
	
	if player:
		_animation_play()
	
	if _animation_is_completed():
		print("Attack changed to Idle")
		Transitioned.emit(self, "idle")
	


func Physics_Update(_delta):
	
	if player:
		_player_attack_velocity()

