//
//  EventDetailScreen.swift
//  Up Next
//
//  Created by Alex Logan on 08/06/2022.
//

import SwiftUI
import AppIntents

struct EventDetailScreen: View {
    @EnvironmentObject var storage: Storage

    @State var showEdit: Bool = false
    let event: Event
    let onFinish: () -> ()

    var body: some View {
        List {
            Section {
                image
                    .listRowInsets(EdgeInsets())
            }
            VStack(alignment: .leading) {
                Text(event.name)
                    .font(.headline.weight(.semibold))
                Text(DateFormatters.relativeFormatter.localizedString(for: event.date, relativeTo: Date()))
                    .font(.headline.weight(.semibold))
                    .foregroundColor(.secondary)
            }

            Section {
                Button(action: {
                    showEdit = true
                }, label: {
                    Text("Edit")
                        .font(.subheadline.weight(.medium))
                        .foregroundColor(.accentColor)
                })
            }

            Section {
                Button(action: {
                    withAnimation {
                        Task {
                            await storage.remove(event: event)
                        }
                        onFinish()
                    }
                }, label: {
                    Text("Delete your event")
                        .font(.subheadline.weight(.medium))
                        .foregroundColor(.red)
                })
            }

            // This doesnt seem to show yet, but still!
            Section {
                SiriTipView(intent: ViewEventIntent(event: event))
                    .padding(.top, 20)
            }
        }
        .navigationTitle("Your event")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(
            isPresented: $showEdit,
            content: {
                NavigationStack {
                    EditEventScreen(existingEvent: event, onSave: {
                        onFinish()
                        showEdit = false
                    })
                }
                .environmentObject(storage)
            }
        )
    }

    @ViewBuilder
    var image: some View {
        if let uiImage = UIImage(data: event.imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .transition(.opacity.combined(with: .scale(scale: 0.99)).animation(.easeInOut))
        } else {
            Rectangle()
                .foregroundStyle(Color.accentColor.gradient)
        }
    }
}

struct EventDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            EventDetailScreen(event: .wwdc22, onFinish: { })
                .environmentObject(Storage.shared)
        }
    }
}
