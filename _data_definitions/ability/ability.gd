class_name Ability
extends Node


signal activated
signal cooldown_started
signal cooldown_ended

@export var display_name: String = ""
@export var icon: Texture = null
@export_range(0.0, 120.0, 0.1, "or_greater") var cooldown: float = 1.0
@export var shared_ability_cooldown: Ability = null

@onready var cooldown_timer: SceneTreeTimer = null
@onready var on_activate_component_container: Node = $OnActivateComponentContainer


func activate(context: AbilityActivateContext) -> void:
	assert(!is_on_cooldown(), "Trying to activate an Ability while it's on cooldown.")
	
	for child in on_activate_component_container.get_children():
		var component = child as AbilityComponent
		assert(component != null, "ComponentContainer should only have AbilityComponent children.")
		component.activate(context)
	
	activated.emit()
	
	if cooldown == 0.0:
		return
	
	cooldown_timer = get_tree().create_timer(cooldown, false)
	cooldown_timer.timeout.connect(_on_cooldown_timer_timeout)
	cooldown_started.emit()


func calc_remaining_cooldown(check_shared_cooldown = true) -> float:
	if cooldown_timer == null:
		return 0.0
	
	var remaining: float = cooldown_timer.time_left
	
	if check_shared_cooldown and shared_ability_cooldown:
		remaining = maxf(remaining, shared_ability_cooldown.calc_remaining_cooldown(false))
	
	return remaining


func calc_remaining_cooldown_normalized(check_shared_cooldown = true) -> float:
	if cooldown == 0.0:
		return 0.0
	
	return calc_remaining_cooldown(check_shared_cooldown) / cooldown


func is_on_cooldown(check_shared_cooldown = true) -> bool:
	return calc_remaining_cooldown(check_shared_cooldown) > 0.0


func _on_cooldown_timer_timeout() -> void:
	cooldown_ended.emit()
