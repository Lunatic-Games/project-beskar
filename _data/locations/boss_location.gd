extends Location


@onready var return_gateway: Gateway = $Gateways/ReturnGateway


func _ready() -> void:
	super._ready()
	
	return_gateway.visible = false
	return_gateway.monitoring = false


func _on_boss_enemy_died() -> void:
	return_gateway.visible = true
	return_gateway.monitoring = true
