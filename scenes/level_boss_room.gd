extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == "main_character":
		get_tree().change_file_to_scene("boss_room_placeholder")
