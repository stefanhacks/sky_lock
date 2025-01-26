extends Node2D

@export var line_color: Color = Color.SKY_BLUE * 0.8

var last_valid_direction: Vector2


func _draw() -> void:
	var cursor_direction = get_local_mouse_position().normalized()
	if cursor_direction.x != 0 and cursor_direction.y != 0:
		last_valid_direction = cursor_direction

	var angle = Vector2.ZERO.angle_to_point(last_valid_direction)
	var deg = rad_to_deg(angle)
	var slightly_wider_degrees = [deg_to_rad(deg + 1), deg_to_rad(deg - 1)]
	var slightly_wider_directions = [Vector2.from_angle(slightly_wider_degrees[0]), Vector2.from_angle(slightly_wider_degrees[1])]
	
	draw_polygon([Vector2.ZERO, slightly_wider_directions[0] * 1000, slightly_wider_directions[1] * 1000], [line_color])


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		queue_redraw()
