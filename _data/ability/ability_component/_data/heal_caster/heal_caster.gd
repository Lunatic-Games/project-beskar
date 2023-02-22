extends AbilityComponent


@export var flat_heal_amount: int = 10
@export_range(0.0, 100.0, 0.1) var max_health_percentage_heal: float = 0.0
@export_range(0.0, 100.0, 0.1) var missing_health_percentage_heal: float = 0.0


func _on_activated(context: AbilityActivateContext) -> void:
	var caster_max_health = context.caster.max_health
	var caster_missing_health = caster_max_health - context.caster.health
	
	var health_to_heal = flat_heal_amount
	health_to_heal += caster_max_health * max_health_percentage_heal / 100.0
	health_to_heal += caster_missing_health * missing_health_percentage_heal / 100.0
	
	context.caster.heal(health_to_heal)
