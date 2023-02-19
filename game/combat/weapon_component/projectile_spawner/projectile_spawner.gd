class_name ProjectileSpawner
extends WeaponComponent

@export var projectile: PackedScene
@export var random_spawn_offset: Vector2 = Vector2.ZERO
@export_range(0.0, 180.0) var random_angle_offset_degrees: float = 0.0
@export_range(0.0, 2000.0, 1.0, "or_greater") var min_speed: float = 750.0
@export_range(0.0, 2000.0, 1.0, "or_greater") var max_speed: float = 750.0


func _ready() -> void:
	super._ready()
	assert(projectile, "A projectile spawner needs a projectile specified")
	assert(max_speed >= min_speed, "Maximum speed of projectile should be greater than minimum.")


func _on_weapon_attacked_triggered(_normalized_charge: float) -> void:
	var new_projectile: Projectile = projectile.instantiate() as Projectile
	assert(new_projectile != null, "Failed to instantiate given projectile")
	
	var projectile_holder: Node2D = GlobalNodeFinder.projectile_holder
	assert(projectile_holder and is_instance_valid(projectile_holder),
		"Failed to find valid projectile holder")
	
	projectile_holder.add_child(new_projectile)
	new_projectile.global_position = global_position
	new_projectile.init(min_speed, Vector2.from_angle(global_rotation))
