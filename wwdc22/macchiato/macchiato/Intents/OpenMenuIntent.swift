//
//  OpenMenuIntent.swift
//  macchiato
//
//  Created by Alex Logan on 08/06/2022.
//

import Foundation
import AppIntents

struct OpenMenuIntent: AppIntent {
    static var title: LocalizedStringResource = "Open the menu"
    static var description = IntentDescription("Hop right into an order.")
    static var openAppWhenRun: Bool = false

    func perform() async throws -> some IntentPerformResult {
        return .finished
    }
}
