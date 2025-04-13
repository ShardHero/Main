extends Node2D

@onready var var_label_node = $Canvas/Panel/VarLabel
@onready var main_character: CharacterBody2D = %main_character
@onready var player = get_node("main_character")
@onready var camera = get_node("MovingCamera")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	Global.set_var_label(var_label_node)
	Global.update_label()
	main_character.position = Vector2(-100,-200)
	Global.adjust_camera(600, -50, -200, 9250, camera, player)
