shader_type canvas_item;

// Author @patriciogv ( patriciogonzalezvivo.com ) - 2015

vec2 tile(vec2 _st, float _zoom){
  _st *= _zoom;
  return fract(_st);
}

float circle(vec2 _st, float _radius){
  vec2 pos = vec2(0.5)-_st;
  _radius *= 0.75;
  return 1.-smoothstep(_radius-(_radius*0.05),_radius+(_radius*0.05),dot(pos,pos)*3.14);
}

void fragment(){

  vec2 st = FRAGCOORD.xy/(1.0/SCREEN_PIXEL_SIZE).xy;
  st.x *= (1.0/SCREEN_PIXEL_SIZE).x/(1.0/SCREEN_PIXEL_SIZE).y;
  st = tile(st,5.);
  vec3 color = vec3(circle(st+vec2(0.,-.5), 0.35)+
                    circle(st+vec2(0.,.5), 0.35)+
                    circle(st+vec2(-.5,0.), 0.35)+
                    circle(st+vec2(.5,0.), 0.35));

  COLOR = vec4(color,1.0);
}
