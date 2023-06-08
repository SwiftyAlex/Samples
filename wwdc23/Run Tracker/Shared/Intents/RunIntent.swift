//
//  RunIntent.swift
//  Run Tracker
//
//  Created by Alex Logan on 08/06/2023.
//

import Foundation
import AppIntents

struct RunIntent: LiveActivityIntent, WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Track your run"

    static var openAppWhenRun: Bool = false

    @Parameter(title: "Your run distance", optionsProvider: RunOptionsProvider())
    var run: CommonRun

    init() {
        self.run = .ten
    }
    init(run: CommonRun) {
        self.run = run
    }

    func perform() async throws -> some IntentResult {
        await RunStore().track(kilomereDistance: run.rawValue)
        return .result(value: run.rawValue)
    }
}


struct RunOptionsProvider: DynamicOptionsProvider {
    func results() async throws -> [CommonRun] {
        CommonRun.allCases
    }
}
