//
//  FancySplitExampleView.swift
//  coffee-sample
//
//  Created by Alex Logan on 07/06/2022.
//

import SwiftUI

struct FancySplitExampleView: View {
    @State private var path = NavigationPath()
    @State private var selectedItem: SplitItem = .emoji
    @State private var coffees = [ Coffee(name: "Flat White"), Coffee(name: "Cortado"), Coffee(name: "Mocha") ]
    @State private var mojis = [Emoji.coffee, Emoji.taco, Emoji.rocket, Emoji.scarf]
    @State var splitVisibility: NavigationSplitViewVisibility = .all

    var body: some View {
        NavigationSplitView(columnVisibility: $splitVisibility, sidebar: {
            sidebar
        }, content: {
            content
        }, detail: {
            detail
        })
        .onChange(of: selectedItem) { _ in
            path.removeLast(path.count)
        }
    }


    var sidebar: some View {
        List(SplitItem.allCases, id: \.self, selection: $selectedItem) { item in
            Button(item.rawValue, action: { selectedItem = item })
                .tag(item)
        }
        .listStyle(.sidebar)
    }

    var content: some View {
        NavigationStack {
            switch selectedItem {
            case .coffee:
                coffeeView
            case .emoji:
                emojiView
            }
        }
    }

    var detail: some View {
        NavigationStack(path: $path, root: {
            Text("Select something to get started.")
                .navigationDestination(for: Coffee.self) { coffee in
                    CoffeeView(onSelectReset: { }, coffee: coffee, otherCoffees: coffees)
                }
                .navigationDestination(for: Emoji.self) { emoji in
                    EmojiView(moji: emoji)
                }
        })
    }

    var coffeeView: some View {
        Section(header: Text("Coffee"))  {
            ForEach(coffees, id: \.name) { coffee in
                Text(coffee.name)
                    .onTapGesture {
                        path.append(coffee)
                    }
            }
        }
        .navigationTitle(Text("Coffee"))
    }

    var emojiView: some View {
        Section(header: Text("Best emoji"))  {
            ForEach(mojis, id: \.moji) { moji in
                Text(moji.moji)
                    .onTapGesture {
                        path.append(moji)
                    }
            }
        }
        .navigationTitle(Text("Emoji"))
    }
}

struct FancySplitExampleView_Previews: PreviewProvider {
    static var previews: some View {
        FancySplitExampleView()
    }
}
