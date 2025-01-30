class_name LineToAngle
extends Node2D

@export var line_color: Color = Color('6ab151cc')
@export var key_center = Vector2.ZERO
@export var to_cursor = true

var interacted
var angle_in_radians: float:
	set(value):
		angle_in_radians = value
		interacted = true
		queue_redraw()
var width: float = 1.0:
	set(value):
		width = value
		interacted = true
		queue_redraw()

var frozen = false:
	set(value):
		frozen = value
		queue_redraw()
var shake_intensity = 0:
	set(value):
		shake_intensity = value
		material.set_shader_parameter("shake_intensity", shake_intensity)
		queue_redraw()
		

var last_valid_direction: Vector2


func _unhandled_input(event: InputEvent) -> void:
	if to_cursor and event is InputEventMouseMotion:
		queue_redraw()


func _draw() -> void:
	if to_cursor:
		_to_cursor()
	elif interacted:
		_to_angle()


func _to_angle() -> void:
	var deg = rad_to_deg(angle_in_radians)
	var slightly_wider_degrees = [deg_to_rad(deg + width / 2), deg_to_rad(deg - width / 2)]
	var slightly_wider_directions = [Vector2.from_angle(slightly_wider_degrees[0]), Vector2.from_angle(slightly_wider_degrees[1])]
	
	draw_polygon([key_center, slightly_wider_directions[0] * 1000, slightly_wider_directions[1] * 1000], [line_color])


func _to_cursor() -> void:
	if !frozen:
		var cursor_direction = get_local_mouse_position().normalized() * -1
		if cursor_direction.x != 0 and cursor_direction.y != 0:
			last_valid_direction = cursor_direction

	# Normalizing * -1, +PI, sets (0, TAU) to the rightmost edge and eases future comparison
	var cursor_angle = Vector2.ZERO.angle_to_point(last_valid_direction) + PI
	var deg = rad_to_deg(cursor_angle)
	var slightly_wider_degrees = [deg_to_rad(deg + width), deg_to_rad(deg - width)]
	var slightly_wider_directions = [Vector2.from_angle(slightly_wider_degrees[0]), Vector2.from_angle(slightly_wider_degrees[1])]
	
	angle_in_radians = cursor_angle
	
	draw_polygon([key_center, slightly_wider_directions[0] * 1000, slightly_wider_directions[1] * 1000], [line_color])
