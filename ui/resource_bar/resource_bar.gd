class_name ResourceBar
extends ProgressBar


@export var show_while_full: bool = true
@export var staggered_drop: bool = true
@export_range(0.01, 3.0, 0.01) var drop_speed: float = 0.5
@export var flash_on_increase: bool = true
@export var flash_on_decrease: bool = true
@export var shake_on_increase: bool = true
@export var shake_on_decrease: bool = true

@onready var delayed_bar: ProgressBar = $DelayedBar
@onready var flash_rect: FlashRect = $FlashRect
@onready var shake_player: AnimationPlayer = $ShakeAnimationPlayer


func _ready() -> void:
	value = 1.0
	delayed_bar.value = 1.0


func _process(delta: float) -> void:
	if staggered_drop and delayed_bar.value != value:
		delayed_bar.value = move_toward(delayed_bar.value, value, drop_speed * delta)


func set_normalized_value(new_value: float):
	assert(value >= 0.0 and value <= 1.0, "Value passed to health bar should be normalized.")
	
	flash_rect.size.x = size.x * new_value
	
	if new_value > value:
		if flash_on_increase:
			flash_rect.flash()
		if shake_on_increase:
			shake_player.play("shake")
	elif new_value < value:
		if flash_on_decrease:
			flash_rect.flash()
		if shake_on_decrease:
			shake_player.play("shake")
			
	value = new_value
	
	if not staggered_drop:
		delayed_bar.value = value
	
	if not show_while_full:
		visible = (value == 1.0)
