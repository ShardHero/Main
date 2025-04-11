extends Node2D

@onready var var_label_node = $Canvas/Panel/VarLabel
@onready var animation_player = %AnimationPlayer
@onready var main_character: CharacterBody2D = %main_character
@onready var player = get_node("main_character")
@onready var camera = get_node("MovingCamera")
@onready var blackbox = $Canvas/blackbox

# Called when the node enters the scene tree for the first time.
func _ready():
	blackbox.modulate.a = 1.0
	call_deferred("_start_scene")

func _start_scene():
	Global.set_var_label(var_label_node)
	Global.update_label()
	main_character.position = Vector2(0,0)
	Global.adjust_camera(450, 100, -7900, 1050, camera, player)
	await get_tree().create_timer(0.5).timeout
	animation_player.play("fade_in")
