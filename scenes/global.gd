extends Node

var spawn_position = Vector2(2,-1)
var hp = 100
var coins = 0

var camera_floor = 420
var camera_ceiling = -500
var camera_x_min = 340
var camera_x_max = 6000
var var_label = null

func update_position(new_position):
	spawn_position = new_position


func set_var_label(label: Label):
	var_label = label

func update_label(): #update label with current state of variables
	if var_label:
		var_label.text = "Health: " + str(Global.hp) + " | Coins: " + str(Global.coins)
	print("Label updated:", var_label.text)  # Confirm the label is set
