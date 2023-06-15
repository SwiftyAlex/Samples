//
//  ApollonianGasket.swift
//  metallic
//
//  Created by nmbr73 on 14.06.23.
//

import SwiftUI

struct ApollonianGasket: View {
    let start = Date()

    var body: some View {
        VStack {
            TimelineView(.animation) { context in
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(.white)
                    .apollonianGasket(
                        seconds: context.date.timeIntervalSince1970 - self.start.timeIntervalSince1970
                    )
                    .overlay {
                        VStack {
                            Spacer()
                            Text("Apollian with a twist\nShader CC0 created by mrange\nPorted to Metal by nmbr73")
                                .font(.caption.bold())
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
    func apollonianGasket(seconds: Double) -> some View {
        self
            .colorEffect(
                ShaderLibrary.default.apollonianGasket(.boundingRect, .float(seconds))
            )
    }
}

#Preview {
    ApollonianGasket()
}
