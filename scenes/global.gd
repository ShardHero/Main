extends Node

var spawn_position = Vector2(2,-1)
var hp = 100
var coins = 0

var camera_floor = 420
var camera_ceiling = 265
var camera_x_min = -8000
var camera_x_max = 750

func update_position(new_position):
	spawn_position = new_position
