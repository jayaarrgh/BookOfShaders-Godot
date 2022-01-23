shader_type canvas_item;

// Author @patriciogv - 2015
// Title: Wave

float random (in float x) { return fract(sin(x)*1e4); }
float random2 (in vec2 st) { return fract(sin(dot(st.xy, vec2(12.9898,78.233)))* 43758.5453123); }

void fragment() {
    vec2 st = FRAGCOORD.xy/(1.0/SCREEN_PIXEL_SIZE).xy;
    st.x *= (1.0/SCREEN_PIXEL_SIZE).x/(1.0/SCREEN_PIXEL_SIZE).y;

    vec3 color = vec3(0.0);

    vec2 grid = vec2(100.0,2.0);

    float t = TIME*max(grid.x,grid.y);

    vec2 ipos = floor(st*grid);
    vec2 fpos = fract(st*grid);

    float value = random(floor(ipos.x+t));

    if (mod(ipos.y,2.) == 0.) {
        fpos = 1.0-fpos;
    }
    color += step(fpos.y*1.5,value);

    COLOR = vec4(color,1.0);
}
