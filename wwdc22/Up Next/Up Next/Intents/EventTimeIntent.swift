//
//  ViewEventIntent.swift
//  Up Next
//
//  Created by Alex Logan on 08/06/2022.
//

import Foundation
import AppIntents
import SwiftUI

struct EventTimeIntent: AppIntent {
    static var title: LocalizedStringResource = "How long until?"
    static var description = IntentDescription("Find out how long is left in your event")
    static var openAppWhenRun: Bool = false

    @Parameter(title: "Event", optionsProvider: EventOptionsProvider())
    var event: Event

    @MainActor
    func perform() async throws -> some ShowsSnippetView {
        return .result(value: event) {
            EventView(event: event, rounded: false)
        }
    }
}

extension EventTimeIntent {
    init(event: Event) {
        self.event = event
    }
}

private struct EventOptionsProvider: DynamicOptionsProvider {
    func results() async throws -> [Event] {
        Storage.shared.events
    }
}
