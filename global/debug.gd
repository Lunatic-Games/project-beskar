extends Node


# F1: Deal quarter of player's health as damage to said player
# F2: Heal player to full health


func _ready() -> void:
	if not OS.is_debug_build():
		queue_free()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_1"):
		deal_damage_to_player()
	elif event.is_action_pressed("debug_2"):
		heal_player_to_full_health()


func deal_damage_to_player() -> void:
	for player in get_tree().get_nodes_in_group("PLAYER"):
		player = player as Player
		if not player:
			continue
		
		player.take_damage(player.max_health / 4)


func heal_player_to_full_health() -> void:
	for player in get_tree().get_nodes_in_group("PLAYER"):
		player = player as Player
		if not player:
			continue
		
		player.heal(player.max_health)
