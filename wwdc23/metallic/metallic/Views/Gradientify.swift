//
//  Gradientify.swift
//  metallic
//
//  Created by Alex Logan on 13/06/2023.
//

import SwiftUI

struct Gradientify: View {
    let start = Date()

    var body: some View {
        VStack {
            TimelineView(.animation) { context in
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(.pink)
                    .gradientEffect(
                        seconds: context.date.timeIntervalSince1970 - self.start.timeIntervalSince1970
                    )
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

        }
        .padding()
    }
}

extension View {
    func gradientEffect(seconds: Double) -> some View {
        let function = ShaderFunction(
            library: .default,
            name: "gradientify"
        )
        let shader = Shader(function: function, arguments: [
            .boundingRect,
            .float(seconds)
        ])
        return self.colorEffect(shader, isEnabled: true)
    }
}

#Preview {
    Gradientify()
}
