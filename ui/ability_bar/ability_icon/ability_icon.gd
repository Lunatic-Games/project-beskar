class_name AbilityIcon
extends TextureRect


var ability: Ability = null :
	set (new_ability):
		if ability and is_instance_valid(ability):
			if ability.cooldown_ended.is_connected(_on_ability_cooldown_ended):
				ability.cooldown_ended.disconnect(_on_ability_cooldown_ended)
		
		ability = new_ability
		
		if ability == null:
			hide()
			return
		
		ability.cooldown_ended.connect(_on_ability_cooldown_ended)
		texture = ability.icon
		_update_cooldown_progress_bar()
		show()

@onready var cooldown_progress_bar: ProgressBar = $CooldownProgressBar
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _process(_delta: float) -> void:
	_update_cooldown_progress_bar()


func _update_cooldown_progress_bar():
	if ability == null:
		return
	
	cooldown_progress_bar.value = ability.calc_remaining_cooldown_normalized()


func _on_ability_cooldown_ended():
	animation_player.play("flash_ready")
