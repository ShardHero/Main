extends Node
@onready var hp_label = %HPLabel
@onready var damage_timer = $DamageCooldownTimer  # Reference to the timer
@onready var main_char = %"main character"

var hp = 100

func char_lose_hp():
	hp -= 10
	hp_label.text = "Health: " + str(hp)
	main_char.set_collision_mask_value(2, false)
	damage_timer.start()  # Start cooldown timer		
	if hp <= 0:
		main_char.queue_free()
