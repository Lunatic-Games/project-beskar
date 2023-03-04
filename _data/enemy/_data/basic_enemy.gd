extends Enemy


@onready var flash_rect: FlashRect = $FlashRect


func _on_took_damage(amount: int):
	super._on_took_damage(amount)
	flash_rect.flash()
