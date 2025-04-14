extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -550.0
@onready var char_sprite_2d = $AnimatedSprite2D
@onready var game_manager = %GameManager
@onready var punch_timer: Timer = $PunchTimer
@onready var punch_sprite: AnimatedSprite2D = $AnimatedSprite2D/PunchSprite
@onready var punch_area: Area2D = $PunchArea
@onready var punch_collision: CollisionShape2D = $PunchArea/PunchCollision

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var punch_offset = 10
var punched_enemies = {}

var anim_playing = false
var can_punch = true
var can_move = true

func _ready() -> void:
	var scene_name = get_tree().current_scene.scene_file_path
	print("scene_name:", scene_name)
	if scene_name not in Global.check_dict:
		print("hello!!")
		self.position = Global.spawn_position
	else:
		print("we have a checkpoint")
		self.position = Global.check_dict[scene_name]

func _physics_process(delta):
	# Add the gravity.
	if not can_move:
		return
	
	if Input.is_action_just_pressed("punch") and can_punch:
		can_punch = false
		punch_sprite.visible = true
		punch_sprite.play("punch")
		await get_tree().create_timer(0.2)
		punch_collision.disabled = false
		punch_timer.start(0.8)
		
	if not is_on_floor():
		if velocity.y >= 0:
			velocity.y += (gravity * 1.2) * delta
			if not anim_playing: char_sprite_2d.play("j_down")
		else:
			velocity.y += gravity * delta
			if not anim_playing: char_sprite_2d.play("j_up")
		anim_playing = true
	else:
		anim_playing = false

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if velocity.x == 0:
		if not anim_playing: 
			char_sprite_2d.play("idle")
		pass # here, we don't want to re-flip the sprite
	else:
		var isLeft = velocity.x < 0
		char_sprite_2d.flip_h = isLeft
		if isLeft:
			punch_sprite.position.x = -punch_offset
			punch_area.position.x = -60
		else: 
			punch_sprite.position.x = punch_offset
			punch_area.position.x = 0

		if not anim_playing: char_sprite_2d.play("run")

	move_and_slide()
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider and collider.is_in_group("enemies"):
			game_manager.char_lose_hp(collider.name)
			print("Player collided with an enemy!")
			# Example: Implement knockback, health reduction, or other effects here

func _on_punch_timer_timeout() -> void:
	can_punch = true
	punch_sprite.stop()
	punch_sprite.frame = 0
	punch_sprite.visible = false
	punch_collision.disabled = true
	punched_enemies.clear()  # Ensure no repeated hits on the same enemy

func _on_punch_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		if body.name not in punched_enemies and not punch_collision.disabled:
			print("Punch collided with enemy:", body.name)
			punched_enemies[body.name] = true
			var left = -1 if velocity.x < 0 else 1
			body.on_punched(left)
		else:
			print("Punch ignored: already punched or collision disabled.")
