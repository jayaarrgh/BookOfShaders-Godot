shader_type canvas_item;

void fragment() {
	COLOR = vec4(abs(sin(TIME)),0.0,0.0,1.0);
}
