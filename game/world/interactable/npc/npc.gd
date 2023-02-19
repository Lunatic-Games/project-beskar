class_name NPC
extends StaticBody2D


signal interacted_with

@export var dialog: Array[String]


func _on_interact_area_interacted_with() -> void:
	GlobalSignals.npc_interacted_with.emit(self)
