//
//  Brew_BookApp.swift
//  Brew Book
//
//  Created by Alex Logan on 05/06/2023.
//

import SwiftUI
import SwiftData

@main
struct Brew_BookApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Brew.self, Brewer.self])
    }
}
