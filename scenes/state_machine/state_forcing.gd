extends NodeState

@export var lock_secret: LockSecret
@export var line_to_cursor: LineToAngle

signal forcing


func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(delta : float) -> void:
	lock_secret.damage_lock(Constants.LOCK_DAMAGE_PER_SECOND * delta)
	var shake_intensity = 1 - pow(lock_secret.integrity / 100.0, 2)
	line_to_cursor.shake_intensity = shake_intensity


func _on_next_transitions() -> void:
	if Input.is_action_just_released("space_bar"):
		transition.emit("Idle")
	elif lock_secret.broken == true:
		transition.emit("Broken")


func _on_enter() -> void:
	forcing.emit()


func _on_exit() -> void:
	line_to_cursor.shake_intensity = 0
