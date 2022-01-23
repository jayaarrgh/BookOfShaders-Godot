shader_type canvas_item;

// Author @patriciogv - 2015
// Title: Ikeda Data Stream

uniform vec2 mouse_position;

float random (in float x) {
    return fract(sin(x)*1e4);
}

float random_vec2_in(in vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898,78.233)))* 43758.5453123);
}

float pattern(vec2 st, vec2 v, float t) {
    vec2 p = floor(st+v);
    return step(t, random_vec2_in(100.+p*.000001)+random(p.x)*0.5 );
}

void fragment() {
    vec2 st = FRAGCOORD.xy/(1.0/SCREEN_PIXEL_SIZE).xy;
    st.x *= (1.0/SCREEN_PIXEL_SIZE).x/(1.0/SCREEN_PIXEL_SIZE).y;

    vec2 grid = vec2(100.0,50.);
    st *= grid;

    vec2 ipos = floor(st);  // integer
    vec2 fpos = fract(st);  // fraction

    vec2 vel = vec2(TIME*2.*max(grid.x,grid.y)); // time
    vel *= vec2(-1.,0.0) * random(1.0+ipos.y); // direction

    // Assign a random value base on the integer coord
    vec2 offset = vec2(0.1,0.);

    vec3 color = vec3(0.);
    color.r = pattern(st+offset,vel,0.5+mouse_position.x/(1.0/SCREEN_PIXEL_SIZE).x);
    color.g = pattern(st,vel,0.5+mouse_position.x/(1.0/SCREEN_PIXEL_SIZE).x);
    color.b = pattern(st-offset,vel,0.5+mouse_position.x/(1.0/SCREEN_PIXEL_SIZE).x);

    // Margins
    color *= step(0.2,fpos.y);

    COLOR = vec4(1.0-color,1.0);
}
