extends AbilityComponent

@export var projectile: PackedScene
@export_range(0.0, 2000.0, 1.0, "or_greater") var speed: float = 750.0
@export var should_hit_caster_enemies = true
@export var should_hit_caster_allies = false
@export_flags_2d_physics var base_projectile_collision_mask: int


func _ready() -> void:
	assert(projectile, "SpawnProjectile AbilityComponent doesn't have a projectile specified.")


func _on_activated(context: AbilityActivateContext) -> void:
	var new_projectile: Projectile = projectile.instantiate() as Projectile
	assert(new_projectile != null, "Failed to instantiate given projectile")
	
	var projectile_holder: Node2D = GlobalNodeFinder.projectile_holder
	assert(projectile_holder and is_instance_valid(projectile_holder),
		"Failed to find valid projectile holder")
	
	projectile_holder.add_child(new_projectile)
	new_projectile.global_position = global_position
	new_projectile.collision_mask = base_projectile_collision_mask
	if should_hit_caster_allies:
		new_projectile.collision_mask |= context.ally_mask
	if should_hit_caster_enemies:
		new_projectile.collision_mask |= context.enemy_mask
	
	new_projectile.init(speed, Vector2.from_angle(context.angle_from_caster_to_mouse_pos))
