//
//  AnimatedSymbols.swift
//  Animation
//
//  Created by Alex Logan on 06/06/2023.
//
import SwiftUI

struct AnimatedSymbols: View {
    @State var animateTheThings: Bool = false

    var body: some View {
        VStack(spacing: 32) {
            Image(systemName: "wifi.square.fill")
                .imageScale(.large)
                .symbolRenderingMode(.palette)
                .foregroundStyle(
                    Color.cyan, Color.gray.opacity(0.3)
                )
                // Indefinite effects can be toggled on and off with a binding
                .symbolEffect(
                    .variableColor.reversing, // Make it reverse
                    options: .repeat(3), // Customise how it behaves
                    isActive: animateTheThings
                )
                // Discrete effects like a bounce only fire on a change
                .symbolEffect(.bounce, value: animateTheThings)

            Button(action: {
                animateTheThings.toggle()
            }, label: {
                Text("Animate")
            })
        }
        .font(.largeTitle)
        .fontWeight(.heavy)
        .padding()
    }
}

#Preview {
    AnimatedSymbols()
}
