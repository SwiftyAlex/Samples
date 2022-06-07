//
//  ViewCoffeeIntent.swift
//  macchiato
//
//  Created by Alex Logan on 07/06/2022.
//

import Foundation
import AppIntents

struct ViewCoffeeIntent: AppIntent {
    static var title: LocalizedStringResource = "View a coffee"
    static var description = IntentDescription("Jumps you right into the app, and into your favourite coffee.")
    static var openAppWhenRun: Bool = true

    @Parameter(title: "Coffee", optionsProvider: CoffeeOptionsProvider())
    var coffee: Coffee

    func perform() async throws -> some IntentPerformResult {
        NavigationManager.shared.open(coffee: coffee)
        return .finished(dialog: .init("Fetching your brew."))
    }
}

extension ViewCoffeeIntent {
    init(coffee: Coffee) {
        self.coffee = coffee
    }
}

private struct CoffeeOptionsProvider: DynamicOptionsProvider {
    func results() async throws -> [Coffee] {
        Coffee.all
    }
}

