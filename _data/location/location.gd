class_name Location
extends Node2D


@onready var marker_holder: Node2D = $Markers
@onready var default_spawn_marker: Marker2D = $Markers/DefaultSpawnMarker
@onready var player_holder: Node2D = $PlayerHolder
@onready var projectile_holder: Node2D = $ProjectileHolder


func _ready() -> void:
	GlobalNodeFinder.projectile_holder = projectile_holder
	GlobalSignals.player_to_marker_request.connect(add_player_to_location, CONNECT_DEFERRED)


func add_player_to_location(player: Player, spawn_marker_name = "") -> void:
	if not player_holder.has_node(NodePath(player.name)):
		if player.get_parent() != null:
			player.get_parent().remove_child(player)
		player_holder.add_child(player)
	
	if spawn_marker_name != "":
		var marker_path: NodePath = NodePath(spawn_marker_name)
		assert(marker_holder.has_node(marker_path), "Location does not have specified marker.")
		
		player.global_position = marker_holder.get_node(marker_path).global_position
	else:
		player.global_position = default_spawn_marker.global_position


func remove_player_as_child(player_to_remove: Player):
	if player_holder.has_node(NodePath(player_to_remove.name)):
		player_holder.remove_child(player_to_remove)
	
