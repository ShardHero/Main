extends Node2D

func adjust_camera(floor, ceiling, x_min, x_max):
	var camera = get_node("MovingCamera")
	camera.position.y = floor
	Global.camera_floor = floor
	Global.camera_ceiling = ceiling
	
	camera.position.x = x_min
	Global.camera_x_min = x_min
	Global.camera_x_max = x_max
	
# Called when the node enters the scene tree for the first time.
func _ready():
	adjust_camera(405, 350, 390, 6500)

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
