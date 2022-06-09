//
//  Event.swift
//  Up Next
//
//  Created by Alex Logan on 08/06/2022.
//

import Foundation
import AppIntents
import SwiftUI

struct Event: Codable, Hashable, AppEntity {
    let id: UUID
    let imageData: Data
    let name: String
    let date: Date

    internal init(id: UUID = UUID(), name: String, date: Date, imageData: Data) {
        self.id = id
        self.name = name
        self.date = date
        self.imageData = imageData
    }
}

// MARK: - App Intents
extension Event {
    typealias DefaultQueryType = EventsQuery

    static var defaultQuery: EventsQuery = EventsQuery()

    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(
            title: .init(stringLiteral: name),
            subtitle: .init(stringLiteral: RelativeDateTimeFormatter().localizedString(for: date, relativeTo: Date())),
            image: DisplayRepresentation.Image(data: imageData)
        )
    }

    static var typeDisplayName: LocalizedStringResource {
        return "Event"
    }
}

struct EventsQuery: EntityStringQuery {
    typealias Entity = Event

    func entities(matching string: String) async throws -> [Event] {
        return Storage.shared.events
    }

    func entities(for identifiers: [UUID]) async throws -> [Event] {
        return Storage.shared.events.filter({ identifiers.contains($0.id) })
    }
}

// MARK: Preview helpers
extension Event {
    static let wwdc22 = Event(name: "WWDC22", date: Date(timeIntervalSince1970: 1654538400), imageData: imageData(named: "22"))
    static let newYork = Event(name: "New York Trip", date: Date(timeIntervalSince1970: 1655556300), imageData: imageData(named: "Brooklyn"))

    static func imageData(named: String) -> Data {
        let image = UIImage(named: named) ?? UIImage()
        return image.jpegData(compressionQuality: 0.5)!
    }

}
