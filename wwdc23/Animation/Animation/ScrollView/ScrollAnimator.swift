//
//  ScrollAnimator.swift
//  Animation
//
//  Created by Alex Logan on 07/06/2023.
//

import SwiftUI

enum Album: String, CaseIterable {
    case speaknow, midnights, red, fearless, evermore, folklore, lover
}

struct ScrollAnimator: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(Album.allCases, id: \.self) { album in
                    albumImage(album: album)
                        .padding(.horizontal, 16)
                        .scrollTransition(
                            topLeading: .animated(.smooth),
                            bottomTrailing: .animated(.smooth),
                            axis: .vertical,
                            transition: { content, phase in
                                // Phase can be identity, topLeading, bottomTrailing
                                // phase.value is the amount we're "offsett"
                                content
                                    .scaleEffect(1.0 - (abs(phase.value) * 0.08))
                                    .blur(radius: 3 * abs(phase.value))
                            })
                }
            }
        }
    }

    func albumImage(album: Album) -> some View {
        Image(album.rawValue)
            .resizable()
            .aspectRatio(1.0, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    ScrollAnimator()
}
