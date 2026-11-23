class_name PlayerInput2D extends Node

#var move_dir: Vector2 = Vector2.ZERO

func move_dir() -> Vector2:
	var input_vec = Input.get_vector(
		"move_left","move_right",
		"move_forward","move_back"
	)
	return input_vec

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
