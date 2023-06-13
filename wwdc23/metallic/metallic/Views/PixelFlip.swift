//
//  PixelFlip.swift
//  metallic
//
//  Created by Alex Logan on 13/06/2023.
//

import SwiftUI

struct PixelFlip: View {
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                Rectangle()
                    .foregroundStyle(Color.cyan)
                Rectangle()
                    .foregroundStyle(Color.yellow)
            }
            .frame(width: 200, height: 200)
            .pixelFlip()
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

extension View {
    func pixelFlip() -> some View {
        return self.distortionEffect(
            ShaderLibrary.default.pixelFlip(.boundingRect),
            maxSampleOffset: .init(width: 200, height: 200)
        )
    }
}

#Preview {
    PixelFlip()
}
