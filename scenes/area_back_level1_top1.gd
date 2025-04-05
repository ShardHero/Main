extends Area2D
@onready var main_character: CharacterBody2D = %main_character

func _on_body_entered(body: Node2D) -> void:
	if body.name == "main_character":
		main_character.position = Vector2(-2375,0)
		get_tree().change_scene_to_file("res://scenes/level1.tscn")
