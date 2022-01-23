shader_type canvas_item;

// Author @patriciogv - 2015
// http://patriciogonzalezvivo.com

float plot(vec2 st, float pct){
  return  smoothstep( pct-0.01, pct, st.y) -
          smoothstep( pct, pct+0.01, st.y);
}

float random (in float x) {
    return fract(sin(x)*1e4);
}

float noise (in float x) {
    float i = floor(x);
    float f = fract(x);

    // Cubic Hermine Curve
    float u = f * f * (3.0 - 2.0 * f);

    return mix(random(i), random(i + 1.0), u);
}

void fragment() {
    vec2 st = FRAGCOORD.xy/(1.0/SCREEN_PIXEL_SIZE).xy;
    st.x *= (1.0/SCREEN_PIXEL_SIZE).x/(1.0/SCREEN_PIXEL_SIZE).y;
    vec3 color = vec3(0.0);

    float y = 0.0;
    // y = random(st.x*0.001+TIME);
    y = noise(st.x*3.+TIME);

    // color = vec3(y);
    float pct = plot(st,y);
    color = (1.0-pct)*color+pct*vec3(0.0,1.0,0.0);

    COLOR = vec4(color,1.0);
}
