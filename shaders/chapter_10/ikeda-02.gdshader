shader_type canvas_item;

// Author @patriciogv - 2015
// Title: DeFrag

uniform vec2 mouse_position;

float random (in float x) { return fract(sin(x)*1e4); }
float random2 (in vec2 _st) { return fract(sin(dot(_st.xy, vec2(12.9898,78.233)))* 43758.5453123);}

void fragment() {
    vec2 st = FRAGCOORD.xy/(1.0/SCREEN_PIXEL_SIZE).xy;
    st.x *= (1.0/SCREEN_PIXEL_SIZE).x/(1.0/SCREEN_PIXEL_SIZE).y;

    st *= vec2(100.0,50.);

    vec2 ipos = floor(st);  // integer
    vec2 fpos = fract(st);  // fraction

    vec2 vel = floor(vec2(TIME*10.)); // time
    vel *= vec2(-1.,0.); // direction

    vel *= (step(1., mod(ipos.y,2.0))-0.5)*2.; // Oposite directions
    vel *= random(ipos.y); // random speed

    // Move
    ipos += floor(vel);
    // Assign a random value base on the integer coord

    float pct = 1.0;
    pct *= random2(ipos);
    pct *= step(.1,fpos.x)*step(.1,fpos.y); // margin
    pct = step(0.001+mouse_position.x/(1.0/SCREEN_PIXEL_SIZE).x,pct); // threshold

    COLOR = vec4(vec3(pct),1.0);
}
