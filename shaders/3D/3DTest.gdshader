shader_type spatial;
render_mode blend_mix,depth_draw_opaque,cull_back,diffuse_burley,specular_schlick_ggx;
//TODO: Accept a texture in our editor
uniform sampler2D texture_albedo : hint_albedo;

varying smooth vec3 our_color;
//varying flat vec3 our_color;

void vertex() {
	our_color = VERTEX;
}

void fragment() {
	vec3 base = texture(texture_albedo, UV).rgb;
	ALBEDO = (base + our_color.rgb)/2.0;
}
