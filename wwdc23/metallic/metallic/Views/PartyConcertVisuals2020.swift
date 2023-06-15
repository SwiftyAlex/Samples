//
//  PartyConcertVisuals2020.swift
//  metallic
//
//  Created by nmbr73 on 15.06.23.
//

import SwiftUI

struct PartyConcertVisuals2020: View {
    let start = Date()

    var body: some View {
        VStack {
            TimelineView(.animation) { context in
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(.white)
                    .partyConcertVisuals2020(
                        seconds: context.date.timeIntervalSince1970 - self.start.timeIntervalSince1970
                    )
                    .overlay {
                        VStack {
                            Spacer()
                            Text("@Party Concert Visuals 2020\nShader CC0 1.0 Universal created by blackle\nPorted to DCTL by JiPi and to Metal by nmbr73")
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
    func partyConcertVisuals2020(seconds: Double) -> some View {
        self
            .colorEffect(
                ShaderLibrary.default.partyConcertVisuals2020(.boundingRect, .float(seconds))
            )
    }
}

#Preview {
    PartyConcertVisuals2020()
}
