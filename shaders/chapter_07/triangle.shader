shader_type canvas_item;

// Author @patriciogv - 2015
// http://patriciogonzalezvivo.com

// Based on https://www.shadertoy.com/view/4sSSzG
float triangle(vec2 st,
                vec2 p0, vec2 p1, vec2 p2,
                float smoothness){
  vec3 e0, e1, e2;

  e0.xy = normalize(p1 - p0).yx * vec2(+1.0, -1.0);
  e1.xy = normalize(p2 - p1).yx * vec2(+1.0, -1.0);
  e2.xy = normalize(p0 - p2).yx * vec2(+1.0, -1.0);

  e0.z = dot(e0.xy, p0) - smoothness;
  e1.z = dot(e1.xy, p1) - smoothness;
  e2.z = dot(e2.xy, p2) - smoothness;

  float a = max(0.0, dot(e0.xy, st) - e0.z);
  float b = max(0.0, dot(e1.xy, st) - e1.z);
  float c = max(0.0, dot(e2.xy, st) - e2.z);

  return smoothstep(smoothness * 2.0,
                    1e-7,
                    length(vec3(a, b, c)));
}

void fragment(){
  vec2 st = FRAGCOORD.xy/(1.0/SCREEN_PIXEL_SIZE).xy;

  vec3 color = vec3( triangle(st,
                              vec2(0.0,0.15),
                              vec2(1.0,0.15),
                              vec2(0.5,0.88),
                              0.001) );

  COLOR = vec4(color,1.0);
}
