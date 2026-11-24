class_name Thrusters extends Node

@export var Isp: float = 50
@export var burn_rate_lps: float = 5
@export var fuel_l: float = 100

func accelerate(space_body: SpaceBody, delta: float) -> bool:
	if fuel_l == 0:
		return false
	var wet_mass = fuel_l + space_body.mass
	var fuel_burn = min(fuel_l, burn_rate_lps * delta)
	var dry_mass = wet_mass - fuel_burn
	var dv = Isp * log(wet_mass / dry_mass)
	dv = Vector2(dv, 0).rotated(space_body.rotation)
	space_body.velocity += dv
	fuel_l -= fuel_burn
	return true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
