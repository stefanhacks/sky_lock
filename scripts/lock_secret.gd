class_name LockSecret

var angle
var width


func _init(target_angle: float, ray_width: int) -> void:
	angle = target_angle
	width = ray_width


static func from_difficulty(difficulty = Difficulty.NORMAL) -> LockSecret:
	var random_angle = TAU * randf() - PI # -PI helps accounting for the y axis when comparing to cursor
	var width_exponent = 2
	var secret = LockSecret.new(random_angle, pow(difficulty, width_exponent) * 2)
	
	return secret
