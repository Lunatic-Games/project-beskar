extends Node2D


const PLAYER = preload("res://game/player/player.tscn")

var player: Player

@onready var location: Location = $StartLocation
@onready var health_bar: ResourceBar = $HUD/HealthBar


func _ready() -> void:
	player = PLAYER.instantiate()
	location.add_player_to_location(player)
	player.taken_damage.connect(_on_player_taken_damage)


func _on_player_taken_damage(_amount: int):
	var normalized_health: float = float(player.health) / float(player.max_health)
	health_bar.set_normalized_value(normalized_health)
	
	if not player.is_alive():
		get_tree().reload_current_scene()
