extends Area2D

var checked = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.name == "main_character":
		var scene_name = get_tree().current_scene.scene_file_path
		print("scene_name:", scene_name)
		Global.update_latest_checkpoint(scene_name, body)
		print("checked off", Global.check_dict[scene_name])
