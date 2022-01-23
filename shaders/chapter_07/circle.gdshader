shader_type canvas_item;

// Author @patriciogv - 2015
// http://patriciogonzalezvivo.com

float circle(in vec2 _st, in float _radius){
    vec2 dist = _st-vec2(0.5);
	return 1.-smoothstep(_radius-(_radius*0.01),
                         _radius+(_radius*0.01),
                         dot(dist,dist)*4.0);
}

void fragment(){
	vec2 st = FRAGCOORD.xy/(1.0/SCREEN_PIXEL_SIZE).xy;

	vec3 color = vec3(circle(st,0.9));

	COLOR = vec4( color, 1.0 );
}
