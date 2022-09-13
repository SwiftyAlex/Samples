//
//  macchiatoApp.swift
//  macchiato
//
//  Created by Alex Logan on 07/06/2022.
//

import SwiftUI
import AppIntents

@main
struct macchiatoApp: App {
    init() {
        AppDependencyManager.shared.add(key: "CoffeeProvider", dependency: CoffeeProvider())
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
