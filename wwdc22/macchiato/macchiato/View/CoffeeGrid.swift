//
//  CoffeeGrid.swift
//  macchiato
//
//  Created by Alex Logan on 07/06/2022.
//

import SwiftUI

struct CoffeeGrid: View {
    var gridItems: [GridItem] = Array(repeating: GridItem(.adaptive(minimum: 100), spacing: 20), count: 2)

    var body: some View {
        LazyVGrid(columns: gridItems) {
            ForEach(Coffee.all) { coffee in
                NavigationLink(value: coffee) {
                    CoffeeView(coffee: coffee)
                        .padding(.bottom, 10)
                }
                .buttonStyle(SquishyButtonStyle())
            }
        }
        .padding()
    }
}

struct CoffeeGrid_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeGrid()
    }
}

struct SquishyButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}


