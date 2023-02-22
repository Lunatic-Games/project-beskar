class_name Weapon
extends Node2D


var held_by: Character = null  # Shoot be set on equipping weapon

@onready var primary_ability_container: Node2D = $PrimaryAbilityContainer
@onready var secondary_ability_container: Node2D = $SecondaryAbilityContainer


func trigger_primary_attack() -> void:
	_activate_ability_container(primary_ability_container)


func trigger_secondary_attack() -> void:
	_activate_ability_container(secondary_ability_container)


func _activate_ability_container(ability_container: Node2D):
	for child in ability_container.get_children():
		var ability = child as WeaponAbility
		assert(ability != null, "Weapon ability container should only contain weapon abilities.")
		
		if not ability.is_on_cooldown():
			var ability_activate_context = AbilityActivateContext.new(held_by, 
				get_viewport().get_mouse_position())
			
			ability.activate(ability_activate_context)
