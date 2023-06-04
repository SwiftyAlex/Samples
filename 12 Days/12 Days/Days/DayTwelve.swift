//
//  DayTwelve.swift
//  12 Days
//
//  Created by Alex Logan on 05/01/2023.
//

import SwiftUI

struct DayTwelve: View {
    @Environment(\.horizontalSizeClass) var horizontalClass
    @State var navigationPath: [Coffee] = []

    var body: some View {
        switch horizontalClass {
        case .regular:
            splitView
        default:
            tabs
        }
    }

    var tabs: some View {
        TabView {
            NavigationStack(path: $navigationPath) {
                CoffeeList(onSelectCoffee: { brew in
                    navigationPath = [brew]
                })
                .navigationDestination(for: Coffee.self, destination: { CoffeeView(coffee: $0) })
            }
            .tabItem{
                Label("Brews", systemImage: "cup.and.saucer.fill")
            }
        }
    }

    var splitView: some View {
        NavigationSplitView(sidebar: {
            CoffeeList(onSelectCoffee: { brew in
                navigationPath = [brew]
            })
        }, detail: {
            NavigationStack(path: $navigationPath, root: {
                placeholder
                    .navigationDestination(for: Coffee.self, destination: { CoffeeView(coffee: $0) })
            })
        })
    }

    var placeholder: some View {
        Text("Pick a coffee!")
    }
}

struct CoffeeList: View {
    @State var coffee: [Coffee] = Coffee.bestBrews
    var onSelectCoffee: ((Coffee) -> ())

    var body: some View {
        List(coffee, id: \.title) { brew in
            Button(action: {
                onSelectCoffee(brew)
            }, label: {
                Text(brew.title)
                    .font(.subheadline.weight(.medium)) 
            })
        }
        .foregroundColor(.primary)
        .navigationTitle("Coffee")
    }
}

struct CoffeeView: View {
    let coffee: Coffee

    var body: some View {
        Text(coffee.title)
            .font(.title.weight(.bold))
    }
}

struct Coffee: Hashable, Equatable {
    let title: String

    static let bestBrews = [
        Coffee(title: "Flat White"),
        Coffee(title: "Cortado"),
        Coffee(title: "Mocha"),
        Coffee(title: "Latte"),
        Coffee(title: "Cappucino")
    ]
}

struct DayTwelve_Previews: PreviewProvider {
    static var previews: some View {
        DayTwelve()
    }
}
