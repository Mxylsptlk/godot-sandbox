class_name Player extends Node

@onready var ship: Ship = $Ship

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var inputs = Input.get_vector("move_left","move_right","move_up","move_down")
	pass
