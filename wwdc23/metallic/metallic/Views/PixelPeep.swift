//
//  PixelFlip.swift
//  metallic
//
//  Created by Alex Logan on 13/06/2023.
//

import SwiftUI

struct PixelPeep: View {
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                Rectangle()
                    .foregroundStyle(Color(red: 1, green: 0, blue: 0))
                Rectangle()
                    .foregroundStyle(Color(red: 0, green: 1, blue: 0))
            }
            .drawingGroup()
            .pixelPeep()
            .frame(width: 200, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

extension View {
    func pixelPeep() -> some View {
        return self.layerEffect(
            ShaderLibrary.default.pixelPeep(),
            maxSampleOffset: .init(width: 200, height: 200)
        )
    }
}

#Preview {
    PixelPeep()
}
