extends Area2D

@onready var boss_text_2: Label = $"../Canvas/boss_text_2"
@onready var animation_player_boss: AnimationPlayer = %AnimationPlayerBossText
@onready var enemy_boss_path = NodePath("../enemyBoss") # store the path
var enemy_boss: CharacterBody2D = null


func _ready() -> void:
	if has_node(enemy_boss_path):
		enemy_boss = get_node(enemy_boss_path)


func _on_body_entered(body: Node2D) -> void:
	if enemy_boss and is_instance_valid(enemy_boss):
		animation_player_boss.play("text_2_appear")
	else:
		get_tree().change_scene_to_file("res://scenes/end_screen.tscn")
