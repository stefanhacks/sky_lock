extends NodeState

@export var lock: Lock
@export var lock_secret: LockSecret
@export var line_to_cursor: LineToAngle
@export var broken_line_color: Color = Color('e9736bcc')

signal broke_lock


func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	pass


func _on_next_transitions() -> void:
	pass


func _on_enter() -> void:
	broke_lock.emit()
	var exit_delay = Constants.FANFARRE_DURATION
	
	var tween = get_tree().create_tween()
	tween.tween_property(line_to_cursor, "modulate", broken_line_color, exit_delay * 0.15)
	tween.tween_property(line_to_cursor, "modulate:a", 0, exit_delay * 0.5)
	
	await get_tree().create_timer(exit_delay).timeout
	transition.emit("Idle")


func _on_exit() -> void:
	line_to_cursor.modulate = Color.WHITE
	lock_secret.fix_lock()
	lock.cylinder_rotation = 0.0
