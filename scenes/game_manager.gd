extends Node
@onready var damage_timer = $DamageCooldownTimer  # Reference to the timer
@onready var main_char = %"main_character"
# VarLabel is autoloaded and global.

@onready var player = get_node("../main_character")
@onready var camera = get_node("../MovingCamera")
@onready var y_pos = player.position.y;
#@onready var previous = 0;
#@onready var frame_count = -1

func _process(_delta):

	if player.position.y < 2 and player.position.y > -1 and not Global.looking_up:
		camera.position.y = Global.camera_floor
		
	if camera.position.y > Global.camera_floor:
		camera.position.y = Global.camera_floor - 1

	if player.is_on_floor():
		y_pos = player.position.y;
		
		if not camera.position.y == Global.camera_floor and not Global.looking_down and not Global.looking_up:
			if not player.position.y + 540 > Global.camera_floor:
				camera.position.y = player.position.y + 540;
				if camera.position.y <= Global.camera_ceiling:
					camera.position.y = Global.camera_ceiling
		
		if not camera.position.y == Global.camera_floor and not Global.looking_down and not Global.looking_up:
				if Input.is_action_just_pressed("down"):
					Global.look_down(Global.camera_floor, camera)
		if not camera.position.y == Global.camera_floor and not camera.position.y == Global.camera_ceiling and not Global.looking_up and not Global.looking_down:
				if Input.is_action_just_pressed("up"):
					Global.look_up(Global.camera_ceiling, camera)
				
			
	if Input.is_action_just_released("down") and Global.looking_down and not Global.looking_up:
		Global.looking_down = false
		if(camera.position.y>Global.initial + 120):
			camera.position.y
		else:
			camera.position.y = Global.initial
			
	if Input.is_action_just_released("up") and Global.looking_up and not Global.looking_down:
		Global.looking_up = false
		if(camera.position.y<Global.initial - 120):
			camera.position.y = Global.initial
		else:
			camera.position.y = Global.initial
		
	if not player.is_on_floor():
		if player.position.y > y_pos+0 or player.position.y < y_pos-0:
			camera.position.y += player.velocity.y/100;
			if camera.position.y <= Global.camera_ceiling: 
				camera.position.y = Global.camera_ceiling
	
	if Input.is_action_pressed("right"):
		if player.velocity[0] != 0:
			if player.position.x + 300 < Global.camera_x_max && player.position.x + 300 > Global.camera_x_min:
				camera.position.x = player.position.x + 300;
			if player.position.x + 300 >= Global.camera_x_max:
				camera.position.x = Global.camera_x_max
			
	if Input.is_action_pressed("left"):
		if player.velocity[0] != 0:
			if player.position.x + 50 < Global.camera_x_max && player.position.x + 50 > Global.camera_x_min:
				camera.position.x = player.position.x + 50;
			if player.position.x + 50 <= Global.camera_x_min:
				camera.position.x = Global.camera_x_min


var can_take_damage = true  # Prevent multiple damage hits

func char_lose_hp():
	if can_take_damage:
		Global.hp -= 10
		Global.update_label()  # Refresh label
		can_take_damage = false  # Start cooldown to prevent more damage
		damage_timer.start()  # Start cooldown timer
		if Global.hp <= 0:
			main_char.queue_free()

func _on_damage_cooldown_timer_timeout() -> void:
	can_take_damage = true

func add_coin():
	Global.coins += 1
	Global.update_label()  
	
