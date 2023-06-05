//
//  ContentView.swift
//  Brew Book
//
//  Created by Alex Logan on 05/06/2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        NavigationStack {
            BrewerList()
                .navigationDestination(for: Brewer.self, destination: {
                    BrewerDetailView(brewer: $0)
                })
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Brewer .self, inMemory: true)
}
