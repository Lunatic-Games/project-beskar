class_name AbilityBar
extends HBoxContainer


func set_ability_icon(icon_idx: int, ability: Ability):
	assert(icon_idx >= 0 and icon_idx < get_child_count(), "Trying to set invalid ability icon")
	
	var ability_icon = get_child(icon_idx) as AbilityIcon
	assert(ability_icon, "Failed to get ability icon")
	
	ability_icon.ability = ability
