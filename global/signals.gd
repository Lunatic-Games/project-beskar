extends Node

signal dialog_request(dialog: Array[String])
signal player_to_marker_request(player: Player, marker_name)
signal location_transition_request(location: Location, marker_name: String)
