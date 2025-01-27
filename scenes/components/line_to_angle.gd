class_name LineToAngle
extends Node2D

@export var line_color: Color = Color('6ab151cc')
@export var key_center = Vector2.ZERO
@export var to_cursor = true
@export var to_angle: float
@export var width: float = 1.0

var last_valid_direction: Vector2


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		queue_redraw()


func _draw() -> void:
	if to_cursor:
		_to_cursor()
	else:
		_to_angle()


func _to_angle() -> void:
	var deg = rad_to_deg(to_angle)
	var slightly_wider_degrees = [deg_to_rad(deg + width / 2), deg_to_rad(deg - width / 2)]
	var slightly_wider_directions = [Vector2.from_angle(slightly_wider_degrees[0]), Vector2.from_angle(slightly_wider_degrees[1])]
	
	draw_polygon([key_center, slightly_wider_directions[0] * 1000, slightly_wider_directions[1] * 1000], [line_color])


func _to_cursor() -> void:
	var cursor_direction = get_local_mouse_position().normalized()
	if cursor_direction.x != 0 and cursor_direction.y != 0:
		last_valid_direction = cursor_direction

	var angle = Vector2.ZERO.angle_to_point(last_valid_direction)
	var deg = rad_to_deg(angle)
	var slightly_wider_degrees = [deg_to_rad(deg + width), deg_to_rad(deg - width)]
	var slightly_wider_directions = [Vector2.from_angle(slightly_wider_degrees[0]), Vector2.from_angle(slightly_wider_degrees[1])]
	
	draw_polygon([key_center, slightly_wider_directions[0] * 1000, slightly_wider_directions[1] * 1000], [line_color])
