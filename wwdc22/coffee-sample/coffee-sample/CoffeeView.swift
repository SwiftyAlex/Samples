//
//  CoffeeView.swift
//  coffee-sample
//
//  Created by Alex Logan on 06/06/2022.
//

import SwiftUI

struct CoffeeView: View {
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
