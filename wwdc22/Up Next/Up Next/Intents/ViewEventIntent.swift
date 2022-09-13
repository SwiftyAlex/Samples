//
//  ViewEventIntent.swift
//  Up Next
//
//  Created by Alex Logan on 08/06/2022.
//

import Foundation
import AppIntents

struct ViewEventIntent: AppIntent {
    static var title: LocalizedStringResource = "Show my event"
    static var description = IntentDescription("Check out your event in the app.")
    static var openAppWhenRun: Bool = true
    
    @Parameter(title: "Your event", optionsProvider: EventOptionsProvider())
    var event: Event

    @MainActor
    func perform() async throws -> some IntentResult {
        NavigationManager.shared.open(event: event)
        return .result()
    }
}

extension ViewEventIntent {
    init(event: Event) {
        self.event = event
    }
}

private struct EventOptionsProvider: DynamicOptionsProvider {
    func results() async throws -> [Event] {
        Storage.shared.events
    }
}
