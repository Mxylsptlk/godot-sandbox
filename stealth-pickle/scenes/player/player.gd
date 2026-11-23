class_name Player extends CharacterBody2D
signal hit

@onready var player_sprite: AnimatedSprite2D = $PlayerSprite
@onready var player_input: PlayerInput2D = $PlayerInput2D
@onready var player_rotate: CharacterRotation2D = $PlayerRotate
@onready var player_hit: PlayerHit = $PlayerHit
@onready var player_collision: CollisionShape2D = $PlayerCollision

@export var speed : int = 1200
@export var recovery_speed : int = 100
@export var knockback_amt : Vector2 = Vector2(10000,10000)
@export var knockback_speed : int = speed

var screen_size : Vector2
var recovery_time : float = 0.0
var knockback : Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	position = screen_size / 2
	print("ready")

func recover(delta: float) -> void:
	recovery_time -= delta * recovery_speed
	recovery_time = max(0, recovery_time)
	print("recovery_time:", recovery_time)

func knock_back() -> void:
	velocity = knockback.sign() * knockback_speed
	velocity = velocity.clamp(-knockback.abs(), knockback.abs())
	knockback -= velocity
	#knockback = knockback.clamp(-knockback_amt, knockback_amt)
	print("remaining knockback:", knockback)

func move(delta) -> void:
	if recovery_time:
		recover(delta)
		if knockback.length():
			knock_back()
		else:
			velocity = Vector2.ZERO
	else:
		velocity = player_input.move_dir()
		if velocity.length_squared() > 0:
			player_rotate.rotate_char(self, velocity)
		if velocity.length() > 0:
			velocity = velocity.normalized() * speed
			player_sprite.play("walk")
		else:
			player_sprite.stop() # This must change
	if velocity.length():
		print("moving:", velocity)
	if move_and_collide(velocity * delta):
		hit.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move(delta)
	#position = position.clamp(Vector2.ZERO, screen_size)


func _on_hit() -> void:
	recovery_time = 25
	player_hit.hit_player(self)
	knockback = knockback_amt * -velocity.sign()
	print("Hit!")
	print(knockback)
