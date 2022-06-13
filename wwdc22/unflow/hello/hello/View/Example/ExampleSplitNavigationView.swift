//
//  ExampleSplitNavigationView.swift
//  hello
//
//  Created by Alex Logan on 13/06/2022.
//

import SwiftUI

struct ExampleSplitNavigationView: View {
    @State var selectedCoffee: Coffee?
    @State var coffees = Coffee.all
    @State var navigationPath: [Coffee] = []

    var body: some View {
        NavigationSplitView(sidebar: {
            List(coffees, selection: $selectedCoffee) { coffee in
                Text(coffee.name)
                    .tag(coffee)
            }
            .navigationTitle("Coffee")
        }, detail: {
            NavigationStack(path: $navigationPath) {
                if let selectedCoffee = selectedCoffee {
                    ExampleCoffeeView(onSelectReset: popToRoot, coffee: selectedCoffee, otherCoffees: coffees)
                } else {
                    Text("Select a coffee")
                }
            }
            .navigationDestination(for: Coffee.self) { coffee in
                ExampleCoffeeView(onSelectReset: popToRoot, coffee: coffee, otherCoffees: coffees)
            }
        })
        .onChange(of: selectedCoffee, perform: { _ in popToRoot() })
    }

    func popToRoot() {
        navigationPath = []
    }
}

struct ExampleSplitNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleSplitNavigationView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
