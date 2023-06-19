//
//  Wifi.swift
//  animatedsymbols
//
//  Created by Alex Logan on 19/06/2023.
//

import SwiftUI

struct Wifi: View {
    @State var isActive: Bool = true

    var body: some View {
        VStack {
            Image(systemName: "wifi")
                .foregroundStyle(.mint)
                .symbolEffect(
                    .pulse,
                    isActive: isActive
                )

            Button(action: { isActive.toggle() }, label: {
                Text("Toggle")
            })
        }
    }
}

#Preview {
    Wifi()
}
