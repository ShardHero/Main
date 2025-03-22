# MainScene.gd (or Level2, Level3, etc.)
extends Node

@onready var var_label_node = $Canvas/Panel/VarLabel

func _ready():
	# Set the global reference to VarLabel when the scene is loaded
	Global.set_var_label(var_label_node)
 
