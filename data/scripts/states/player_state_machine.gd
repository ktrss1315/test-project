extends Node
class_name Player_state_machine


@export var INITIAL_STATE: State
var CURRENT_STATE: State
var states: Dictionary


func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
	
	if INITIAL_STATE:
		INITIAL_STATE.Enter()
		CURRENT_STATE = INITIAL_STATE


func _process(delta):
	if CURRENT_STATE:
		CURRENT_STATE.Update(delta)

func _physics_process(delta):
	if CURRENT_STATE:
		CURRENT_STATE.Physics_Update(delta)


func on_child_transition(STATE: State, new_state_name: StringName):
	if STATE != CURRENT_STATE:
		print("ERROR: Transitioned STATE is not CURRENT_STATE")
		return
	
	var NEW_STATE: State = states.get(new_state_name)
	if not(NEW_STATE):
		print("ERROR: NEW_STATE not defined")
		return
	
	if CURRENT_STATE:
		CURRENT_STATE.Exit()
	
	NEW_STATE.Enter()
	CURRENT_STATE = NEW_STATE
