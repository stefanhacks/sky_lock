extends Control

@onready var line_to_secret: LineToAngle = $LineToSecret

var secret: LockSecret


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_released('click'):
		_generate()


func _generate() -> void:
	secret = LockSecret.from_difficulty(randi_range(1, 5))
	line_to_secret.width = secret.width
	line_to_secret.angle = secret.angle
