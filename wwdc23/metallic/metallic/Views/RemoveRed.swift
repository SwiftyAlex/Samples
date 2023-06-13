//
//  RemoveRed.swift
//  metallic
//
//  Created by Alex Logan on 13/06/2023.
//

import SwiftUI

struct RemoveRed: View {
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(Color.pink)
                .removeRed()
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .padding()
    }
}

extension View {
    func removeRed() -> some View {
        self
            .colorEffect(
                ShaderLibrary.default.removeRed()
            )
    }
}

#Preview {
    RemoveRed()
}
