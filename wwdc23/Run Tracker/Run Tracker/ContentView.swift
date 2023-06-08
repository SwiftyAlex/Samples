//
//  ContentView.swift
//  Run Tracker
//
//  Created by Alex Logan on 07/06/2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    let runStore: RunStore

    var body: some View {
        NavigationStack {
            WeekSummaryView(runStore: runStore)
        }
    }
}

#Preview {
    ContentView(runStore: .init())
        .modelContainer(for: Run.self, inMemory: true)
}
