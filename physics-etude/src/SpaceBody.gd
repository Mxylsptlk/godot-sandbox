class_name SpaceBody extends CharacterBody2D

@export var mass: float = 100

func _physics_process(delta: float) -> void:
	var collided = move_and_slide()
	if collided:
		print("Collided")
