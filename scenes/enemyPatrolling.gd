extends CharacterBody2D

var normal_speed = 100.0
var speed = normal_speed
var facing_right = true
	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if !$FallingCheck.is_colliding() && is_on_floor():
		flip()
		
	if $WallCheck.is_colliding() && is_on_floor():
		flip()

	velocity.x = speed

	move_and_slide()
	
func flip():
	facing_right = !facing_right
	
	scale.x = abs(scale.x) * -1
	if facing_right:
		speed = abs(normal_speed)
	else:
		speed = abs(normal_speed) * -1
