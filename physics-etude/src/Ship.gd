class_name Ship extends CharacterBody2D

const PX_PER_M: int = 16

@export var loadout: ShipLoadout

@export var fuel_l: float = 100
@onready var sprite: Sprite2D = $sprite
@onready var collision: CollisionShape2D = $collision

var mass: float = 0

func get_total_mass() -> void:
	mass = (
		loadout.hull.mass +
		loadout.thrusters.mass
	)

func _ready():
	sprite.texture = loadout.hull.texture
	collision.shape = loadout.hull.shape
	get_total_mass()
	print("Confirming thrusters: ", is_instance_valid(loadout.thrusters))

func _physics_process(delta: float) -> void:
	#print(velocity)
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
	
func accelerate(delta: float) -> bool:
	if fuel_l == 0:
		return false
	var wet_mass = fuel_l + mass
	var fuel_burn = min(fuel_l, loadout.thrusters.burn_rate_lps * delta)
	var dry_mass = wet_mass - fuel_burn
	var dv = loadout.thrusters.Isp * log(wet_mass / dry_mass) * PX_PER_M
	dv = Vector2(0, -dv).rotated(rotation)
	velocity += dv
	fuel_l -= fuel_burn
	print(fuel_l, velocity)
	return true
