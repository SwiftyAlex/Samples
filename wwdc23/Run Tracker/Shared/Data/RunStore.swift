//
//  RunStore.swift
//  Run Tracker
//
//  Created by Alex Logan on 07/06/2023.
//

import Foundation
import SwiftData
import WidgetKit

/// Simple class to easily track a run
class RunStore {
    let container: ModelContainer

    init() {
        self.container = try! ModelContainer(for: Run.self,.init(
            sharedAppContainerIdentifier: "group.uk.co.alexanderlogan.samples.runtracker"
        ))
    }

    func track(kilomereDistance: Double) async {
        let run: Run = .init(date: .init(), kilometers: kilomereDistance)
        await MainActor.run {
            let context = container.mainContext
            context.insert(object: run)
            try? context.save()

            // Reload our non dynamic widget
            WidgetCenter.shared.reloadTimelines(ofKind: "Run_Widget")
        }
    }

    // This should filter by the date, but it doesn't work as detailed in the list view
    @MainActor
    func currentDistance() async -> Double {
        let fetchConfiguration = FetchDescriptor<Run>()
        let runs = try? container.mainContext.fetch(fetchConfiguration) 
        return runs.map(\.kilometers).reduce(0, +)
    }
}
