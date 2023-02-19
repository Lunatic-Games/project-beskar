class_name Player
extends CharacterBody2D


const MAX_SPEED: float = 250.0
const MOVE_ACCELERATION: float = 2.0

@onready var rotation_joint: Node2D = $RotationJoint

func _physics_process(delta: float) -> void:
	var h_axis: float = Input.get_axis("move_left", "move_right")
	var v_axis: float = Input.get_axis("move_up", "move_down")
	
	var movement_input := Vector2(h_axis, v_axis).normalized()
	
	velocity = velocity.move_toward(movement_input * MAX_SPEED, 
		MOVE_ACCELERATION * delta * 1000.0)
	
	move_and_slide()


func _process(_delta: float) -> void:
	var mouse_pos: Vector2 = get_global_mouse_position()
	rotation_joint.rotation = rotation_joint.global_position.angle_to_point(mouse_pos)
