//
//  Shaders.metal
//  metallic
//
//  Created by Alex Logan on 13/06/2023.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

// MARK: - Aqua
[[ stitchable ]] half4 aqua(
    float2 position,
    half4 color
) {
    // R, G, B, A
    return half4(60.0/255.0, 238.0/255.0, 227.0/255.0, 1.0);
}

// MARK: - Gradientify
[[ stitchable ]] half4 gradientify(
    float2 position,
    half4 color,
    float4 box,
    float secs
) {
    // Normalised pixel coords from 0 to 1
    vector_float2 uv = position/box.zw;
    // Calculate color as a function of the position & time
    // Start from 0.5 to brighten the colors ( we don't want this to be dark )
    vector_float3 col = 0.5 + 0.5 *cos(secs+uv.xyx+float3(0, 2, 4));
    return half4(col.x, col.y, col.z, 1);
}

// MARK: - Remove Red
[[ stitchable ]] half4 removeRed(
    float2 position,
    half4 color
) {
    color.x = 0;
    return color;
}

// MARK: - Gradient Subtract
[[ stitchable ]] half4 gradientSubtract(
    float2 position,
    SwiftUI::Layer layer,
    float4 bounds
) {
    // Normalise coordinates
    // This time we're taking a float2 out of a float4, which we do with zw
    float2 uv = position / bounds.zw;
    // Get our pixel color
    half4 pixelColor = layer.sample(position);
    // Alter this number to affect how close this will be to the base color
    float offset = 0.5;
    // Remove from the base color, returning a new color
    return pixelColor - half4(uv.x * offset, uv.y * offset, 0, 0);
}

// MARK: - Pixel Flip
[[ stitchable ]] float2 pixelFlip(float2 position, float4 bounds) {
    // Normalise coordinates
    float2 uv = position / bounds.zw;
    // Offset by our offset from 0, so the further away you are, the closer you get
    return position.x = ((1 - (uv.x * 1)) * bounds.z);
}

// MARK: - Circle Loader
[[ stitchable ]] half4 circleLoader(
    float2 position,
    half4 color,
    float4 bounds,
    float secs
) {
    float cols = 6;
    float PI2 = 6.2831853071795864769252867665590;
    float timeScale = 0.04;

    vector_float2 uv = position/bounds.zw;

    float circle_rows = (cols * bounds.w) / bounds.z;
    float scaledTime = secs * timeScale;

    float circle = -cos((uv.x - scaledTime) * PI2 * cols) * cos((uv.y + scaledTime) * PI2 * circle_rows);
    float stepCircle = step(circle, -sin(secs + uv.x - uv.y));

    // Blue Colors
    vector_float4 background = vector_float4(0.2, 0.6, 0.6, 1.0);
    vector_float4 circles = vector_float4(0, 0.8, 0.8, 1.0);

    return half4(mix(background, circles, stepCircle));
}


// MARK: - Apollonian Gasket


// Based on "Apollian with a twist" - a WebGL shader created by mrange (License CC0).
// Converted to DCTL and embeddet into a Lua Fuse for DaVinci Resolve by nmbr73.
// Then ported to pure Metal code again by nmbr73.
//
// Works, but the code could need some cleanup ...


float apollonianGasket_df(float2 p, float iTime, float scale) {
  const float zoom = 0.5f;
  p /= zoom;

  float z = 4.0f;

  float tm = 0.1f*iTime;

  p = p * float2x2(cos(tm), sin(tm), -sin(tm), cos(tm));
  tm = 0.2f*iTime;
  float r = 0.5f;

  float4 off = float4(
    r*(0.5f+0.5f*sin(tm*sqrt(3.0f))),
    r*(0.5f+0.5f*sin(tm*sqrt(1.5f))),
    r*(0.5f+0.5f*sin(tm*sqrt(2.0f))),
    0.0f);

  float4 pp = float4(p.x, p.y, 0.0f, 0.0f)+off;
  pp.w = 0.125f*(1.0f-tanh(length(pp.xyz)));

  float tmsqrt = tm*sqrt(0.5f);
  pp.yz = pp.yz * float2x2(cos(tm), sin(tm), -sin(tm), cos(tm));
  pp.xz = pp.xz * float2x2(cos(tmsqrt), sin(tmsqrt), -sin(tmsqrt), cos(tmsqrt));

  pp /= z;

  for(int i=0; i<7; ++i) {
    pp        = -1.0f + 2.0f*fract(0.5f*pp+0.5f);

    float r2 = dot(pp,pp);

    float k  = 1.2/r2;
    pp      *= k;
    scale   *= k;
  }

  return  (abs(pp.y)/scale * z) * zoom;

}


[[ stitchable ]] half4 apollonianGasket(
    float2 fragCoord,
    half4 color,
    float4 bounds,
    float iTime
) {
    
    float2 iResolution = bounds.zw;

    // Could be nice to add some UI controls for these:
    
    float  Alpha      = 1.0f;
    float  Scale      = 1.0;
    float  Contrast   = 0.6;
    float  Saturation = 0.33;
    float  Vigneting  = 0.7;

    // --------

    float2 q = fragCoord / iResolution.xy;
    float2 p = -1.0f + 2.0f * q;
    p.x *= iResolution.x/iResolution.y;


    float aa   = 2.0f/iResolution.y;
    const float lw = 0.0235f;
    const float lh = 1.25f;

    const float3 lp1 = float3(0.5f, lh, 0.5f);
    const float3 lp2 = float3(-0.5f, lh, 0.5f);

    float d = apollonianGasket_df(p,iTime,Scale);

    float b = -0.125f;
    float t = 10.0f;

    float3 ro = float3(0.0f, t, 0.0f);
    float3 pp = float3(p.x, 0.0f, p.y);

    float3 rd = normalize(pp - ro);

    float bt = -(t-b)/rd.y;

    float3 bp   = ro + bt*rd;
    float3 srd1 = normalize(lp1-bp);
    float3 srd2 = normalize(lp2-bp);
    float bl21= dot(lp1-bp,lp1-bp);
    float bl22= dot(lp2-bp,lp2-bp);

    float st1= (0.0f-b)/srd1.y;
  //float st2= (0.0f-b)/srd2.y;
    float3 sp1 = bp + srd1*st1;
    float3 sp2 = bp + srd2*st1;

    float sd1= apollonianGasket_df(sp1.xz,iTime,Scale);
    float sd2= apollonianGasket_df(sp2.xz,iTime,Scale);

    float3 col  = float3(.0);
    const float ss =15.0f;

    col += float3(1.)*(1.0f-exp(-ss*(fmax((sd1+0.0f*lw), 0.0f))))/bl21;
    col += float3(.5)*(1.0f-exp(-ss*(fmax((sd2+0.0f*lw), 0.0f))))/bl22;
    
    float l   = length(p);
    float hue = fract(0.75f*l-0.3f*iTime)+0.3f+0.15f;
    float sat = 0.75f*tanh(2.0f*l);
    float3 hsv  = float3(hue, sat, 1.0f);

    // hsv2rgb
    const float4 K = float4(1., 2. / 3., 1. / 3., 3.);
    float3 bcol = hsv.z * mix(K.xxx, clamp(fabs(fract(hsv.xxx + K.xyz) * 6.0f - K.www) - K.xxx, 0.0f, 1.0f), hsv.y);

    col *= (1.0f-tanh(0.75f*l))*0.5f;
    col  = mix(col, bcol, smoothstep(-aa, aa, -d));
    col += 0.5f*sqrt(bcol.zxy)*(exp(-(10.0f+100.0f*tanh(l))*fmax(d, 0.0f)));

    col  = pow(clamp(col,0.0f,1.0f),float3(1.0f/2.2f));
    col  = col*Contrast+0.4f*col*col*(3.0f-2.0f*col);  // contrast
    col  = mix(col, float3( dot(col, float3(Saturation)) ), -0.4f);  // saturation
    col *= 0.5f+0.5f*pow(19.0f*q.x*q.y*(1.0f-q.x)*(1.0f-q.y),Vigneting);  // vigneting

    return half4(col.x,col.y,col.z, Alpha);
                
}



// MARK: - Party Concert Visuals 202

// CC0 1.0f Universal https://creativecommons.org/publicdomain/zero/1.0f/
// To the extent possible under law, Blackle Mori has waived all copyright and related or neighboring rights to this work.
// Ported to DCTL by JiPi and converted to Metal by nmbr73.


#define asin_f2(i) float2( asin((i).x), asin((i).y))
#define asin_f3(i) float3( asin((i).x), asin((i).y), asin((i).z))


float comp(float3 p, bool Fork) {
    p = asin_f3(sin(p)*.9);
    if (Fork) p = acos(sin(p)*.9);
    return length(p)-1.;
}

float3 erot(float3 p, float3 ax, float ro) {
    return mix(dot(p,ax)*ax,p,cos(ro))+sin(ro)*cross(ax,p);
}

float smin(float a, float b, float k) {
    float h = fmax(.0,k-abs(b-a))/k;
    return fmin(a,b)-h*h*h*k/6.;
}

float4 wrot(float4 p) {
    return float4(dot(p,float4(1.)), p.y + p.z - p.w - p.x, p.z + p.w - p.y - p.x, p.w + p.y - p.z - p.x)/2.;
}

float scene(float3 p, thread float3 *p2, thread float *doodad, thread float *lazors, thread float *d1, thread float *d2, thread float *d3, float t, float iTime, float bpm, bool Fork ) {
    *p2 = erot(p, float3(.0,1.,.0), t);
    *p2 = erot(*p2, float3(.0,.0,1.), t/3.);
    *p2 = erot(*p2, float3(1.,.0,.0), t/5.);

    float bpt = iTime / 60. * bpm;
    float4 p4 = float4(*p2,0.);
    p4=mix(p4,wrot(p4),smoothstep(-.5,.5,sin(bpt/4.)));
    p4 =abs(p4);
    p4=mix(p4,wrot(p4),smoothstep(-.5,.5,sin(bpt)));
    float fctr = smoothstep(-.5,.5,sin(bpt/2.));
    float fctr2 = smoothstep(.9,1.,sin(bpt/16.));

    if (Fork)
        fctr = smoothstep(-.5,.5,cos(bpt/2.)), fctr2 = smoothstep(.9,1.,cos(bpt/16.));

    *doodad = length(fmax(abs(p4)-mix(.05,.07,fctr),float4(.0))+mix(-.1,.0,fctr))-mix(.15,.55,fctr*fctr)+fctr2;

    p.x += asin(sin(t/80.) * .99) * 80.;

    *lazors = length(asin_f2(sin( erot(p,float3(1.,.0,.0),t * .2).yz * .5+1.))/.5)-.1;
    *d1 = comp(p,Fork);
    *d2 = comp(erot(p+5., normalize(float3(1.,3.,4.)),.4),Fork);
    *d3 = comp(erot(p+10., normalize(float3(3.,2.,1.)),1.), Fork);

    if (Fork)
        *d3 = comp(erot(p+10., normalize(float3(1.,2.,3.)),1.),Fork);

    return fmin(*doodad,fmin(*lazors,.3-smin(smin(*d1,*d2,.05),*d3,.05)));
}

float3 norm(float3 p, thread float3 *p2, thread float *doodad, thread float *lazors, thread float *d1, thread float *d2, thread float *d3, float t, float iTime, float bpm, bool Fork) {
    float precis = length(p) < 1. ? .005 : .01;
    float3x3 k(.0);
    k[0][0] = k[1][1] = k[2][2] = precis;

    k = float3x3(p,p,p) - k;
    return normalize(scene(p, p2,doodad,lazors,d1,d2,d3,t,iTime,bpm, Fork)
         - float3(scene(k[0], p2,doodad,lazors,d1,d2,d3,t,iTime,bpm,Fork),scene(k[1], p2,doodad,lazors,d1,d2,d3,t,iTime,bpm,Fork),scene(k[2], p2,doodad,lazors,d1,d2,d3,t,iTime,bpm,Fork)));
}



[[ stitchable ]] half4 partyConcertVisuals2020(
    float2 fragCoord,
    half4 color,
    float4 bounds,
    float iTime
) {
    
    float2 iResolution = bounds.zw;

    float4 fragColor   = float4(.0);
    // float2 fragCoord   = to_float2(fusion_x,fusion_y);


    bool   Invers = false;
    bool   ApplyColor = true;
    bool   Fork = false;
    float4 Color = float4(.5,.5,.5,1.);
    float  AlphaThres = 1.;
    float  BeatPerMinute = 125.;

  // --------

    float d1, d2, d3;
    float t;
    float lazors, doodad;
    float3 p2;
    float bpm = BeatPerMinute;//125.0f;

    float2 uv = (fragCoord-0.5f*iResolution)/iResolution.y;

    float bpt = iTime/60.0f*bpm;
    float bp = mix(pow(sin(fract(bpt)*3.14/2.),20.)+floor(bpt),bpt,.4);
    t = bp;
    float3 cam = normalize(float3(.8f+sin(bp*3.14/4.)* .3,uv.x,uv.y));
    float3 init = float3(-1.5f+sin(bp*3.14f)*0.2f,0,0)+cam*0.2f;
    init = erot(init,float3(0,1,0),sin(bp* .2)* .4);
    init = erot(init,float3(0,0,1),cos(bp* .2)* .4);

    if (Fork)
      cam = erot(cam,float3(.0,1.,.0),cos(bp* .2) * .4),
      cam = erot(cam,float3(.0,.0,1.),sin(bp* .2) * .4);
    else
      cam = erot(cam,float3(.0,1.,.0),sin(bp * .2) * .4),
      cam = erot(cam,float3(.0,.0,1.),cos(bp * .2) * .4);


    float3 p = init;
    bool hit = false;
    float atten = 1.;
    float tlen = .0;
    float glo = .0;
    float dist;
    float fog = .0;
    float dlglo = .0;
    bool trg = false;
    for (int i = 0; i <80 && !hit; i++) {
        dist = scene(p, &p2,&doodad,&lazors,&d1,&d2,&d3,t, iTime, bpm, Fork);
        hit = dist*dist < 1e-6;
        glo += .2/(1.+lazors*lazors*20.)*atten;
        dlglo += .2/(1.+doodad*doodad*20.)*atten;

        bool lengthP2 = sin(pow(length(p2*p2*p2),.3)*120.)>.4;
        if (Fork) lengthP2 = cos(pow(length(p2*p2*p2),.3)*120.)>.4;

      //if (hit && ((sin(d3*45.0f) < -.4 && (dist!=doodad )) || (dist==doodad && sin(pow(length(p2*p2*p2),0.3f)*120.0f)>0.4f )) && dist != lazors) { //_cosf(pow
        if (hit && ((sin(d3*45.0f) < -.4 && (dist!=doodad )) || (dist==doodad &&  lengthP2  )) && dist != lazors) { //_cosf(pow

        trg = trg || dist==doodad;
            hit = false;
            float3 n = norm(p, &p2,&doodad,&lazors,&d1,&d2,&d3,t, iTime, bpm, Fork);
            atten *= 1.-abs(dot(cam,n))* .98;
            cam = reflect(cam,n);
            dist = .1;
        }
        p += cam*dist;
        tlen += dist;
        fog += dist*atten/30.;
    }
    fog = smoothstep(0.0f,1.0f,fog);
    bool lz = lazors == dist;
    bool dl = doodad == dist;
    float3 fogcol = mix(float3(.5,.8,1.2), float3(.4,.6,.9), length(uv));
    float3 n = norm(p, &p2,&doodad,&lazors,&d1,&d2,&d3,t, iTime, bpm, Fork);
    float3 r = reflect(cam,n);
    float ss = smoothstep(-.3,.3,scene(p+float3(.3), &p2,&doodad,&lazors,&d1,&d2,&d3,t, iTime, bpm, Fork))+.5;

    float fact = length(sin(r*(dl?4.:3.))* .5+.5)/sqrt(3.)* .7+.3;
    float3 matcol = mix(float3(.9,.4,.3), float3(.3,.4,.8), smoothstep(-1.,1.,sin(d1*5.+iTime*2.)));
    matcol = mix(matcol, float3(.5,.4,1.), smoothstep(.0,1.,sin(d2*5.+iTime*2.)));
    if (dl) matcol = mix(float3(1.),matcol,.1)* .2+.1;
    float3 col = matcol*fact*ss + pow(fact,10.);
    if (lz) col = float3(4.);

    float3 fragColorxyz = col*atten + glo*glo + fogcol*glo;
    fragColorxyz = mix(fragColorxyz, fogcol, fog);
    if(!dl)         fragColorxyz = abs(erot(fragColorxyz, normalize(sin(p*2.)),.2*(1.-fog)));
    if(!trg&&!dl)   fragColorxyz += dlglo*dlglo*0.1f*float3(.4,.6,.9);
    fragColorxyz = sqrt(fragColorxyz);
    fragColorxyz = smoothstep(float3(.0),float3(1.2),fragColorxyz);

    fragColor = float4(fragColorxyz,fragColor.w);

    if (Invers)
        fragColor = float4(1.) - fragColor;
    
    if (ApplyColor)
    {
      if (fragColor.x <= AlphaThres)
          fragColor.w = Color.w;

      fragColor = (fragColor + (Color-.5));
    }

    return half4(fragColor.x,fragColor.y,fragColor.z,fragColor.w);

}
