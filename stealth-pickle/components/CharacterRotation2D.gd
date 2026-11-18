class_name CharacterRotation2D extends Node

@export var rotation_speed: float = 0.125

func rotate_char(sprite: Node2D, velocity: Vector2) -> void:
	var target_angle = atan2(velocity.x, -velocity.y)
	var angle = lerp_angle(sprite.rotation, target_angle, rotation_speed)
	#print(sprite.rotation)
	print(target_angle)
	print(rotation_speed)
	print(angle)
	sprite.rotation = angle
	#print(sprite.rotation)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
