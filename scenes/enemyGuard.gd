extends CharacterBody2D

var gravity = ProjectSettings.get("physics/2d/default_gravity")
var speed = 700.0
var jump_speed = 700.0
@export var facing_right: bool = true
var posx
var distance
var hp = 100

var knockback_force_x = 50.0  # Horizontal knockback strength
var knockback_force_y = 200.0 # Vertical knockback strength (upward push)
var knockback_duration = 1    # Knockback duration in seconds
var knockback_timer = 0.0      # Timer to track knockback duration
var is_knocked_back = false    # Flag to track if knockback is happening

func _ready() -> void:
	if (!facing_right):
		scale.x = abs(scale.x) * -1

func _physics_process(delta: float) -> void:
	# Handle knockback timer
	if (is_knocked_back):
		knockback_timer -= delta
		if knockback_timer <= 0:
			is_knocked_back = false
			velocity.x = 0  # Stop any knockback force after timer ends
			velocity.x += speed  # Restore normal speed

	# If the guard is not knocked back, apply gravity and handle normal movement
	if not is_knocked_back:
		if not is_on_floor():
			velocity.y += gravity * delta
			$Sprite2D.animation = "Leaping"
		
		if (is_on_floor() && velocity.x == 0):
			$Sprite2D.animation = "Idle"
		
		if (is_on_floor() && velocity.x != 0):
			$Sprite2D.animation = "Running"
		
		if (facing_right && $Vision.is_colliding() && is_on_floor()):
			if ($Vision.get_collider() is CharacterBody2D):
				if (!$WallCheck.is_colliding()):
					posx = $Vision.get_collision_point().x
					distance = posx - position.x 
					velocity.y = -sqrt(0.55 * distance * gravity)
					velocity.x = sqrt(0.5 * distance * gravity)
			if ($Vision.get_collider() is not CharacterBody2D && $WallCheck.is_colliding()):
				velocity.x = 0
				flip()
			if ($Vision.get_collider() is not CharacterBody2D && !$FloorCheck.is_colliding()):
				velocity.x = 0
				flip()
		
		elif (!facing_right && $Vision.is_colliding() && is_on_floor()):
			if ($Vision.get_collider() is CharacterBody2D):
				if (!$WallCheck.is_colliding()):
					posx = $Vision.get_collision_point().x
					distance = position.x - posx
					velocity.y = -sqrt(0.55 * distance * gravity)
					velocity.x = sqrt(0.5 * distance * gravity) * -1
			if ($Vision.get_collider() is not CharacterBody2D && $WallCheck.is_colliding()):
				velocity.x = 0
				flip()
			if ($Vision.get_collider() is not CharacterBody2D && !$FloorCheck.is_colliding()):
				velocity.x = 0
				flip()

	move_and_slide()

# Flip the guard direction when needed
func flip():
	facing_right = !facing_right
	scale.x = abs(scale.x) * -1

# In on_punched function
func on_punched(knockback_direction: int):
	if not is_knocked_back:
		hp -= 25
		print("Enemy punched, HP:", hp)
		if hp <= 0:
			Global.coins += 2
			Global.update_label()
			queue_free()

		is_knocked_back = true
		knockback_timer = knockback_duration
		velocity.x = knockback_force_x * knockback_direction
		velocity.y = knockback_force_y
