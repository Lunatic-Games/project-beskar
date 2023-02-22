extends CharacterAI


@export var should_look_at_closest_target: bool = true
@export var should_primary_attack_closest_target: bool = true
@export var should_secondary_attack_closest_target: bool = true

@onready var hostile_detection: HostileDetection = $HostileDetection


func _ready() -> void:
	assert(controlled_character != null, "AI Controlled Character not set.")
	_on_controlled_character_enemy_mask_changed()
	controlled_character.enemy_mask_changed.connect(_on_controlled_character_enemy_mask_changed)


func _process(_delta: float) -> void:
	assert(controlled_character, "AI Controlled Character not set.")
	
	var closest_target: Character = hostile_detection.get_closest_target()
	if not closest_target:
		return
	
	if should_look_at_closest_target:
		controlled_character.look_at_point(closest_target.global_position)
	
	var equipped_weapon: Weapon = controlled_character.equipped_weapon
	if equipped_weapon:
		if should_primary_attack_closest_target:
			equipped_weapon.trigger_primary_attack(closest_target.global_position)
		if should_secondary_attack_closest_target:
			equipped_weapon.trigger_secondary_attack(closest_target.global_position)


func _on_controlled_character_enemy_mask_changed():
	hostile_detection.collision_mask = controlled_character.enemy_mask
	hostile_detection.manual_refresh()
