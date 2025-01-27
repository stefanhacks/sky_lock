shader_type canvas_item;

uniform float shake_intensity = 0.0;
uniform float shake_speed = 20.0;

void vertex() {
	vec2 shake = vec2(0.0);
	shake.x = sin(TIME * shake_speed + VERTEX.x) * shake_intensity;
	shake.y = cos(TIME * shake_speed + VERTEX.y) * shake_intensity;
	VERTEX.xy += shake;
}