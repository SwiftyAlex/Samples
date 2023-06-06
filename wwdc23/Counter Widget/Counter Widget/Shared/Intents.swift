//
//  Intents.swift
//  Counter Widget
//
//  Created by Alex Logan on 06/06/2023.
//

import Foundation
import AppIntents

final class IncrementIntent: LiveActivityIntent {
    static var title: LocalizedStringResource = "Increment"

    public init() { }

    public func perform() async throws -> some IntentResult {
        let suite = UserDefaults(suiteName: Constants.suiteName)
        let counter = suite?.integer(forKey: Constants.key) ?? 0
        suite?.setValue(counter+1, forKey: Constants.key)
        return .result(value: counter)
    }
}


final class DecrementIntent: LiveActivityIntent {
    static var title: LocalizedStringResource = "Increment"

    public init() { }

    public func perform() async throws -> some IntentResult {
        let suite = UserDefaults(suiteName: Constants.suiteName)
        let counter = suite?.integer(forKey: Constants.key) ?? 0
        suite?.setValue(counter-1, forKey: Constants.key)
        return .result(value: counter)
    }
}

