//
//  EventsScreen.swift
//  Up Next
//
//  Created by Alex Logan on 08/06/2022.
//

import SwiftUI

struct EventsScreen: View {
    @EnvironmentObject var storage: Storage
    @State var showCreate: Bool = false

    var body: some View {
        ZStack {
            Color(uiColor: .systemGroupedBackground).edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack {
                    if storage.events.isEmpty {
                        Text("Tap plus to add your first event.")
                            .font(.subheadline.weight(.semibold))
                            .padding()
                            .transition(.opacity)
                    }
                    EventGrid(events: storage.events)
                }
            }
            .navigationTitle(Text("Up Next"))
            .navigationBarItems(trailing: plusButton)
        }
        .sheet(
            isPresented: $showCreate,
            content: {
                NavigationStack {
                    EditEventScreen(existingEvent: nil, onSave: {
                        showCreate = false
                    })
                }
                .environmentObject(storage)
            }
        )
    }

    var plusButton: some View {
        Button {
            showCreate = true
        } label: {
            Image(systemName: "plus.circle.fill")
                .font(.system(.headline, design: .rounded))
                .foregroundColor(.accentColor)
                .contentShape(Rectangle())
        }

    }
}

struct EventsScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            EventsScreen()
                .environmentObject(Storage.shared)
        }
    }
}
