class_name PlayerHit extends Node

func hit_player(player: Player) -> void:
	player.player_sprite.play("hit")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
