class_name DialogManager
extends Control


signal finished_current_text
signal finished_all_text

var queued_text: Array[String]

@onready var dialog_box: DialogBox = $DialogBox


func _ready() -> void:
	dialog_box.hide()
	GlobalSignals.dialog_request.connect(_on_GlobalSignals_dialog_request)


func _input(event) -> void:
	var mouse_press = event is InputEventMouseButton and event.pressed
	if dialog_box.visible and (event.is_action_pressed("interact") or mouse_press):
		get_viewport().set_input_as_handled()
		_next()


func _on_GlobalSignals_dialog_request(dialog_pages: Array[String]):
	for dialog in dialog_pages:
		queue_text(dialog)


func display_text(text: String) -> void:
	get_tree().paused = true
	dialog_box.show()
	dialog_box.set_text(text)


func display_and_wait(text: String) -> void:
	display_text(text)
	await(finished_all_text)


func queue_text(text: String) -> void:
	if dialog_box.visible:
		queued_text.append(text)
	else:
		display_text(text)


func queue_and_wait(text: String) -> void:
	queue_text(text)
	await(finished_all_text)


func _next():
	if dialog_box.is_still_typing_out():
		dialog_box.skip_typing()
		return
	
	finished_current_text.emit()
	if queued_text:
		display_text(queued_text.pop_front())
	else:
		dialog_box.hide()
		finished_all_text.emit()
		get_tree().paused = false
