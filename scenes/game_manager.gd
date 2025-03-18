extends Node
@onready var damage_timer = $DamageCooldownTimer  # Reference to the timer
@onready var main_char = %"main_character"
@onready var var_label: Label = %VarLabel

<<<<<<< HEAD
@onready var player = get_node("../main_character")
@onready var camera = get_node("../MovingCamera")
@onready var y_pos = player.position.y;

@onready var camera_floor = 420
@onready var camera_ceiling = 265
@onready var camera_x_min = 340
@onready var camera_x_max = 4600

func _process(delta):
	
	##TEST TEST
	#print("Player x Pos: ", player.position.x)
	#print("Camera x Pos: ", camera.position.x)
	#print("Player y Pos: ", player.position.y)
	#print("Camera y Pos: ", camera.position.y)
	##TEST TEST
	
	if player.position.y < 2 and player.position.y > -1:
		camera.position.y = camera_floor
		
	if camera.position.y > camera_floor:
		camera.position.y = camera_floor - 1

	if player.is_on_floor():
		y_pos = player.position.y;
		if not camera.position.y == camera_floor:
			if not player.position.y + 540 > camera_floor:
				camera.position.y = player.position.y + 540;
				if camera.position.y <= camera_ceiling:
					camera.position.y = camera_ceiling
		
		#CAMERA CEILING 265??
	if not player.is_on_floor():
		if player.position.y > y_pos+50 or player.position.y < y_pos-50:
			camera.position.y += player.velocity.y/100;
			if camera.position.y <= camera_ceiling: 
				camera.position.y = camera_ceiling
	
	if Input.is_action_pressed("ui_right"):
		if player.velocity[0] != 0:
			if player.position.x + 300 < camera_x_max && player.position.x + 300 > camera_x_min:
				camera.position.x = player.position.x + 300;
			if player.position.x + 300 >= camera_x_max:
				camera.position.x = camera_x_max
			
	if Input.is_action_pressed("ui_left"):
		if player.velocity[0] != 0:
			if player.position.x + 50 < camera_x_max && player.position.x + 50 > camera_x_min:
				camera.position.x = player.position.x + 50;
			if player.position.x + 50 <= camera_x_min:
				camera.position.x = camera_x_min


var can_take_damage = true  # Prevent multiple damage hits

func char_lose_hp():
	if can_take_damage:
		Global.hp -= 10
		var_label.update_label()  # Refresh label
		can_take_damage = false  # Start cooldown to prevent more damage
		damage_timer.start()  # Start cooldown timer
		if Global.hp <= 0:
			main_char.queue_free()
		

func _on_damage_cooldown_timer_timeout() -> void:
	can_take_damage = true

func add_coin():
	Global.coins += 1
	var_label.update_label() 
	
