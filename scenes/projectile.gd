extends CharacterBody2D

@export var speed: float = 240  # Speed of projectile
@export var move_direction: Vector2 = Vector2(-1, 0)  # Default direction
@export var move_distance: float = 240  # Distance before reset

@onready var sprite_2D = $Animated_cannonball

var start_position: Vector2  # Store initial spawn position
var traveled_distance: float = 0
var respawn_timer: Timer  # Timer for respawning

func _ready():
	start_position = position  # Save the spawn position
	
	# Create and configure a timer dynamically
	respawn_timer = Timer.new()
	respawn_timer.wait_time = move_distance / speed  # Time to travel full distance
	respawn_timer.one_shot = true  # Only trigger once per activation
	respawn_timer.timeout.connect(respawn_projectile)  # Connect timeout to respawn
	add_child(respawn_timer)  # Add timer to the node

func _physics_process(delta):
	if not visible:
		return  # Don't move if the projectile is hidden

	var movement = move_direction.normalized() * speed * delta
	var collision = move_and_collide(movement)

	if (collision and collision.get_collider().name == 'main character') or traveled_distance == move_distance:
		#sprite_2D.animation = "exploding"
		#await sprite_2D.animation_finished
		despawn_projectile()  # Despawn on collision or max distance

	traveled_distance += movement.length()

func despawn_projectile():
	hide()  # Make the projectile invisible
	await get_tree().create_timer((move_distance - traveled_distance) / speed).timeout
	traveled_distance = 0  # Reset distance counter
	set_deferred("collision_layer", 0)  # Disable collisions initially
	set_deferred("collision_mask", 0)
	respawn_timer.start()  # Start the respawn timer
	

func respawn_projectile():
	#sprite_2D.animation = "default"
	position = start_position  # Move back to spawn location
	set_deferred("collision_layer", 2)  # Re-enable collisions
	set_deferred("collision_mask", 1)
	show()  # Make the projectile visible again
  
