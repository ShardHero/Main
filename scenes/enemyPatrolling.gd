extends CharacterBody2D

var normal_speed = 100.0
var speed = normal_speed
var facing_right = true

var hp = 99
var knockback_duration = 0.5  # Knockback duration in seconds
var knockback_force_x = 80.0  # Horizontal knockback strength
var knockback_force_y = -300.0  # Vertical knockback strength (upward push)
var knockback_timer = 0.8  # Timer to track knockback duration
var is_knocked_back = false  # Flag to check if the character is currently in knockback state

func _physics_process(delta: float) -> void:
	# Handle knockback timer
	if is_knocked_back:
		knockback_timer -= delta
		if knockback_timer <= 0:
			is_knocked_back = false
			velocity.x = 0  # Stop any knockback force after timer ends
			velocity.x += speed  # Restore normal speed

	# Apply gravity if the character is not on the floor
	if not is_on_floor():
		velocity += get_gravity() * delta

	if !$FallingCheck.is_colliding() and is_on_floor():
		flip()

	if $WallCheck.is_colliding() and is_on_floor():
		flip()

	# If not in knockback, move normally
	if not is_knocked_back:
		velocity.x = speed

	move_and_slide()

func flip():
	facing_right = !facing_right
	scale.x = abs(scale.x) * -1
	if facing_right:
		speed = abs(normal_speed)
	else:
		speed = abs(normal_speed) * -1

func on_punched(knockback_direction: int):
	if not is_knocked_back:
		hp -= 33
		print("Enemy punched, HP:", hp)
		if hp <= 0:
			queue_free()

		is_knocked_back = true
		knockback_timer = knockback_duration
		velocity.x = knockback_force_x * knockback_direction
		velocity.y = knockback_force_y
