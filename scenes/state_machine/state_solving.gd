extends NodeState

@export var lock: Lock
@export var lock_secret: LockSecret
@export var line_to_cursor: LineToAngle

var max_cylinder_rotation: int


func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(delta : float) -> void:
	if Input.is_action_pressed("space_bar"):
		_rotate_cylinder(delta)


func _on_next_transitions() -> void:
	if lock.cylinder_rotation == 90:
		transition.emit("Solved")
	elif lock.cylinder_rotation >= max_cylinder_rotation:
		transition.emit("Forcing")
	elif Input.is_action_just_released("space_bar"):
		transition.emit("Idle")


func _on_enter() -> void:
	var available_distance = lock_secret.max_distance_to_solve
	var distance = lock_secret.get_distance_to_solving(line_to_cursor.angle_in_radians)
	var difficulty_mod = lock_secret.difficulty * 3
	max_cylinder_rotation = floor(90 * pow((available_distance - distance) / available_distance, difficulty_mod))


func _on_exit() -> void:
	pass


func _rotate_cylinder(delta: float) -> void:
	var attempted_rotation = lock.cylinder_rotation + delta * Constants.LOCK_PICKING_SPEED
	var clamped_rotation = min(attempted_rotation, max_cylinder_rotation)
	var new_rotation = max(clamped_rotation, lock.cylinder_rotation)
	lock.cylinder_rotation = new_rotation
