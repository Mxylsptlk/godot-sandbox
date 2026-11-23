class_name SpaceBody extends CharacterBody2D


const SPEED = 300.0

@export var mass: float = 100
@export var booster_exhaust_velocity: float = 100
@export var thruster_exhaust_velocity: float = 10
@export var fuel_capacity_kl: float = 1000
@export var fuel_burn_rate_kl_per_s: float = 10

func _physics_process(delta: float) -> void:
	var collided = move_and_slide()
	if collided:
		print("Collided")
