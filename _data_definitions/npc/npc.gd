class_name NPC
extends Character


signal interacted_with(player: Player)

@export var dialog: Array[String]


func _on_interact_area_interacted_with(player: Player) -> void:
	interacted_with.emit(player)
	
	if dialog:
		GlobalSignals.dialog_request.emit(dialog)
