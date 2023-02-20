class_name Player
extends CharacterBody2D

signal taken_damage(amount: int)

var max_speed: float = 250.0
var move_acceleration: float = 2.0

var max_health: int = 100
var health: int = max_health

@onready var rotation_joint: Node2D = $RotationJoint
@onready var pea_shooter: Weapon = $RotationJoint/PeaShooter


func _physics_process(delta: float) -> void:
	var h_axis: float = Input.get_axis("move_left", "move_right")
	var v_axis: float = Input.get_axis("move_up", "move_down")
	
	var movement_input := Vector2(h_axis, v_axis).normalized()
	
	velocity = velocity.move_toward(movement_input * max_speed, 
		move_acceleration * delta * 1000.0)
	
	move_and_slide()


func _process(_delta: float) -> void:
	var mouse_pos: Vector2 = get_global_mouse_position()
	rotation_joint.rotation = rotation_joint.global_position.angle_to_point(mouse_pos)


func is_alive() -> bool:
	return health > 0


func take_damage(amount: int) -> int:
	assert(amount >= 0, "Taking negative damage.")
	
	var health_before: int = health
	health = clampi(health - amount, 0, max_health)
	
	var actual_damage_taken: int = health_before - health
	taken_damage.emit(actual_damage_taken)
	
	return actual_damage_taken
