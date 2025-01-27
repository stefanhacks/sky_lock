extends Node2D

@onready var line_to_cursor: LineToAngle = $"LineToCursor"
@onready var line_to_secret: LineToAngle = $"LineToSecret"

var lock_secret: LockSecret


func _ready() -> void:
	call_deferred('game_start')


func game_start() -> void:
	lock_secret = LockSecret.from_difficulty(Difficulty.NORMAL)
	line_to_secret.width = lock_secret.width
	line_to_secret.angle = lock_secret.angle


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_released("click"):
		var cursor_direction = get_local_mouse_position().normalized()
		var angle = Vector2.ZERO.angle_to_point(cursor_direction)
		
		var victory_bandwith = lock_secret.width / 2
		var cursor_degrees = rad_to_deg(angle)
		var secret_degrees = rad_to_deg(lock_secret.angle)
		var upper_limit = rad_to_deg(lock_secret.angle) + victory_bandwith
		var lower_limit = rad_to_deg(lock_secret.angle) - victory_bandwith
		
		if (upper_limit > cursor_degrees) and (cursor_degrees > lower_limit):
			print (cursor_degrees, ' ~ ', secret_degrees, '!')
			game_start()
		else:
			line_to_cursor.freeze()
	
	if Input.is_action_just_released("space_bar"):
		lock_secret = LockSecret.from_difficulty(Difficulty.NORMAL)
		line_to_secret.width = lock_secret.width
		line_to_secret.angle = lock_secret.angle
