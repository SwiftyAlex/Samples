//
//  HealthAnimation.swift
//  Animation
//
//  Created by Alex Logan on 06/06/2023.
//

import SwiftUI

enum AnimationPhase: Int, CaseIterable, Animatable, Comparable {
    static func < (lhs: AnimationPhase, rhs: AnimationPhase) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }

    case idle = 0, icon, innerCircle, outerCircle, pulse
}

struct HealthAnimation: View {
    @State var animate: Bool = false

    var body: some View {
        VStack {
            animation
        }

    }

    var animation: some View {
        PhaseAnimator(
            AnimationPhase.allCases,
            content: { phase in
            GeometryReader { geometry in
                ZStack(alignment: .center) {
                    let center = CGPoint(
                        x: geometry.frame(in: .local).midX,
                        y: geometry.frame(in: .local).midY
                    )

                    if phase.rawValue > AnimationPhase.innerCircle.rawValue {
                        OuterCircle(center: center)
                            .transition(
                                .opacity.combined(with: .scale(scale: 0.8))
                            )
                            .scaleEffect(phase == .pulse ? 1.01 : 1)
                            .rotationEffect(.degrees(phase == .pulse ? 2 : 0))
                    }

                    if phase.rawValue > AnimationPhase.icon.rawValue {
                        InnerCircle(center: center)
                            .transition(
                                .opacity.combined(with: .scale(scale: 0.6))
                            )
                            .scaleEffect(phase == .pulse ? 1.01 : 1)
                            .rotationEffect(.degrees(phase == .pulse ? -2 : 0))
                    }

                    if phase.rawValue >= AnimationPhase.icon.rawValue {
                        Image("HealthIcon")
                            .resizable()
                            .frame(width: 80, height: 80, alignment: .center)
                            .shadow(radius: 4)
                            .transition(
                                .scale(0.6).combined(with: .opacity)
                            )
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            .frame(width: 400, height: 400, alignment: .center)
        }, animation: { phase in
            switch phase {
            case .idle:
                    .bouncy
            case .icon:
                    .timingCurve(0.34, 1.56, 0.64, 1, duration: 0.6)
            case .innerCircle:
                    .timingCurve(0.34, 1.56, 0.64, 1, duration: 0.4)
            case .outerCircle:
                    .timingCurve(0.34, 1.56, 0.64, 1, duration: 0.6)
            case .pulse:
                    .bouncy(duration: 2)
            }
        })
    }
}

struct OuterCircle: View {
    let center: CGPoint

    var body: some View {
        Circle()
            .stroke(
                Color.green.opacity(0),
                lineWidth: 30
            )
            .padding(60)
            .overlay {
                let slice = (CGFloat.pi * 2) / CGFloat(OuterIcon.allCases.count)
                let radius: CGFloat = 140

                ForEach(OuterIcon.allCases.indices, id: \.self) { index in
                    let angle = slice * CGFloat(index)
                    let icon = OuterIcon.allCases[index]

                    let x = center.x + radius * cos(angle)
                    let y = center.y + radius * sin(angle)

                    Image(systemName: icon.imageName)
                        .font(.title.weight(.semibold))
                        .fontDesign(.rounded)
                        .position(
                            x: x,
                            y: y
                        )
                        .foregroundStyle(icon.color)
                }
            }
    }
}

struct InnerCircle: View {
    let center: CGPoint

    var body: some View {
        Circle()
            .stroke(
                Color.cyan.opacity(0),
                lineWidth: 30
            )
            .padding(120)
            .overlay {
                let slice = (CGFloat.pi * 2) / CGFloat(InnerIcon.allCases.count)
                let radius: CGFloat = 80

                ForEach(InnerIcon.allCases.indices, id: \.self) { index in
                    let icon = InnerIcon.allCases[index]
                    let angle = slice * CGFloat(index)

                    let x = center.x + radius * cos(angle)
                    let y = center.y + radius * sin(angle)

                    Image(systemName: icon.imageName)
                        .font(.title.weight(.semibold))
                        .fontDesign(.rounded)
                        .position(
                            x: x,
                            y: y
                        )
                        .foregroundStyle(icon.color)
                        .transition(
                            .opacity.combined(with: .scale(scale: 0.8))
                        )

                }
            }
    }
}

#Preview {
    HealthAnimation()
}
