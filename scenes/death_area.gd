extends Area2D
@onready var camera = get_node("../MovingCamera")
@onready var player = get_node("../main_character")
@onready var animation_player = %AnimationPlayer
@onready var var_label = %VarLabel


func _on_body_entered(body: Node2D) -> void:
	if body.name == "main_character":
		animation_player.play("fade")
		animation_player.play("fade_in")
		body.position = Global.spawn_position
		Global.hp = 100
		var_label.update_label()
		camera.position.y = 420
		camera.position.x = player.position.x + 300
