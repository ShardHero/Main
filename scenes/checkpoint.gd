extends Area2D

var checked = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.name == "main_character" and not checked:
		Global.update_position(body.position)
		checked = true
