class_name Character
extends CharacterBody2D


signal new_equipped_weapon(weapon: Weapon)
signal new_ability_set(idx: int, ability: Ability)

signal health_changed(amount: int)
signal took_damage(amount: int)
signal healed(amount: int)


@export var equipped_weapon: Weapon = null :
	set (new_weapon) :
		equipped_weapon = new_weapon
		if equipped_weapon:
			equipped_weapon.held_by = self

@export var primary_ability: Ability = null :
	set (new_ability) :
		primary_ability = new_ability
		new_ability_set.emit(0, primary_ability)

@export var secondary_ability: Ability = null :
	set (new_ability) :
		secondary_ability = new_ability
		new_ability_set.emit(1, secondary_ability)

@export var max_health: int = 100
@export_flags_2d_physics var ally_mask: int = 0
@export_flags_2d_physics var enemy_mask: int = 0

@onready var health: int = max_health


func is_alive() -> bool:
	return health > 0


func take_damage(amount: int) -> int:
	assert(amount >= 0, "Taking negative damage.")
	
	var health_before: int = health
	health = clampi(health - amount, 0, max_health)
	
	var actual_damage_taken: int = health_before - health
	took_damage.emit(actual_damage_taken)
	health_changed.emit(-actual_damage_taken)
	
	return actual_damage_taken


func heal(amount: int) -> int:
	assert(amount >= 0, "Healing a negative amount.")
	
	var health_before: int = health
	health = clampi(health + amount, 0, max_health)
	
	var actual_amount_healed = health - health_before
	healed.emit(actual_amount_healed)
	health_changed.emit(actual_amount_healed)
	
	return actual_amount_healed


func activate_ability(ability: Ability) -> void:
	if ability.is_on_cooldown():
		return
	
	var ability_activate_context = AbilityActivateContext.new(self, 
		get_viewport().get_mouse_position())
	ability.activate(ability_activate_context)
