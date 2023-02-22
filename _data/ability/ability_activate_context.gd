class_name AbilityActivateContext
extends Object


var caster: Character
var caster_pos_at_cast: Vector2
var mouse_pos_at_cast: Vector2
var angle_from_caster_to_mouse_pos: float
var ally_mask: int  # Physics layer mask
var enemy_mask: int  # Phyiscs layer mask


func _init(ability_caster: Character, mouse_pos: Vector2):
	caster = ability_caster
	caster_pos_at_cast = caster.global_position
	mouse_pos_at_cast = mouse_pos
	angle_from_caster_to_mouse_pos = caster_pos_at_cast.angle_to_point(mouse_pos)
	ally_mask = caster.ally_mask
	enemy_mask = caster.enemy_mask
