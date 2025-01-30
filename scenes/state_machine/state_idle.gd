extends NodeState

@export var lock: Lock
@export var lock_secret: LockSecret
@export var line_to_cursor: LineToAngle


func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(delta : float) -> void:
	if Input.is_action_just_pressed('generate'):
		_generate()
	else: 
		_release_lock(delta)


func _on_next_transitions() -> void:
	if Input.is_action_just_pressed("space_bar"):
		transition.emit("Solving")


func _on_enter() -> void:
	line_to_cursor.frozen = false


func _on_exit() -> void:
	line_to_cursor.frozen = true


func _generate() -> void:
	lock_secret.randomize_secret(Difficulty.VERY_HARD)


func _release_lock(delta: float) -> void:
	var new_rotation = lock.cylinder_rotation - delta * Constants.LOCK_RELEASE_SPEED
	lock.cylinder_rotation = max(new_rotation, 0)
	lock_secret.repair_lock(Constants.LOCK_REPAIR_PER_SECOND)
