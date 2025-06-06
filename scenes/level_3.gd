extends Node2D

@onready var var_label_node = $Canvas/Panel/VarLabel
@onready var main_character: CharacterBody2D = %main_character
@onready var player = get_node("main_character")
@onready var camera = get_node("MovingCamera")
@onready var animation_player = %AnimationPlayer
@onready var blackbox = $Canvas/blackbox

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	blackbox.modulate.a = 1.0
	call_deferred("_start_scene")

func _start_scene():
	Global.set_var_label(var_label_node)
	Global.update_label()
	main_character.position = Vector2(-100,-200)
	Global.adjust_camera(600, -50, 120, 8700, camera, player)
	await get_tree().create_timer(0.5).timeout
	animation_player.play("fade_in")
