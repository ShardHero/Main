extends Area2D
@onready var camera = get_node("../MovingCamera")
@onready var player = get_node("../main_character")
@onready var animation_player = %AnimationPlayer
@onready var blackbox = get_node("../Canvas/blackbox")


func _on_body_entered(body: Node2D) -> void:
	if body.name == "main_character":
		body.can_move = false
		
		var scene_name = get_tree().current_scene.scene_file_path
		animation_player.play("fade_out")
		await animation_player.animation_finished # Wait for it to finish
		blackbox.modulate.a = 1.0
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
		await get_tree().create_timer(1).timeout
		animation_player.play("fade_in")
		
		body.can_move = true
		
	elif body.name.begins_with("enemy"):
		body.queue_free()
