class_name LockSecret
extends Node

@export var line_to_secret: LineToAngle

# Docs indicate Enums are okay as ints, but typing this variable throws type error.
var difficulty: int:
	set(value):
		difficulty = value
		max_integrity = Constants.BASE_LOCK_HEALTH * value

var broken: bool
var integrity: int
var max_integrity: int

var angle_in_radians: float
var width_in_radians:float
var lower_limit: float
var upper_limit: float

var max_distance_to_solve: float:
	get():
		return PI - width_in_radians / 2


func _ready() -> void:
	if line_to_secret != null:
		line_to_secret.visible = false

	randomize_secret()


func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("see_secret") and line_to_secret != null:
		line_to_secret.visible = !line_to_secret.visible


func damage_lock(amount: int) -> void:
	integrity = max(integrity - amount, 0)
	if integrity == 0:
		broken = true


func repair_lock(amount: int) -> void:
	if broken == false:
		integrity = min(integrity + amount, max_integrity)


func fix_lock() -> void:
	broken = false
	integrity = max_integrity


func set_secret(target_radians: float, ray_width: int) -> void:
	fix_lock()
	
	width_in_radians = deg_to_rad(ray_width)
	angle_in_radians = fmod(target_radians, TAU)
	lower_limit = angle_in_radians - width_in_radians / 2
	upper_limit = angle_in_radians + width_in_radians / 2
	
	if line_to_secret != null:
		line_to_secret.width = ray_width
		line_to_secret.angle_in_radians = angle_in_radians


func randomize_secret(new_difficulty = Difficulty.NORMAL) -> void:
	difficulty = new_difficulty
	var random_angle = TAU * randf() # -PI helps account for the y axis when comparing to cursor
	var new_width = pow(difficulty, 2) * 2
	set_secret(random_angle, new_width)


func _is_attempt_solution(attempted_radians: float) -> bool:
	# Normal situation, when angle and limits are within (0, TAU)
	var test_1 = lower_limit < attempted_radians and attempted_radians < upper_limit
	
	# Edge situations, when limits are lower or higher than TAU because we're close to 0.
	var test_3 = lower_limit < 0 and TAU + lower_limit <= attempted_radians and attempted_radians <= 0
	var test_2 = upper_limit > TAU and upper_limit - TAU >= attempted_radians and attempted_radians >= 0
	
	return test_1 or test_2 or test_3


func get_distance_to_solving(attempted_radians: float) -> float:
	var is_solved = _is_attempt_solution(attempted_radians)
	if is_solved:
		return 0.0
	
	# Boiled Wolframalpha and stackxchange solution to this.
	# https://gamedev.stackexchange.com/questions/4467/comparing-angles-and-working-out-the-difference
	var lower_distance = (PI - abs(abs(lower_limit - attempted_radians) - PI));
	var upper_distance = (PI - abs(abs(upper_limit - attempted_radians) - PI));
		
	return min(lower_distance, upper_distance)
