extends Area2D

@onready var not_enough_coins_label: Label = $"../Canvas/not_enough_coins_label"
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var heart: AnimatedSprite2D = $Heart

func _on_body_entered(body: Node2D) -> void:
	if body.name == "main_character":
		if Global.coins >= 5:
			Global.coins -= 5
			Global.hp += 20
			Global.update_label()
			heart.play("on_enter")
		else:
			not_enough_coins_label.text = "YOU NEED " + str(5 - Global.coins) + " MORE COINS"
			not_enough_coins_label.visible = true
			animation_player.play("not_enough_coins")
