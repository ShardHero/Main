extends Node
@onready var damage_timer = $DamageCooldownTimer  # Reference to the timer
@onready var main_char = %"main_character"
@onready var var_label: Label = %VarLabel

var hp = 100
var can_take_damage = true  # Prevent multiple damage hits
var coins = 0

func char_lose_hp():
	if can_take_damage:
		hp -= 10
		var_label.set_hp(hp)  # Call the function from the label script
		can_take_damage = false  # Start cooldown to prevent more damage
		damage_timer.start()  # Start cooldown timer
		if hp <= 0:
			main_char.queue_free()
		

func _on_damage_cooldown_timer_timeout() -> void:
	can_take_damage = true

func add_coin():
	coins += 1
	var_label.set_hp(hp)  # Call the function from the label script
	
