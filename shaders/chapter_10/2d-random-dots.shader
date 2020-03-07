shader_type canvas_item;

// Author @patriciogv ( patriciogonzalezvivo.com ) - 2015

const float rows = 10.0;
uniform vec2 mouse_position;

float circle(vec2 st, float radius){
  vec2 pos = vec2(0.5)-st;
  radius *= 0.75;
  return 1.-smoothstep(radius-(radius*0.01),radius+(radius*0.01),dot(pos,pos)*3.14);
}

float random(in vec2 st){ return fract(sin(dot(st.xy ,vec2(12.9898,78.233))) * 43758.5453); }

void fragment(){
  vec2 st = FRAGCOORD.xy/(1.0/SCREEN_PIXEL_SIZE).xy;
  st.x *= (1.0/SCREEN_PIXEL_SIZE).x/(1.0/SCREEN_PIXEL_SIZE).y;

  st *= 10.0;
  // Offset every other row
  st.x -= step(1., mod(st.y,2.0)) * 0.5;

  vec2 ipos = floor(st);  // integer position
  vec2 fpos = fract(st);  // float position

  // Move Right
  ipos += vec2(floor(TIME*-8.),0.);

  float pct = random(ipos);
  pct *= step(0.1+mouse_position.x/(1.0/SCREEN_PIXEL_SIZE).x,pct);
//  pct = 1.-pct;
  pct *= circle(fpos, 0.5);


  COLOR = vec4(vec3(pct),1.0);
}
