class_name Interactable
extends Area2D


signal interacted_with(player: Player)

var players_in_area: Array[Player] = []

@onready var prompt: Label = $Prompt


func _ready() -> void:
	prompt.hide()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		for player in players_in_area:
			interacted_with.emit(player)


func _on_body_entered(body: Node2D) -> void:
	var player: Player = body as Player
	if player == null or players_in_area.has(player):
		return
	
	players_in_area.append(player)
	
	if not prompt.visible:
		prompt.show()


func _on_body_exited(body: Node2D) -> void:
	var player: Player = body as Player
	if player == null:
		return
	
	if players_in_area.has(player):
		players_in_area.erase(player)
	
	if players_in_area.is_empty():
		prompt.hide()
