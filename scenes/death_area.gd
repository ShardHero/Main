extends Area2D
@onready var camera = get_node("../MovingCamera")
@onready var player = get_node("../main_character")

func _on_body_entered(body: Node2D) -> void:
	if body.name == "main_character":
		body.position = Global.spawn_position
		camera.position.y = 420
		camera.position.x = player.position.x + 300
