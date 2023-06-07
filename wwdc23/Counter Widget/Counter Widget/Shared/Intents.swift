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
    static var title: LocalizedStringResource = "Decrement"

    public init() { }

    public func perform() async throws -> some IntentResult {
        let suite = UserDefaults(suiteName: Constants.suiteName)
        let counter = suite?.integer(forKey: Constants.key) ?? 0
        suite?.setValue(counter-1, forKey: Constants.key)
        return .result(value: counter)
    }
}

struct CounterIntent: LiveActivityIntent {
    static var title: LocalizedStringResource = "Counter"

    @Parameter(title: "Amount")
    var amount: Int

    public init(amount: Int) {
        self.amount = amount
    }

    // We're required to have an empty initialiser by the system
    init() { amount = 0 }

    public func perform() async throws -> some IntentResult {
        let suite = UserDefaults(suiteName: Constants.suiteName)
        let counter = suite?.integer(forKey: Constants.key) ?? 0
        suite?.setValue(counter+amount, forKey: Constants.key)
        return .result(value: counter)
    }
}


