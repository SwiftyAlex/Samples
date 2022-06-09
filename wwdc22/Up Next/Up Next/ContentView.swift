//
//  ContentView.swift
//  Up Next
//
//  Created by Alex Logan on 08/06/2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var navigationManager = NavigationManager.shared
    @State var navigationPath: [Route] = []

    var body: some View {
        NavigationStack(path: $navigationPath) {
            EventsScreen()
                .navigationDestination(for: Route.self, destination: navigate(route:))
        }
        .onChange(of: navigationManager.requestedEvent, perform: { requestedEvent in
            if let requestedEvent {
                navigationManager.requestedEvent = nil
                navigationPath = [.event(requestedEvent)]
            }
        })
        .onOpenURL(perform: { url in
            guard
                let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
                let eventIdItem = components.queryItems?.first(where: { $0.name == "eventId" }),
                let eventId = eventIdItem.value,
                let event = Storage.shared.events.first(where: { $0.id.uuidString == eventId })
            else { return }

            navigationPath = [.event(event)]
        })
        .environmentObject(Storage.shared)
    }

    func navigate(route: Route) -> some View {
        switch route {
        case .event(let event):
            return EventDetailScreen(event: event, onFinish: { navigationPath = [] })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
