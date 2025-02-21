extends Node2D

@export var speed: float = 200  # Speed of projectile
@export var move_direction: Vector2 = Vector2(-1, 0)  # Default direction
@export var move_distance: float = 240  # Distance before reset

@onready var main_char = %"main character"
@onready var invuln_timer = $InvulnerabilityTimer  # Reference to the timer

var start_position: Vector2
var traveled_distance: float = 0

func _ready():
	start_position = position  # Store initial position

func _process(delta):
	var movement = move_direction.normalized() * speed * delta
	position += movement
	traveled_distance += movement.length()
	
	if traveled_distance >= move_distance:
		reset_projectile()  # Remove the projectile after moving a certain distance

func reset_projectile():
	position = start_position  # Move back to the start position
	traveled_distance = 0  # Reset distance counter
	
