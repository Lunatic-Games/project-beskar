class_name AbilityActivateContext
extends Object


var caster: Character
var caster_pos_at_cast: Vector2
var cast_origin_pos: Vector2
var target_pos_at_cast: Vector2
var angle_from_caster_to_target_pos: float
var ally_mask: int  # Physics layer mask
var enemy_mask: int  # Phyiscs layer mask
var tint: Color


func _init(ability_caster: Character, origin_pos: Vector2, target_pos: Vector2,
		ability_tint: Color = Color.WHITE):
	caster = ability_caster
	caster_pos_at_cast = caster.global_position
	cast_origin_pos = origin_pos
	target_pos_at_cast = target_pos
	angle_from_caster_to_target_pos = caster_pos_at_cast.angle_to_point(target_pos)
	ally_mask = caster.ally_mask
	enemy_mask = caster.enemy_mask
	tint = ability_tint
