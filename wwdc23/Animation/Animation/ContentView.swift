//
//  ContentView.swift
//  Animation
//
//  Created by Alex Logan on 06/06/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink(destination: SimplePhasedAnimation()) {
                    Text("Simple Phased")
                }
                NavigationLink(destination: SquarePhasedAnimation()) {
                    Text("Square Phased")
                }
                NavigationLink(destination: AnimatedSymbols()){
                    Text("Symbols")
                }
                NavigationLink(destination: KeyframeAnimation()){
                    Text("Keyframes")
                }
                NavigationLink(destination: HealthAnimation()) {
                    Text("Health")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
