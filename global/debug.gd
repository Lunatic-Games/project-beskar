extends Node


# F1: Deal quarter of player's health as damage to said player


func _ready() -> void:
	if not (OS.is_debug_build() or OS.has_feature("standalone")):
		queue_free()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_1"):
		deal_damage_to_player()


func deal_damage_to_player():
	for player in get_tree().get_nodes_in_group("PLAYER"):
		player = player as Player
		if not player:
			continue
		
		player.take_damage(player.max_health / 4)
