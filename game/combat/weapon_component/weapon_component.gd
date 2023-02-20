class_name WeaponComponent
extends Node2D

signal attacked_triggered (normalized_charge: float)
signal charge_started
signal charge_stopped
signal min_charge_reached_and_still_charging
signal max_charge_reached_and_held

@export_flags("Primary", "Secondary") var trigger: int = 1
@export var allow_holding: bool = true
@export_range(0.0, 30.0, 0.1) var cooldown: float = 0.5
@export_group("Charging")
@export var is_chargeable: bool = false
@export_range(0.0, 10.0, 0.1, "or_greater") var min_charge_time: float
@export_range(0.0, 10.0, 0.1, "or_greater") var max_charge_time: float
@export var auto_release_on_max_charge: bool = true

const _PRIMARY_TRIGGER_FLAG: int = 1
const _SECONDARY_TRIGGER_FLAG: int = 2

var _has_reached_min_charge: bool = false
var _has_reached_max_charge: bool = false
var _last_attack_time: float = -INF  # Start with not being on cooldown
var _charge_start_time: float = NAN  # Start with not being charged


func _ready() -> void:
	assert(trigger, "Weapon was set to not be triggerable, does this make sense? " +
		"Can remove this assert if so.")


func _process(_delta: float) -> void:
	var current_time: float = GlobalUtility.get_time_seconds()
	if current_time < _last_attack_time + cooldown:
		return
	
	var is_triggered: bool = false
	
	if allow_holding or _is_charging():
		is_triggered = _is_trigger_being_held()
	else:
		is_triggered = _is_trigger_just_pressed()
	
	var is_charged: bool = _is_charging() and current_time >= _charge_start_time + min_charge_time
	
	# Check for nothing happening, a charge being manually released, or a charge being stopped
	if not is_triggered:
		if is_chargeable and is_charged and _is_trigger_just_released():
			_trigger_attack()
		elif _is_charging():
			_stop_charge()
		return
	
	# Check for still charging up or a new charge starting
	if (is_chargeable and not is_charged) or !_is_charging():
		if !_is_charging():
			_start_charge()
		return
	
	# Check for automatically releasing max charge
	var is_max_charge: bool = current_time > _charge_start_time + max_charge_time
	if auto_release_on_max_charge and is_max_charge:
		_trigger_attack()
		return
	
	# If auto release is off we just hold the charge
	if is_chargeable:
		if is_max_charge and !_has_reached_max_charge:
			if current_time >= _charge_start_time + max_charge_time:
				_has_reached_max_charge = true
				max_charge_reached_and_held.emit()
		elif !is_max_charge and !_has_reached_min_charge:
			min_charge_reached_and_still_charging.emit()
		return
	
	_trigger_attack()


func _start_charge() -> void:
	_charge_start_time = GlobalUtility.get_time_seconds()
	_has_reached_max_charge = false
	charge_started.emit()


func _stop_charge() -> void:
	charge_stopped.emit()
	_charge_start_time = NAN
	_has_reached_max_charge = false


func _trigger_attack() -> void:
	var current_time: float = GlobalUtility.get_time_seconds()
	
	var normalized_charge: float = 1.0
	if is_chargeable:
		assert(_is_charging(), "Firing chargeable weapon without any charge.")
		normalized_charge = clampf(current_time - _charge_start_time / max_charge_time, 0.0, 1.0)
	
	attacked_triggered.emit(normalized_charge)
	_last_attack_time = current_time
	_charge_start_time = NAN
	_has_reached_max_charge = false


func _is_trigger_being_held() -> bool:
	var held: bool = Input.is_action_pressed("primary_attack") and (trigger & _PRIMARY_TRIGGER_FLAG)
	held = held or Input.is_action_pressed("secondary_attack") and (trigger & _SECONDARY_TRIGGER_FLAG)
	return held
	

func _is_trigger_just_pressed() -> bool:
	var primary_pressed: bool = Input.is_action_just_pressed("primary_attack")
	var secondary_pressed: bool = Input.is_action_just_pressed("secondary_attack")
	
	var pressed: bool =  primary_pressed and trigger & _PRIMARY_TRIGGER_FLAG
	pressed = pressed or secondary_pressed and trigger & _SECONDARY_TRIGGER_FLAG
	return pressed


func _is_trigger_just_released() -> bool:
	var primary_released: bool = Input.is_action_just_released("primary_attack")
	var secondary_released: bool = Input.is_action_just_released("secondary_attack")
	
	var released: bool =  primary_released and trigger & _PRIMARY_TRIGGER_FLAG
	released = released or secondary_released and trigger & _SECONDARY_TRIGGER_FLAG
	return released


func _is_charging() -> bool:
	return is_nan(_charge_start_time) == false
