shader_type canvas_item;

// Author: @patriciogv
// Title: CellularNoise

vec2 random2( vec2 p ) {
    return fract(sin(vec2(dot(p,vec2(127.1,311.7)),dot(p,vec2(269.5,183.3))))*43758.5453);
}

void fragment() {
    vec2 st = FRAGCOORD.xy/(1.0/SCREEN_PIXEL_SIZE).xy;
    st.x *= (1.0/SCREEN_PIXEL_SIZE).x/(1.0/SCREEN_PIXEL_SIZE).y;
    vec3 color = vec3(.0);

    // Scale
    st *= 3.;

    // Tile the space
    vec2 i_st = floor(st);
    vec2 f_st = fract(st);

    vec2 point = random2(i_st);
    vec2 diff = point - f_st;

    float dist = length(diff);

    // Draw the min distance (distance field)
    color += dist;

    // Draw cell center
    color += 1.-step(.02, dist);

    // Draw grid
    color.r += step(.98, f_st.x) + step(.98, f_st.y);

    // Show isolines
    // color -= step(.7,abs(sin(27.0*dist)))*.5;

    COLOR = vec4(color,1.0);
}
