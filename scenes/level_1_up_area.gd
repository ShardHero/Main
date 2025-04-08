extends Area2D
@onready var animation_player = %AnimationPlayer


func _on_body_entered(body: Node2D) -> void:
	if body.name == "main_character":
		animation_player.play("fade_out")
		await animation_player.animation_finished # Wait for it to finish
		get_tree().change_scene_to_file("res://scenes/toplevel_2.tscn")
