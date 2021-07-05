//
//  CoffeeListView.swift
//  List Actions
//
//  Created by Alex Logan on 05/07/2021.
//

import Foundation
import SwiftUI

struct CoffeeListView: View {
    @State var coffees = Coffee.all
    @State var favouriteCoffees: [Coffee] = []

    var body: some View {
        NavigationView {
            List {
                if favouriteCoffees.count > 0 {
                    Section("Favourites") {
                        ForEach(favouriteCoffees, id: \.hashValue) { coffee in
                            CoffeeItemView(coffee: coffee)
                            .swipeActions(edge: .trailing) {
                                if coffee.name == "Mocha" {
                                    Button(action: { archiveCoffee(coffee: coffee) }, label: {
                                        Image(systemName: "archivebox.fill")
                                    })
                                    .tint(.teal)
                                }
                                Button(action: { unFavouriteCoffee(coffee: coffee) }, label: {
                                    Image(systemName: "star.slash.fill")
                                })
                                .tint(.red)
                            }
                        }
                    }
                }
                Section("Coffee") {
                    ForEach(coffees, id: \.hashValue) { coffee in
                        CoffeeItemView(coffee: coffee)
                            .swipeActions(edge: .leading) {
                                Button(action: { favouriteCoffee(coffee: coffee) }, label: {
                                    Image(systemName: "star.fill")
                                })
                                .tint(.yellow)
                            }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Menu")
        }
    }
    
    func favouriteCoffee(coffee: Coffee) {
        withAnimation {
            coffees.removeAll(where: { $0 == coffee })
            favouriteCoffees.append(coffee)
        }
    }
    func unFavouriteCoffee(coffee: Coffee) {
        withAnimation {
            favouriteCoffees.removeAll(where: { $0 == coffee })
            coffees.append(coffee)
        }
    }
    func archiveCoffee(coffee: Coffee) {
        withAnimation {
            favouriteCoffees.removeAll(where: { $0 == coffee })
        }
    }
}

struct CoffeeListView_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeListView()
    }
}
