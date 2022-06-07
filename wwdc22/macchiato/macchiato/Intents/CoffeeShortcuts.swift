//
//  CoffeeShortcuts.swift
//  macchiato
//
//  Created by Alex Logan on 07/06/2022.
//

import Foundation
import AppIntents

struct CoffeeShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: ViewCoffeeIntent(),
            phrases: ["Show me my favourite coffee"]
        )
    }
}
