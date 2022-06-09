//
//  Storage.swift
//  Up Next
//
//  Created by Alex Logan on 08/06/2022.
//

import Foundation
import Combine

/// A simple storage class that uses UserDefaults as a source of truth.
class Storage: ObservableObject {
    static let shared = Storage()

    @Published var events: [Event] = []

    private let userDefaults: UserDefaults
    private let jsonDecoder: JSONDecoder
    private let jsonEncoder: JSONEncoder

    init() {
        // In production, you should just fallback to another user defaults instance, not force unwrap.
        self.userDefaults = UserDefaults(suiteName: "group.uk.co.alexanderlogan.samples.upnext")!
        self.jsonDecoder = JSONDecoder()
        self.jsonEncoder = JSONEncoder()
        fetchEvents()
        UpNextShortcuts.updateAppShortcutParameters()
    }

    @MainActor
    func store(event: Event) async {
        events.append(event)
        await updateArray()
    }

    @MainActor
    func edit(event: Event) async {
        guard let existingIndex = events.firstIndex(where: { $0.id == event.id }) else { return }
        events[existingIndex] = event
        await updateArray()
    }

    @MainActor
    func remove(event: Event) async {
        events.removeAll(where: { $0.id == event.id })
        Task {
            do {
                let newEventsArray = try jsonEncoder.encode(events)
                userDefaults.set(newEventsArray, forKey: Constants.defaultsKey)
            } catch {
                print("Unable to save events due to \(error)")
            }
        }
    }

    private func fetchEvents() {
        do {
            guard let existingEventsData = userDefaults.data(forKey: Constants.defaultsKey) else {
                    return
                }
            let existingEventsArray = try jsonDecoder.decode([Event].self, from: existingEventsData)
            self.events = existingEventsArray
        } catch {
            print("Unable to load events due to \(error)")
        }
    }

    private func updateArray() async  {
        UpNextShortcuts.updateAppShortcutParameters()
        Task {
            do {
                let newEventsArray = try jsonEncoder.encode(events)
                userDefaults.set(newEventsArray, forKey: Constants.defaultsKey)
            } catch {
                print("Unable to save events due to \(error)")
            }
        }
    }
}

private extension Storage {
    enum Constants {
        static let defaultsKey = "stored-events"
    }
}
