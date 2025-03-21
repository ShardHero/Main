extends Node

var spawn_position = Vector2(2,-1)
var hp = 100
var coins = 0

var camera_floor = 420
var camera_ceiling = 265
var camera_x_min = 340
var camera_x_max = 4600

#Must be fed max and min values AND the camera node in order
#to set its initial location
#IMPORTANT: AT camera zoom (1.2)...
#IMPORTANT: camera location is 384 pixels offset from x min/max
#IMPORTANT: camera location is 216 pixels offset from y min/max
func adjust_camera(floor, ceiling, x_min, x_max, camera_node):
	Global.camera_floor = floor
	Global.camera_ceiling = ceiling
	Global.camera_x_min = x_min
	Global.camera_x_max = x_max
	
	camera_node.position.x = x_min
	camera_node.position.y = floor
	
func update_position(new_position):
	spawn_position = new_position
