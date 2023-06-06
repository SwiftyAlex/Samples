//
//  KeyframeAnimation.swift
//  Animation
//
//  Created by Alex Logan on 06/06/2023.
//

import SwiftUI

struct KeyframeAnimation: View {
    @State var trigger: Bool = false

    var body: some View {
        VStack {
            KeyframeAnimator(
                initialValue: Values(),
                content: { values in
                    RoundedRectangle(cornerRadius: 12)
                        .frame(width: 100, height: 100)
                        .scaleEffect(values.scale)
                        .rotationEffect(values.rotation)
                        .offset(y: values.offset)
                }, keyframes: { values in
                    KeyframeTrack(\.scale) {
                        SpringKeyframe(0.8, spring: .smooth(duration: 0.6))
                        SpringKeyframe(1.2, spring: .smooth)
                    }

                    KeyframeTrack(\.rotation) {
                        CubicKeyframe(.degrees(-45), duration: 0.4)
                        CubicKeyframe(.degrees(45), duration: 0.4)
                        CubicKeyframe(.zero, duration: 0.3)
                    }

                    KeyframeTrack(\.offset) {
                        SpringKeyframe(-20, duration: 0.8)
                        SpringKeyframe(0, duration: 0.3)
                    }
                }
            )
        }
    }
}

private struct Values {
    var scale: Double = 1
    var rotation = Angle.zero
    var offset: Double = 0
}

#Preview {
    KeyframeAnimation()
}
