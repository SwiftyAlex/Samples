//
//  ContentView.swift
//  animatedsymbols
//
//  Created by Alex Logan on 19/06/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Discrete") {
                    NavigationLink(destination: AddToBasket(), label: {
                        Text("Add to basket")
                    })
                    NavigationLink(destination: AppBadge(), label: {
                        Text("App Badge")
                    })
                }
                Section("Indefinite") {
                    NavigationLink(destination: Wifi(), label: {
                        Text("Wifi")
                    })
                    NavigationLink(destination: WifiVariable(), label: {
                        Text("Variable Wifi")
                    })
                    NavigationLink(destination: PulsingAppBadge(), label: {
                        Text("Pulsing App Badge")
                    })
                }

                Section("Replace") {
                    NavigationLink(destination: SunMoonSimple(), label: {
                        Text("Sun & Moon")
                    })
                    NavigationLink(destination: SunMoon(), label: {
                        Text("Sun & Moon with Color")
                    })
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
