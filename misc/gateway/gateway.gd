class_name Gateway
extends Area2D


@export_file var location_file: String = ""
@export var marker_name: String = ""


func _ready() -> void:
	assert(location_file != "" or marker_name != "", 
		"A Gateway does nothing without a location or a marker name.")
	
	if location_file:
		assert(FileAccess.file_exists(location_file),
			"Gateway location can not be found: %s" % location_file)


func _on_body_entered(body: Node2D) -> void:
	var player: Player = body as Player
	if player == null:
		return
	
	if location_file != null:
		var location_scene: PackedScene = load(location_file)
		assert(location_scene, "Failed to load location file \"%s\"" % location_file)
		
		var location: Location = load(location_file).instantiate()
		assert(location, "Failed to instantiate gateway location.")
		
		GlobalSignals.location_transition_request.emit(location, marker_name)
		
	elif marker_name:
		GlobalSignals.player_to_marker_request.emit(player, marker_name)
