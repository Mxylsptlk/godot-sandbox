class_name Ship extends CharacterBody2D

const PX_PER_M: int = 16

@export var loadout: ShipLoadout

@export var fuel_l: float = 100
@onready var sprite: Sprite2D = $sprite
@onready var collision: CollisionShape2D = $collision

var mass: float = 0
var wet_mass: float = 0
var rotational_velocity: float = 0

func get_total_mass() -> void:
	mass = (
		loadout.hull.mass +
		loadout.thrusters.mass +
		loadout.stearing_thrusters.mass
	)

func _ready():
	sprite.texture = loadout.hull.texture
	collision.shape = loadout.hull.shape
	get_total_mass()
	print("Confirming thrusters: ", is_instance_valid(loadout.thrusters))

func _physics_process(delta: float) -> void:
	wet_mass = fuel_l + mass
	#print(velocity)
	self.rotate(rotational_velocity)
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())

func dry_mass(burn_rate: float, delta: float) -> float:
	var fuel_burn = min(fuel_l, burn_rate * delta)
	fuel_l -= fuel_burn
	return wet_mass - fuel_burn

func get_dv(dry_mass: float) -> float:
	return loadout.thrusters.Isp * log(wet_mass / dry_mass) * PX_PER_M

func accelerate(delta: float) -> bool:
	if fuel_l == 0:
		return false
	var dv = get_dv(dry_mass(loadout.thrusters.burn_rate_lps, delta))
	dv = Vector2(0, -dv).rotated(rotation)
	velocity += dv
	print(fuel_l, velocity)
	return true

func accelerate_rotation(dir: int, delta: float) -> void:
	var dv = get_dv(dry_mass(loadout.stearing_thrusters.burn_rate_lps, delta))
	rotational_velocity += dir * dv / mass
	print(rotational_velocity)
