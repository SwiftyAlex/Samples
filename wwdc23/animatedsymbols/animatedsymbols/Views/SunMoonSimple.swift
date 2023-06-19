//
//  SunMoonSimple.swift
//  animatedsymbols
//
//  Created by Alex Logan on 19/06/2023.
//

import SwiftUI

struct SunMoonSimple: View {
    @State var symbol: Symbol = .sun

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: symbol.name)
                .font(.largeTitle)
                .frame(height: 40)
                .contentTransition(
                    .symbolEffect(.replace.downUp)
                )

            Picker(selection: $symbol, content: {
                ForEach(SunMoonSimple.Symbol.allCases, id: \.self) { symbol in
                    Text(String(describing: symbol).localizedUppercase)
                }
            }, label: {
                Text("Symbol")
            })
            .pickerStyle(.segmented)
        }
        .padding()
    }

    enum Symbol: Hashable, CaseIterable {
        case sun, moon

        var name: String {
            switch self {
            case .sun: return "sun.max.fill"
            case .moon: return "moon.fill"
            }
        }
    }
}

#Preview {
    SunMoonSimple()
}
