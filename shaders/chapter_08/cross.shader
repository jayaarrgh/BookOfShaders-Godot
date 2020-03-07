shader_type canvas_item;

// Author @patriciogv ( patriciogonzalezvivo.com ) - 2015

float box(vec2 _st, vec2 _size){
    _size = vec2(0.5) - _size*0.5;
    vec2 uv = smoothstep(_size,
                        _size+vec2(0.0001),
                        _st);
    uv *= smoothstep(_size,
                    _size+vec2(0.0001),
                    vec2(1.0)-_st);
    return uv.x*uv.y;
}

void fragment(){
	vec2 st = FRAGCOORD.xy/(1.0/SCREEN_PIXEL_SIZE).xy;

	vec3 color = vec3( box(st, vec2(0.4,0.1)) + box(st, vec2(0.1,0.4)) );

	COLOR = vec4(color,1.0);
}
