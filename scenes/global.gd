extends Node
@onready var damage_timer = $DamageCooldownTimer  # Reference to the timer

var spawn_position = Vector2(2,-1)
var hp = 100
var coins = 0

var camera_floor = 420
var camera_ceiling = -500
var camera_x_min = 340
var camera_x_max = 6000
var var_label = null

var check_dict = {}

# flag denoting if player should spawn from diff position other than default pos stated in level*.gd
var spawn_flag = false

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
	
func set_spawn_flag(flag):
	spawn_flag = flag

func on_player_death(body, camera, scene_name): # assuming body is main_char AND camera is MovingCamera
	if scene_name not in check_dict:
		body.position = Global.spawn_position
	else:
		body.position = check_dict[scene_name]
	camera.position.y = body.position.y - 100
	camera.position.x = body.position.x + 150
	Global.coins = max(Global.coins - 10, 0)
	Global.hp = 100
	Global.update_label()

func update_latest_checkpoint(scene_name, checkpoint):
	check_dict[scene_name] = checkpoint.global_position
