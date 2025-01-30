extends Node2D

const rim_color: Color = Color('1f272e')
const lock_color: Color = Color('574830')
const cover_rim_color: Color = Color('465759')
const cover_color: Color = Color('6c8284')

var keyhole_tooth_shape: PackedVector2Array = [
		Vector2(-13, -20), Vector2(13, -20), 
		Vector2(20, 80), Vector2(0, 95), Vector2(-20, 80), 
	]

var keyhole_tooth_cover_shape: Array[Vector2] = [
		Vector2(-20, -25), Vector2(20, -25), 
		Vector2(40, 105), Vector2(20, 115),
		Vector2(0, 135), Vector2(-20, 115),
		Vector2(-40, 105), 
	]

var keyhole_tooth_cover_rim_shape


func _ready() -> void:
	keyhole_tooth_cover_rim_shape = keyhole_tooth_cover_shape.map(func(prev): return Vector2(prev.x * 1.15, prev.y * 1.05))
	keyhole_tooth_cover_rim_shape[4].y += 10


func _draw() -> void:
	# Outline
	draw_circle(Vector2.ZERO, 165, lock_color)
	draw_circle(Vector2.ZERO, 165, rim_color, false, 2)
	
	# Tooth Cover
	draw_polygon(keyhole_tooth_cover_rim_shape, [cover_rim_color])
	draw_polygon(keyhole_tooth_cover_shape, [cover_color])
	draw_arc(Vector2(0, -49), 46, deg_to_rad(-238), deg_to_rad(62), 50, cover_rim_color, 8)
	draw_arc(Vector2(0, -51), 26, deg_to_rad(-243), deg_to_rad(67), 50, cover_color, 40)
	
	# Tooth
	draw_circle(Vector2(0, -51), 35, Color.BLACK)
	draw_polygon(keyhole_tooth_shape, [Color.BLACK])
