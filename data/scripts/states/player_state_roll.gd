extends State
class_name Player_state_roll


@onready var player: CharacterBody2D = $"../.."

@export var Roll_Animation_Duration: float
@onready var animation_tree: AnimationTree = $"../../AnimationTree"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var animation_playback: AnimationNodeStateMachinePlayback = $"../../AnimationTree".get("parameters/playback")


const ROLL_VELOCITY =  Player.SPEED * 1.7
const ROLL_ACCELERATION = ROLL_VELOCITY / 12


func _animation_is_completed() -> bool:
	if animation_playback.get_current_play_position() > Roll_Animation_Duration:
		animation_playback.stop()
		return true
	else:
		return false

func _animation_play():
	animation_tree.set("parameters/Roll/blend_position", $"../Move".previous_vector)


func _player_roll_velocity():
	player.velocity = player.velocity.move_toward($"../Move".previous_vector * ROLL_VELOCITY, ROLL_ACCELERATION)
	print("Roll velocity updated: ", str(player.velocity))


func Enter():
	animation_playback.travel("Roll")
	_animation_play()
	_player_roll_velocity()


func Update(_delta):
	
	if player:
		_animation_play()
	
	if _animation_is_completed():
		Transitioned.emit(self, "move")


func Physics_Update(_delta):
	
	if player:
		_player_roll_velocity()
	
