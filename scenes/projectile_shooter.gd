extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var facing_right: bool = true

func _ready():
	if !facing_right:
		scale.x = abs(scale.x) * -1
