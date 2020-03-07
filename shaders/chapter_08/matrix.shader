shader_type canvas_item;

// Author @patriciogv - 2015
// http://patriciogonzalezvivo.com

float random(in float x){
    return fract(sin(x)*43758.5453);
}

float random_vec2_in(in vec2 st){
    return fract(sin(dot(st.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

float rchar(in vec2 outer,in vec2 inner){
    float grid = 5.;
    vec2 margin = vec2(.2,.05);
    float seed = 23.;
    vec2 borders = step(margin,inner)*step(margin,1.-inner);
    return step(.5,random_vec2_in(outer*seed+floor(inner*grid))) * borders.x * borders.y;
}

vec3 matrix(in vec2 st, float t){
    float rows = 80.0;
    vec2 ipos = floor(st*rows);

    ipos += vec2(.0,floor(t*20.*random(ipos.x)));


    vec2 fpos = fract(st*rows);
    vec2 center = (.5-fpos);

    float pct = random_vec2_in(ipos);
    float glow = (1.-dot(center,center)*3.)*2.0;

    // vec3 color = vec3(0.643,0.851,0.690) * ( rchar(ipos,fpos) * pct );
    // color +=  vec3(0.027,0.180,0.063) * pct * glow;
    return vec3(rchar(ipos,fpos) * pct * glow);
}

void fragment(){
    vec2 st = FRAGCOORD.xy/(1.0/SCREEN_PIXEL_SIZE).xy;
    st.y *= (1.0/SCREEN_PIXEL_SIZE).y/(1.0/SCREEN_PIXEL_SIZE).x;
    vec3 color = vec3(0.0);

    color = matrix(st, TIME);
    COLOR = vec4( color , 1.0);
}
