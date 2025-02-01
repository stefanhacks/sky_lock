extends NodeState

@export var lock: Lock
@export var lock_secret: LockSecret
@export var line_to_cursor: LineToAngle

var had_interaction = false
signal first_interaction
signal changed_dificulty


func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(delta : float) -> void:
	if Input.is_action_just_pressed('difficulty_very_easy'):
		_change_difficulty(Difficulty.VERY_EASY)
	elif Input.is_action_just_pressed('difficulty_easy'):
		_change_difficulty(Difficulty.EASY)
	elif Input.is_action_just_pressed('difficulty_normal'):
		_change_difficulty(Difficulty.NORMAL)
	elif Input.is_action_just_pressed('difficulty_hard'):
		_change_difficulty(Difficulty.HARD)
	elif Input.is_action_just_pressed('difficulty_very_hard'):
		_change_difficulty(Difficulty.VERY_HARD)
	else: 
		_release_lock(delta)


func _on_next_transitions() -> void:
	if Input.is_action_just_pressed("space_bar"):
		transition.emit("Solving")
		if had_interaction == false:
			had_interaction = true
			first_interaction.emit()


func _on_enter() -> void:
	line_to_cursor.frozen = false


func _on_exit() -> void:
	line_to_cursor.frozen = true


func _change_difficulty(level: int) -> void:
	lock_secret.randomize_secret(level)
	changed_dificulty.emit()


func _release_lock(delta: float) -> void:
	var new_rotation = lock.cylinder_rotation - delta * Constants.LOCK_RELEASE_SPEED
	lock.cylinder_rotation = max(new_rotation, 0)
	lock_secret.repair_lock(Constants.LOCK_REPAIR_PER_SECOND)
