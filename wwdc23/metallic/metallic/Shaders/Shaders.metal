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

// MARK: - Pixel Peep
[[ stitchable ]] half4 pixelPeep(
    float2 position,
    SwiftUI::Layer layer
) {
    half4 pixelColor = layer.sample(position);
    half4 lookAheadPixelColor = layer.sample(position.x + 20);

    bool pixelIsRed = pixelColor.x == 1 && pixelColor.y == 0 && pixelColor.z == 0;
    bool lookAheadIsGreen = lookAheadPixelColor.x == 0 && lookAheadPixelColor.y == 1 && lookAheadPixelColor.z == 0;

    if (pixelIsRed && lookAheadIsGreen) {
        return half4(0, 0.8, 0.8, 1);
    }

    return layer.sample(position);
}
