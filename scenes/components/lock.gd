extends Node2D

@export var color_picker: Color
@onready var cylinder: Node2D = $Cylinder

const rim_color: Color = Color('233a44')
const plate_color: Color = Color('465759')


func _draw() -> void:
	draw_circle(Vector2.ZERO, 265, rim_color, true)
	draw_circle(Vector2.ZERO, 258, plate_color, true)
