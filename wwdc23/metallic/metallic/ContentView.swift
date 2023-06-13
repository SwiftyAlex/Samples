//
//  ContentView.swift
//  metallic
//
//  Created by Alex Logan on 13/06/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink(destination: Aqua()) {
                    Text("Let's go barbie")
                }
                NavigationLink(destination: Gradientify()) {
                    Text("Gradientify")
                }
                NavigationLink(destination: RemoveRed()) {
                    Text("Remove Red")
                }
                NavigationLink(destination: GradientSubtract()) {
                    Text("Gradient Subtract")
                }
                NavigationLink(destination: PixelPeep()) {
                    Text("Pixel Peep")
                }
                NavigationLink(destination: PixelFlip()) {
                    Text("Pixel Flip")
                }
                NavigationLink(destination: CircleLoader()) {
                    Text("Circle Loader")
                }
            }
            .navigationTitle("Shaderland")
        }
    }
}

#Preview {
    ContentView()
}