class_name Projectile
extends Area2D


var speed: float = 0.0
var direction: Vector2 = Vector2.RIGHT


func init(new_speed: float, new_direction: Vector2) -> void:
	speed = new_speed
	direction = new_direction
	assert(direction.is_normalized(), "Projectile direciton should be normalized.")


func _physics_process(delta: float) -> void:
	position += direction * speed * delta
