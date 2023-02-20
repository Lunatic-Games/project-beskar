class_name ResourceBar
extends ProgressBar


@export var show_while_full: bool = true
@export var staggered_drop: bool = true
@export_range(0.01, 3.0, 0.01) var drop_speed: float = 0.5

@onready var delayed_bar: ProgressBar = $DelayedBar


func _ready() -> void:
	value = 1.0
	delayed_bar.value = 1.0


func _process(delta: float) -> void:
	if staggered_drop and delayed_bar.value != value:
		delayed_bar.value = move_toward(delayed_bar.value, value, drop_speed * delta)


func set_normalized_value(new_value: float):
	assert(value >= 0.0 and value <= 1.0, "Value passed to health bar should be normalized.")
	
	value = new_value
	
	if not staggered_drop:
		delayed_bar.value = value
	
	if not show_while_full:
		visible = (value == 1.0)
