extends Area2D
@onready var boss: CharacterBody2D = $"../Boss"
@onready var boss_text_2: Label = $"../Canvas/boss_text_2"
@onready var animation_player_boss: AnimationPlayer = %AnimationPlayerBoss


func _on_body_entered(body: Node2D) -> void:
	if boss:
		animation_player_boss.play("text_2_appear")
	else:
		pass
