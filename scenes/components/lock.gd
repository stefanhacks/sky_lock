class_name Lock
extends Node2D

@export var color_picker: Color
@onready var cylinder: Node2D = $Cylinder

const rim_color: Color = Color('233a44')
const cylinder_color: Color = Color('465759')


func _draw() -> void:
	draw_circle(Vector2.ZERO, 235, rim_color, true)
	draw_circle(Vector2.ZERO, 228, cylinder_color, true)


func set_cylinder_rotation(angle: float) -> void:
	cylinder.rotation_degrees = angle
