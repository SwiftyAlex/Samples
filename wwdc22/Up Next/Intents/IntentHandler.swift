//
//  IntentHandler.swift
//  intents
//
//  Created by Alex Logan on 09/06/2022.
//

import Intents

class IntentHandler: INExtension, WidgetEventIntentHandling {
    override func handler(for intent: INIntent) -> Any {
        return self
    }

    func provideEventOptionsCollection(for intent: WidgetEventIntent) async throws -> INObjectCollection<SiriEvent> {
        let appEvents = Storage.shared.events
        let siriEvents = appEvents.map { event in
            SiriEvent(identifier: event.id.uuidString, display: event.name)
        }
        return INObjectCollection(items: siriEvents)
    }
}
