//
//  Aqua.swift
//  metallic
//
//  Created by Alex Logan on 13/06/2023.
//

import SwiftUI

struct Aqua: View {
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 12)
                .aqua()
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding()
        }
    }
}

extension View {
    func aqua() -> some View {
        let function = ShaderFunction(
            library: .default,
            name: "aqua"
        )
        let shader = Shader(function: function, arguments: [])
        return self.colorEffect(shader, isEnabled: true)
    }
}

#Preview {
    Aqua()
}
