//
//  ContentView.swift
//  Seventeen
//
//  Created by Alex Logan on 06/06/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink(destination: MarkdownExporter()) {
                    Text("File Exporter")
                }
                NavigationLink(destination: PlayerView(), label: {
                    Text("Audio Player")
                })
            }
            .navigationTitle("Seventeen")
        }
    }
}

#Preview {
    ContentView()
}
