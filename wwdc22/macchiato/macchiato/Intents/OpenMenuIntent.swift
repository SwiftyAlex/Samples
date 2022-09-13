//
//  OpenMenuIntent.swift
//  macchiato
//
//  Created by Alex Logan on 08/06/2022.
//

import Foundation
import AppIntents

struct OpenMenuIntent: AppIntent {
    static var title: LocalizedStringResource = "Open the latest menu"
    static var description = IntentDescription("Hop right into an order.")
    static var openAppWhenRun: Bool = true

    func perform() async throws -> some IntentResult {
        NavigationManager.shared.openMenu()
        return .result()
    }
}
