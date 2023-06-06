//
//  SimplePhasedAnimation.swift
//  Animation
//
//  Created by Alex Logan on 06/06/2023.
//

import SwiftUI

enum SimpleAnimationPhase: CaseIterable {
    case invisible, visible
}

struct SimplePhasedAnimation: View {
    @State var animate: Bool = false

    var body: some View {
        VStack {
            PhaseAnimator(
                SimpleAnimationPhase.allCases,
                trigger: animate,
                content: { phase in
                    RoundedRectangle(cornerRadius: 12)
                        .opacity(phase == .invisible ? 0 : 1)
                }, animation: { phase in
                    switch phase {
                    case .invisible:
                        return .easeInOut(duration: 1)
                    case .visible:
                        return .easeInOut(duration: 2)
                    }
                }
            )

            Button(action: {
                animate.toggle()
            }, label: {
                Text("Animate")
            })
        }
    }
}

#Preview {
    SimplePhasedAnimation()
}
