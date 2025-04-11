extends Area2D
@onready var camera = get_node("../MovingCamera")
@onready var player = get_node("../main_character")
@onready var animation_player = %AnimationPlayer


func _on_body_entered(body: Node2D) -> void:
	if body.name == "main_character":
		var scene_name = get_tree().current_scene.scene_file_path
		animation_player.play("fade_out")
		animation_player.play("fade_in")
		if scene_name not in Global.check_dict:
			body.position = Global.spawn_position
		else:
			body.position = Global.check_dict[scene_name]
		camera.position.y = player.position.y - 100
		camera.position.x = player.position.x + 150
		Global.hp -= 10
		Global.update_label()  # Refresh label
		if Global.hp <= 0:
			Global.on_player_death(player, camera, scene_name)
