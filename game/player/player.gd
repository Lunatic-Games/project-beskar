class_name Player
extends Character

var max_speed: float = 300.0
var move_acceleration: float = 2.0

@onready var pistol: Weapon = $RotationJoint/Pistol


func _physics_process(delta: float) -> void:
	var h_axis: float = Input.get_axis("move_left", "move_right")
	var v_axis: float = Input.get_axis("move_up", "move_down")
	
	var movement_input := Vector2(h_axis, v_axis).normalized()
	
	velocity = velocity.move_toward(movement_input * max_speed, 
		move_acceleration * delta * 1000.0)
	
	move_and_slide()


func _process(_delta: float) -> void:
	var mouse_pos: Vector2 = get_global_mouse_position()
	look_at_point(mouse_pos)
	
	if equipped_weapon:
		if Input.is_action_pressed("primary_attack"):
			equipped_weapon.trigger_primary_attack(get_viewport().get_mouse_position())
		if Input.is_action_pressed("secondary_attack"):
			equipped_weapon.trigger_secondary_attack(get_viewport().get_mouse_position())
	
	if primary_ability and Input.is_action_pressed("primary_ability"):
		activate_ability(primary_ability)
	if secondary_ability and Input.is_action_pressed("secondary_ability"):
		activate_ability(secondary_ability)
	
