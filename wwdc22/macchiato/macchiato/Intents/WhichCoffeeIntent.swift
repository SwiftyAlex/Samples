//
//  WhichCoffeeIntent.swift
//  macchiato
//
//  Created by Alex Logan on 10/07/2022.
//

import Foundation
import SwiftUI
import AppIntents

struct WhichCoffeeIntent: AppIntent {
    static var title: LocalizedStringResource = "Get a list of coffee"
    static var description = IntentDescription("Gives you a lovely list of all the coffees available.")
    static var openAppWhenRun: Bool = false

    // Or @Dependency(key: "CoffeeProvider", default: CoffeeProvider()
    @Dependency(key: "CoffeeProvider") var coffeeProvider: CoffeeProvider

    func perform() async throws -> some IntentPerformResult {
        let coffees = String(coffeeProvider.getCoffees().map(\.name).joined(separator: ","))
        return .finished(value: coffees, dialog: nil, view: CoffeesView(coffees: coffeeProvider.getCoffees()))
    }
}

// Public as it wont render otherwise
public struct CoffeesView: View {
    let coffees: [Coffee]

    public var body: some View {
        VStack(alignment: .leading) {
            ForEach(coffees) { coffee in
                HStack {
                    Text(coffee.name)
                        .font(.headline.weight(.semibold))
                    Spacer()
                }
            }
            Divider()
        }
    }
}
