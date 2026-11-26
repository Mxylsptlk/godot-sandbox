class_name Player extends Node

@onready var ship: Ship = $Ship

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var inputs = Input.get_vector("move_left","move_right","move_up","move_down")
	#print(inputs)
	if inputs.y < 0:
		#print(inputs)
		ship.accelerate(delta)
	if abs(inputs.x) > 0:
		print(inputs.x)
		ship.accelerate_rotation(inputs.x, delta)
	#ship.rotate(inputs.x * delta)
