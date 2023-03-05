class_name DialogBox
extends ColorRect


const TEXT_CHARACTER_DELAY: float = 0.05

var character_delay_timer: float = 0.0

@onready var label: Label = $MarginContainer/Label


func _process(delta: float) -> void:
	if not visible:
		return
	
	if label.visible_characters < label.text.length():
		character_delay_timer += delta
		
		while character_delay_timer > TEXT_CHARACTER_DELAY:
			label.visible_characters += 1
			character_delay_timer -= TEXT_CHARACTER_DELAY


func set_text(text: String):
	label.text = text
	label.visible_characters = 0


func clear_text():
	label.text = ""


func is_still_typing_out():
	return label.visible_characters < label.text.length()


func skip_typing():
	label.visible_characters = label.text.length()
