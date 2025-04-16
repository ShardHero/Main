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

# Called when the node enters the scene tree for the first time.
func _start_scene():
	Global.set_var_label(var_label_node)
	Global.update_label()
	var scene_name = get_tree().current_scene.scene_file_path
	if Global.check_dict["res://scenes/level1.tscn"].x < 5550:
		main_character.position = Vector2(-400,0)
		Global.adjust_camera(405,-134, -5000, 400, camera, player)
		await get_tree().create_timer(0.5).timeout
		animation_player.play("fade_in")
	else:
		main_character.position = Vector2(200,0)
		Global.adjust_camera(405, -134, 390, 1550, camera, player)
		await get_tree().create_timer(0.5).timeout
		animation_player.play("fade_in")
