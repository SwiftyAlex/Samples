//
//  Run_TrackerApp.swift
//  Run Tracker
//
//  Created by Alex Logan on 07/06/2023.
//

import SwiftUI
import SwiftData

@main
struct Run_TrackerApp: App {
    let store = RunStore()

    var body: some Scene {
        WindowGroup {
            ContentView(runStore: store)
        }
        .modelContainer(store.container)
    }
}
