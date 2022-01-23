shader_type canvas_item;

// Author @patriciogv - 2015
// Title: Matrix

float random(in float x){ return fract(sin(x)*43758.5453); }
float random2(in vec2 st){ return fract(sin(dot(st.xy ,vec2(12.9898,78.233))) * 43758.5453); }

float randomChar(vec2 outer,vec2 inner){
    float grid = 5.;
    vec2 margin = vec2(.2,.05);
    vec2 borders = step(margin,inner)*step(margin,1.-inner);
    vec2 ipos = floor(inner*grid);
    vec2 fpos = fract(inner*grid);
    return step(.5,random2(outer*64.+ipos)) * borders.x * borders.y * step(0.01,fpos.x) * step(0.01,fpos.y);
}

void fragment(){
    vec2 st = FRAGCOORD.xy/(1.0/SCREEN_PIXEL_SIZE)*5.;
    st.y *= (1.0/SCREEN_PIXEL_SIZE).y/(1.0/SCREEN_PIXEL_SIZE).x;
    vec3 color = vec3(0.0);

    float rows = 40.0; //1.0;
    vec2 ipos = floor(st*rows);
    vec2 fpos = fract(st*rows);

    ipos += vec2(0.,floor(mod(TIME*20., 1200.)*random(ipos.x+1.)));

    float pct = 1.0;
    pct *= randomChar(ipos,fpos);
	pct *= random2(ipos);

    color = vec3(pct);

    COLOR = vec4( color , 1.0);
}
