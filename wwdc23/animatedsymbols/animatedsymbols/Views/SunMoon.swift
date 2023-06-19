//
//  SunMoon.swift
//  animatedsymbols
//
//  Created by Alex Logan on 19/06/2023.
//

import SwiftUI


struct SunMoon: View {
    @State var symbol: Symbol = .sun

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: symbol.name)
                .font(.largeTitle)
                .frame(height: 40)
                .foregroundStyle(symbol == .moon ? Color.blue.gradient : Color.orange.gradient)
                .contentTransition(
                    .symbolEffect(.replace.upUp)
                )

            Picker(selection: $symbol, content: {
                ForEach(SunMoon.Symbol.allCases, id: \.self) { symbol in
                    Text(String(describing: symbol).localizedUppercase)
                }
            }, label: {
                Text("Symbol")
            })
            .pickerStyle(.segmented)
        }
        .animation(.linear, value: symbol) // Only needed for the color
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
    SunMoon()
}
