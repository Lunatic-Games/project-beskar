class_name Weapon
extends Node2D


@export var ability_tint: Color = Color.WHITE

var held_by: Character = null

@onready var _ability_origin_marker: Marker2D = $AbilityOriginMarker
@onready var _primary_ability_container: Node = $PrimaryAbilityContainer
@onready var _secondary_ability_container: Node = $SecondaryAbilityContainer


func init(character_held_by: Character) -> void:
	assert(character_held_by != null, "Trying to equip weapon to null Character.")
	held_by = character_held_by


func trigger_primary_attack(target_position: Vector2) -> void:
	_activate_ability_container(_primary_ability_container, target_position)


func trigger_secondary_attack(target_position: Vector2) -> void:
	_activate_ability_container(_secondary_ability_container, target_position)


func _activate_ability_container(ability_container: Node, target_position: Vector2):
	assert(held_by, "Trying to activate a Weapon that doesn't know who it is held by.")
	
	for child in ability_container.get_children():
		var ability: Ability = child as Ability
		assert(ability != null, "Weapon ability containers should only contain Ability children.")
		
		if ability.is_on_cooldown() == false:
			var ability_activate_context := AbilityActivateContext.new(held_by,
				_ability_origin_marker.global_position, target_position, ability_tint)
			
			ability.activate(ability_activate_context)
