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
    let container: ModelContainer = {
        // Don't force unwrap for real 👀
        try! ModelContainer(
            for: [Brewer.self, Brew.self],
            .init(
                cloudKitContainerIdentifier: "icloud.uk.co.alexanderlogan.samples.Brew-Book"
            )
        )
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
}
