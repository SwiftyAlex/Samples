//
//  ExampleNavigationView.swift
//  hello
//
//  Created by Alex Logan on 13/06/2022.
//

import SwiftUI

struct ExampleNavigationView: View {
    @State var coffees = Coffee.all
    @State var navigationPath: [Coffee] = []

    var body: some View {
        NavigationStack(path: $navigationPath) {
            List {
                Section(header: Text("Coffee"))  {
                    ForEach(coffees, id: \.name) { coffee in
                        NavigationLink(value: coffee, label: {
                            Text(coffee.name)
                        })
                    }
                }
            }
            .navigationDestination(for: Coffee.self, destination: { coffee in
                ExampleCoffeeView(onSelectReset: popToRoot, coffee: coffee, otherCoffees: coffees)
            })
            .onOpenURL { url in
                let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
                let queryItem = components?.queryItems?.first(where: { $0.name == "coffee" })
                guard let coffeeId = queryItem?.value?.uppercased() else { return }

                if let matchingCoffee = Coffee.all.first(
                    where: { $0.id.uuidString == coffeeId }
                ) {
                    popToRoot()
                    navigationPath.append(matchingCoffee)
                }
            }
            .navigationTitle(Text("Navigation"))
        }
    }

    func popToRoot() {
        navigationPath = []
    }
}

struct ExampleCoffeeView: View {
    var onSelectReset: () -> ()
    let coffee: Coffee
    let otherCoffees: [Coffee]

    var body: some View {
        List {
            Text(coffee.name)
                .font(.subheadline.weight(.medium))

            Button(action: {
                onSelectReset()
            }, label: {
                Text("Reset")
            })

            Section(header: Text("Other Coffee")) {
                ForEach(otherCoffees, id: \.name) { coffee in
                    NavigationLink(value: coffee, label: {
                        Text(coffee.name)
                            .font(.subheadline.weight(.medium))
                    })
                }
            }
        }
        .navigationTitle(Text(coffee.name))
    }
}

struct ExampleNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleNavigationView()
    }
}
