class_name Location
extends Node2D


@onready var default_spawn_marker: Marker2D = $Markers/DefaultSpawnMarker
@onready var player_holder: Node2D = $PlayerHolder
@onready var projectile_holder: Node2D = $ProjectileHolder


func _ready() -> void:
	GlobalNodeFinder.projectile_holder = projectile_holder


func add_player_to_location(player: Player) -> void:
	player_holder.add_child(player)
	player.global_position = default_spawn_marker.global_position
