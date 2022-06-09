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
            phrases: ["How long until my event?"]
        )
        AppShortcut(
            intent: ViewEventIntent(),
            phrases: ["Show me my event"]
        )
    }
}
