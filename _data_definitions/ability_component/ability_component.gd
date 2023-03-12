class_name AbilityComponent
extends Node


signal activated(context: AbilityActivateContext)


func activate(context: AbilityActivateContext) -> void:
	activated.emit(context)
