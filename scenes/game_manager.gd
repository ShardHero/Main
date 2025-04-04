extends Node
@onready var damage_timer = $DamageCooldownTimer  # Reference to the timer
@onready var main_char = %"main_character"
@onready var animation_player = %AnimationPlayer
# VarLabel is autoloaded and global.

@onready var player = get_node("../main_character")
@onready var camera = get_node("../MovingCamera")
@onready var y_pos = player.position.y;

func _process(_delta):
	if player.position.y < 2 and player.position.y > -1:
		camera.position.y = Global.camera_floor
		
	if camera.position.y > Global.camera_floor:
		camera.position.y = Global.camera_floor - 1

	if player.is_on_floor():
		y_pos = player.position.y;
		if not camera.position.y == Global.camera_floor:
			if not player.position.y + 540 > Global.camera_floor:
				camera.position.y = player.position.y + 540;
				if camera.position.y <= Global.camera_ceiling:
					camera.position.y = Global.camera_ceiling
		
		#CAMERA CEILING 265??
	if not player.is_on_floor():
		if player.position.y > y_pos+0 or player.position.y < y_pos-0:
			camera.position.y += player.velocity.y/100;
			if camera.position.y <= Global.camera_ceiling: 
				camera.position.y = Global.camera_ceiling
	
	if Input.is_action_pressed("ui_right"):
		if player.velocity[0] != 0:
			if player.position.x + 300 < Global.camera_x_max && player.position.x + 300 > Global.camera_x_min:
				camera.position.x = player.position.x + 300;
			if player.position.x + 300 >= Global.camera_x_max:
				camera.position.x = Global.camera_x_max
			
	if Input.is_action_pressed("ui_left"):
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
			animation_player.play("fade")
			animation_player.play("fade_in")
			main_char.position = Global.spawn_position
			Global.hp = 100
			var_label.update_label()

func _on_damage_cooldown_timer_timeout() -> void:
	can_take_damage = true

func add_coin():
	Global.coins += 1
	Global.update_label()  
	
