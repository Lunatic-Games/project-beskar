extends Node

signal dialog_request(dialog_pages: Array[String])

signal player_to_marker_request(player: Player, marker_name: String)

signal location_transition_request(location: Location, marker_name: String)
