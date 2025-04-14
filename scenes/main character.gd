extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -550.0
@onready var char_sprite_2d = $AnimatedSprite2D
@onready var game_manager = %GameManager
@onready var fist_hitbox = $Fist

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	self.position = Global.spawn_position
	fist_hitbox.monitoring = false
	
func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			print("TEST")
			attack()

func attack():
	fist_hitbox.monitoring = true
	await get_tree().create_timer(0.1).timeout
	fist_hitbox.monitoring = false

func _on_Fist_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		body.queue_free()
		#body.take_damage(5)
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		if velocity.y >= 0:
			velocity.y += (gravity * 1.2) * delta
			# char_sprite_2d.play("j_down")
		else:
			velocity.y += gravity * delta
			# char_sprite_2d.play("j_up")

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
		# char_sprite_2d.play("idle")
		pass # here, we don't want to re-flip the sprite
	else:
		var isLeft = velocity.x < 0
		char_sprite_2d.flip_h = isLeft
		
		# char_sprite_2d.play("run")

	move_and_slide()
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider and collider.is_in_group("enemies"):
			game_manager.char_lose_hp()
			print("Player collided with an enemy!")
			# Example: Implement knockback, health reduction, or other effects here
