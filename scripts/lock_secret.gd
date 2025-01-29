class_name LockSecret

var angle
var width


func _init(target_radians: float, ray_width: int) -> void:
	angle = fmod(target_radians, TAU)
	width = ray_width


static func from_difficulty(difficulty = Difficulty.NORMAL) -> LockSecret:
	var random_angle = TAU * randf() # -PI helps account for the y axis when comparing to cursor
	var width_exponent = 2
	var secret = LockSecret.new(random_angle, pow(difficulty, width_exponent) * 2)
	
	return secret


func check_solution(attempted_angle: float) -> bool:
	var victory_bandwith = width / 2
	var secret_degrees = angle
	var upper_limit = angle + deg_to_rad(victory_bandwith)
	var lower_limit = angle - deg_to_rad(victory_bandwith)
	
	# Normal situation, when angle and limits are within (0, TAU)
	var test_1 = lower_limit < attempted_angle and attempted_angle < upper_limit
	
	# Edge situations, when limits are lower or higher than TAU due to width.
	var test_2 = upper_limit > TAU and attempted_angle < upper_limit - TAU and 0 < attempted_angle
	var test_3 = lower_limit < 0 and TAU + lower_limit < attempted_angle

	return test_1 or test_2 or test_3
