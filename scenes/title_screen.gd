extends Node
@onready var animation_player = %AnimationPlayer

func _on_button_pressed() -> void:
	animation_player.play("fade")
	await animation_player.animation_finished # Wait for it to finish
	
	get_tree().change_scene_to_file("res://scenes/level1.tscn")
