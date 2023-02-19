extends Node2D


const PLAYER = preload("res://game/player/player.tscn")

var player: Player

@onready var location: Location = $StartLocation


func _ready() -> void:
	player = PLAYER.instantiate()
	location.add_player_to_location(player)
