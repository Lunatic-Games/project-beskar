extends Node


func get_time_seconds() -> float:
	return Time.get_ticks_msec() / 1000.0
