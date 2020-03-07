shader_type canvas_item;

// Author @patriciogv - 2015
// http://patriciogonzalezvivo.com

float rect(in vec2 st, in vec2 size){
	size = 0.25-size*0.25;
    vec2 uv = smoothstep(size,size+size*vec2(0.002),st*(1.0-st));
	return uv.x*uv.y;
}

void fragment(){
	vec2 st = FRAGCOORD.xy/(1.0/SCREEN_PIXEL_SIZE).xy;

	vec3 color = vec3( rect(st, vec2(0.9) ) );

	COLOR = vec4(color,1.0);
}
