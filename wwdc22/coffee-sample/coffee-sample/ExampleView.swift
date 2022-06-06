//
//  ExampleView.swift
//  coffee-sample
//
//  Created by Alex Logan on 06/06/2022.
//

import SwiftUI

struct Emoji: Equatable, Hashable {
    let moji: String
    static let coffee = Emoji(moji: "☕️")
    static let taco = Emoji(moji: "🌮")
    static let rocket = Emoji(moji: "🚀")
    static let scarf = Emoji(moji: "🧣")
}

struct ExampleView: View {
    @State var mojis = [Emoji.coffee, Emoji.taco, Emoji.rocket, Emoji.scarf]
    @State var coffees = [Coffee(name: "Cortado"), Coffee(name: "Flat White")]

    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Best emoji"))  {
                    ForEach(mojis, id: \.moji) { moji in
                        NavigationLink(value: moji, label: {
                            Text(moji.moji)
                        })
                    }
                }
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
            }
            .navigationDestination(for: Coffee.self, destination: { coffee in
                CoffeeView(onSelectReset: { }, coffee: coffee, otherCoffees: coffees)
            })
            .navigationTitle(Text("Moji"))
        }
    }
}

struct ExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView()
    }
}
