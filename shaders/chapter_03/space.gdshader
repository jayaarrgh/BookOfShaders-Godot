shader_type canvas_item;

void fragment() {
	vec2 st = FRAGCOORD.xy/(1.0/SCREEN_PIXEL_SIZE);
	COLOR = vec4(st.x,st.y,0.0,1.0);
}
