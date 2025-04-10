# MainScene.gd (or Level2, Level3, etc.)
extends Node

@onready var var_label_node = $Canvas/Panel/VarLabel
@onready var player = get_node("main_character")
@onready var camera = get_node("MovingCamera")

# Called when the node enters the scene tree for the first time.
func _ready():
	#Floor, Ceiling, Xmin, Xmax
	Global.set_var_label(var_label_node)
	Global.update_label()
	Global.adjust_camera(405, -134, 390, 6116, camera, player)
	Global.set_var_label(var_label_node)

	var level3_scene = load("res://scenes/level_3.tscn")
	print("Scene loaded: ", level3_scene)

	var instance = level3_scene.instantiate()
	get_tree().root.add_child(instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
