//
//  SplitExampleView.swift
//  coffee-sample
//
//  Created by Alex Logan on 07/06/2022.
//

import SwiftUI

enum SplitItem: String, CaseIterable {
    case coffee = "Coffee", emoji = "Moji"
}

struct SplitExampleView: View {
    @State private var path = NavigationPath()
    @State private var selectedItem: SplitItem = .coffee
    @State private var coffees = [ Coffee(name: "Flat White"), Coffee(name: "Cortado"), Coffee(name: "Mocha") ]
    @State private var mojis = [Emoji.coffee, Emoji.taco, Emoji.rocket, Emoji.scarf]

    var body: some View {
        NavigationSplitView(sidebar: {
            sidebar
        }, detail: {
            NavigationStack(path: $path, root: {
                Group {
                    switch selectedItem {
                    case .coffee:
                        coffeeView
                    case .emoji:
                        emojiView
                    }
                }
                .navigationDestination(for: Coffee.self) { coffee in
                    CoffeeView(onSelectReset: { }, coffee: coffee, otherCoffees: coffees)
                }
                .navigationDestination(for: Emoji.self) { emoji in
                    EmojiView(moji: emoji)
                }
            })
        })
        .onChange(of: selectedItem) { _ in
            path.removeLast(path.count)
        }
    }

    enum SplitItem: String, CaseIterable {
        case coffee = "Coffee", emoji = "Moji"
    }

    var sidebar: some View {
        List(SplitItem.allCases, id: \.self, selection: $selectedItem) { item in
            Button(item.rawValue, action: { selectedItem = item })
                .tag(item)
        }
        .listStyle(.sidebar)
    }

    var coffeeView: some View {
        Section(header: Text("Coffee"))  {
            ForEach(coffees, id: \.name) { coffee in
                NavigationLink(value: coffee, label: {
                    Text(coffee.name)
                })
            }
        }
        .navigationTitle(Text("Coffee"))
    }

    var emojiView: some View {
        Section(header: Text("Best emoji"))  {
            ForEach(mojis, id: \.moji) { moji in
                NavigationLink(value: moji, label: {
                    Text(moji.moji)
                })
            }
        }
        .navigationTitle(Text("Emoji"))
    }
}

struct SplitExampleView_Previews: PreviewProvider {
    static var previews: some View {
        SplitExampleView()
    }
}
