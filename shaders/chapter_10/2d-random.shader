shader_type canvas_item;

// Author @patriciogv - 2015
// http://patriciogonzalezvivo.com

float random (vec2 st) {
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}

void fragment() {
    vec2 st = FRAGCOORD.xy/(1.0/SCREEN_PIXEL_SIZE).xy;

    float rnd = random( st );

    COLOR = vec4(vec3(rnd),1.0);
}
