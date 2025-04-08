extends Node

var spawn_position = Vector2(2,-1)
var hp = 100
var coins = 0

var camera_floor = 420
var camera_ceiling = -500
var camera_x_min = 340
var camera_x_max = 6000
var var_label = null
var looking_down = false
var looking_up = false
var initial = 0

func update_position(new_position):
	spawn_position = new_position

func look_down(floor, camera_node):
	Global.initial = camera_node.position.y;
	
	if(initial + 120 > floor and Global.initial!=floor):
		camera_node.position.y = floor
		looking_down = true
	else:
		if Global.initial!=floor:
			camera_node.position.y = camera_node.position.y + 120
			looking_down = true
		
	if Global.initial == floor:
		looking_down = false

func look_up(ceiling, camera_node):
	Global.initial = camera_node.position.y
	
	if(initial - 120 < ceiling and Global.initial!=ceiling):
		camera_node.position.y = ceiling
		looking_up = true
	else:
		if Global.initial!=ceiling:
			camera_node.position.y = camera_node.position.y - 120
			looking_up = true
			
	if Global.initial == ceiling:
		looking_up = false

#Must be fed max and min values AND the camera node in order
#to set its initial location
#IMPORTANT: AT camera zoom (1.2)...
#IMPORTANT: camera location is 384 pixels offset from x min/max
#IMPORTANT: camera location is 216 pixels offset from y min/max
func adjust_camera(floor, ceiling, x_min, x_max, camera_node, player):
	
	var face = player.get_node("AnimatedSprite2D")
		
	Global.camera_floor = floor
	Global.camera_ceiling = ceiling
	Global.camera_x_min = x_min
	Global.camera_x_max = x_max
	
	if(not face.flip_h):
		camera_node.position.x = player.position.x + (300)
	else:
		camera_node.position.x = player.position.x - (300)
	
	
	if(camera_node.position.x<x_min):
		camera_node.position.x = x_min
	if(camera_node.position.x>x_max):
		camera_node.position.x = x_max
		
	camera_node.position.y = player.position.y
	if(camera_node.position.y<ceiling):
		camera_node.position.y = ceiling
	if(camera_node.position.y>floor):
		camera_node.position.y = floor
	


func set_var_label(label: Label):
	var_label = label

func update_label(): #update label with current state of variables
	if var_label:
		var_label.text = "Health: " + str(Global.hp) + " | Coins: " + str(Global.coins)
	print("Label updated:", var_label.text)  # Confirm the label is set
