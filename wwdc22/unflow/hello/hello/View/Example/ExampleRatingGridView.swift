//
//  ExampleRatingGridView.swift
//  hello
//
//  Created by Alex Logan on 13/06/2022.
//

import SwiftUI

struct ExampleRatingGridView: View {
    @State var ratings: [CoffeeRating] = [.espresso, .cortado, .macchiato]

    var body: some View {
        ZStack {
            Color(uiColor: .systemGroupedBackground).edgesIgnoringSafeArea(.all)
            ratingCard
                .padding()
        }
    }

    var ratingCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Ratings")
                .font(.headline.weight(.semibold))
            Grid(alignment: .leading, horizontalSpacing: 20) {
                ForEach(ratings, id: \.self) { rating in
                    GridRow(alignment: .center) {
                        Text(rating.coffee)
                            .font(.subheadline.weight(.regular))
                        ProgressView(value: rating.rating, total: 5)
                            .tint(Color.teal)
                    }
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(Color.white)
                .shadow(color: .gray.opacity(0.5), radius: 6)
        )
    }
}

struct CoffeeRating: Hashable {
    let rating: Float = Float.random(in: 0..<5)
    let coffee: String

    static let espresso = CoffeeRating(coffee: "Espresso")
    static let cortado = CoffeeRating(coffee: "Cortado")
    static let macchiato = CoffeeRating(coffee: "Macchiato")
}

struct ExampleRatingGridView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleRatingGridView()
    }
}
