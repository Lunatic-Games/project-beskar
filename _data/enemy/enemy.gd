class_name Enemy
extends Character


func _on_took_damage(_amount: int) -> void:
	if !is_alive():
		queue_free()
