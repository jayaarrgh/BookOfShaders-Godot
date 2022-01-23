shader_type canvas_item;

// Author @patriciogv - 2015
// Title: Ikeda Grid

float random(in float x){ return fract(sin(x)*43758.5453); }
float random_vec2_in(in vec2 st){ return fract(sin(dot(st.xy ,vec2(12.9898,78.233))) * 43758.5453); }

float grid(vec2 st, float res){
    vec2 grid = fract(st*res);
    return 1.-(step(res,grid.x) * step(res,grid.y));
}

float box(in vec2 st, in vec2 size){
    size = vec2(0.5) - size*0.5;
    vec2 uv = smoothstep(size,
                        size+vec2(0.001),
                        st);
    uv *= smoothstep(size,
                    size+vec2(0.001),
                    vec2(1.0)-st);
    return uv.x*uv.y;
}

float makeCross(in vec2 st, vec2 size){
    return  clamp(box(st, vec2(size.x*0.5,size.y*0.125)) +
            box(st, vec2(size.y*0.125,size.x*0.5)),0.,1.);
}

void fragment(){
    vec2 st = FRAGCOORD.xy/(1.0/SCREEN_PIXEL_SIZE).xy;
    st.x *= (1.0/SCREEN_PIXEL_SIZE).x/(1.0/SCREEN_PIXEL_SIZE).y;

    vec3 color = vec3(0.0);

    // Grid
    vec2 grid_st = st*300.;
    color += vec3(0.5,0.,0.)*grid(grid_st,0.01);
    color += vec3(0.2,0.,0.)*grid(grid_st,0.02);
    color += vec3(0.2)*grid(grid_st,0.1);

    // Crosses
    vec2 crosses_st = st + .5;
    crosses_st *= 3.;
    vec2 crosses_st_f = fract(crosses_st);
    color *= 1.-makeCross(crosses_st_f,vec2(.3,.3));
    color += vec3(.9)*makeCross(crosses_st_f,vec2(.2,.2));

    // Digits
    vec2 blocks_st = floor(st*6.);
    float t = TIME*.8+random_vec2_in(blocks_st);
    float time_i = floor(t);
    float time_f = fract(t);
    color.rgb += step(0.9,random_vec2_in(blocks_st+time_i))*(1.0-time_f);

    COLOR = vec4( color , 1.0);
}
