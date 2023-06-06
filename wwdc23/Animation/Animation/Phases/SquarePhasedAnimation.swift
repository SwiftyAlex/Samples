//
//  SimplePhasedAnimation.swift
//  Animation
//
//  Created by Alex Logan on 06/06/2023.
//

import SwiftUI

enum SquareAnimationPhase: Int, CaseIterable, Comparable {
    case none, left, middle, right

    static func < (lhs: SquareAnimationPhase, rhs: SquareAnimationPhase) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

struct SquarePhasedAnimation: View {
    @State var animate: Bool = false

    var body: some View {
        VStack {
            PhaseAnimator(
                SquareAnimationPhase.allCases,
                trigger: animate,
                content: { phase in
                    HStack {
                        if phase >= .left {
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundStyle(.cyan)
                                .transition(.scale.combined(with: .opacity))
                        }
                        if phase >= .middle {
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundStyle(.teal)
                                .transition(.scale.combined(with: .opacity))
                        }

                        if phase >= .right {
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundStyle(.blue)
                                .transition(.scale.combined(with: .opacity))
                        }
                    }
                    .frame(height: 100)
                    .padding()
                }, animation: { phase in
                    switch phase {
                    case .none: return .bouncy.delay(1)
                    case .left: return .spring(duration: 0.6)
                    case .middle: return .spring(duration: 0.4)
                    case .right: return .spring(duration: 0.3)
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
    SquarePhasedAnimation()
}
