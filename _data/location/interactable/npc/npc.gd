class_name NPC
extends Character


signal interacted_with

@export var dialog: Array[String]


func _on_interact_area_interacted_with() -> void:
	GlobalSignals.dialog_request.emit(dialog)
