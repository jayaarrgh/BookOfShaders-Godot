shader_type canvas_item;

// Author: @patriciogv - 2015
// Title: Cell

vec4 permute(vec4 x) {
  return mod((34.0 * x + 1.0) * x, 289.0);
}

vec2 cellular2x2(vec2 P) {
	float K = 0.142857142857; // 1/7
	float K2 = 0.0714285714285; // K/2
	float jitter = 0.8; // jitter 1.0 makes F1 wrong more often
	vec2 Pi = mod(floor(P), 289.0);
 	vec2 Pf = fract(P);
	vec4 Pfx = Pf.x + vec4(-0.5, -1.5, -0.5, -1.5);
	vec4 Pfy = Pf.y + vec4(-0.5, -0.5, -1.5, -1.5);
	vec4 p = permute(Pi.x + vec4(0.0, 1.0, 0.0, 1.0));
	p = permute(p + Pi.y + vec4(0.0, 0.0, 1.0, 1.0));
	vec4 ox = mod(p, 7.0)*K+K2;
	vec4 oy = mod(floor(p*K),7.0)*K+K2;
	vec4 dx = Pfx + jitter*ox;
	vec4 dy = Pfy + jitter*oy;
	vec4 d = dx * dx + dy * dy; // d11, d12, d21 and d22, squared
	// Sort out the two smallest distances
//#if 0
//	// Cheat and pick only F1
//	d.xy = min(d.xy, d.zw);
//	d.x = min(d.x, d.y);
//	return d.xx; // F1 duplicated, F2 not computed
//#else
	// Do it right and find both F1 and F2
	d.xy = (d.x < d.y) ? d.xy : d.yx; // Swap if smaller
	d.xz = (d.x < d.z) ? d.xz : d.zx;
	d.xw = (d.x < d.w) ? d.xw : d.wx;
	d.y = min(d.y, d.z);
	d.y = min(d.y, d.w);
	return sqrt(d.xy);

}

void fragment() {
	vec2 res = (1.0/SCREEN_PIXEL_SIZE);
	vec2 st = FRAGCOORD.xy/res.xy;
	st = (st-.5)*1.+.5;
    if (res.y > res.x ) {
        st.y *= res.y/res.x;
        st.y -= (res.y*.5-res.x*.5)/res.x;
    } else {
        st.x *= res.x/res.y;
        st.x -= (res.x*.5-res.y*.5)/res.y;
    }

	st -= .5;
	st *= .7;
	vec2 F = cellular2x2(st*40.*(.1+1.0-dot(st,st)*5.));

	float facets = 0.1+(F.y-F.x);
	float dots = smoothstep(0.05, 0.1, F.x);
	float n = facets * dots;
	n = step(.2,facets)*dots;
	COLOR = vec4(n, n, n, 1.0);
}
