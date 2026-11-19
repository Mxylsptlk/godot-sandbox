class_name Player extends Area2D

@onready var player_input: PlayerInput2D = $PlayerInput2D
@onready var player_rotate: CharacterRotation2D = $PlayerRotate

@export var speed : int = 600
var screen_size : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	position = screen_size / 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity: Vector2 = player_input.move_dir()
	#var angle: Vector2 = Vector2.from_angle($PlayerSprite.rotation)
	
	if velocity.length_squared() > 0:
		player_rotate.rotate_char($PlayerSprite, velocity)
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$PlayerSprite.play("walk")
	else:
		$PlayerSprite.stop() # This must change
	
	position += velocity * delta
	#position = position.clamp(Vector2.ZERO, screen_size)
