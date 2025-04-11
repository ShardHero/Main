extends Area2D

@onready var animation_player = %AnimationPlayer

func _on_body_entered(body: Node2D) -> void:
	if body.name == "main_character":
		get_tree().paused = true
		# Make sure the animation player can still process while the game is paused
		animation_player.process_mode = Node.PROCESS_MODE_ALWAYS
		
		animation_player.play("fade_out")
		await animation_player.animation_finished # Wait for it to finish
		
		# Unpause before changing scene
		get_tree().paused = false
		get_tree().change_file_to_scene("boss_room_placeholder")
