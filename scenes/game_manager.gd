extends Node
@onready var hp_label = %HPLabel
@onready var damage_timer = $DamageCooldownTimer  # Reference to the timer
@onready var main_char = %"main character"

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
