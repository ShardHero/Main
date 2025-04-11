extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if body.name == "main_character":
		print("wooooooo")
		call_deferred("_go_to_level_3")

func _go_to_level_3():
	get_tree().change_scene_to_file("res://scenes/level_3.tscn")
