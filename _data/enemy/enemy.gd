class_name Enemy
extends CharacterBody2D


signal taken_damage(amount: int)

@export var max_health: int = 30

var health: int = max_health

func is_alive() -> bool:
	return health > 0


func take_damage(amount: int) -> int:
	assert(amount >= 0, "Taking negative damage.")
	
	var health_before: int = health
	health = clampi(health - amount, 0, max_health)
	
	var actual_damage_taken: int = health_before - health
	taken_damage.emit(actual_damage_taken)
	
	if !is_alive():
		queue_free()
	
	return actual_damage_taken
