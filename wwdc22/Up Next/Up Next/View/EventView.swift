//
//  EventView.swift
//  Up Next
//
//  Created by Alex Logan on 08/06/2022.
//

import SwiftUI

struct EventView: View {
    let event: Event

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Rectangle()
                .foregroundStyle(.clear)
                .background(
                    alignment: .center,
                    content: { image }
                )
                .clipped()
            text
        }
        .aspectRatio(0.88, contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .background(
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.white)
                .shadow(color: .gray.opacity(0.5), radius: 8)
        )
    }

    var text: some View {
        EventViewText(event: event)
            .padding()
    }

    @ViewBuilder
    var image: some View {
        if let uiImage = UIImage(data: event.imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .transition(.opacity.combined(with: .scale(scale: 0.99)).animation(.easeInOut))
        } else {
            Rectangle()
                .foregroundStyle(Color.accentColor.gradient)
        }
    }
}

struct EventViewText: View {
    let event: Event

    var body: some View {
        VStack(alignment: .leading) {
            Text(event.name)
                .font(.headline.weight(.semibold))
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(DateFormatters.relativeFormatter.localizedString(for: event.date, relativeTo: Date()))
                .font(.subheadline.weight(.semibold))
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView(event: .newYork)
    }
}
