class_name HostileDetection
extends Area2D


var hostile_targets: Array[Character] = []


func get_closest_target():
	if hostile_targets.is_empty():
		return null
	
	hostile_targets.sort_custom(_sort_closest)
	return hostile_targets.front()


func manual_refresh() -> void:
	hostile_targets.clear()
	
	# Forces an update
	monitoring = false
	monitoring = true


func _on_body_entered(body: Node2D) -> void:
	var character: Character = body as Character
	if character == null:
		return
	
	if not hostile_targets.has(character):
		hostile_targets.append(character)
		if not character.died.is_connected(_on_target_died):
			character.died.connect(_on_target_died.bind(character))


func _on_body_exited(body: Node2D) -> void:
	var character: Character = body as Character
	if character == null:
		return

	if hostile_targets.has(character):
		hostile_targets.erase(character)
		if character.died.is_connected(_on_target_died):
			character.died.disconnect(_on_target_died)


func _on_target_died(target: Character):
	if hostile_targets.has(target):
		hostile_targets.erase(target)
		target.died.disconnect(_on_target_died)


func _sort_closest(a: Character, b: Character):
	var distance_to_a = global_position.direction_to(a.global_position)
	var distance_to_b = global_position.direction_to(b.global_position)
	return distance_to_a < distance_to_b
