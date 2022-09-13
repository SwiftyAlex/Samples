//
//  CoffeeDetailView.swift
//  macchiato
//
//  Created by Alex Logan on 07/06/2022.
//

import SwiftUI
import AppIntents

struct CoffeeDetailView: View {
    let coffee: Coffee

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Rectangle()
                .foregroundStyle(.clear)
                .background(
                    alignment: .bottom,
                    content: { image }
                )
                .clipped()
                .edgesIgnoringSafeArea(.top)
                .frame(height: 250)
            VStack(alignment: .leading, spacing: 8) {
                Text(coffee.name)
                    .font(.headline.weight(.semibold))
                Text("There should be some more information about the coffee here.")
                    .font(.subheadline.weight(.regular))
                SiriTipView(
                    intent: ViewCoffeeIntent(coffee: coffee)
                )
            }
            .padding(.horizontal)
            Spacer()
        }
        .task {
            do {
                let intent = ViewCoffeeIntent(coffee: coffee)
                let manager = IntentDonationManager.shared
                _ = try await manager.donate(intent: intent)
            } catch let error {
                print("Unable to donate ViewCoffeeIntent for \(coffee) due to \(error.localizedDescription)")
            }
        }
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

struct CoffeeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeDetailView(coffee: .cortado)
    }
}
