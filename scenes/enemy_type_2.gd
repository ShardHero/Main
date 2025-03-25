extends CharacterBody2D

var gravity = ProjectSettings.get("physics/2d/default_gravity")
var speed = 700.0
var jump_speed = 700.0
@export var facing_right: bool = true
var posx
var distance
	
func _ready() -> void:
	if(!facing_right):
		scale.x = abs(scale.x)* -1
		
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
		
	if(facing_right && $Vision.is_colliding() && is_on_floor()):
		if($Vision.get_collider() is CharacterBody2D):
			if(!$WallCheck.is_colliding()):
				posx = $Vision.get_collision_point().x
				distance = posx - position.x 
				velocity.y = -sqrt(0.55 * distance*gravity)
				velocity.x = sqrt(0.5 * distance*gravity)
		if($Vision.get_collider() is not CharacterBody2D && $WallCheck.is_colliding()):
			velocity.x = 0
			flip()
		if($Vision.get_collider() is not CharacterBody2D && !$FloorCheck.is_colliding()):
			velocity.x = 0
			flip()
			
	elif(!facing_right && $Vision.is_colliding() && is_on_floor()):
		if($Vision.get_collider() is CharacterBody2D):
			if(!$WallCheck.is_colliding()):
				posx = $Vision.get_collision_point().x
				distance = position.x - posx
				velocity.y = -sqrt(0.55 * distance*gravity)
				velocity.x = sqrt(0.5 * distance*gravity) * -1
		if($Vision.get_collider() is not CharacterBody2D && $WallCheck.is_colliding()):
			velocity.x = 0
			flip()
		if($Vision.get_collider() is not CharacterBody2D && !$FloorCheck.is_colliding()):
			velocity.x = 0
			flip()
	
	

	move_and_slide()
	
func flip():
	facing_right = !facing_right
	
	scale.x = abs(scale.x) * -1
