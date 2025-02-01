extends NodeState

@export var lock: Lock
@export var lock_secret: LockSecret

signal solved_lock


func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	pass


func _on_next_transitions() -> void:
	pass


func _on_enter() -> void:
	solved_lock.emit()
	await get_tree().create_timer(Constants.FANFARRE_DURATION).timeout
	transition.emit("Idle")


func _on_exit() -> void:
	lock_secret.randomize_secret(lock_secret.difficulty)
	lock.cylinder_rotation = 0.0
