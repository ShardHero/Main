extends CharacterBody2D

@export var patrol_speed := 100.0
@export var charge_speed := 250.0
@export var knockback_force := Vector2(50, -100)
@export var knockback_duration := 0.5
@export var hp := 300

var speed := 0.0
var is_charging := false
var is_knocked_back := false
var knockback_timer := 0.0
var facing_right := true
var fight_started := false
var punch_cooldown := 1.0
var punch_timer := 0.0
var charge_continues := false  # New variable to continue charging after losing vision
@onready var game_manager: Node = %GameManager
@onready var animation_player_boss_text: AnimationPlayer = %AnimationPlayerBossText
@onready var boss_text: Label = $"../Canvas/boss_text"

func _ready() -> void:
	$AnimatedSprite2D.play("idle")
	$PunchRayCast.enabled = true

func _physics_process(delta: float) -> void:
	if not fight_started:
		return

	# Knockback
	if is_knocked_back:
		knockback_timer -= delta
		if knockback_timer <= 0:
			is_knocked_back = false
			speed = charge_speed if is_charging else patrol_speed

	# Gravity
	if not is_on_floor():
		velocity.y += ProjectSettings.get("physics/2d/default_gravity") * delta

	# Wall flip (Boss flips when it hits a wall)
	if $WallCheck.is_colliding() and not is_knocked_back and $WallCheck.get_collider() is not CharacterBody2D:
		charge_continues = false
		flip()

	# Behavior based on vision check and wall collision
	if not is_knocked_back:
		# If the boss sees the player (in vision range)
		if $Vision.is_colliding() and $Vision.get_collider() is CharacterBody2D:
			# Start charging if it sees the player
			is_charging = true
			charge_continues = true  # Start charging and continue even after losing sight
			speed = charge_speed
		elif charge_continues:
			# Continue charging if it was already charging
			speed = charge_speed
		else:
			# Stop charging and return to patrol speed
			is_charging = false
			charge_continues = false
			speed = patrol_speed

		# Move with the appropriate speed (patrolling or charging)
		velocity.x = speed

		# PUNCH detection via RayCast2D
		punch_timer -= delta
		if $PunchRayCast.is_colliding() and $PunchRayCast.get_collider() is CharacterBody2D:
			if punch_timer <= 0:
				$AnimatedSprite2D.play("punch")
				game_manager.char_lose_hp("big_boss_atk_go_vroom")
				var target = $PunchRayCast.get_collider()
				if target.has_method("apply_knockback"):
					var direction = sign(target.global_position.x - global_position.x)
					target.apply_knockback(Vector2(0, -800))
				punch_timer = punch_cooldown

		# Animations
		if $AnimatedSprite2D.animation != "punch" or !$AnimatedSprite2D.is_playing():
			if abs(velocity.x) > 0:
				$AnimatedSprite2D.play("run")
			else:
				$AnimatedSprite2D.play("idle")

	move_and_slide()

func flip() -> void:
	facing_right = !facing_right
	scale.x = abs(scale.x) * -1
	patrol_speed *= -1
	charge_speed *= -1

func on_punched(knockback_direction: int) -> void:
	if is_knocked_back:
		return

	hp -= 30
	print("Boss HP:", hp)
	if hp <= 0:
		Global.coins += 10
		Global.update_label()
		queue_free()

	if not $Vision.is_colliding():
		await get_tree().create_timer(0.4).timeout
		flip()

	is_knocked_back = true
	knockback_timer = knockback_duration
	velocity.x = knockback_force.x * knockback_direction
	velocity.y = knockback_force.y
	if $AnimatedSprite2D.animation != "punch":
		$AnimatedSprite2D.play("idle")

func _on_start_area_body_entered(body: Node2D) -> void:
	if body.name == "main_character" and not fight_started:
		boss_text.visible = true
		animation_player_boss_text.play("text_appear")
		fight_started = true
		speed = patrol_speed
		$AnimatedSprite2D.play("run")
