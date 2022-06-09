//
//  EventGrid.swift
//  Up Next
//
//  Created by Alex Logan on 08/06/2022.
//

import SwiftUI

struct EventGrid: View {
    @EnvironmentObject var storage: Storage
    var events: [Event] = []
    private let gridItems: [GridItem] = Array(repeating: GridItem(.adaptive(minimum: 100), spacing: 20), count: 2)

    var body: some View {
        LazyVGrid(columns: gridItems) {
            ForEach(events) { event in
                NavigationLink(value: Route.event(event)) {
                    EventView(event: event)
                        .padding(.bottom, 10)
                }
                .buttonStyle(SquishyButtonStyle())
                .contextMenu {
                    Button {
                        Task {
                            await storage.remove(event: event)
                        }
                    } label: {
                        Label("Delete Event", systemImage: "trash.fill")
                    }
                }
                .transition(.opacity.combined(with: .scale).animation(.easeInOut))
            }
        }
        .animation(.easeInOut, value: events)
        .padding()
    }
}

struct EventGrid_Previews: PreviewProvider {
    static var previews: some View {
        EventGrid(events: [
            .wwdc22,
            .newYork
        ])
    }
}

struct SquishyButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}
