//
//  WifiVariable.swift
//  animatedsymbols
//
//  Created by Alex Logan on 19/06/2023.
//

import SwiftUI

struct WifiVariable: View {
    @State var isActive: Bool = true

    var body: some View {
        VStack {
            Image(systemName: "wifi")
                .font(.largeTitle.weight(.bold))
                .fontDesign(.rounded)
                .foregroundStyle(.mint)
                .symbolEffect(
                    .variableColor.iterative,
                    isActive: isActive
                )

            Button(action: { isActive.toggle() }, label: {
                Text("Toggle")
            })
        }
    }
}

#Preview {
    WifiVariable()
}
