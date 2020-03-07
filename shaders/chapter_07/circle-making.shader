shader_type canvas_item;

// Author @patriciogv - 2015
// http://patriciogonzalezvivo.com

void fragment(){
	vec2 st = FRAGCOORD.xy/(1.0/SCREEN_PIXEL_SIZE);
    float pct = 0.0;

    // a. The DISTANCE from the pixel to the center
    pct = distance(st,vec2(0.5));

    // b. The LENGTH of the vector
    //    from the pixel to the center
    // vec2 toCenter = vec2(0.5)-st;
    // pct = length(toCenter);

    // c. The SQUARE ROOT of the vector
    //    from the pixel to the center
    // vec2 tC = vec2(0.5)-st;
    // pct = sqrt(tC.x*tC.x+tC.y*tC.y);

    vec3 color = vec3(pct);

	COLOR = vec4( color, 1.0 );
}
