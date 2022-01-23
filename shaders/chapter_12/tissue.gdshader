shader_type canvas_item;

// Author: @patriciogv - 2015
// Title: Tissue

// Created by inigo quilez - iq/2013
// License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
// http://www.iquilezles.org/www/articles/voronoilines/voronoilines.htm

vec2 random2( vec2 p ) {
    return fract(sin(vec2(dot(p,vec2(127.1,311.7)),dot(p,vec2(269.5,183.3))))*43758.5453);
}

//#define ANIMATE
vec3 voronoi( in vec2 x, float rnd, float t ) {
    vec2 n = floor(x);
    vec2 f = fract(x);

    // first pass: regular voronoi
    vec2 mg, mr;
    float md = 8.0;
    for (int j=-1; j<=1; j++ ) {
        for (int i=-1; i<=1; i++ ) {
            vec2 g = vec2(float(i),float(j));
            vec2 o = random2( n + g )*rnd;
            //#ifdef ANIMATE
            o = 0.5 + 0.5*sin( t + 6.2831*o );
            //
            vec2 r = g + o - f;
            float d = dot(r,r);

            if( d<md ) {
                md = d;
                mr = r;
                mg = g;
            }
        }
    }

    // second pass: distance to borders
    md = 8.0;
    for (int j=-2; j<=2; j++ ) {
        for (int i=-2; i<=2; i++ ) {
            vec2 g = mg + vec2(float(i),float(j));
            vec2 o = random2(n + g)*rnd;
            //#ifdef ANIMATE
            o = 0.5 + 0.5*sin( t + 6.2831*o );
            //
            vec2 r = g + o - f;

            if( dot(mr-r,mr-r)>0.00001 )
            md = min( md, dot( 0.5*(mr+r), normalize(r-mr) ) );
        }
    }
    return vec3( md, mr );
}

void fragment() {
	vec2 res = (1.0/SCREEN_PIXEL_SIZE).xy;
    vec2 st = FRAGCOORD.xy/res.xy;
    st = (st-.5)*.75+.5;
    if (res.y > res.x ) {
        st.y *= res.y/res.x;
        st.y -= (res.y*.5-res.x*.5)/res.x;
    } else {
        st.x *= res.x/res.y;
        st.x -= (res.x*.5-res.y*.5)/res.y;
    }
    vec3 color = vec3(0.0);

    float d = dot(st-.5,st-.5);
    vec3 c = voronoi( 20.*st, pow(d,.4), TIME );

    // borders
    color = mix( vec3(1.0), color, smoothstep( 0.01, 0.02, c.x ) );
    // feature points
    float dd = length( c.yz );
    color += vec3(1.)*(1.0-smoothstep( 0.0, 0.1, dd));

    COLOR = vec4(color,1.0);
}
