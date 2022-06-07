//
//  DeeplinkView.swift
//  coffee-sample
//
//  Created by Alex Logan on 06/06/2022.
//

import SwiftUI

struct DeeplinkView: View {
    @State var path = NavigationPath()
    @State var mojis = [Emoji.coffee, Emoji.taco, Emoji.rocket, Emoji.scarf]
    @State private var coffees = [Coffee(name: "Flat White"), Coffee(name: "Cortado"), Coffee(name: "Mocha")]

    var body: some View {
        NavigationStack(path: $path) {
            List {
                Text("What would you like to drink?")

                Section(header: Text("Coffee"))  {
                    ForEach(coffees, id: \.name) { coffee in
                        NavigationLink(value: coffee, label: {
                            Text(coffee.name)
                        })
                    }
                }
            }
            .navigationDestination(for: Emoji.self) { moji in
                EmojiView(moji: moji)
                    .navigationTitle("Your Moji")
            }
            .navigationDestination(for: Coffee.self, destination: { coffee in
                CoffeeView(onSelectReset: { popToRoot() }, coffee: coffee, otherCoffees: coffees)
            })
            .navigationTitle(Text("Café Logan"))
        }
        .onOpenURL { url in
            let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            let queryItem = components?.queryItems?.first(where: { $0.name == "moji" })
            guard let emoji = queryItem?.value else { return }
            popToRoot()
            path.append(Emoji(moji: emoji))
        }
    }

    func popToRoot() {
        path.removeLast(path.count)
    }
}

struct DeeplinkView_Previews: PreviewProvider {
    static var previews: some View {
        DeeplinkView()
    }
}
