shader_type canvas_item;

// Author @patriciogv ( patriciogonzalezvivo.com ) - 2015

vec2 tile(vec2 _st, float _zoom){
    _st *= _zoom;
    return fract(_st);
}

float box(vec2 _st, vec2 _size){
    _size = vec2(0.5)-_size*0.5;
    vec2 uv = smoothstep(_size,_size+vec2(1e-4),_st);
    uv *= smoothstep(_size,_size+vec2(1e-4),vec2(1.0)-_st);
    return uv.x*uv.y;
}

void fragment(){
    vec2 st = FRAGCOORD.xy/(1.0/SCREEN_PIXEL_SIZE).xy;
    vec3 color = vec3(0.0);

    // Repat the space
    st = tile(st,10.0);

    // Draw a rectangle in each one
    color = vec3(box(st,vec2(0.9)));

    // Show the space coordinates
    // color = vec3(st,0.0);

    COLOR = vec4(color,1.0);
}
