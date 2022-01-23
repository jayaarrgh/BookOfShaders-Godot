shader_type canvas_item;

// Author @patriciogv - 2015
// Title: DeFrag

uniform vec2 mouse_position;

float random (in float x) { return fract(sin(x)*1e4); }
float random2 (in vec2 _st) { return fract(sin(dot(_st.xy, vec2(12.9898,78.233)))* 43758.5453123);}

void fragment() {
    vec2 st = FRAGCOORD.xy/(1.0/SCREEN_PIXEL_SIZE).xy;
    st.x *= (1.0/SCREEN_PIXEL_SIZE).x/(1.0/SCREEN_PIXEL_SIZE).y;

    // Grid
    vec2 grid = vec2(100.0,50.);
    st *= grid;

    vec2 ipos = floor(st);  // integer

    vec2 vel = floor(vec2(TIME*10.)); // time
    vel *= vec2(-1.,0.); // direction

    vel *= (step(1., mod(ipos.y,2.0))-0.5)*2.; // Oposite directions
    vel *= random(ipos.y); // random speed

    // 100%
    float totalCells = grid.x*grid.y;
    float t = mod(TIME*max(grid.x,grid.y)+floor(1.0+TIME*mouse_position.y),totalCells);
    vec2 head = vec2(mod(t,grid.x), floor(t/grid.x));

    vec2 offset = vec2(0.1,0.);

    vec3 color = vec3(1.0);
    color *= step(grid.y-head.y,ipos.y);                                // Y
    color += (1.0-step(head.x,ipos.x))*step(grid.y-head.y,ipos.y+1.);   // X
    color = clamp(color,vec3(0.),vec3(1.));

    // Assign a random value base on the integer coord
    color.r *= random2(floor(st+vel+offset));
    color.g *= random2(floor(st+vel));
    color.b *= random2(floor(st+vel-offset));

    color = smoothstep(0.,.5+mouse_position.x/(1.0/SCREEN_PIXEL_SIZE).x*.5,color*color); // smooth
    color = step(0.5+mouse_position.x/(1.0/SCREEN_PIXEL_SIZE).x*0.5,color); // threshold

    //  Margin
    color *= step(.1,fract(st.x+vel.x))*step(.1,fract(st.y+vel.y));

    COLOR = vec4(1.0-color,1.0);
}
