//
//  ObservableDemoApp.swift
//  ObservableDemo
//
//  Created by Alex Logan on 06/06/2023.
//

import SwiftUI
import SwiftData

@main
struct ObservableDemoApp: App {
    private let counter: Counter = .init()

    var body: some Scene {
        WindowGroup {
            ContentView(counter: counter)
        }
    }
}
