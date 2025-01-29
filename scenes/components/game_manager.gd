extends Node2D

@onready var lock: Lock = $Lock
@onready var line_to_cursor: LineToAngle = $"LineToCursor"
@onready var line_to_secret: LineToAngle = $"LineToSecret"

var lock_secret: LockSecret
var holding_spacebar: bool = false
var holding_timer: float = 0.0

var lock_picking_duration: float = 0.9
var lock_picking_release_resistance: float = 1.7
var frozen = false


func _ready() -> void:
	_game_start()


func _process(delta: float) -> void:
	if frozen:
		return
	
	if holding_spacebar:
		holding_timer = min(holding_timer + delta, lock_picking_duration)
	else:
		holding_timer = max(holding_timer - delta / lock_picking_release_resistance, 0)
	
	var rotation = 90 / lock_picking_duration * holding_timer
	lock.set_cylinder_rotation(rotation)


func _game_start() -> void:
	lock_secret = LockSecret.from_difficulty(Difficulty.NORMAL)
	line_to_secret.width = lock_secret.width
	line_to_secret.angle = lock_secret.angle


func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("click"):
		_on_click()
	elif Input.is_action_just_pressed("space_bar"):
		_on_space_bar_pressed()
	elif Input.is_action_just_released("space_bar"):
		_on_space_bar_released()
	elif Input.is_action_just_released("generate"):
		_generate()


func _on_click() -> void:
	if frozen:
		return
	
	if _check_secret():
		print ('Click!')
		_game_start()
	else:
		_freeze()


func _check_secret() -> bool:
	var cursor_direction = get_local_mouse_position().normalized() * -1
	var cursor_angle = Vector2.ZERO.angle_to_point(cursor_direction) + PI
	return lock_secret.check_solution(cursor_angle)


func _get_solving_distance() -> float:
	var cursor_direction = get_local_mouse_position().normalized()
	var angle = Vector2.ZERO.angle_to_point(cursor_direction)
	
	var victory_bandwith = lock_secret.width / 2
	var cursor_degrees = rad_to_deg(angle)
	var secret_degrees = rad_to_deg(lock_secret.angle)
	var upper_limit = rad_to_deg(lock_secret.angle) + victory_bandwith
	var lower_limit = rad_to_deg(lock_secret.angle) - victory_bandwith
	
	var upper_distance = upper_limit - cursor_degrees
	var lower_distance = lower_limit - cursor_degrees
	
	# Work on a solution for 360 = 0
	
	return 0.0


func _freeze() -> void:
	frozen = true
	line_to_cursor.frozen = true
	await get_tree().create_timer(0.35).timeout
	line_to_cursor.frozen = false
	frozen = false


func _on_space_bar_pressed() -> void:
	holding_spacebar = true


func _on_space_bar_released() -> void:
	holding_spacebar = false


func _generate() -> void:
	lock_secret = LockSecret.from_difficulty(Difficulty.VERY_EASY)
	line_to_secret.width = lock_secret.width
	line_to_secret.angle = lock_secret.angle
