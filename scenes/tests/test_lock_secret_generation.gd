extends Node

@onready var lock_secret: LockSecret = $LockSecret


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_released('generate'):
		_generate()


func _generate() -> void:
	lock_secret.randomize_secret()
