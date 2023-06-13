//
//  GradientSubtract.swift
//  metallic
//
//  Created by Alex Logan on 13/06/2023.
//

import SwiftUI

struct GradientSubtract: View {
    let start = Date()

    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.pink)
                .gradientSubtract()
                .overlay {
                    // You don't actually need to put a love heart on top of your views, but it helps <3
                    VStack {
                        Text("<3")
                            .font(.largeTitle.bold())
                            .fontDesign(.rounded)
                            .foregroundStyle(.white.gradient)
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .padding()
    }
}

extension View {
    func gradientSubtract() -> some View {
        self.layerEffect(
            ShaderLibrary.default.gradientSubtract(.boundingRect),
            maxSampleOffset: .zero
        )
    }
}

#Preview {
    Gradientify()
}
