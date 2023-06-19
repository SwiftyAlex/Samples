//
//  PulsingAppBadge.swift
//  animatedsymbols
//
//  Created by Alex Logan on 19/06/2023.
//

import SwiftUI

struct PulsingAppBadge: View {
    @State var pushes: Int = 0

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "app.badge.fill")
                .foregroundStyle(.red, .gray)
                .font(.largeTitle)
                .fontDesign(.rounded)
                .symbolEffect(.pulse, isActive: pushes > 0)

            Button(action: {
                pushes += 1
            }, label: {
                Text("Increment")
                    .font(.headline.weight(.semibold))
                    .fontDesign(.rounded)
            })
            .foregroundColor(.cyan)
        }
    }
}

#Preview {
    PulsingAppBadge()
}
