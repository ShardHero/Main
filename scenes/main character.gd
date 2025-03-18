extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var char_sprite_2d = $AnimatedSprite2D
@onready var game_manager = %GameManager
@onready var damage_timer = $HitCooldownTimer  # Reference to the timer

var can_take_damage = true  # Prevent multiple damage hits

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		if velocity.y >= 0:
			velocity.y += (gravity * 1.2) * delta
		else:
			velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if velocity.x == 0:
		pass # here, we don't want to re-flip the sprite
	else:
		var isLeft = velocity.x < 0
		char_sprite_2d.flip_h = isLeft
		

	move_and_slide()
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider and collider.is_in_group("enemies") and can_take_damage:
			game_manager.char_lose_hp()
			set_collision_mask_value(2, false)
			can_take_damage = false
			print("Player collided with an enemy!")

	

func _on_hit_cooldown_timer_timeout() -> void:
	set_collision_mask_value(2, true)
	can_take_damage = true
