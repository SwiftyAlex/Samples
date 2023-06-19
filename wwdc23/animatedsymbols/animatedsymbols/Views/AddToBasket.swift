//
//  AddToBasket.swift
//  animatedsymbols
//
//  Created by Alex Logan on 19/06/2023.
//

import SwiftUI

// DiscreteSymbolEffect
struct AddToBasket: View {
    @State var basketCount: Int = 0

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "basket.fill")
                .foregroundColor(.gray)
                .font(.largeTitle)
                .fontDesign(.rounded)
                .symbolEffect(
                    .bounce.up.wholeSymbol,
                    options: .speed(1.5).repeat(3),
                    value: basketCount
                )

            Button(action: {
                basketCount += 1
            }, label: {
                Text("Add to basket")
                    .font(.headline.weight(.semibold))
                    .fontDesign(.rounded)
            })
            .foregroundColor(.cyan)
        }
    }
}

#Preview {
    AddToBasket()
}
