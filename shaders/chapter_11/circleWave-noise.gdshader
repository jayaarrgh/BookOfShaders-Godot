shader_type canvas_item;

// Author @patriciogv - 2015
// http://patriciogonzalezvivo.com

// My own port of this processing code by @beesandbombs
// https://dribbble.com/shots/1696376-Circle-wave



vec2 random2(vec2 st){
    st = vec2( dot(st,vec2(127.1,311.7)),
              dot(st,vec2(269.5,183.3)) );
    return -1.0 + 2.0*fract(sin(st)*43758.5453123);
}

// Value Noise by Inigo Quilez - iq/2013
// https://www.shadertoy.com/view/lsf3WH
float noise(vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);

    vec2 u = f*f*(3.0-2.0*f);

    return mix( mix( dot( random2(i + vec2(0.0,0.0) ), f - vec2(0.0,0.0) ),
                     dot( random2(i + vec2(1.0,0.0) ), f - vec2(1.0,0.0) ), u.x),
                mix( dot( random2(i + vec2(0.0,1.0) ), f - vec2(0.0,1.0) ),
                     dot( random2(i + vec2(1.0,1.0) ), f - vec2(1.0,1.0) ), u.x), u.y);
}

mat2 rotate2d(float _angle){
    return mat2(vec2(cos(_angle),-sin(_angle)),
                vec2(sin(_angle),cos(_angle)));
}

float shape(vec2 st, float radius, float t) {
	st = vec2(0.5)-st;
    float r = length(st)*2.0;
    float a = atan(st.y,st.x);
    float m = abs(mod(a+t*2.,3.14*2.)-3.14)/3.6;
    float f = radius;
    m += noise(st+t*0.1)*.5;
    // a *= 1.+abs(atan(TIME*0.2))*.1;
    // a *= 1.+noise(st+TIME*0.1)*0.1;
    f += sin(a*50.)*noise(st+t*.2)*.1;
    f += (sin(a*20.)*.1*pow(m,2.));
    return 1.-smoothstep(f,f+0.007,r);
}

float shapeBorder(vec2 st, float radius, float width, float t) {
    return shape(st,radius, t)-shape(st,radius-width, t);
}

void fragment() {
	vec2 st = FRAGCOORD.xy/(1.0/SCREEN_PIXEL_SIZE).xy;
	vec3 color = vec3(1.0) * shapeBorder(st,0.8,0.02, TIME);

	COLOR = vec4( 1.-color, 1.0 );
}
