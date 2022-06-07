//
//  ContentView.swift
//  macchiato
//
//  Created by Alex Logan on 07/06/2022.
//

import SwiftUI
import AppIntents

struct ContentView: View {
    @ObservedObject var navigationManager = NavigationManager.shared
    @State var navigationStack: [Coffee] = []

    var body: some View {
        NavigationStack(path: $navigationStack) {
            MenuView()
                .navigationDestination(for: Coffee.self) { coffee in
                    CoffeeDetailView(coffee: coffee)
                }
        }
        .onChange(of: navigationManager.requestedCoffee) { newValue in
            if let coffee = newValue {
                navigationStack = [coffee]
            }
        }
        .onAppear {
            CoffeeShortcuts.updateAppShortcutParameters()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
