//
//  CoffeeView.swift
//  macchiato
//
//  Created by Alex Logan on 07/06/2022.
//

import SwiftUI

struct CoffeeView: View {
    let coffee: Coffee

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Rectangle()
                .foregroundStyle(.clear)
                .background(
                    alignment: .center,
                    content: { image }
                )
                .clipped()
            Text(coffee.name)
                .font(.subheadline.weight(.semibold))
                .padding()
        }
        .aspectRatio(0.88, contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .background(
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.white)
                .shadow(color: .gray.opacity(0.5), radius: 8)
        )
    }

    var image: some View {
        AsyncImage(url: coffee.imageUrl, content: { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .transition(.opacity.combined(with: .scale(scale: 0.99)).animation(.easeInOut))
        },
        placeholder: { Rectangle().foregroundStyle(Color.gray.gradient) })
    }
}

struct CoffeeView_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeView(coffee: .flatWhite)
            .padding()
    }
}
