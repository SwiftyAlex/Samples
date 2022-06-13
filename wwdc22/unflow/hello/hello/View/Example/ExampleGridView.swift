//
//  ExampleGridView.swift
//  hello
//
//  Created by Alex Logan on 13/06/2022.
//

import SwiftUI

struct ExampleGridView: View {
    var body: some View {
        Grid {
            GridRow {
                CoffeeGridView(coffee: .cortado)
                CoffeeGridView(coffee: .flatWhite)
            }
            GridRow {
                CoffeeGridView(coffee: .macchiato)
                    .gridCellColumns(2)
            }
            GridRow {
                CoffeeGridView(coffee: .mocha)
                CoffeeGridView(coffee: .latte)
            }
            GridRow {
                CoffeeGridView(coffee: .americano)
                    .gridCellColumns(2)
            }
        }
        .padding()
    }
}

struct CoffeeGridView: View {
    let coffee: Coffee

    var body: some View {
        Text(coffee.name)
            .font(.subheadline.weight(.semibold))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding()
            .background(
                Color.teal.gradient, in: RoundedRectangle(cornerRadius: 12)
            )
    }
}

struct ExampleGridView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleGridView()
    }
}
