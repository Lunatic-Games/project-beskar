class_name Projectile
extends Area2D


signal hit_something(Node2D)
signal hit_character(Character)

var speed: float = 0.0
var direction: Vector2 = Vector2.RIGHT


func init(new_speed: float, new_direction: Vector2) -> void:
	assert(new_direction.is_normalized(), "Projectile direciton should be normalized.")
	
	speed = new_speed
	direction = new_direction


func _physics_process(delta: float) -> void:
	position += direction * speed * delta


func _on_body_entered(body: Node2D) -> void:
	hit_something.emit(body)
	
	var character_hit: Character = body as Character
	if character_hit:
		hit_character.emit(character_hit)
	
	queue_free()
