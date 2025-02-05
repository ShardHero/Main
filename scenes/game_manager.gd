extends Node
@onready var hp_label = %HPLabel

var hp = 100
func lose_hp():
	hp -= 15
	hp_label.text = "Health: " + str(hp)
