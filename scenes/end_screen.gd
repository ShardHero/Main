extends Node2D




func _on_button_pressed() -> void:
	Global.check_dict.clear()
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")
