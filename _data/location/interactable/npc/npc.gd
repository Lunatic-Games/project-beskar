class_name NPC
extends Character


signal interacted_with

@export var dialog: Array[String]


func _on_interact_area_interacted_with() -> void:
	GlobalSignals.interacted_with_npc.emit(self)
