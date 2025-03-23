# MainScene.gd (or Level2, Level3, etc.)
extends Node

@onready var var_label_node = $Canvas/Panel/VarLabel

extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var camera = get_node("MovingCamera")
	#Floor, Ceiling, Xmin, Xmax
	Global.adjust_camera(405, -134, 390, 6116, camera)
	Global.set_var_label(var_label_node)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
