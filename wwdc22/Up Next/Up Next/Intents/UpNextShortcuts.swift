//
//  UpNextShortcuts.swift
//  Up Next
//
//  Created by Alex Logan on 08/06/2022.
//

import Foundation
import AppIntents

struct UpNextShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: EventTimeIntent(),
            phrases: [
                "\(.applicationName) how long until \(\.$event)"
            ]
        )
        AppShortcut(
            intent: ViewEventIntent(),
            phrases: [
                "\(.applicationName) show me my \(\.$event)"
            ]
        )
    }
}
