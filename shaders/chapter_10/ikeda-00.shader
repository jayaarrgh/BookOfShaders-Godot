shader_type canvas_item;

// Author @patriciogv - 2015
// Title: Ikeda Test patterns

float random (in float x) {
    return fract(sin(x)*1e4);
}

float random_vec2_in (in vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898,78.233)))* 43758.5453123);
}

float randomSerie(float x, float freq, float t) {
    return step(.8,random( floor(x*freq)-floor(t) ));
}

void fragment() {
    vec2 st = FRAGCOORD.xy/(1.0/SCREEN_PIXEL_SIZE).xy;
    st.x *= (1.0/SCREEN_PIXEL_SIZE).x/(1.0/SCREEN_PIXEL_SIZE).y;

    vec3 color = vec3(0.0);

    float cols = 2.;
    float freq = random(floor(TIME))+abs(atan(TIME)*0.1);
    float t = 60.+TIME*(1.0-freq)*30.;

    if (fract(st.y*cols* 0.5) < 0.5){
        t *= -1.0;
    }

    freq += random(floor(st.y));

    float offset = 0.025;
    color = vec3(randomSerie(st.x, freq*100., t+offset),
                 randomSerie(st.x, freq*100., t),
                 randomSerie(st.x, freq*100., t-offset));

    COLOR = vec4(1.0-color,1.0);
}
