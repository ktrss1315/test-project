extends Node2D
class_name Object_grass

var grass_effect_resource: Resource = load("res://data/scenes/Effects/grass_effect.tscn")
var effect = grass_effect_resource.instantiate()

@onready var main = get_tree().current_scene


func _process(_delta):
	
	if Input.is_action_just_pressed("attack"):
		main.add_child(effect)
		effect.global_position = global_position
		queue_free()
