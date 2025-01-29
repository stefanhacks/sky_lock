extends Node2D

@onready var lock: Lock = $Lock
@onready var line_to_cursor: LineToAngle = $"LineToCursor"
@onready var line_to_secret: LineToAngle = $"LineToSecret"

var frozen = false

var lock_secret: LockSecret
var lock_picking_duration: float = 0.9
var lock_picking_release_resistance: float = 1.7

var holding_spacebar: bool = false
var holding_timer: float = 0.0

var attempted_radians
var max_cylinder_rotation


func _ready() -> void:
	_game_start()


func _process(delta: float) -> void:
	if frozen:
		return
	
	if holding_timer > 0:
		_rotate_cylinder()
		if holding_timer == lock_picking_duration:
			_check_solution()
	
	if holding_spacebar:
		holding_timer = min(holding_timer + delta, lock_picking_duration)
	else:
		holding_timer = max(holding_timer - delta / lock_picking_release_resistance, 0)


func _game_start() -> void:
	lock.set_cylinder_rotation(0.0)
	lock_secret = LockSecret.from_difficulty(Difficulty.NORMAL)
	line_to_cursor.frozen = false
	line_to_secret.width = lock_secret.width
	line_to_secret.angle_in_radians = lock_secret.angle_in_radians
	holding_spacebar = false
	holding_timer = 0.0
	frozen = false


func _unhandled_input(_event: InputEvent) -> void:
	if frozen:
		return
	if Input.is_action_just_pressed("space_bar"):
		holding_spacebar = true
		_start_solving()
	elif Input.is_action_just_released("space_bar"):
		holding_spacebar = false
		line_to_cursor.frozen = false
	elif Input.is_action_just_released("generate"):
		_on_generate()


func _check_solution() -> void:
	if (lock_secret.check_solution(attempted_radians)):
		print("Click!")
		frozen = true
		holding_spacebar = false
		await get_tree().create_timer(2).timeout
		_game_start()


func _start_solving() -> void:
	line_to_cursor.frozen = true
	
	var cursor_direction = get_local_mouse_position().normalized() * -1
	attempted_radians = Vector2.ZERO.angle_to_point(cursor_direction) + PI
	
	var distance = lock_secret.get_distance_to_solving(attempted_radians)
	var available_distance = lock_secret.max_distance_to_solve
	
	max_cylinder_rotation = 90 * (available_distance - distance) / available_distance


func _rotate_cylinder() -> void:
	var rotation = max_cylinder_rotation / lock_picking_duration * holding_timer
	lock.set_cylinder_rotation(rotation)


func _on_generate() -> void:
	lock_secret = LockSecret.from_difficulty(Difficulty.VERY_EASY)
	line_to_secret.width = lock_secret.width
	line_to_secret.angle_in_radians = lock_secret.angle_in_radians
