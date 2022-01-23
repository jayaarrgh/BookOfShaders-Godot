shader_type canvas_item;

// Author @patriciogv ( patriciogonzalezvivo.com ) - 2015

vec2 tile(vec2 _st, float _zoom){
  _st *= _zoom;
  return fract(_st);
}

float box(in vec2 _st, in vec2 _size){
    _size = vec2(0.5) - _size*0.5;
    vec2 uv = smoothstep(_size,
                        _size+vec2(0.001),
                        _st);
    uv *= smoothstep(_size,
                    _size+vec2(0.001),
                    vec2(1.0)-_st);
    return uv.x*uv.y;
}

float makeCross(in vec2 _st, float _size){
    return  box(_st, vec2(_size*0.5,_size*0.125)) +
            box(_st, vec2(_size*0.125,_size*0.5));
}

void fragment(){
  vec2 st = FRAGCOORD.xy/(1.0/SCREEN_PIXEL_SIZE).xy;
  st.x *= (1.0/SCREEN_PIXEL_SIZE).x/(1.0/SCREEN_PIXEL_SIZE).y;

  st = tile(st,3.0);
  vec3 color = vec3( clamp(makeCross(fract(st),0.3),0.0,1.0) );

  COLOR = vec4(color,1.0);
}
