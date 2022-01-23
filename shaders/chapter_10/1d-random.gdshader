shader_type canvas_item;

// Author @patriciogv - 2015
// http://patriciogonzalezvivo.com

float plot(vec2 _st, float _pct){
  return  smoothstep( _pct-0.01, _pct, _st.y) -
          smoothstep( _pct, _pct+0.01, _st.y);
}

float random (in float _x) {
    return fract(sin(_x)*43758.5453);
}

void fragment() {
    vec2 st = FRAGCOORD.xy/(1.0/SCREEN_PIXEL_SIZE).xy;
    st.x *= (1.0/SCREEN_PIXEL_SIZE).x/(1.0/SCREEN_PIXEL_SIZE).y;
    vec3 color = vec3(0.0);

    float y = random(st.x*0.001+TIME);

    // color = vec3(y);
    float pct = plot(st,y);
    color = (1.0-pct)*color+pct*vec3(0.0,1.0,0.0);

    COLOR = vec4(color,1.0);
}
