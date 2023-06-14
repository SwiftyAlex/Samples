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
