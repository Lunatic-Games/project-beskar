extends ColorRect


@export var character: Character = null

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	assert(character != null, "CharacterFlashRect needs a character assigned.")
	character.took_damage.connect(_on_character_took_damage)


func _on_character_took_damage(_damage: int):
	animation_player.play("flash")
