class_name FlashRect
extends ColorRect


@onready var animation_player = $AnimationPlayer


func flash() -> void:
	animation_player.play("flash")
