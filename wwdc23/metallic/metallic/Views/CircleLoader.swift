//
//  CircleLoader.swift
//  metallic
//
//  Created by Alex Logan on 13/06/2023.
//

import SwiftUI

struct CircleLoader: View {
    let start = Date()

    var body: some View {
        VStack {
            TimelineView(.animation) { context in
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(.white)
                    .circleLoader(
                        seconds: context.date.timeIntervalSince1970 - self.start.timeIntervalSince1970
                    )
                    .overlay {
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
    func circleLoader(seconds: Double) -> some View {
        self
            .colorEffect(
                ShaderLibrary.default.circleLoader(.boundingRect, .float(seconds))
            )
    }
}

#Preview {
    CircleLoader()
}
