extends Node
@onready var hp_label = %HPLabel
@onready var damage_timer = $DamageCooldownTimer  # Reference to the timer
@onready var main_char = %"main_character"

@onready var player = get_node("../main_character")
@onready var camera = get_node("../MovingCamera")
@onready var y_pos = player.position.y;

func _process(delta):
	#print("Player x Vel: ",player.velocity.x)
	print("Player y Pos: ", player.position.y)
	print("Camera y Pos: ", camera.position.y)

	if player.position.y < 2 and player.position.y > -1:
		camera.position.y = 420

	if player.is_on_floor():
		y_pos = player.position.y;
		camera.position.y = player.position.y + 420;
		#camera.position.y = -400;
		
	if not player.is_on_floor():
		if player.position.y > y_pos or player.position.y < y_pos:
			camera.position.y += player.velocity.y/100;
			#if camera.position.y >= 405: 
				#camera.position.y = 405
	
	if Input.is_action_pressed("ui_right"):
		if player.position.x < 100000 && player.position.x > 40:
			if player.velocity[0] != 0:
				camera.position.x = player.get_position()[0] + 300;
			
	if Input.is_action_pressed("ui_left"):
		if player.velocity[0] != 0:
			if player.position.x < 100000 && player.position.x > 340:
				camera.position.x = player.get_position()[0] + 50;
			if player.position.x < 390:
				camera.position.x = 340


var hp = 100
var can_take_damage = true  # Prevent multiple damage hits

func char_lose_hp():
	if can_take_damage:
		hp -= 10
		hp_label.text = "Health: " + str(hp)
		can_take_damage = false  # Start cooldown to prevent more damage
		damage_timer.start()  # Start cooldown timer
		if hp <= 0:
			main_char.queue_free()
		

func _on_damage_cooldown_timer_timeout() -> void:
	can_take_damage = true
