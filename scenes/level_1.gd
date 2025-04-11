# MainScene.gd (or Level2, Level3, etc.)
extends Node

@onready var var_label_node = $Canvas/Panel/VarLabel
@onready var animation_player = %AnimationPlayer
@onready var player = get_node("main_character")
@onready var camera = get_node("MovingCamera")

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("fade_in")
	#Floor, Ceiling, Xmin, Xmax
	Global.set_var_label(var_label_node)
	Global.update_label()
	Global.adjust_camera(405, -134, 390, 6116, camera, player)
	Global.set_var_label(var_label_node)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
