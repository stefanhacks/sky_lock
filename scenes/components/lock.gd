class_name Lock
extends Node2D

@export var color_picker: Color
@export var cylinder: Node2D

const rim_color: Color = Color('233a44')
const cylinder_color: Color = Color('465759')

var cylinder_rotation: float:
	set(value):
		cylinder.rotation_degrees = value
	get():
		return cylinder.rotation_degrees


func _draw() -> void:
	draw_circle(Vector2.ZERO, 235, rim_color, true)
	draw_circle(Vector2.ZERO, 228, cylinder_color, true)
