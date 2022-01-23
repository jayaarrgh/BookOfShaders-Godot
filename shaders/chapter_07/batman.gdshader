shader_type canvas_item;

// Author @patriciogv - 2015
// http://patriciogonzalezvivo.com

float plot(float y, float pct){
  return  smoothstep( pct-0.01, pct, y) -
          smoothstep( pct, pct+0.01, y);
}

void fragment(){
    vec2 st = FRAGCOORD.xy/(1.0/SCREEN_PIXEL_SIZE);
	st.y += .35; // had to add to y in godot to get more centered vertically...
    st.y *= (1.0/SCREEN_PIXEL_SIZE).y/(1.0/SCREEN_PIXEL_SIZE).x;
    vec3 color = vec3(.0);
    float pct = .0;

    float shape = 1.0-distance(st*vec2(1.,2.)-vec2(0.,.5),vec2(.5));

    pct = shape;
    pct = min(pct, distance(st,vec2(0.5,0.76))*10.);
    pct = min(pct, distance(st,vec2(0.36,0.71))*5.);
    pct = min(pct, distance(st,vec2(0.64,0.71))*5.);
    pct = min(pct, distance(st,vec2(0.36,0.20))*4.*pow(1.-st.y,shape*1.1));
    pct = min(pct, distance(st,vec2(0.64,0.20))*4.*pow(1.-st.y,shape*1.1));

    color = vec3(pct);

    color += vec3(1.,1.,.0)*plot(pct,0.5+smoothstep(-1.,2.,sin(TIME))*.1);


    COLOR = vec4( color, 1.0 );
}
