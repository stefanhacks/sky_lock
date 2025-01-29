class_name LockSecret

var angle_in_radians
var width

var max_distance_to_solve: float:
	get():
		return PI - deg_to_rad(width / 2)


func _init(target_radians: float, ray_width: int) -> void:
	angle_in_radians = fmod(target_radians, TAU)
	width = ray_width


static func from_difficulty(difficulty = Difficulty.NORMAL) -> LockSecret:
	var random_angle = TAU * randf() # -PI helps account for the y axis when comparing to cursor
	var width_exponent = 2
	var secret = LockSecret.new(random_angle, pow(difficulty, width_exponent) * 2)
	
	return secret


func check_solution(attempted_radians: float) -> bool:
	var victory_bandwith = deg_to_rad(width / 2)
	var lower_limit = angle_in_radians - victory_bandwith
	var upper_limit = angle_in_radians + victory_bandwith
	
	# Normal situation, when angle and limits are within (0, TAU)
	var test_1 = lower_limit < attempted_radians and attempted_radians < upper_limit
	
	# Edge situations, when limits are lower or higher than TAU because we're close to 0.
	var test_3 = lower_limit < 0 and TAU + lower_limit <= attempted_radians and attempted_radians <= 0
	var test_2 = upper_limit > TAU and upper_limit - TAU >= attempted_radians and attempted_radians >= 0
	
	return test_1 or test_2 or test_3


func get_distance_to_solving(attempted_radians: float) -> float:
	var is_solved = check_solution(attempted_radians)
	if is_solved:
		return 0.0
	
	var victory_bandwith = deg_to_rad(width / 2)
	var lower_limit = angle_in_radians - victory_bandwith
	var upper_limit = angle_in_radians + victory_bandwith
	
	# Boiled Wolframalpha and stackxchange solution to this.
	# https://gamedev.stackexchange.com/questions/4467/comparing-angles-and-working-out-the-difference
	var lower_distance = (PI - abs(abs(lower_limit - attempted_radians) - PI));
	var upper_distance = (PI - abs(abs(upper_limit - attempted_radians) - PI));
		
	return min(lower_distance, upper_distance)
