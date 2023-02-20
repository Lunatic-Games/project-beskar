class_name HitBox
extends Area2D


@export var hitbox_owner: Node


func _ready() -> void:
	assert(hitbox_owner, "Hitbox needs an owner specified")
