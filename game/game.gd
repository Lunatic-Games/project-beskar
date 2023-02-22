extends Node2D


const PLAYER = preload("res://game/player/player.tscn")

var player: Player

@onready var location: Location = $StartLocation
@onready var health_bar: ResourceBar = $HUD/HealthBar
@onready var ability_bar: AbilityBar = $HUD/AbilityBar


func _ready() -> void:
	player = PLAYER.instantiate()
	location.add_player_to_location(player)
	player.health_changed.connect(_on_player_health_changed)
	player.new_ability_set.connect(_on_player_new_ability_set)
	
	# new_ability_set will first be emitted before it is connected here
	# so we have to call it manually the first time
	_on_player_new_ability_set(0, player.primary_ability)
	_on_player_new_ability_set(1, player.secondary_ability)


func _on_player_health_changed(_amount: int):
	var normalized_health: float = float(player.health) / float(player.max_health)
	health_bar.set_normalized_value(normalized_health)
	
	if not player.is_alive():
		get_tree().reload_current_scene()


func _on_player_new_ability_set(idx: int, ability: Ability):
	ability_bar.set_ability_icon(idx, ability)
