class_name AbilityComponent
extends Node2D


signal activated(context: AbilityActivateContext)


func activate(context: AbilityActivateContext) -> void:
	activated.emit(context)
