//
//  CoffeeShortcuts.swift
//  macchiato
//
//  Created by Alex Logan on 07/06/2022.
//

import Foundation
import AppIntents

public struct CoffeeShortcuts: AppShortcutsProvider {
    public static var appShortcuts: [AppShortcut] {
        AppShortcut(intent: ViewCoffeeIntent(), phrases: [
            "\(.applicationName) open \(\.$coffee)"
        ])
        AppShortcut(intent: WhichCoffeeIntent(), phrases: [
            "\(.applicationName) show be the bevs."
        ])
        AppShortcut(intent: OpenMenuIntent(), phrases: [
            "\(.applicationName) show me the menu."
        ])
    }
}

