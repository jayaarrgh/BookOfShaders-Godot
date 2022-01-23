shader_type canvas_item;

// Author @patriciogv - 2015

float circle(in vec2 _st, in float _radius){
    vec2 l = _st-vec2(0.5);
    return 1.-smoothstep(_radius-(_radius*0.01),
                         _radius+(_radius*0.01),
                         dot(l,l)*4.0);
}

void fragment() {
	vec2 st = FRAGCOORD.xy/(1.0/SCREEN_PIXEL_SIZE);
    vec3 color = vec3(0.0);

    st *= 3.0;      // Scale up the space by 3
    st = fract(st); // Wrap arround 1.0

    // Now we have 3 spaces that goes from 0-1

    color = vec3(st,0.0);
    //color = vec3(circle(st,0.5));

	COLOR = vec4(color,1.0);
}
